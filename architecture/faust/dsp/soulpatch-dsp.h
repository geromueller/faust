/************************** BEGIN soulpatch-dsp.h **************************/
/************************************************************************
 FAUST Architecture File
 Copyright (C) 2019 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This Architecture section is free software; you can redistribute it
 and/or modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 3 of
 the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; If not, see <http://www.gnu.org/licenses/>.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 ************************************************************************/

#ifndef __soulpatch_dsp__
#define __soulpatch_dsp__

#include <iostream>
#include <sstream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>

#include "faust/dsp/dsp.h"
#include "faust/GUI/UI.h"
#include "faust/GUI/JSONUIDecoder.h"
#include "faust/dsp/libfaust.h"

#include "soul/API/soul_patch.h"

class soul_dsp_factory;

/**
* Faust wrapped SOUL DSP
*/

class soulpatch_dsp : public dsp {
    
    private:
    
        bool startWith(const std::string& str, const std::string& prefix)
        {
            return (str.substr(0, prefix.size()) == prefix);
        }
    
        std::string unquote(const std::string& str)
        {
            return (str[0] == '"') ? str.substr(1, str.size() - 2) : str;
        }
    
        int countTotalBusChannels(soul::patch::Span<soul::patch::Bus> buses)
        {
            int res = 0;
            for (auto& i : buses) {
                res += i.numChannels;
            }
            return res;
        }
        
        bool checkParam(soul::patch::Span<const char*> names, const std::string& name)
        {
            for (int i = 0; i < names.size(); i++) {
                if (names[i] == name) return true;
            }
            return false;
        }
    
        struct ZoneParam {
            
            FAUSTFLOAT fZone;
            soul::patch::Parameter::Ptr fParam;
            
            ZoneParam(soul::patch::Parameter::Ptr param):fParam(param)
            {}
            
            void reflectZone() { fParam->setValue(fZone); }
            void modifyZone() { fZone = fParam->getValue(); }
            
        };
    
        soul_dsp_factory* fFactory;
    
        std::vector<ZoneParam*> fInputsControl;
        std::vector<ZoneParam*> fOutputsControl;
    
        soul::patch::PatchPlayer::Ptr fPlayer;
        soul::patch::PatchPlayerConfiguration fConfig;
        soul::patch::PatchPlayer::RenderContext fRenderContext;
    
        // Event handlers used to call additional functions
        soul::patch::Parameter::Ptr fClassInit;
        soul::patch::Parameter::Ptr fInstanceConstants;
        soul::patch::Parameter::Ptr fInstanceResetUserInterface;
        soul::patch::Parameter::Ptr fInstanceClear;
        JSONUITemplatedDecoder* fDecoder;
    
        midi_handler* fMIDIHander;
        std::vector<soul::patch::MIDIMessage> fMIDIMessages;
    
    public:

        // Implemented later on
        soulpatch_dsp(soul_dsp_factory* factory, std::string& error_msg);
    
        virtual ~soulpatch_dsp()
        {
            for (auto& i : fInputsControl) {
                delete i;
            }
            for (auto& i : fOutputsControl) {
                delete i;
            }
            delete fDecoder;
        }
    
        void setMidiHandler(midi_handler* handler) { fMIDIHander = handler; }
        midi_handler* getMidiHandler() { return fMIDIHander; }

        virtual int getNumInputs()
        {
            return fRenderContext.numInputChannels;
        }
    
        virtual int getNumOutputs()
        {
            return fRenderContext.numOutputChannels;
        }
    
        virtual void buildUserInterface(UI* ui_interface)
        {
            if (fDecoder) {
                
                soul::patch::Span<soul::patch::Parameter::Ptr> params = fPlayer->getParameters();
                for (int i = 0; i < params.size(); i++) {
                    std::string label = params[i]->ID->getCharPointer();
                    if (label.find("Hslider") != std::string::npos
                        || label.find("Vslider") != std::string::npos
                        || label.find("Entry") != std::string::npos
                        || label.find("Button") != std::string::npos
                        || label.find("Checkbox") != std::string::npos) {
                        // Additional event handlers are added before the control handlers, so the control index start at 5
                        fDecoder->setReflectZoneFun(i-5, [=](double value) { params[i]->setValue(value); });
                    } else if (label.find("Hbargraph") != std::string::npos
                        || label.find("Vbargraph") != std::string::npos) {
                        // Additional event handlers are added before the control handlers, so the control index start at 5
                        fDecoder->setModifyZoneFun(i-5, [=]() { std::cout << params[i]->getValue() << std::endl; return params[i]->getValue(); });
                    }
                }
                fDecoder->buildUserInterface(ui_interface);
                
            } else {
                
                ui_interface->openVerticalBox("SOUL");
                {
                    ui_interface->openVerticalBox("Inputs");
                    
                    soul::patch::Span<soul::patch::Parameter::Ptr> params = fPlayer->getParameters();
                    for (int i = 0; i < params.size(); i++) {
                        
                        std::string label = params[i]->ID->getCharPointer();
                        ZoneParam* param = new ZoneParam(params[i]);
                        FAUSTFLOAT* zone = &param->fZone;
                        fInputsControl.push_back(param);
                        
                        // Possibly add 'Faust compatible' metadata
                        soul::patch::Span<const char*> names = params[i]->getPropertyNames();
                        for (int j = 0; j < names.size(); j++) {
                            std::string key = names[j];
                            if (key == "unit") {
                                ui_interface->declare(zone, key.c_str(), params[i]->getProperty(names[j]));
                            }
                        }
                        
                        if (checkParam(params[i]->getPropertyNames(), "boolean")) {
                            ui_interface->addButton(params[i]->name->getCharPointer(), zone);
                        } else if (!checkParam(params[i]->getPropertyNames(), "hidden")) {
                            ui_interface->addHorizontalSlider(params[i]->name->getCharPointer(), zone,
                                                              params[i]->initialValue, params[i]->minValue,
                                                              params[i]->maxValue, params[i]->step);
                        }
                    }
                    ui_interface->closeBox();
                }
                {
                    ui_interface->openVerticalBox("Outputs");
                    /*
                    soul::patch::Span<soul::patch::Parameter::Ptr> params = fPlayer->getParameters();
                    for (int i = 0; i < params.size(); i++) {
                        
                        std::string label = params[i]->ID->getCharPointer();
                        ZoneParam* param = new ZoneParam(params[i]);
                        FAUSTFLOAT* zone = &param->fZone;
                        fOutputsControl.push_back(param);
                     
                        // Possibly add 'Faust compatible' metadata
                        soul::patch::Span<const char*> names = params[i]->getPropertyNames();
                        for (int j = 0; j < names.size(); j++) {
                            std::string key = names[j];
                            if (key == "unit") {
                                ui_interface->declare(zone, key.c_str(), params[i]->getProperty(names[j]));
                            }
                        }
                        if !(checkParam(params[i]->getPropertyNames(), "hidden")) {
                            ui_interface->addVerticalBargraph(params[i]->name->getCharPointer(), zone, params[i]->minValue, params[i]->maxValue);
                        }
                    }
                    */
                    ui_interface->closeBox();
                }
                ui_interface->closeBox();
            }
        }
    
        virtual int getSampleRate()
        {
            return int(fConfig.sampleRate);
        }
    
        void classInit(int sample_rate)
        {
            if (fClassInit) fClassInit->setValue(0);
        }
    
        // Implemented later on
        virtual void init(int sample_rate);
  
        virtual void instanceInit(int sample_rate)
        {
            instanceConstants(sample_rate);
            instanceResetUserInterface();
            instanceClear();
        }

        virtual void instanceConstants(int sample_rate)
        {
            if (fInstanceConstants) fInstanceConstants->setValue(0);
        }
    
        virtual void instanceResetUserInterface()
        {
            if (fInstanceResetUserInterface) fInstanceResetUserInterface->setValue(0);
        }
    
        virtual void instanceClear()
        {
            if (fInstanceClear) fInstanceClear->setValue(0);
        }
 
        // Implemented later on
        virtual soulpatch_dsp* clone();
    
        virtual void metadata(Meta* m) {}
    
        virtual void compute(int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs)
        {
            // Update inputs control
            if (fDecoder) {
                for (auto& i : fDecoder->getInputControls()) {
                    i->reflectZone();
                }
            } else {
                for (auto& i : fInputsControl) {
                    i->reflectZone();
                }
            }
            
            // MIDI handling
            if (fMIDIHander) {
                fRenderContext.numMIDIMessages = fMIDIHander->getMessages(reinterpret_cast<std::vector<MIDIMessage>*>(&fMIDIMessages));
                fRenderContext.incomingMIDI = std::addressof(fMIDIMessages[0]);
            }
        
            // DSP compute
            fRenderContext.inputChannels = (const float**)inputs;
            fRenderContext.outputChannels = outputs;
            fRenderContext.numFrames = count;
            fPlayer->render(fRenderContext);
            
            // Update outputs control
            if (fDecoder) {
                for (auto& i : fDecoder->getOutputControls()) {
                    i->modifyZone();
                }
            } else {
                for (auto& i : fOutputsControl) {
                    i->modifyZone();
                }
            }
        }
    
        virtual void compute(double /*date_usec*/, int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) { compute(count, inputs, outputs); }
       
};

/**
 * Faust wrapped SOUL patches factory
 */

class soul_dsp_factory : public dsp_factory {
    
    protected:
    
        friend soulpatch_dsp;
    
        struct FaustSOULFile : public soul::patch::VirtualFile {
            
            virtual soul::patch::String::Ptr getName() { return {}; }
            
            virtual soul::patch::String::Ptr getAbsolutePath() { return {}; }
            
            virtual soul::patch::VirtualFile::Ptr getParent() { return {}; }
            
            virtual soul::patch::VirtualFile::Ptr getChildFile (const char* subPath) { return {}; }
            
            virtual bool isFolder() { return false; }
            
            virtual int64_t getSize() { return 0; }
            
            virtual int64_t getLastModificationTime() { return 0; }
            
            virtual int64_t read (uint64_t startPositionInFile, void* targetBuffer, uint64_t bytesToRead) { return 0; }
            
            virtual uint64_t findChildFiles (const char* wildcard, soul::patch::FileSearchCallback* callback) { return 0; }
        };
    
        struct FaustSourceFilePreprocessor : public soul::patch::SourceFilePreprocessor {
            
            virtual soul::patch::VirtualFile::Ptr preprocessSourceFile (soul::patch::VirtualFile& inputFile) override
            {
                return {};
            }
            
        };
    
        std::string fPath;
        soul::patch::PatchInstance::Ptr fPatch;
        soul::patch::Description fDescription;
        FaustSourceFilePreprocessor::Ptr fProcessor;
    
    public:
    
        soul_dsp_factory(const std::string& path, std::string& error_msg)
        {
            fPath = path;
            std::string filename = "/usr/local/lib/" + std::string(soul::patch::SOULPatchLibrary::getLibraryFileName());
            soul::patch::SOULPatchLibrary library(filename.c_str());
            
            if (!library.loadedSuccessfully()) {
                error_msg = "cannot load SOUL_PatchLoader.dylib\n";
                throw std::bad_alloc();
            }
            
            fPatch = library.createPatchFromFileBundle(fPath.c_str());
            fDescription = fPatch->getDescription();
        }
    
        virtual ~soul_dsp_factory() {}
        
        virtual std::string getName() { return fDescription.name; }
        virtual std::string getSHAKey() { return ""; }
        virtual std::string getDSPCode() { return ""; }
        virtual std::string getCompileOptions() { return ""; }
        virtual std::vector<std::string> getLibraryList() { return {}; }
        virtual std::vector<std::string> getIncludePathnames() { return {}; }
    
        virtual soulpatch_dsp* createDSPInstance()
        {
            std::string error_msg;
            return new soulpatch_dsp(this, error_msg);
        }
    
        virtual void setMemoryManager(dsp_memory_manager* manager) {}
        virtual dsp_memory_manager* getMemoryManager() { return nullptr; };
    
};

soulpatch_dsp::soulpatch_dsp(soul_dsp_factory* factory, std::string& error_msg)
{
    fFactory = factory;
    fDecoder = nullptr;
    fMIDIHander = nullptr;
    
    fConfig.sampleRate = 44100;
    fConfig.maxFramesPerBlock = 4096;
    fPlayer = fFactory->fPatch->compileNewPlayer(fConfig, nullptr, fFactory->fProcessor.get(), nullptr);
    if (!fPlayer->isPlayable()) {
        soul::patch::Span<soul::patch::CompilationMessage> errors = fPlayer->getCompileMessages();
        error_msg = "getCompileError";
        for (int i = 0; i < errors.size(); i++) {
            error_msg += " ";
            error_msg += std::string(errors[i].fullMessage->getCharPointer());
        }
        error_msg += "\n";
        throw std::bad_alloc();
    }
    
    // Setup fixed parts of the render context
    fRenderContext.numInputChannels = countTotalBusChannels(fPlayer->getInputBuses());
    fRenderContext.numOutputChannels = countTotalBusChannels(fPlayer->getOutputBuses());
}

void soulpatch_dsp::init(int sample_rate)
{
    fConfig.sampleRate = double(sample_rate);
    fPlayer = fFactory->fPatch->compileNewPlayer(fConfig, nullptr, fFactory->fProcessor.get(), nullptr);
    fMIDIMessages.resize(1024);
    
    // FAUST soul code has additional functions
    soul::patch::Span<soul::patch::Parameter::Ptr> params = fPlayer->getParameters();
    for (int i = 0; i < params.size(); i++) {
        std::string label = params[i]->ID->getCharPointer();
        if (label == "eventbuildUserInterface") {
            soul::patch::Span<const char*> names = params[i]->getPropertyNames();
            // JSON is the first key
            std::string json = unquote(params[i]->getProperty(names[0])->getCharPointer());
            json.erase(std::remove(json.begin(), json.end(), '\\'), json.end());
            fDecoder = createJSONUIDecoder(json);
        } else if (label == "eventclassInit") {
            fClassInit = params[i];
        } else if (label == "eventinstanceConstants") {
            fInstanceConstants = params[i];
        } else if (label == "eventinstanceResetUserInterface") {
            fInstanceResetUserInterface = params[i];
        } else if (label == "eventinstanceClear") {
            fInstanceClear = params[i];
        }
    }
    
    fPlayer->reset();
    classInit(sample_rate);
    instanceInit(sample_rate);
}

// External API

soulpatch_dsp* soulpatch_dsp::clone()
{
    return fFactory->createDSPInstance();
}

soul_dsp_factory* getSOULDSPFactoryFromSHAKey(const std::string& sha_key)
{
    return nullptr;
}

soul_dsp_factory* createSOULDSPFactoryFromFile(const std::string& filename,
                                               int argc, const char* argv[],
                                               std::string& error_msg)
{
    try {
        soul_dsp_factory* factory = new soul_dsp_factory(filename, error_msg);
        soulpatch_dsp dummy(factory, error_msg);
        return factory;
    } catch (...) {
        return nullptr;
    }
}

soul_dsp_factory* createSOULDSPFactoryFromString(const std::string& name_app,
                                                const std::string& dsp_content,
                                                int argc, const char* argv[],
                                                std::string& error_msg)
{
    return nullptr;
}

bool deleteSOULDSPFactory(soul_dsp_factory* factory)
{
    return false;
}

/**
 * Faust/SOUL hybrid file parser
 */

class faust_soul_parser  {
    
    private:
        
        std::map <std::string, std::string> extractFaustBlocks(std::istream* in, std::stringstream& res_file)
        {
            std::string line;
            std::stringstream faust_block;
            bool is_faust_block = false;
            int brackets = 0;
            std::map <std::string, std::string> faust_blocks;     // name, code
            std::map <std::string, std::string>::iterator cur_faust_block;
            
            while (getline(*in, line)) {
                
                std::stringstream line_reader(line);
                std::string token1, token2, token3;
                
                line_reader >> token1;
                line_reader >> token2;
                line_reader >> token3;
                
                if (is_faust_block) {
                    // End of block
                    if ((token1 == "}") && (--brackets == 0)) {
                        is_faust_block = false;
                        cur_faust_block->second = faust_block.str();
                        faust_block.str("");
                        // Start of block (or could be on the previous line)
                    } else if (token1 == "{") {
                        brackets++;
                        continue;
                    } else {
                        faust_block << line;
                    }
                    continue;
                } else {
                    is_faust_block = (token1 == "faust" && token2 != "");
                    if (is_faust_block) {
                        if (token3 == "{") brackets++;
                        faust_blocks[token2] = "";
                        cur_faust_block = faust_blocks.find(token2);
                    }
                }
                
                // Keep the lines of SOUL file
                if (!is_faust_block) res_file << line << std::endl;
            }
            
            return faust_blocks;
        }
        
        std::string generateSOULBlock(const std::string& name, const std::string& code)
        {
            int argc = 0;
            const char* argv[16];
            argv[argc++] = "-lang";
            argv[argc++] = "soul";
            argv[argc++] = "-cn";
            argv[argc++] = name.c_str();
            argv[argc++] = "-o";
            argv[argc++] = "/var/tmp/exp.soul";
            argv[argc] = nullptr;  // NULL terminated argv
            
            std::string error_msg;
            bool res = generateAuxFilesFromString("FaustDSP", code, argc, argv, error_msg);
            
            if (res) {
                std::ifstream soul_file("/var/tmp/exp.soul");
                std::string soul_string((std::istreambuf_iterator<char>(soul_file)), std::istreambuf_iterator<char>());
                return soul_string;
            } else {
                std::cerr << "ERROR : generateAuxFilesFromFile " << error_msg << std::endl;
                return "";
            }
        }

    public:
    
        faust_soul_parser()
        {}
    
        bool parse(const std::string& inputfile, const std::string& outputfile)
        {
            std::ifstream reader(inputfile.c_str());
            if (reader.is_open()) {
                
                // Open SOUL output file
                std::ofstream output_file(outputfile);
          
                // Extract the Faust blocks and returns the input file without them
                std::stringstream soul_file;
                std::map <std::string, std::string> faust_blocks = extractFaustBlocks(&reader, soul_file);
                
                // Write all Faust blocks translated to SOUL
                for (auto& it : faust_blocks) {
                    output_file << generateSOULBlock(it.first, it.second);
                }
                
                // Write the SOUL part
                output_file << soul_file.str();
                output_file.close();
                
                return true;
            } else {
                return false;
            }
        }
    
        virtual ~faust_soul_parser()
        {}
    
};


#endif
/**************************  END  soulpatch-dsp.h **************************/


(module
	(export "getNumInputs" (func $getNumInputs))
	(export "getNumOutputs" (func $getNumOutputs))
	(export "getSampleRate" (func $getSampleRate))
	(export "init" (func $init))
	(export "instanceInit" (func $instanceInit))
	(export "instanceConstants" (func $instanceConstants))
	(export "instanceResetUserInterface" (func $instanceResetUserInterface))
	(export "instanceClear" (func $instanceClear))
	(export "setParamValue" (func $setParamValue))
	(export "getParamValue" (func $getParamValue))
	(export "compute" (func $compute))
	(import "env" "memoryBase" (global $memoryBase i32))
	(import "env" "tableBase" (global $tableBase i32))
	(memory (export "memory") 64)
	(data (i32.const 0) "{\"name\":\"UI Tester\",\"version\":\"2.5.15\",\"options\":\"wast-i, -double -ftz 0\",\"size\":\"280\",\"inputs\":\"6\",\"outputs\":\"34\",\"meta\":[{\"author\":\"O. Guillerminet\"},{\"copyright\":\"(c) O. Guillerminet 2012\"},{\"license\":\"BSD\"},{\"name\":\"UI Tester\"},{\"version\":\"1.0\"}],\"ui\":[{\"type\":\"tgroup\",\"label\":\"grp 1\",\"items\":[{\"type\":\"hgroup\",\"label\":\"hmisc\",\"items\":[{\"type\":\"button\",\"label\":\"button\",\"address\":\"/grp_1/hmisc/button\",\"index\":\"232\"},{\"type\":\"hbargraph\",\"label\":\"hbar\",\"address\":\"/grp_1/hmisc/hbar\",\"index\":\"264\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"hslider\",\"label\":\"hslider\",\"address\":\"/grp_1/hmisc/hslider\",\"index\":\"240\",\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"nentry\",\"label\":\"num\",\"address\":\"/grp_1/hmisc/num\",\"index\":\"248\",\"meta\":[{\"unit\":\"f\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vbargraph\",\"label\":\"vbar\",\"address\":\"/grp_1/hmisc/vbar\",\"index\":\"256\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"vslider\",\"label\":\"vslider4\",\"address\":\"/grp_1/hmisc/vslider4\",\"index\":\"224\",\"meta\":[{\"unit\":\"f\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"hgroup\",\"label\":\"knobs\",\"items\":[{\"type\":\"vslider\",\"label\":\"knob1\",\"address\":\"/grp_1/knobs/knob1\",\"index\":\"48\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"knob2\",\"address\":\"/grp_1/knobs/knob2\",\"index\":\"56\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"knob3\",\"address\":\"/grp_1/knobs/knob3\",\"index\":\"64\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"hgroup\",\"label\":\"sliders\",\"items\":[{\"type\":\"vslider\",\"label\":\"vslider1\",\"address\":\"/grp_1/sliders/vslider1\",\"index\":\"24\",\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"vslider2\",\"address\":\"/grp_1/sliders/vslider2\",\"index\":\"32\",\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"vslider3\",\"address\":\"/grp_1/sliders/vslider3\",\"index\":\"40\",\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"vgroup\",\"label\":\"vbox\",\"items\":[{\"type\":\"checkbox\",\"label\":\"check1\",\"address\":\"/grp_1/vbox/check1\",\"index\":\"0\"},{\"type\":\"checkbox\",\"label\":\"check2\",\"address\":\"/grp_1/vbox/check2\",\"index\":\"8\"},{\"type\":\"nentry\",\"label\":\"knob0\",\"address\":\"/grp_1/vbox/knob0\",\"index\":\"16\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"vgroup\",\"label\":\"vmisc\",\"items\":[{\"type\":\"button\",\"label\":\"button\",\"address\":\"/grp_1/vmisc/button\",\"index\":\"80\"},{\"type\":\"hbargraph\",\"label\":\"hbar\",\"address\":\"/grp_1/vmisc/hbar\",\"index\":\"216\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"hslider\",\"label\":\"hslider\",\"address\":\"/grp_1/vmisc/hslider\",\"index\":\"88\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"hgroup\",\"label\":\"small box 1\",\"items\":[{\"type\":\"vslider\",\"label\":\"knob4\",\"address\":\"/grp_1/vmisc/small_box_1/knob4\",\"index\":\"112\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"nentry\",\"label\":\"num1\",\"address\":\"/grp_1/vmisc/small_box_1/num1\",\"index\":\"120\",\"meta\":[{\"unit\":\"f\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vbargraph\",\"label\":\"vbar1\",\"address\":\"/grp_1/vmisc/small_box_1/vbar1\",\"index\":\"128\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"vslider\",\"label\":\"vslider5\",\"address\":\"/grp_1/vmisc/small_box_1/vslider5\",\"index\":\"96\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"vslider6\",\"address\":\"/grp_1/vmisc/small_box_1/vslider6\",\"index\":\"104\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"hgroup\",\"label\":\"sub box 1\",\"items\":[{\"type\":\"hgroup\",\"label\":\"small box 2\",\"items\":[{\"type\":\"vslider\",\"label\":\"knob5\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_2/knob5\",\"index\":\"152\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"nentry\",\"label\":\"num2\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_2/num2\",\"index\":\"160\",\"meta\":[{\"unit\":\"f\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vbargraph\",\"label\":\"vbar2\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_2/vbar2\",\"index\":\"168\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"vslider\",\"label\":\"vslider7\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_2/vslider7\",\"index\":\"136\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"vslider8\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_2/vslider8\",\"index\":\"144\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]},{\"type\":\"hgroup\",\"label\":\"small box 3\",\"items\":[{\"type\":\"vslider\",\"label\":\"knob6\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_3/knob6\",\"index\":\"192\",\"meta\":[{\"style\":\"knob\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"nentry\",\"label\":\"num3\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_3/num3\",\"index\":\"200\",\"meta\":[{\"unit\":\"f\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vbargraph\",\"label\":\"vbar3\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_3/vbar3\",\"index\":\"208\",\"min\":\"0\",\"max\":\"127\"},{\"type\":\"vslider\",\"label\":\"vslider10\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_3/vslider10\",\"index\":\"184\",\"meta\":[{\"unit\":\"m\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"},{\"type\":\"vslider\",\"label\":\"vslider9\",\"address\":\"/grp_1/vmisc/sub_box_1/small_box_3/vslider9\",\"index\":\"176\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]}]},{\"type\":\"vslider\",\"label\":\"vslider4\",\"address\":\"/grp_1/vmisc/vslider4\",\"index\":\"72\",\"meta\":[{\"unit\":\"Hz\"}],\"init\":\"60\",\"min\":\"0\",\"max\":\"127\",\"step\":\"0.1\"}]}]}]}")
	
	(func $min_i (param $v10 i32) (param $v20 i32) (result i32)
		(return (select (get_local $v10) (get_local $v20) (i32.lt_s (get_local $v10) (get_local $v20))))
	)
	(func $max_i (param $v11 i32) (param $v21 i32) (result i32)
		(return (select (get_local $v21) (get_local $v11) (i32.lt_s (get_local $v11) (get_local $v21))))
	)
	(func $getNumInputs (param $dsp i32) (result i32)
		(return (i32.const 6))
	)
	(func $getNumOutputs (param $dsp i32) (result i32)
		(return (i32.const 34))
	)
	(func $classInit (param $dsp i32) (param $samplingFreq i32)
		
	)
	(func $instanceConstants (param $dsp i32) (param $samplingFreq i32)
		(i32.store offset=272 (i32.const 0) (get_local $samplingFreq))
		
	)
	(func $instanceResetUserInterface (param $dsp i32)
		(f64.store (i32.const 0) (f64.const 0.))
		(f64.store offset=8 (i32.const 0) (f64.const 0.))
		(f64.store offset=16 (i32.const 0) (f64.const 60.))
		(f64.store offset=24 (i32.const 0) (f64.const 60.))
		(f64.store offset=32 (i32.const 0) (f64.const 60.))
		(f64.store offset=40 (i32.const 0) (f64.const 60.))
		(f64.store offset=48 (i32.const 0) (f64.const 60.))
		(f64.store offset=56 (i32.const 0) (f64.const 60.))
		(f64.store offset=64 (i32.const 0) (f64.const 60.))
		(f64.store offset=72 (i32.const 0) (f64.const 60.))
		(f64.store offset=80 (i32.const 0) (f64.const 0.))
		(f64.store offset=88 (i32.const 0) (f64.const 60.))
		(f64.store offset=96 (i32.const 0) (f64.const 60.))
		(f64.store offset=104 (i32.const 0) (f64.const 60.))
		(f64.store offset=112 (i32.const 0) (f64.const 60.))
		(f64.store offset=120 (i32.const 0) (f64.const 60.))
		(f64.store offset=136 (i32.const 0) (f64.const 60.))
		(f64.store offset=144 (i32.const 0) (f64.const 60.))
		(f64.store offset=152 (i32.const 0) (f64.const 60.))
		(f64.store offset=160 (i32.const 0) (f64.const 60.))
		(f64.store offset=176 (i32.const 0) (f64.const 60.))
		(f64.store offset=184 (i32.const 0) (f64.const 60.))
		(f64.store offset=192 (i32.const 0) (f64.const 60.))
		(f64.store offset=200 (i32.const 0) (f64.const 60.))
		(f64.store offset=224 (i32.const 0) (f64.const 60.))
		(f64.store offset=232 (i32.const 0) (f64.const 0.))
		(f64.store offset=240 (i32.const 0) (f64.const 60.))
		(f64.store offset=248 (i32.const 0) (f64.const 60.))
		
	)
	(func $instanceClear (param $dsp i32)
		
	)
	(func $init (param $dsp i32) (param $samplingFreq i32)
		(call $classInit (get_local $dsp) (get_local $samplingFreq))
		(call $instanceInit (get_local $dsp) (get_local $samplingFreq))
		
	)
	(func $instanceInit (param $dsp i32) (param $samplingFreq i32)
		(call $instanceConstants (get_local $dsp) (get_local $samplingFreq))
		(call $instanceResetUserInterface (get_local $dsp))
		(call $instanceClear (get_local $dsp))
		
	)
	(func $getSampleRate (param $dsp i32) (result i32)
		(return (i32.load offset=272 (i32.const 0)))
	)
	(func $setParamValue (param $dsp i32) (param $index i32) (param $value f64)
		(f64.store 
			(i32.add (get_local $dsp) (get_local $index))
			(get_local $value)
		)
	)
	(func $getParamValue (param $dsp i32) (param $index i32) (result f64)
		(return (f64.load (i32.add (get_local $dsp) (get_local $index))))
	)
	(func $compute (param $dsp i32) (param $count i32) (param $inputs i32) (param $outputs i32)
		(local $input0 i32)
		(local $input1 i32)
		(local $input2 i32)
		(local $input3 i32)
		(local $input4 i32)
		(local $input5 i32)
		(local $output0 i32)
		(local $output1 i32)
		(local $output2 i32)
		(local $output3 i32)
		(local $output4 i32)
		(local $output5 i32)
		(local $output6 i32)
		(local $output7 i32)
		(local $output8 i32)
		(local $output9 i32)
		(local $output10 i32)
		(local $output11 i32)
		(local $output12 i32)
		(local $output13 i32)
		(local $output14 i32)
		(local $output15 i32)
		(local $output16 i32)
		(local $output17 i32)
		(local $output18 i32)
		(local $output19 i32)
		(local $output20 i32)
		(local $output21 i32)
		(local $output22 i32)
		(local $output23 i32)
		(local $output24 i32)
		(local $output25 i32)
		(local $output26 i32)
		(local $output27 i32)
		(local $output28 i32)
		(local $output29 i32)
		(local $output30 i32)
		(local $output31 i32)
		(local $output32 i32)
		(local $output33 i32)
		(local $fSlow0 f64)
		(local $fSlow1 f64)
		(local $fSlow2 f64)
		(local $fSlow3 f64)
		(local $fSlow4 f64)
		(local $fSlow5 f64)
		(local $fSlow6 f64)
		(local $fSlow7 f64)
		(local $fSlow8 f64)
		(local $fSlow9 f64)
		(local $fSlow10 f64)
		(local $fSlow11 f64)
		(local $fSlow12 f64)
		(local $fSlow13 f64)
		(local $fSlow14 f64)
		(local $fSlow15 f64)
		(local $fSlow16 f64)
		(local $fSlow17 f64)
		(local $fSlow18 f64)
		(local $fSlow19 f64)
		(local $fSlow20 f64)
		(local $fSlow21 f64)
		(local $fSlow22 f64)
		(local $fSlow23 f64)
		(local $fSlow24 f64)
		(local $fSlow25 f64)
		(local $fSlow26 f64)
		(local $fSlow27 f64)
		(local $i i32)
		(set_local $input0 (i32.const 0))
		(set_local $input1 (i32.const 0))
		(set_local $input2 (i32.const 0))
		(set_local $input3 (i32.const 0))
		(set_local $input4 (i32.const 0))
		(set_local $input5 (i32.const 0))
		(set_local $output0 (i32.const 0))
		(set_local $output1 (i32.const 0))
		(set_local $output2 (i32.const 0))
		(set_local $output3 (i32.const 0))
		(set_local $output4 (i32.const 0))
		(set_local $output5 (i32.const 0))
		(set_local $output6 (i32.const 0))
		(set_local $output7 (i32.const 0))
		(set_local $output8 (i32.const 0))
		(set_local $output9 (i32.const 0))
		(set_local $output10 (i32.const 0))
		(set_local $output11 (i32.const 0))
		(set_local $output12 (i32.const 0))
		(set_local $output13 (i32.const 0))
		(set_local $output14 (i32.const 0))
		(set_local $output15 (i32.const 0))
		(set_local $output16 (i32.const 0))
		(set_local $output17 (i32.const 0))
		(set_local $output18 (i32.const 0))
		(set_local $output19 (i32.const 0))
		(set_local $output20 (i32.const 0))
		(set_local $output21 (i32.const 0))
		(set_local $output22 (i32.const 0))
		(set_local $output23 (i32.const 0))
		(set_local $output24 (i32.const 0))
		(set_local $output25 (i32.const 0))
		(set_local $output26 (i32.const 0))
		(set_local $output27 (i32.const 0))
		(set_local $output28 (i32.const 0))
		(set_local $output29 (i32.const 0))
		(set_local $output30 (i32.const 0))
		(set_local $output31 (i32.const 0))
		(set_local $output32 (i32.const 0))
		(set_local $output33 (i32.const 0))
		(set_local $fSlow0 (f64.const 0.))
		(set_local $fSlow1 (f64.const 0.))
		(set_local $fSlow2 (f64.const 0.))
		(set_local $fSlow3 (f64.const 0.))
		(set_local $fSlow4 (f64.const 0.))
		(set_local $fSlow5 (f64.const 0.))
		(set_local $fSlow6 (f64.const 0.))
		(set_local $fSlow7 (f64.const 0.))
		(set_local $fSlow8 (f64.const 0.))
		(set_local $fSlow9 (f64.const 0.))
		(set_local $fSlow10 (f64.const 0.))
		(set_local $fSlow11 (f64.const 0.))
		(set_local $fSlow12 (f64.const 0.))
		(set_local $fSlow13 (f64.const 0.))
		(set_local $fSlow14 (f64.const 0.))
		(set_local $fSlow15 (f64.const 0.))
		(set_local $fSlow16 (f64.const 0.))
		(set_local $fSlow17 (f64.const 0.))
		(set_local $fSlow18 (f64.const 0.))
		(set_local $fSlow19 (f64.const 0.))
		(set_local $fSlow20 (f64.const 0.))
		(set_local $fSlow21 (f64.const 0.))
		(set_local $fSlow22 (f64.const 0.))
		(set_local $fSlow23 (f64.const 0.))
		(set_local $fSlow24 (f64.const 0.))
		(set_local $fSlow25 (f64.const 0.))
		(set_local $fSlow26 (f64.const 0.))
		(set_local $fSlow27 (f64.const 0.))
		(set_local $i (i32.const 0))
		(set_local $input0 (i32.load (i32.add (get_local $inputs) (i32.const 0))))
		(set_local $input1 (i32.load (i32.add (get_local $inputs) (i32.const 4))))
		(set_local $input2 (i32.load (i32.add (get_local $inputs) (i32.const 8))))
		(set_local $input3 (i32.load (i32.add (get_local $inputs) (i32.const 12))))
		(set_local $input4 (i32.load (i32.add (get_local $inputs) (i32.const 16))))
		(set_local $input5 (i32.load (i32.add (get_local $inputs) (i32.const 20))))
		(set_local $output0 (i32.load (i32.add (get_local $outputs) (i32.const 0))))
		(set_local $output1 (i32.load (i32.add (get_local $outputs) (i32.const 4))))
		(set_local $output2 (i32.load (i32.add (get_local $outputs) (i32.const 8))))
		(set_local $output3 (i32.load (i32.add (get_local $outputs) (i32.const 12))))
		(set_local $output4 (i32.load (i32.add (get_local $outputs) (i32.const 16))))
		(set_local $output5 (i32.load (i32.add (get_local $outputs) (i32.const 20))))
		(set_local $output6 (i32.load (i32.add (get_local $outputs) (i32.const 24))))
		(set_local $output7 (i32.load (i32.add (get_local $outputs) (i32.const 28))))
		(set_local $output8 (i32.load (i32.add (get_local $outputs) (i32.const 32))))
		(set_local $output9 (i32.load (i32.add (get_local $outputs) (i32.const 36))))
		(set_local $output10 (i32.load (i32.add (get_local $outputs) (i32.const 40))))
		(set_local $output11 (i32.load (i32.add (get_local $outputs) (i32.const 44))))
		(set_local $output12 (i32.load (i32.add (get_local $outputs) (i32.const 48))))
		(set_local $output13 (i32.load (i32.add (get_local $outputs) (i32.const 52))))
		(set_local $output14 (i32.load (i32.add (get_local $outputs) (i32.const 56))))
		(set_local $output15 (i32.load (i32.add (get_local $outputs) (i32.const 60))))
		(set_local $output16 (i32.load (i32.add (get_local $outputs) (i32.const 64))))
		(set_local $output17 (i32.load (i32.add (get_local $outputs) (i32.const 68))))
		(set_local $output18 (i32.load (i32.add (get_local $outputs) (i32.const 72))))
		(set_local $output19 (i32.load (i32.add (get_local $outputs) (i32.const 76))))
		(set_local $output20 (i32.load (i32.add (get_local $outputs) (i32.const 80))))
		(set_local $output21 (i32.load (i32.add (get_local $outputs) (i32.const 84))))
		(set_local $output22 (i32.load (i32.add (get_local $outputs) (i32.const 88))))
		(set_local $output23 (i32.load (i32.add (get_local $outputs) (i32.const 92))))
		(set_local $output24 (i32.load (i32.add (get_local $outputs) (i32.const 96))))
		(set_local $output25 (i32.load (i32.add (get_local $outputs) (i32.const 100))))
		(set_local $output26 (i32.load (i32.add (get_local $outputs) (i32.const 104))))
		(set_local $output27 (i32.load (i32.add (get_local $outputs) (i32.const 108))))
		(set_local $output28 (i32.load (i32.add (get_local $outputs) (i32.const 112))))
		(set_local $output29 (i32.load (i32.add (get_local $outputs) (i32.const 116))))
		(set_local $output30 (i32.load (i32.add (get_local $outputs) (i32.const 120))))
		(set_local $output31 (i32.load (i32.add (get_local $outputs) (i32.const 124))))
		(set_local $output32 (i32.load (i32.add (get_local $outputs) (i32.const 128))))
		(set_local $output33 (i32.load (i32.add (get_local $outputs) (i32.const 132))))
		(set_local $fSlow0 (f64.load (i32.const 0)))
		(set_local $fSlow1 (f64.load offset=8 (i32.const 0)))
		(set_local $fSlow2 (f64.load offset=16 (i32.const 0)))
		(set_local $fSlow3 (f64.load offset=24 (i32.const 0)))
		(set_local $fSlow4 (f64.load offset=32 (i32.const 0)))
		(set_local $fSlow5 (f64.load offset=40 (i32.const 0)))
		(set_local $fSlow6 (f64.load offset=48 (i32.const 0)))
		(set_local $fSlow7 (f64.load offset=56 (i32.const 0)))
		(set_local $fSlow8 (f64.load offset=64 (i32.const 0)))
		(set_local $fSlow9 (f64.load offset=72 (i32.const 0)))
		(set_local $fSlow10 (f64.load offset=80 (i32.const 0)))
		(set_local $fSlow11 (f64.load offset=88 (i32.const 0)))
		(set_local $fSlow12 (f64.load offset=96 (i32.const 0)))
		(set_local $fSlow13 (f64.load offset=104 (i32.const 0)))
		(set_local $fSlow14 (f64.load offset=112 (i32.const 0)))
		(set_local $fSlow15 (f64.load offset=120 (i32.const 0)))
		(set_local $fSlow16 (f64.load offset=136 (i32.const 0)))
		(set_local $fSlow17 (f64.load offset=144 (i32.const 0)))
		(set_local $fSlow18 (f64.load offset=152 (i32.const 0)))
		(set_local $fSlow19 (f64.load offset=160 (i32.const 0)))
		(set_local $fSlow20 (f64.load offset=176 (i32.const 0)))
		(set_local $fSlow21 (f64.load offset=184 (i32.const 0)))
		(set_local $fSlow22 (f64.load offset=192 (i32.const 0)))
		(set_local $fSlow23 (f64.load offset=200 (i32.const 0)))
		(set_local $fSlow24 (f64.load offset=224 (i32.const 0)))
		(set_local $fSlow25 (f64.load offset=232 (i32.const 0)))
		(set_local $fSlow26 (f64.load offset=240 (i32.const 0)))
		(set_local $fSlow27 (f64.load offset=248 (i32.const 0)))
		(set_local $i (i32.const 0))
		(loop $for-in-i 
			(block $for-out-i 
				(f64.store (i32.add (get_local $output0) (get_local $i)) (get_local $fSlow0))
				(f64.store (i32.add (get_local $output1) (get_local $i)) (get_local $fSlow1))
				(f64.store (i32.add (get_local $output2) (get_local $i)) (get_local $fSlow2))
				(f64.store (i32.add (get_local $output3) (get_local $i)) (get_local $fSlow3))
				(f64.store (i32.add (get_local $output4) (get_local $i)) (get_local $fSlow4))
				(f64.store (i32.add (get_local $output5) (get_local $i)) (get_local $fSlow5))
				(f64.store (i32.add (get_local $output6) (get_local $i)) (get_local $fSlow6))
				(f64.store (i32.add (get_local $output7) (get_local $i)) (get_local $fSlow7))
				(f64.store (i32.add (get_local $output8) (get_local $i)) (get_local $fSlow8))
				(f64.store (i32.add (get_local $output9) (get_local $i)) (get_local $fSlow9))
				(f64.store (i32.add (get_local $output10) (get_local $i)) (get_local $fSlow10))
				(f64.store (i32.add (get_local $output11) (get_local $i)) (get_local $fSlow11))
				(f64.store (i32.add (get_local $output12) (get_local $i)) (get_local $fSlow12))
				(f64.store (i32.add (get_local $output13) (get_local $i)) (get_local $fSlow13))
				(f64.store (i32.add (get_local $output14) (get_local $i)) (get_local $fSlow14))
				(f64.store (i32.add (get_local $output15) (get_local $i)) (get_local $fSlow15))
				(f64.store offset=128 (i32.const 0) (f64.load (i32.add (get_local $input0) (get_local $i))))
				(f64.store (i32.add (get_local $output16) (get_local $i)) (f64.load offset=128 (i32.const 0)))
				(f64.store (i32.add (get_local $output17) (get_local $i)) (get_local $fSlow16))
				(f64.store (i32.add (get_local $output18) (get_local $i)) (get_local $fSlow17))
				(f64.store (i32.add (get_local $output19) (get_local $i)) (get_local $fSlow18))
				(f64.store (i32.add (get_local $output20) (get_local $i)) (get_local $fSlow19))
				(f64.store offset=168 (i32.const 0) (f64.load (i32.add (get_local $input1) (get_local $i))))
				(f64.store (i32.add (get_local $output21) (get_local $i)) (f64.load offset=168 (i32.const 0)))
				(f64.store (i32.add (get_local $output22) (get_local $i)) (get_local $fSlow20))
				(f64.store (i32.add (get_local $output23) (get_local $i)) (get_local $fSlow21))
				(f64.store (i32.add (get_local $output24) (get_local $i)) (get_local $fSlow22))
				(f64.store (i32.add (get_local $output25) (get_local $i)) (get_local $fSlow23))
				(f64.store offset=208 (i32.const 0) (f64.load (i32.add (get_local $input2) (get_local $i))))
				(f64.store (i32.add (get_local $output26) (get_local $i)) (f64.load offset=208 (i32.const 0)))
				(f64.store offset=216 (i32.const 0) (f64.load (i32.add (get_local $input3) (get_local $i))))
				(f64.store (i32.add (get_local $output27) (get_local $i)) (f64.load offset=216 (i32.const 0)))
				(f64.store (i32.add (get_local $output28) (get_local $i)) (get_local $fSlow24))
				(f64.store (i32.add (get_local $output29) (get_local $i)) (get_local $fSlow25))
				(f64.store (i32.add (get_local $output30) (get_local $i)) (get_local $fSlow26))
				(f64.store (i32.add (get_local $output31) (get_local $i)) (get_local $fSlow27))
				(f64.store offset=256 (i32.const 0) (f64.load (i32.add (get_local $input4) (get_local $i))))
				(f64.store (i32.add (get_local $output32) (get_local $i)) (f64.load offset=256 (i32.const 0)))
				(f64.store offset=264 (i32.const 0) (f64.load (i32.add (get_local $input5) (get_local $i))))
				(f64.store (i32.add (get_local $output33) (get_local $i)) (f64.load offset=264 (i32.const 0)))
				(set_local $i (i32.add (get_local $i) (i32.const 8)))
				(if (i32.lt_s (get_local $i) (i32.mul (i32.const 8) (get_local $count))) (br $for-in-i) (br $for-out-i))
				
			)
		)
		
	)
	
)
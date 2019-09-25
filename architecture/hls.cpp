
<<includeIntrinsic>>

<<includeclass>>

#include <ap_int.h>

const ap_uint<24> scaleFactor = 0x800000; // represent 2^23
const float scaleFactorInv = 1.0f / 0x800000; // represent 2^-23

void faust(ap_int<48>* input, ap_int<48>* output) {
	float inputs[2], outputs[2];
	inputs[0] = (ap_int<24>)input[0].range(47, 24) * scaleFactor;
	inputs[1] = (ap_int<24>)input[0].range(23,0) * scaleFactorInv;

	compute(inputs, outputs);

	output[0] = ((ap_int<24>)(outputs[0]*scaleFactor)).concat((ap_int<24>)(outputs[1]*scaleFactor));
}

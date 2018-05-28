#include "mex.h"
#include "libresamp.h"

//TODO: Document this function
void mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	//TODO: Make a better error message
	if (nrhs != 3 || nlhs > 1) {
		mexErrMsgTxt("Wrong number of arguments");
	}

	double* signal = (double*)mxGetData(prhs[0]);
	unsigned length = (unsigned)mxGetDimensions(prhs[0])[0];
	unsigned channels = (unsigned)mxGetDimensions(prhs[0])[1];
	double resamplingFactor = mxGetScalar(prhs[1]);
	unsigned sampleRadius = (unsigned)mxGetScalar(prhs[2]);


	double* resampledSignal = resample(signal, length, channels, resamplingFactor, sampleRadius);


	mwSize outputSize[] = {(mwSize)(resamplingFactor*length), channels};
	plhs[0] = mxCreateNumericArray(2, outputSize, mxDOUBLE_CLASS, mxREAL);
	mxSetData(plhs[0], resampledSignal);

}

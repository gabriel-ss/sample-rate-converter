#include "libsigproc.h"
#include "libresamp.h"


double* resample(double* signal, unsigned signalLength, unsigned channels, double resamplingFactor, unsigned sampleRadius) {

	unsigned outputLength = (unsigned)(resamplingFactor*signalLength);

	//Allocates memory for the output
	double* output = new double[channels*outputLength];

	unsigned spot, start, stop, m, n, channel;

	// For each sample "m" of the new signal...
	for (m = 0; m < outputLength; m++) {

		// ...determines the corresponding sample in the original signal...
		spot = (unsigned)(m/resamplingFactor);
		// ...and evaluates the relevant range of original samples...
		start = (spot <= sampleRadius) ? 0 : spot - sampleRadius;
		stop = (signalLength - spot > sampleRadius) ? spot+sampleRadius : signalLength;

		// ...then convolutes the original signal in the range.
		output[m] = 0;
		for (n = start; n < stop; n++) {
			for (channel = 0; channel < channels; channel++) {
				output[channel*outputLength + m] +=
				 sinc((m/resamplingFactor) - n)*signal[channel*signalLength + n];
			}
		}

	}
	return output;
}

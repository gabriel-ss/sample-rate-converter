#include <thread>
#include "libsigproc.h"
#include "libresamp.h"


double* resample(double* signal, unsigned* length, unsigned channels, double resamplingFactor, unsigned sampleRadius) {

	unsigned inputLength = *length;
	unsigned outputLength = (unsigned)(resamplingFactor*inputLength);

	double* output = new double[channels*outputLength];

	unsigned channel;

	std::thread *threads = new std::thread[channels];

	//Starts a new thread for each channel...
	for (channel = 0; channel < channels; channel++)
		threads[channel] = std::thread(
			// ...passing a lambda that receives arrays corresponding to the
			//respective channel of the thread and makes the convolution.
			[&](double *signal, double *output) {

				unsigned spot, start, stop, m, n;

				// For each sample "m" of the new signal...
				for (m = 0; m < outputLength; m++) {
					// ...determines the corresponding sample in the original signal...
					spot = (unsigned)(m/resamplingFactor);
					// ...and evaluates the relevant range of original samples...
					start = (spot <= sampleRadius) ? 0 : spot - sampleRadius;
					stop = (inputLength - spot > sampleRadius) ? spot+sampleRadius : inputLength;

					// ...then convolutes the original signal in the range.
					output[m] = 0;
					for (n = start; n < stop; n++) {
						output[m] += sinc((m/resamplingFactor) - n)*signal[n];
					}
				}
			},
			//Passes to the lambda function pointers positioned at the begining of
			//each channel in the signal arrays.
			(signal + (channel*inputLength)), (output + (channel*outputLength))
		);

	for (channel = 0; channel < channels; channel++)
		threads[channel].join();

	delete[] threads;
	*length = outputLength;

	return output;
}

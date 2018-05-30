#pragma once

/**
 * Resamples the input by any real factor using an algorithm based on the
 * convolution operation with the sinc function. **DOES NOT FILTER THE INPUT,
 * ALIASING MAY OCCUR**.
 *
 * @param  input            An array where each element is a sample of the
 * signal. If the signal has multiple channels all the samples of a channel
 * must be in sequence. The array of a signal of length n samples then have
 * n * channels elements where the first n elements are the samples of channel
 * 1, the elements from n + 1 to n * 2 of channel 2 and so go on.
 * @param  inputLength      The amount of samples in each channel.
 * @param  channels         The number of channels represented in the input.
 * @param  resamplingFactor The resampling to be applied. Can be any real number.
 * @param  sampleRadius     The number of samples before and after each point in
 * the original signal considered relevant to the calculation of the new signal
 * around the corresponding point.
 * @return                  An array with the resampled signal. Respects the
 * same channel order of the input.
 */
double* resample(double* input, unsigned inputLength, unsigned channels, double resamplingFactor, unsigned sampleRadius);

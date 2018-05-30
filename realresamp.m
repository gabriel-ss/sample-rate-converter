function output = realresamp (signal, resamplingFactor, sampleRadius)
% -- realresamp (S, FS, SR)
%
% Resamples a matrix S where each column represents one channel of a 
% sampled signal. The new sample rate will be FS times the original rate.
%
% The resampled signal will be created by making a truncated convolution
% between the signal and the sinc function. The sample radius SR specifies
% how many samples before and after each point in the original signal 
% should be used in the calculation of the corresponding point in the
% new signal. High SR values make the process more precise but also slower.
%
% THE ALGORITHM DOES NOT FILTER THE ORIGINAL SIGNAL, ALIASING MAY OCCURS!

inputLength = length(signal);
% Pre allocates memory
output = zeros(resamplingFactor*size(signal)(1), size(signal)(2));

if (nargin != 3)

	error([...
		"Invalid call to ratresamp. Correct usage is:"...
		"\n\n -- realresamp (S, FS, SR)"...
	]);

elseif (resamplingFactor <= 0)
	error("FS must be greater than zero.");
elseif (sampleRadius != round(sampleRadius) || sampleRadius < 1)
	error("SR must be an integer greater than zero.");
end


# For each sample "m" of the new signal...
for m = 1:1:resamplingFactor*inputLength;

	# ...determines the corresponding sample in the original signal...
	spot = floor(m/resamplingFactor);
	# ...and evaluates the relevant range of original samples...
	if (spot <= sampleRadius); start = 1; else; start = spot - sampleRadius; end
	if (inputLength - spot > sampleRadius); stop = spot + sampleRadius; else; stop = inputLength; end

	# ...then convolutes the original signal in the range.
	n = start:1:stop;
	output(m,:) = sinc((m/resamplingFactor) - n)*signal(n,:);

end


endfunction

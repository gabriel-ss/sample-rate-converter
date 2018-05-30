function output = ratresamp (signal, stretchFactor, squeezeFactor)
% -- ratresamp (S, L, M)
%
% Resamples a matrix S where each column represents one channel of a
% sampled signal.
%
% The signal will be stretched by a factor of L and squeezed by a
% factor of M. Thus the new sample rate will be L/M times the original
% sample rate. Both L and M must be integers greater than zero.
%
% The frequency spectrum of the signal will be filtered to prevent
% aliasing from occurring.


if (nargin != 3)

	error([...
		"Invalid call to ratresamp. Correct usage is:"...
		"\n\n -- ratresamp (S, L, M)"...
	]);

elseif (...
	stretchFactor != round(stretchFactor) || ...
	squeezeFactor != round(squeezeFactor) || ...
	stretchFactor < 1 || squeezeFactor < 1 ...
)

	error("L and M must be integers greater than zero.")

end


inputLength = length(signal)(1);
outputLength = inputLength*stretchFactor/squeezeFactor;


	% ## STRETCHMENT STAGE

	% Inserts L - 1 zeros between each sample
	stretchedInput((1:inputLength)*stretchFactor,:) = stretchFactor*signal(1:inputLength,:);


	% ## FILTRATION STAGE
	outputFft = fft(stretchedInput);

	% Depending on which is greater, applies a low-pass filter...
	if (stretchFactor > squeezeFactor);
		%...to remove spectrum images...
		passband = round(inputLength/2);
	else
		%...or to prevent aliasing.
		passband = round(outputLength/2);
	end
	% This way, both spectrum and aliasing are removed with just one filter
	outputFft(passband:end - passband,:) = 0;
	stretchedInput = real(ifft(outputFft));


	% ## SHRINKAGE PHASE

	% Takes 1 out of M samples in the stretched signal
	output(1:outputLength,:) = stretchedInput((1:outputLength)*squeezeFactor,:);

endfunction

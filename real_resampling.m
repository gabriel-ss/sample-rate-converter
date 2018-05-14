signal = audioread("testAudio.wav");
#signal = sin(2*pi*440*(0:(1/44100):1));
#plot(signal);
#sound(signal, 44100);


sampleRadius = 100; # Number of neighbor sample to be used
resamplingFactor = pi; # New_Sampling_Rate/Old_Sampling_Rate


lgth = length(signal);

# For each sample "m" of the new signal...
for m = 1:1:resamplingFactor*lgth;

		# ...determines the corresponding sample in the original signal...
		spot = floor(m/resamplingFactor);
		# ...and evaluates the relevant range of original samples...
		if (spot <= sampleRadius); start = 1; else; start = spot - sampleRadius; end
		if (lgth - spot > sampleRadius); stop = spot + sampleRadius; else; stop = lgth; end

		# ...then convolutes the original signal in the range.
		y(m) = 0;
		for n = start:1:stop;
			y(m) = y(m) + sinc((m/resamplingFactor) - n)*signal(n);
		end

end

disp("Playing output...")
sound(y, 44100);

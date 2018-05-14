signal = audioread("testAudio.wav");
#signal = sin(2*pi*440*(0:(1/44100):1));
#plot(signal);
#sound(signal, 44100);
tic()

sampleRadius = 100; # Number of neighbor sample to be used
resamplingFactor = pi; # New_Sampling_Rate/Old_Sampling_Rate


lgth = length(signal);
y = zeros(1, resamplingFactor*lgth); # Pre allocates memory;

# For each sample "m" of the new signal...
for m = 1:1:resamplingFactor*lgth;

		# ...determines the corresponding sample in the original signal...
		spot = floor(m/resamplingFactor);
		# ...and evaluates the relevant range of original samples...
		if (spot <= sampleRadius); start = 1; else; start = spot - sampleRadius; end
		if (lgth - spot > sampleRadius); stop = spot + sampleRadius; else; stop = lgth; end

		# ...then convolutes the original signal in the range.
		n = start:1:stop;
		y(m) = sinc((m/resamplingFactor) - n)*signal(n).';

		
		# The two lines of code above are mathematically equivalent to...
		#for n = start:1:stop;
		#	y(m) = y(m) + sinc((m/resamplingFactor) - n)*signal(n);
		#end
		# ...however, doing the sum as a inner product is hundreds of times faster

end

toc()

disp("Playing output...")
sound(y, 44100);

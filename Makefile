CXX=g++
CXXFLAGS=-Wall -O2
LDFLAGS=-Wall -O2
MEX=mkoctfile --mex

all: resample.mex

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

resample.mex: libresamp.o libsigproc.o
	$(MEX) -o $@ resample.cpp $?

clean:
	rm ./*.o

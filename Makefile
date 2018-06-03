CXX=g++
CXXFLAGS=-Wall -std=c++11 -pedantic -D_FORTIFY_SOURCE=2 -O2 -fPIC -pthread
LDFLAGS=-Wall -std=c++11 -O2 -pthread
MEX=mkoctfile --mex

all: resample.mex

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

resample.mex: libresamp.o libsigproc.o
	$(MEX) $(CXXFLAGS) -o $@ resample.cpp $^

clean:
	rm ./*.o

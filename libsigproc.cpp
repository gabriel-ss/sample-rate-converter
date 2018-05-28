#include "libsigproc.h"
#include <cmath>


double sinc(double x) {
	return (x ? std::sin(M_PI*x)/(M_PI*x): 1);
}

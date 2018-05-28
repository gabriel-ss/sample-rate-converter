#pragma once
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/**
 * Evaluates the cardinal sine of the argument.
 *
 * @param  x sinc argument.
 * @return   normalized sinc of x (sin(pi*x)/(pi*x).
 */
double sinc(double x);

import numpy as np
cimport numpy as cnp

cdef extern from "numpy/npy_math.h" nogil:
    double npy_log(double x)


def use_log(double val):
    return npy_log(val)


print(use_log(5.))

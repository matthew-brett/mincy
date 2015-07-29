# distutils: language = c
# cython: wraparound=False, cdivision=True, boundscheck=False

from libc.math cimport sqrt, acos

import math

cdef double PI = math.pi

ctypedef float[:,:] Data2D

cdef double c_dist(Data2D features1, Data2D features2) nogil except -1:
    cdef :
        int d, D = features1.shape[1]
        double sqr_norm_features1 = 0.0, sqr_norm_features2 = 0.0
        double cos_theta = 0.0

    for d in range(D):
        cos_theta += features1[0, d] * features2[0, d]
        sqr_norm_features1 += features1[0, d] * features1[0, d]
        sqr_norm_features2 += features2[0, d] * features2[0, d]

    if sqr_norm_features1 == 0.:
        if sqr_norm_features2 == 0.:
            return 0.
        else:
            return 1.

    cos_theta /= sqrt(sqr_norm_features1) * sqrt(sqr_norm_features2)

    # Make sure it's in [-1, 1], i.e. within domain of arccosine
    cos_theta = min(cos_theta, 1.)
    cos_theta = max(cos_theta, -1.)
    return acos(cos_theta) / PI  # Normalized cosine distance


def dist(Data2D features1, Data2D features2):
    return c_dist(features1, features2)


import numpy as np

arr = np.array([[  1.00000000e+01,   1.50216311e-01,   1.22460635e-16]], dtype=np.float32)

print dist(arr, arr)

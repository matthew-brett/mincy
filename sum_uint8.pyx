import numpy as np
cimport numpy as cnp

def summer():
    cdef:
        cnp.npy_intp c = 0

    mask = np.zeros(3, dtype=np.uint8)
    c += mask.sum()
    return c


print(summer())

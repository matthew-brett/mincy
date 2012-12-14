import numpy as np
cimport numpy as cnp
cimport cython


@cython.boundscheck(False)
@cython.wraparound(False)
def vec_vals_vect(vecs, vals):
    """ Vectorize `vecs` . `vals` . `vecs`.T over last dimensions

    Parameters
    ----------
    vecs : shape (..., P, P) array
        containing tensor in last two dimensions, P usually equal to 3
    vals : shape (..., P) array
        values in last dimension

    Returns
    -------
    res : shape (..., P, P) array
        For all the dimensions ellided by ``...`` loops to get (P, P) ``vec``
        matrix, and (P,) ``vals`` vector, and calculates
        ``vec.dot(val[None,:]).dot(vec.T)``.
    """
    vecs = np.asarray(vecs)
    vals = np.asarray(vals)
    cdef:
        cnp.npy_intp t, N, rows, cols, r, c, out_c
        double [:, :, :] vecr
        double [:, :] valr
        double [:, :] vec
        double [:] val
        double [:, :, :] out
        double row_c
    common_shape = vecs.shape[:-2]
    rows, cols = vecs.shape[-2], vecs.shape[-1]
    if vals.shape != common_shape + (cols,):
        raise ValueError('dimensions do not match')
    if cols != rows:
        raise ValueError('Must have same number of rows, cols')
    N = np.prod(common_shape)
    vecr = (vecs.reshape((N, rows, cols))).astype(float)
    valr = (vals.reshape((N, cols))).astype(float)
    out = np.zeros((N, rows, cols))
    with nogil:
        for t in range(N): # loop over tensors
            vec = vecr[t]
            val = valr[t]
            for r in range(rows):
                for c in range(cols):
                    row_c = vec[r, c] * val[c]
                    for out_c in range(cols):
                        out[t, r, out_c] += row_c * vec[out_c, c]
    return np.reshape(out, (common_shape + (rows, cols)))

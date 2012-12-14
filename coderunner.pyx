import numpy as np

def vec_vals_vect(vecs, vals):
    QL = vecs * vals[..., None, :] # shape N, 3, 3
    A = QL.astype(float)
    B = np.rollaxis(vecs, -1, -2).astype(float)
    if A.ndim != B.ndim:
        raise ValueError('arrays should have same number of dimensions')
    if A.ndim < 3:
        return np.dot(A, B)
    common_shape = A.shape[:-2]
    if B.shape[:-2] != common_shape:
        raise ValueError('dimensions up until last 2 should match')
    N = np.prod(common_shape)
    Ar = A.reshape((N,) + A.shape[-2:])
    Br = B.reshape((N,) + B.shape[-2:])
    dot_shape = A.shape[-2], B.shape[-1]
    out = np.zeros((N,) + dot_shape)
    for i in range(N):
        out[i] = np.dot(Ar[i], Br[i])
    return out.reshape(common_shape + dot_shape)

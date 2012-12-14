import numpy as np
from numpy.random import randn
from numpy.testing import assert_array_equal, measure

from coderunner import vec_vals_vect

def make_vecs_vals(shape):
    return randn(*(shape + (3, 3))), randn(*(shape + (3,)))


def test_vec_vals_vect():
    for shape in ((10,), (100,), (10, 12), (12, 10, 5)):
        evecs, evals = make_vecs_vals(shape)
        res1 = np.einsum('...ij,...j,...kj->...ik', evecs, evals, evecs)
        assert_array_equal(res1, vec_vals_vect(evecs, evals))


def bench_vec_vals_vect():
    # nosetests -s --match '(?:^|[\\b_\\.//-])[Bb]ench'
    repeat = 40
    evecs, evals = make_vecs_vals((100, 100))
    etime = measure("np.einsum('...ij,...j,...kj->...ik', evecs, evals, evecs)",
                    repeat)
    vtime = measure("vec_vals_vect(evecs, evals)", repeat)
    print("einsum %4.2f; vec_vals_vect %4.2f" % (etime, vtime))

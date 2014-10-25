import numpy as np
from numpy.testing import assert_array_equal

from eg_log import use_log

def test_vec_vals_vect():
    assert_array_equal(use_log(5), np.log(5))

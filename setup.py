from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

from numpy.distutils.misc_util import get_info
npm_info = get_info('npymath')

ext_modules = [Extension("eg_log", ["eg_log.pyx"],
                         **npm_info)
              ]

setup(
  name = 'eg_log',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)

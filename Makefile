all : test

test : ext
	nosetests test_vec_val_vect.py

bench : ext
	nosetests -s --match '(?:^|[\\b_\\.//-])[Bb]ench' test_vec_vals_vect.py

ext :
	python setup.py build_ext -i

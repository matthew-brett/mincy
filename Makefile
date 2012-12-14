TEST_FILE = test_vec_val_vect.py
all : test

test : ext
	nosetests $(TEST_FILE)

bench : ext
	nosetests -s --match '(?:^|[\\b_\\.//-])[Bb]ench' $(TEST_FILE)

ext :
	python setup.py build_ext -i

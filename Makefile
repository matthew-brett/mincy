all : test

test : ext
	pytest .

ext :
	python setup.py build_ext -i

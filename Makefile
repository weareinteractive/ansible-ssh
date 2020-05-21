PWD=$(shell pwd)

docs:
	ansible-role docgen

lint:
	ansible-lint .

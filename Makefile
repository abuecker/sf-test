build: clean
	mkdir docs
	cd docs && cleaver --debug ../src/presentation.md
	cp -prv src/diagrams docs/

clean:
	rm -rf docs

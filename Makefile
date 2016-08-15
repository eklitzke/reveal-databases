serve:
	./node_modules/.bin/reveal-md --theme blood slides.md

bootstrap:
	npm install reveal-md

.PHONY: bootstrap serve

all:
test:
	ruff .
	python3 -m flake8 --max-line-length=131
	mypy --ignore-missing-imports -- .
	# FIXME: remove "-"
	-pytest
	find -name '*.html' -exec tidy --gnu-emacs yes {} + >/dev/null
	flit build
debug: test
	IN_PRODUCTION=no python3 -m FuckMariaDB

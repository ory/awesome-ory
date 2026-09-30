VENV := .venv

.PHONY: test
test: $(VENV)
	$(VENV)/bin/pytest -q

$(VENV): requirements-dev.txt
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install -q -r requirements-dev.txt
	touch $(VENV)

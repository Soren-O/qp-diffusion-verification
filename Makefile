PY ?= python3

VERIFY_SCRIPTS := \
	verify_gA_convention.py \
	verify_traces.py \
	verify_fT.py \
	verify_nonadiabatic.py \
	verify_tdep_inhomogeneous.py \
	verify_proximity.py \
	verify_supercurrent.py

.PHONY: verify
verify:
	@set -e; for script in $(VERIFY_SCRIPTS); do \
		echo "==> $$script"; \
		$(PY) "$$script"; \
	done

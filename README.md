# Symbolic verification for "Which Diffusion Equation for Nonequilibrium Superconducting Quasiparticles?"

This repository is a standalone snapshot of the seven SymPy verification
programs maintained with the paper and its Supplemental Material.  The checks
cover the convention-sensitive trace identities, the longitudinal and
transverse kinetic reductions, and the nonadiabatic, proximity, and
supercurrent extensions.

Every script is fail-closed: it exits with status 0 only after all of its
symbolic identities and numerical guards pass.  A failed identity, numerical
guard, or assertion produces a nonzero exit status, so the suite is suitable
for CI and pre-submission gates.

| Script | Scope |
| --- | --- |
| `verify_gA_convention.py` | Side-by-side audit of the superseded and physical advanced-propagator conventions.  The corrected `g^A = -tau3 (g^R)^dagger tau3` column is the regression baseline for the spectral equation, equilibrium Keldysh weight, diffusion coefficients, and collision channels. |
| `verify_traces.py` | Load-bearing trace identities: first-order Moyal spectral flow, longitudinal/transverse diffusion, static inhomogeneous-gap currents, real and complex interface kernels, interface normalization, and the local Peclet estimate. |
| `verify_fT.py` | Transverse (charge-imbalance) kinetic equation: kernel/image channel projection, first Wigner correction, frozen-shell solutions, and uniform/inhomogeneous spatial sectors. |
| `verify_nonadiabatic.py` | Corrected second-order nonadiabatic derivation: normalized retarded/advanced spectral corrections and star-normalization, the complete generic coherence source, its survival for a static gap with time-dependent `f_L`, its cancellation for shell-slaved or constant `f_L`, and the explicit Pauli decomposition of the correction. |
| `verify_tdep_inhomogeneous.py` | Combined `Delta(x,t)` check with local coefficients.  It evaluates the full starred spatial current, including both the inner Moyal correction to `g^K` and the outer star products, and verifies cancellation of the would-be mixed time/space energy source and longitudinal-transverse mixing. |
| `verify_proximity.py` | Complex spectral-angle continuation and the physical identities `D_L = cos^2(Im theta)`, `D_T = cosh^2(Re theta)`, and `D_L D_T = N_1^2`. |
| `verify_supercurrent.py` | Gauge-covariant frozen-spectrum cancellation, the depaired retarded-angle solution, its fixed-energy weak-depairing outer limit, rounded-edge scaling, and edge sum rule. |

## Run

Create an environment with the declared dependency, then run the fail-fast
suite:

```sh
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
make verify PY=.venv/bin/python
```

On Windows, point `PY` at the environment's interpreter, for example:

```powershell
make verify PY='A:/Einstein/Documents/qp-diffusion-paper/.venv/Scripts/python.exe'
```

Without `make`, invoke each `verify_*.py` file with the same interpreter and
stop on the first nonzero exit.  `verify_fT.py` is the heaviest symbolic check
and may take several minutes.

The numerical benchmark figures in the paper (uniform-gap packet,
gap-gradient drift, and interface/trap) are generated separately by the
`validation/diffusion_operators` module of the
[qpsim simulation package](https://github.com/Soren-O/Quasiparticle-Physics-Simulation).

# Machine checks for "Four Deductive Arguments for God Have Not Been Shown to Compel Assent"

These files check the logical and arithmetic claims in the paper. They do not check any philosophical premise. Whether a premise is warranted is the paper's argument, and nothing here bears on it.

## Lean 4 (v4.32.2, Mathlib v4.32.2)

**`Formal/Modal.lean`** covers Kripke semantics for the paper's §6 and §4:
- `ontological_valid_B`: the modal ontological argument is valid on every symmetric frame (the B system).
- `ontological_S5_necessary`: on every S5 frame (accessibility an equivalence relation) the argument gives necessary existence.
- `reverse_ontological`: the reverse argument is valid on every reflexive frame.
- `reverse_ontological_S5`: on S5 frames the reverse argument gives necessary non-existence.
- `rivals_incompatible`: on a reflexive symmetric frame, "possibly G", "possibly not G" and premise 2 cannot all hold.
- `S4_countermodel`: a reflexive, transitive, non-symmetric frame on which both premises hold and the conclusion fails.
- `vanInwagen_collapse`: van Inwagen's step, in system K.
- `vanInwagen_needs_entailment`: the step fails without the entailment premise.

**`Formal/Probability.lean`** covers the probability claims behind §1, §2 and Craig 2016:
- A conjunction is never more probable than a conjunct.
- A valid conclusion is at least as probable as the conjunction of its premises.
- Craig's 2008 condition is inadequate: with five equally likely cases, two premises can each have probability 3/5 while their conjunction has 1/5.
- The Fréchet bound shows that this example is the worst case.

**Result.** Built on Atlas on 2026-10-05: `Build completed successfully (8658 jobs)`, with no `sorry`. `axioms.log` holds the axiom audit:
- The modal theorems use no axioms, apart from `S4_countermodel`, which uses `propext`.
- The probability theorems use only the standard `propext`, `Classical.choice` and `Quot.sound`.

The build prints deprecation warnings. Mathlib now prefers `Std.Symm`, `Std.Refl` and `IsTrans` to `Symmetric`, `Reflexive` and `Transitive`. The warnings do not affect the results.

**To build.** Run `lake build` (`lake exe cache get` first if needed), then `lake env lean Axioms.lean`.

## SymPy (1.14.0), `symbolic_checks.py`

This script works independently of the Lean files.
- It checks the modal claims exhaustively on every frame with 1 to 3 worlds.
- It checks the Fréchet bounds.
- It checks the omission floor, the commission tax and the flip on the toy cases the paper describes. These results come from Bond 2026a (Appendix, Theorems "Commission tax" and "Omission floor") and Bond 2026b.
- It checks the non-distributivity example from §7.2.

**Result.** 17/17 PASS on Atlas, including the coin-flip example from §2; the output is in `symbolic.log`.

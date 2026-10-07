import Mathlib

/-!
# Modal claims in Section 6 and Section 4 of the paper

Kripke semantics: a frame is a relation `R` on worlds `W`, a proposition is a
predicate on worlds. `G u` reads "a maximally great being exists at world u".

Checked here:
* the modal ontological argument is valid on every symmetric frame (system B),
  and on every equivalence frame (S5) it yields necessary existence;
* the reverse ("possibly no maximally great being") argument is valid on every
  reflexive frame, and yields necessary non-existence on S5 frames;
* the two possibility premises are jointly inconsistent with premise 2 on
  every reflexive symmetric frame;
* a reflexive transitive (S4) frame on which the argument fails;
* van Inwagen's collapse step: a necessary explanans that entails the
  conjunction of contingent truths makes each conjunct necessary (system K),
  and without entailment the step fails.
-/

namespace CounterApologetics.Modal

variable {W : Type*} (R : W → W → Prop)

/-- Necessity at `w`: true at every world accessible from `w`. -/
def box (p : W → Prop) (w : W) : Prop := ∀ v, R w v → p v

/-- Possibility at `w`: true at some world accessible from `w`. -/
def dia (p : W → Prop) (w : W) : Prop := ∃ v, R w v ∧ p v

/-- Premise 2, necessitated at `w`: necessarily, if G then necessarily G. -/
def Prem2 (G : W → Prop) (w : W) : Prop := box R (fun u => G u → box R G u) w

/-- The argument is valid on every symmetric frame (the B principle suffices). -/
theorem ontological_valid_B (hsym : Symmetric R) (G : W → Prop) (w : W)
    (h1 : dia R G w) (h2 : Prem2 R G w) : G w := by
  obtain ⟨v, hwv, hGv⟩ := h1
  exact h2 v hwv hGv w (hsym hwv)

/-- On every S5 (equivalence) frame the conclusion is necessary existence. -/
theorem ontological_S5_necessary (heq : Equivalence R) (G : W → Prop) (w : W)
    (h1 : dia R G w) (h2 : Prem2 R G w) : box R G w := by
  obtain ⟨v, hwv, hGv⟩ := h1
  intro u hwu
  exact h2 v hwv hGv u (heq.trans (heq.symm hwv) hwu)

/-- The reverse argument: possibly not-G plus premise 2 gives not-G
(reflexivity suffices). -/
theorem reverse_ontological (hrefl : Reflexive R) (G : W → Prop) (w : W)
    (h1 : dia R (fun u => ¬ G u) w) (h2 : Prem2 R G w) : ¬ G w := by
  obtain ⟨v, hwv, hnv⟩ := h1
  intro hGw
  exact hnv (h2 w (hrefl w) hGw v hwv)

/-- On S5 frames the reverse argument yields necessary non-existence. -/
theorem reverse_ontological_S5 (heq : Equivalence R) (G : W → Prop) (w : W)
    (h1 : dia R (fun u => ¬ G u) w) (h2 : Prem2 R G w) :
    box R (fun u => ¬ G u) w := by
  obtain ⟨v, hwv, hnv⟩ := h1
  intro u hwu hGu
  exact hnv (h2 u hwu hGu v (heq.trans (heq.symm hwu) hwv))

/-- The two possibility premises cannot both hold together with premise 2 on a
reflexive symmetric frame. -/
theorem rivals_incompatible (hrefl : Reflexive R) (hsym : Symmetric R)
    (G : W → Prop) (w : W) (h1 : dia R G w) (h1' : dia R (fun u => ¬ G u) w)
    (h2 : Prem2 R G w) : False :=
  reverse_ontological R hrefl G w h1' h2 (ontological_valid_B R hsym G w h1 h2)

/-- Two worlds, `false` sees `true`, each sees itself: reflexive, transitive,
not symmetric. -/
def R4 : Bool → Bool → Prop := fun a b => a = false ∨ b = true

/-- An S4 countermodel: both premises hold at `false`, the conclusion fails. -/
theorem S4_countermodel :
    Reflexive R4 ∧ Transitive R4 ∧ ¬ Symmetric R4 ∧
    dia R4 (fun b => b = true) false ∧ Prem2 R4 (fun b => b = true) false ∧
    ¬ (false = true) := by
  refine ⟨?_, ?_, ?_, ⟨true, Or.inl rfl, rfl⟩, ?_, by decide⟩
  · intro a; cases a <;> simp [R4]
  · intro a b c hab hbc; cases a <;> cases b <;> cases c <;> simp_all [R4]
  · intro h
    have := h (show R4 false true from Or.inl rfl)
    simp [R4] at this
  · intro u _ hu v huv
    subst hu
    cases v <;> simp_all [R4]

/-- Van Inwagen's step (system K): if a necessary `N` necessarily entails the
conjunction `B` of contingent truths, every conjunct `p` of `B` is necessary. -/
theorem vanInwagen_collapse (N B p : W → Prop) (w : W)
    (hN : box R N w) (hent : box R (fun u => N u → B u) w)
    (hconj : box R (fun u => B u → p u) w) : box R p w :=
  fun v hv => hconj v hv (hent v hv (hN v hv))

/-- Without the entailment premise the step fails: on the universal two-world
frame, a necessary truth coexists with a true but contingent `B`. -/
theorem vanInwagen_needs_entailment :
    box (fun _ _ => True) (fun _ : Bool => True) true ∧
    (fun b : Bool => b = true) true ∧
    ¬ box (fun _ _ => True) (fun b : Bool => b = true) true := by
  refine ⟨fun _ _ => trivial, rfl, ?_⟩
  intro h
  exact absurd (h false trivial) (by decide)

end CounterApologetics.Modal

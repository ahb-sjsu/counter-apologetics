import Mathlib

/-!
# Probability claims behind Craig's 2016 revision (Section 1 and Section 2)

* A conjunction is never more probable than any conjunct, so a premise that is
  not more probable than not keeps the conjunction from being more probable
  than not.
* A valid argument's conclusion is at least as probable as the conjunction of
  its premises.
* Craig's 2008 condition is inadequate: two premises can each have probability
  3/5 while their conjunction has probability 1/5 (five equally likely cases).
* That example is the worst case: on n equally likely cases,
  |A| + |B| ≤ |A ∩ B| + n (the Fréchet lower bound).
-/

namespace CounterApologetics.Prob

open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω]

theorem conj_le_left (μ : Measure Ω) (A B : Set Ω) : μ (A ∩ B) ≤ μ A :=
  measure_mono Set.inter_subset_left

theorem conclusion_ge_conj (μ : Measure Ω) (A B C : Set Ω) (h : A ∩ B ⊆ C) :
    μ (A ∩ B) ≤ μ C :=
  measure_mono h

theorem conj_not_majority (μ : Measure Ω) (A B : Set Ω) (h : μ A ≤ 1 / 2) :
    μ (A ∩ B) ≤ 1 / 2 :=
  (conj_le_left μ A B).trans h

/-- Probability of an event among five equally likely cases. -/
def pr (S : Finset (Fin 5)) : ℚ := S.card / 5

def A : Finset (Fin 5) := {0, 1, 2}
def B : Finset (Fin 5) := {2, 3, 4}

theorem old_criterion_inadequate :
    pr A > 1 / 2 ∧ pr B > 1 / 2 ∧ pr (A ∩ B) < 1 / 2 ∧ pr (A ∩ B) = 1 / 5 := by
  have hA : A.card = 3 := by decide
  have hB : B.card = 3 := by decide
  have hAB : (A ∩ B).card = 1 := by decide
  simp only [pr, hA, hB, hAB]
  norm_num

theorem frechet (n : ℕ) (S T : Finset (Fin n)) :
    S.card + T.card ≤ (S ∩ T).card + n := by
  have h := Finset.card_union_add_card_inter S T
  have hu : (S ∪ T).card ≤ n := by simpa using Finset.card_le_univ (S ∪ T)
  omega

end CounterApologetics.Prob

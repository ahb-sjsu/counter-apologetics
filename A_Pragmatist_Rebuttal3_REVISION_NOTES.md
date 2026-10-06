# v3 revision notes (2026-10-05)

v3 (`A_Pragmatist_Rebuttal3.md`) answers an outside critique. The critique's section numbers refer to the December 2025 PDF. v2 (RST-2026-0068 at *Religious Studies*) is left untouched.

## The critic's points, against v2

| # | Critic's point | Verdict on v2 | What v3 does |
|---|---|---|---|
| 1 | Instrumentalism is a rival framework, not a refutation | Correct. v2 says the bridge "collapses" and calls realist epistemology "untenable" | Main argument (§§2–6) rewritten to be framework-neutral, using a three-question test of premise warrant (support, track record in the domain, rival of equal weight). Instrumentalism moved to a separable diagnosis (§7). Claims calibrated to "does not compel assent" |
| 2 | Gödel isn't doing the assigned work | Correct, and v2 is worse than the PDF. v2 §4.3 says S5 plus axioms "cannot prove its own consistency". That is false. Propositional S5 does not express arithmetic, so incompleteness does not apply, and a one-world model shows the premises are consistent | Gödel section cut to one paragraph (§7.3) saying incompleteness does not bear on these arguments. Title no longer mentions Gödel |
| 3 | QM doesn't break classical reasoning | Partly fixed in v2 §5.5. But v2 still says classical logic "presupposes" locality and value-definiteness, and says "we developed quantum logic" when classical logic failed | §7.2 separates the structure representing properties from the reasoning about it. Uses the defensible point that intuitions needed revision. Kalam section concedes that decay has a cause (Craig's reply) and that Bohm is deterministic |
| 4 | Moral section changes the meaning of "objective" | Correct. v2 §7.3 still charges Craig with equivocation. He uses one definition | Charge withdrawn. Split into (5.1) denying stance-independence, an alternative account that is not a refutation, and (5.2) godless realism, which denies premise 1. Added §5.3, the symmetry argument (sceptical theism cuts both ways), drawing on the Fall paper's dilemma |
| 5 | Ontological argument treated imprecisely | Correct. v2 §6.2/§7.4 say the proof gives "only a model" or "an S5-frame", which understates validity. v2 also leans on "S5 is a tool choice", but the inference only needs the B axiom | Concedes validity in every model of the premises, and in B. Drops the equivocation charge. Main objection is now that the possibility premise and its reverse have the same support. Gödel/Sobel collapse is recast correctly (it holds in every model) as evidence that perfection intuitions are unreliable |

## Also changed (same overclaim pattern, not raised by the critic)
- Putnam's model-theoretic argument removed. It presupposes the contested anti-realism, so it has the same flaw as point 1.
- Wigner reply: "the puddle dissolves it" softened. The reply now concedes that pure mathematics later found application, which selection does not explain.
- Contingency: van Inwagen's modal-collapse argument against PSR moved to the front, because realists accept it as a serious objection. v2 cited it only in passing.

## Before submission
- (round 1) 17 `[VERIFY]` markers. All resolved in round 2.
- Note 3 is an AI-use disclosure placeholder. CUP requires AI use to be declared.
- v3 is about 5,700 words, down from about 7,900.
- If RST-2026-0068 comes back as R&R, v3 is the revision. If it is still under review, do not send v3 unsolicited.
- §5.3 echoes the Fall paper's dilemma. If both papers are at RS, check anonymity before citing it.

---

# Round 2 (2026-10-05): second critique, citation check, OT, machine checks

## Second critique (five points plus Gödel/Scott). All verified against primary sources, all applied
| # | Point | Done in v3 |
|---|---|---|
| 1 | Craig revised his criterion in 2016 | Q&A #468 (2 Apr 2016) confirmed: Craig calls the 2008 condition "inadequate" (after McGrew & DePoe 2013) and moves to the probability of the conjunction. Intro and §2 now give both forms. The critique holds a fortiori, since a conjunction is never more probable than its weakest conjunct |
| 2 | Untested vs. unreliable | §2 Q2 now separates the two: an untested extension is not a defeater, it only removes corroboration. §3 concedes that failure of determinism does not touch Craig's weaker premise. §8.1 rewritten to match |
| 3 | The abstract's "opposite conclusion" was too broad | New terms "blocking rival" (PSR denial, godless realism) and "contrary rival" (reverse ontological). Applied in the abstract, §2, §4, §5.2, §6 and the conclusion |
| 4 | Narrow the sceptical-theism symmetry | §5.3 rewritten. The claim is now the narrow same-kind symmetry. It then examines three candidate independent sources (definition, experience, testimony) and does not claim no source escapes |
| 5 | Give Pruss more room | §4: non-entailing explanation is ordinary (Pruss 2009, 52), not a theological exception. The objection now targets whether it covers the totality (Pruss 2009, 86) |
| + | Distinguish the Gödel and Scott versions | §6: Gödel's 1970 axioms are inconsistent (IJCAI 2016). Scott's are consistent with modal collapse (ECAI 2014). Benzmüller 2026 (Lean 4) reports that KB suffices, which matches §6's B point |

## Citation check: 0 VERIFY markers remain
Corrections made:
- Putnam: "The Tale of Quantum Logic" is by Maudlin. The retraction is Putnam 1994. BJPS 2005 fixed. "Is logic empirical?" dated 1969.
- Oppy: pages moved to 130–137, and one unsupported Oppy citation removed.
- Craig & Sinclair: the quantum reply is about the vacuum, not the nucleus (pp. 182–183).
- Plantinga: 219–221.
- *Reasonable Faith*: moral argument 172–183, epistemic vs. metaphysical possibility on p. 185.
- Bergmann 2009: the claimed content was not in the chapter, so the sentence was rewritten to what p. 389 actually says.
- Pruss 2006 dropped, because its pages were not seen.

Resting on secondary sources only:
- van Inwagen 202–204, via Pruss 2009 p. 50.
- Sobel 1987 pages.

Bond 2026a = Zenodo 10.5281/zenodo.21431106 (Paper III). Bond 2026b (the flip, Paper IV) has no DOI and is cited as a manuscript in the public repo.

## OT material added (labelled as a model, not as evidence about minds)
- §2: omission floor vs. bounded commission tax (Paper III appendix) as a model of question 2. Stich 1990 and Hoffman et al. 2015 are the philosophical anchors.
- §8.1: reflection cannot recover an omitted feature.
- §8.5: the flip concedes part of Plantinga's premise, and local reliability follows.

## Machine checks: formal/
- `formal/Formal/Modal.lean` and `formal/Formal/Probability.lean`: Lean 4.32.2 + Mathlib. Built on Atlas: 13 theorems, no sorry. The modal theorems are axiom-free apart from propext. The probability theorems use the standard 3 axioms (`formal/axioms.log`). Paper Note 4 records the checks.
- `formal/symbolic_checks.py`: SymPy 1.14.0 plus an exhaustive search over all Kripke frames with up to 3 worlds. 15/15 PASS on Atlas.

What is NOT machine-checked: any philosophical premise. The checks cover logic and arithmetic only. That is validity, countermodels, probability bounds and the toy compression examples. They do not cover the warrant claims that carry the paper.

## Before submission
- Anonymity: Bond 2026a/b and the GitHub URL identify the author. Under double-blind review, mask them as "Author (2026a)" and so on.
- Note 3 is the AI-use disclosure placeholder (CUP policy).
- RST-2026-0068 status unknown. Do not send v3 unsolicited while v2 is under review.

---

# Round 3 (2026-10-05): third critique (four points) plus the user's composition point
| # | Point | Done in v3 |
|---|---|---|
| 1 | "Carries no information about untested ones" was too strong | Intro now says success "does not, by itself, establish reliability in untested ones". §2 adds the coin-flip example (correlated bits transfer, independent bits do not) and limits the omission floor to the independent part. Symbolic check added (17/17 PASS) |
| 2 | The §8.1 reflection reply was unconditional | Reflection can extract implications from retained information. The model only rules out recovering absent information. The reply is now explicitly conditional and does not claim the boundary judgment needs absent information |
| 3 | Task success is not fidelity | §8.5 now claims only "tested performance on tested tasks". Accuracy needs its own assessment |
| 3' | User: composition/division | The old wording inferred component accuracy from whole-system success (division; errors can offset). The §2 model sentence was fixed the same way. Craig's 2008 criterion is the composition counterpart, already covered by Lean `old_criterion_inadequate` |
| 4 | Lean cannot establish equal support | §6 no longer says "same kind and degree". It now says: apparent coherence alone gives no demonstrated basis for privileging the theistic premise. Undetected contradiction does not equal equal warrant. The same weakening is applied to §2 Q3, §8.1, the abstract and the conclusion. Note 4 says the checks do not show equal support |

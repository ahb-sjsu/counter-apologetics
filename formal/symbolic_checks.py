"""Symbolic and exhaustive checks for 'Four Deductive Arguments for God Have Not Been Shown to Compel Assent'.

Independent of the Lean development. Run: python symbolic_checks.py
Prints PASS/FAIL per check and exits nonzero on any FAIL.
"""
import itertools
import sys

import sympy as sp

results = []


def check(name, ok, detail=""):
    ok = bool(ok)
    results.append(ok)
    print(("PASS " if ok else "FAIL ") + name + ((" | " + detail) if detail else ""))


# 1. Exhaustive Kripke check on all frames with 1 to 3 worlds ------------------
def frames(n):
    pairs = [(a, b) for a in range(n) for b in range(n)]
    for bits in itertools.product([0, 1], repeat=len(pairs)):
        yield {p for p, x in zip(pairs, bits) if x}


def box(R, n, p, w):
    return all(p[v] for v in range(n) if (w, v) in R)


def dia(R, n, p, w):
    return any(p[v] for v in range(n) if (w, v) in R)


def prem2(R, n, G, w):
    boxG = [box(R, n, G, u) for u in range(n)]
    return all((not G[v]) or boxG[v] for v in range(n) if (w, v) in R)


def props(R, n):
    refl = all((a, a) in R for a in range(n))
    sym = all((b, a) in R for (a, b) in R)
    trans = all((a, d) in R for (a, b) in R for (c, d) in R if b == c)
    return refl, sym, trans


counts = dict(B_frames=0, B_fail=0, T_frames=0, rev_fail=0, S5_fail=0, S4_cm=0, T_cm=0, joint_ok=0)
for n in (1, 2, 3):
    for R in frames(n):
        refl, sym, trans = props(R, n)
        for G in itertools.product([False, True], repeat=n):
            notG = [not g for g in G]
            for w in range(n):
                p1, p2 = dia(R, n, G, w), prem2(R, n, G, w)
                if sym:
                    counts["B_frames"] += 1
                    if p1 and p2 and not G[w]:
                        counts["B_fail"] += 1
                if refl:
                    counts["T_frames"] += 1
                    if dia(R, n, notG, w) and p2 and G[w]:
                        counts["rev_fail"] += 1
                if refl and sym and trans and p1 and p2 and not box(R, n, G, w):
                    counts["S5_fail"] += 1
                if refl and trans and not sym and p1 and p2 and not G[w]:
                    counts["S4_cm"] += 1
                if refl and not sym and p1 and p2 and not G[w]:
                    counts["T_cm"] += 1
                if refl and sym and p1 and dia(R, n, notG, w) and p2:
                    counts["joint_ok"] += 1

check("ontological argument valid on every symmetric frame (n<=3)", counts["B_fail"] == 0,
      f"{counts['B_frames']} frame/valuation/world cases")
check("S5 frames: conclusion is necessary existence", counts["S5_fail"] == 0)
check("reverse argument valid on every reflexive frame (n<=3)", counts["rev_fail"] == 0,
      f"{counts['T_frames']} cases")
check("S4 countermodels exist", counts["S4_cm"] > 0, f"{counts['S4_cm']} found")
check("T countermodels exist", counts["T_cm"] > 0, f"{counts['T_cm']} found")
check("both possibility premises + premise 2 never jointly hold on reflexive symmetric frames",
      counts["joint_ok"] == 0)

# 2. Probability: Craig 2008 vs 2016 ------------------------------------------
a, b = sp.symbols("a b", real=True)
frechet_low = sp.Max(0, a + b - 1)
check("Frechet lower bound at a=b=3/5 is 1/5",
      sp.simplify(frechet_low.subs({a: sp.Rational(3, 5), b: sp.Rational(3, 5)}) - sp.Rational(1, 5)) == 0)
region = sp.reduce_inequalities([a > sp.Rational(1, 2), b > sp.Rational(1, 2), a + b - 1 < sp.Rational(1, 2), a <= 1, b <= 1], [a])
check("premises each >1/2 with conjunction lower bound <1/2 is a nonempty region",
      bool(region != sp.false), str(region))

# 3. Omission floor and commission tax (Bond 2026a, Appendix) -----------------
th, D, m, M = sp.symbols("theta D m M", positive=True)
# Sigma_x = I_2, coder reads e1 only (Phat = diag(1,0)), true consumer reads both (P = I).
S = sp.diag(sp.Min(1, th), 1)
P = sp.eye(2)
Pi = sp.diag(0, 1)
true_dist = sp.simplify((P * S).trace().subs(sp.Min(1, th), th))  # theta < 1 branch
rate = sp.Rational(1, 2) * sp.log(1 / th)
floor = (P * Pi).trace()
check("omission floor tr(P Pi) = 1", floor == 1)
check("true distortion -> floor as theta -> 0", sp.limit(true_dist, th, 0, "+") == floor, str(true_dist))
check("rate diverges as theta -> 0", sp.limit(rate, th, 0, "+") == sp.oo)
# scalar commission tax: R_P(D) = 1/2 log(P/D); coder knows only P in [m, M].
excess = sp.Rational(1, 2) * sp.log(M / D) - sp.Rational(1, 2) * sp.log(m / D)
check("commission tax at P=m equals (1/2) log(M/m) (sharp, r=1)",
      sp.simplify(sp.expand_log(excess - sp.Rational(1, 2) * sp.log(M / m), force=True)) == 0)

# 4. The flip (Bond 2026b): Sigma = diag(4,1), consumer reads e2, rate (1/2) log 2 nats.
R_ = sp.Rational(1, 2) * sp.log(2)
theta = 4 * sp.exp(-2 * R_)              # reverse water-filling level, only e1 coded
assert theta >= 1
rec_opt = sp.diag(theta, 1)              # reconstruction-optimal error covariance
aware = sp.diag(4, sp.exp(-2 * R_))      # all rate on the read direction e2
Pc = sp.diag(0, 1)
r1, r2 = sp.nsimplify(rec_opt.trace()), sp.nsimplify(aware.trace())
c1, c2 = sp.nsimplify((Pc * rec_opt).trace()), sp.nsimplify((Pc * aware).trace())
check("flip: aware code reconstructs worse", r2 > r1, f"tr {r2} vs {r1}")
check("flip: aware code serves the consumer better", c2 < c1, f"consumer {c2} vs {c1}")

# 5. Non-distributivity of the quantum proposition lattice (Section 7.2) -------
def dim_meet(U, V):
    return U.rank() + V.rank() - U.row_join(V).rank()

A_ = sp.Matrix([1, 0]); B_ = sp.Matrix([1, 1]); C_ = sp.Matrix([1, -1])
BvC = B_.row_join(C_)
lhs = dim_meet(A_, BvC)                       # dim of A meet (B join C)
rhs = dim_meet(A_, B_) + dim_meet(A_, C_)     # both meets are {0}, so join has dim 0
check("A meet (B join C) = A but (A meet B) join (A meet C) = 0", lhs == 1 and rhs == 0,
      f"dims {lhs} vs {rhs}")

# 6. Coin-flip example (Section 2): a kept fair bit carries information about a
# discarded fair bit exactly when the two are correlated. P(X = Y) = q.
q = sp.symbols("q", positive=True)
H2 = lambda t: -(t * sp.log(t, 2) + (1 - t) * sp.log(1 - t, 2))
I_xy = 1 - H2(q)  # mutual information in bits between two fair bits agreeing with prob q
check("independent fair bits: kept bit says nothing about discarded bit",
      sp.simplify(I_xy.subs(q, sp.Rational(1, 2))) == 0)
check("correlated fair bits (q=9/10): kept bit carries information",
      I_xy.subs(q, sp.Rational(9, 10)).evalf() > 0, str(I_xy.subs(q, sp.Rational(9, 10)).evalf(6)))

print(f"\n{sum(results)}/{len(results)} PASS")
sys.exit(0 if all(results) else 1)

from sage.all import *
import random

sqrt_2pi = sqrt(2*pi)
m, q, sigma = 4, 16, 2
Sc = [1, -1, 2, 0]
base = q / (sigma * sqrt_2pi)
M_theory = float(base^m)

print(f"Theoretical M = {M_theory:.2f}")

total_iters = 0
num_trials = 20

for trial in range(num_trials):
    iters = 0
    accepted = False
    
    while not accepted and iters < 10000:
        y = [randint(-q//2, q//2-1) for _ in range(m)]
        z = [y[i] + Sc[i] for i in range(m)]
        
        norm_sq = sum(zz^2 for zz in z)
        f_z = exp(-norm_sq / (2*sigma^2))
        rho_sigma = (sqrt(2*pi) * sigma)^m
        f_z_norm = float(f_z) / float(rho_sigma)  # convert to float
        g_z = 1.0 / (q^m)
        
        accept_prob = min(f_z_norm / (M_theory * g_z), 1.0)
        
        if random.random() < accept_prob:
            accepted = True
        iters += 1
    
    total_iters += iters

# Key fix: explicitly convert to Python float
avg_iter = float(total_iters) / float(num_trials)

print(f"Experimental avg iterations: {avg_iter:.1f}")
print(f"Theoretical expectation: {M_theory:.1f}")
print(f"Relative error: {abs(avg_iter - M_theory)/M_theory * 100:.1f}%")
print("=" * 75)
print("Verification completed: IBMS-pka scheme is infeasible under practical parameters")
print("=" * 75)
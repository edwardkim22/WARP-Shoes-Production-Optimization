# WARP Shoe Company Production Optimization

## Problem Background

WARP Shoe Company faced a production crisis in early 2006 when a major competitor went bankrupt, creating an opportunity with doubled market demand. With zero starting inventory and limited resources, the company needed an optimal production schedule for February 2006 to maximize profitability.

**Key Constraints:**
- $10M raw materials budget
- 72 machines × 12 hours/day × 28 days
- 8 warehouses with capacity limits
- 165 different raw material types
- 557 shoe varieties to consider

## Technical Approach

The solution combines multiple technologies to create a comprehensive optimization framework:

**Data Pipeline:**
- **Java + SQL** → Extract historical demand from Access database (1997-2003)
- **R** → Statistical forecasting with linear regression and missing value imputation
- **AMPL** → Mixed integer programming model formulation
- **Gurobi** → Commercial optimization solver

**Model Structure:**
- 565 decision variables (557 production + 8 warehouse binary)
- Multi-constraint optimization across materials, capacity, labor, and storage
- LP relaxation due to computational complexity

## Results & Impact

🎯 **Optimal Profit: $11,777,402.50**

The solution strategically prioritizes high-margin shoes while accepting shortfalls on lower-margin products. Key insights from sensitivity analysis:

| Resource | Status | Impact |
|----------|--------|---------|
| Raw Materials | **Bottleneck** | Primary profit constraint |
| Machine Hours | Underutilized | No improvement from capacity increase |
| Warehouse Space | Sufficient | Additional space unnecessary |
| Budget | Adequate | More funding won't help without materials |

**Business Recommendation:** Secure additional raw material suppliers for maximum profit impact.

## Repository Structure

├── WARP_Shoes.dat     # Input data file
├── WARP_Shoes.mod     # Mathematical model definition
├── WARP_Shoes.out     # Solution results
└── WARP_Shoes.run     # Execution script

**To Run:** `ampl WARP_Shoes.run` (requires AMPL + Gurobi license)

---

*University of Toronto MIE262 Operations Research project demonstrating practical manufacturing optimization*

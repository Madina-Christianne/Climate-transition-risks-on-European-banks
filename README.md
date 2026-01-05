# Climate Transition Policies and Bank Capital Dynamics in Europe

This project studies how European banks adjust their balance sheets and capital ratios in response to climate transition policies. Rather than estimating causal effects, the focus is on mechanisms and dynamics that is capital buffers, asset growth, leverage, and profitability.


## Table of Contents
1. Research Questions
2. Data Collection
3. Methodological Approach
4. Analysis in R: Capital Ratios and Policy Milestones
5. Analysis in Python: Balance-Sheet Dynamics
6. Key Findings
7. Next Steps


## 1. Research Questions
- How do banks' capital ratio's (CET1) evolve around climate policy milestones ?
- Do banks adjust through asset growth or leverage?
- Are there systematic differences between Eastern and Western European banks?


## 2. Data Collection

Data is sourced primarily from the European Central Bank (ECB), using the Consolidated Banking Data portal.

- Quarterly balance-sheet data for domestic banks
- Countries: DE, FR, NL, LU, PL, HU, HR, LT
- Period: 2014–2024

Key variables include CET1 ratios, return on equity (ROE), total assets, and leverage proxies.


## 3. Methodological Approach

The project combines two complementary approaches:

- **R** is used for policy-event analysis and difference-in-differences regressions, focusing on how bank capital ratios respond to major climate policy announcements.
- **Python** is used to study balance-sheet dynamics, such as asset growth and leverage adjustments, to understand *how* banks adapt rather than whether policies caused the change.

The objective is not causal identification, but to document adjustment mechanisms and structural patterns.


## 4. Analysis in R: Capital Ratios and Policy Milestones

In R, we test whether banks’ CET1 ratios change following key EU climate policy milestones, such as the European Green Deal (2019) and the ECB climate stress test (2020).

**Hypothesis:**  
Banks increase capital buffers after climate-related policy announcements, with heterogeneous effects across regions.

The R scripts:
- Construct policy dummies
- Implement difference-in-differences regressions
- Visualize CET1 trends across countries

Key outputs include regression tables and time-series plots of CET1 ratios.


## 5. Analysis in Python: Balance-Sheet Dynamics

Python is used to analyze how banks adjust their balance sheets in response to climate transition pressures.

**Focus:**
- Asset growth
- Leverage changes
- Profitability (ROE)

**Hypothesis:**  
Capital adjustments occur primarily through leverage and balance-sheet restructuring rather than through asset contraction.

The Python analysis:
- Constructs a quarterly bank-level panel
- Computes asset growth and leverage changes
- Estimates panel regressions linking CET1, ROE, and balance-sheet dynamics

This complements the R analysis by highlighting adjustment channels.



### Capital adjustment dynamics
![Asset growth by country](figures/asset_growth.png)

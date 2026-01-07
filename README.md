# Climate Transition Policies and Bank Capital Dynamics in Europe

This project studies how European banks adjust their balance sheets and capital ratios in response to climate transition policies. Rather than estimating causal effects, the focus is on mechanisms and dynamics that is capital buffers, asset growth, leverage, and profitability.


## Table of Contents

- [Research Questions](#research-questions)
- [Data Collection](#data-collection)
- [Methodological Approach](#methodological-approach)
- [Analysis in R: Capital Ratios and Policy Milestones](#analysis-in-r-capital-ratios-and-policy-milestones)
- [Analysis in Python: Balance-Sheet Dynamics](#analysis-in-python-balance-sheet-dynamics)
- [Key Findings](#key-findings)
- [Next Steps](#next-steps)



## Research Questions

- How do banks' capital ratio's (CET1) evolve around climate policy milestones ?
- Do banks adjust through asset growth or leverage?
- Are there systematic differences between Eastern and Western European banks?


## Data Collection

Data is sourced primarily from the European Central Bank (ECB), using the Consolidated Banking Data portal.

- Quarterly balance-sheet data for domestic banks
- Countries: Germany (DE), France (FR), Netherlands (NL), Luxembourg (LU), Poland (PL), Hungary (HU), Croatia (HR), Lithuania (LT)
- Period: 2014–2024

Key variables include CET1 ratios, return on equity (ROE), total assets, and leverage proxies.


## Methodological Approach

The project combines two complementary approaches:

- **R** is used for policy-event analysis and difference-in-differences regressions, focusing on how bank capital ratios respond to major climate policy announcements.
- **Python** is used to study balance-sheet dynamics, such as asset growth and leverage adjustments, to understand *how* banks adapt rather than whether policies caused the change.

The objective is not causal identification, but to document adjustment mechanisms and structural patterns.


## Analysis in R: Capital Ratios and Policy Milestones

In R, we test whether banks’ CET1 ratios change following key EU climate policy milestones, such as the European Green Deal (2019) and the ECB climate stress test (2020).

**Hypothesis:**  
Banks increase capital buffers after climate-related policy announcements, with heterogeneous effects across regions.

The R scripts:
- Construct policy dummies
- Implement difference-in-differences regressions
- Visualize CET1 trends across countries

Key outputs include regression tables and time-series plots of CET1 ratios.

<img width="1920" height="1080" alt="Average CET1 quarterly" src="https://github.com/user-attachments/assets/94178576-9798-4221-a3e0-7f9ac42627ac" />


<img width="1920" height="1080" alt="ROE graph quarterly" src="https://github.com/user-attachments/assets/a29f57c2-fb50-44c3-85ca-0417b73716d7" />


## Analysis in Python: Balance-Sheet Dynamics

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

<img width="640" height="480" alt="Asset growth figure py" src="https://github.com/user-attachments/assets/e636057a-6dbf-4743-ac2a-08c736dbb420" />


## Key Findings (Current Progress)

Based on the analyses conducted so far in R and Python, several patterns stand out:

- Banks tend to strengthen capital buffers following major climate policy announcements.
CET1 ratios increase around key EU climate milestones, such as the European Green Deal (2019) and the ECB climate stress test (2020), 
suggesting that banks respond proactively to climate-related regulatory signals.

- Capital adjustment mainly occurs through leverage management rather than asset contraction.
Balance-sheet dynamics indicate that banks adjust by reducing leverage instead of shrinking total assets, pointing to restructuring rather than withdrawal from lending activities.

- Profitability plays a secondary role.
Return on equity does not appear to be the main driver of capital strengthening, reinforcing the idea that balance-sheet decisions dominate the adjustment process.

- Regional heterogeneity matters.
Eastern European banks display stronger responses in capital and profitability measures compared to Western European banks, highlighting uneven adjustment paths across the European banking system.

- Results are robust across policy definitions.
The main findings hold when using both 2019 and 2020 climate policy milestones as reference points.

At this stage, the project documents adjustment mechanisms rather than claiming direct causal effects.

## Next Steps

This project is ongoing and will be extended along several dimensions:

 **1.Bank-level heterogeneity**: The current analysis is conducted at the country level. The next step is to explore bank-level differences, such as:
- size
- exposure to international markets
- initial capital constraints

This is essential to understand how climate transition risks are distributed across institutions.

**2.Longer-term dynamics**: Climate transition policies operate over long horizons. Future work will study adjustment paths over multiple years, 
distinguish short-term regulatory reactions from structural balance-sheet changes and assess the persistence of capital adjustments

**Extension using SAS**

SAS will be used to:

- handle larger and more granular datasets

- implement industry-standard panel and risk analysis workflows

- align the project more closely with tools used in banking, regulation, and financial supervision

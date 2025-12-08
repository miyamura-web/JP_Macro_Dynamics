# Macroeconomic Dynamics of Japan: Consumption Behaviour, Phillips Curve Breakdown, Monetary Policy, and GDP Forecasting

## Introduction
This project provides an econometric and theoretical analysis of Japan’s macroeconomic environment. Using real datasets on GDP, CPI, unemployment, and policy rates, the study investigates Japan’s growth trends, inflation dynamics, consumption behaviour, and the breakdown of the Phillips Curve. Visual models such as IS–LM and AD–AS are incorporated to interpret structural issues in Japan’s economy.

## 🧭 Motivation
Japan is a unique macroeconomic case where:
- Inflation remains near zero for decades, despite massive monetary stimulus.
- GDP growth is stagnant, showing little cyclical fluctuation.
- The Phillips Curve has collapsed, showing no inflation–unemployment trade-off.
- Consumption behaviour remains stable, driven strongly by income.
  
This project attempts to empirically diagnose these anomalies using data-driven evidence.

## 🎯 Objectives
- To forecast Japan’s GDP using ARIMA/SARIMAX models.
- To estimate Japan’s consumption function using regression analysis.
- To test the validity of the Phillips Curve for Japan.
- To evaluate the effectiveness of monetary policy in a low-interest, near-deflation environment.
- To illustrate macroeconomic relationships using IS–LM and AD–AS curve plots.

---

## 📂 Repository Structure

```
├── datasets/
│   ├── 1. Unemployment Data.csv
│   ├── 2. CPI Data.csv
│   ├── 3. GDP Data.csv
│   ├── 4. Policy Data.csv
│   ├── 5. Consumption Data .csv
│   ├── Merged Data.csv
├── SQL File/
│   ├── 1. Data Pre-processing.sql 
├── Python File/
│   ├── 1. Scrapping data.ipynb
│   ├── 2. Philips Curve.ipynb
│   ├── 3. Consumption Function.ipynb
│   ├── 4. Japan's GDP Forecasting.ipynb
├── Report on Project Japan.pdf   [ A detailed report on the project ]
├── 1. Summary.pdf                [ A short summary of the full project ]
└── README.md
```

## 📊 Modeling Framework

- Consumption Function (Log–Log OLS)

   lnC=α+βlnY+γr+ϵ
- Phillips Curve Estimation

   πt​=α+βut−1​+γrt−1​+ϵ
- GDP Forecasting using ARIMA

  ARIMA(0,1,0)​

## 🏛️ Policy Recommendations
- ✔ Strengthen Fiscal Policy

Because consumption → income-driven (R² = 0.77), fiscal expansion has large effects.

- ✔ Use Unconventional Monetary Tools

Yield Curve Control

Forward guidance

Large-scale QE

- ✔ Structural Reforms

Increase female & elderly labour participation

Immigration reform

Productivity-enhancing investment

- ✔ Long-Term Growth Strategy

Digital transformation

High-tech & green sectors

R&D incentives

- ✔ Improve Inflation Expectations

Coordinated fiscal–monetary communication

Persistent policy commitment


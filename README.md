# ⚙️ Dynamic System Identification & Parametric Modeling

## 📌 Project Overview
This repository contains MATLAB and Simulink implementations for the mathematical modeling and system identification of dynamic processes.The project explores both non-parametric and parametric methods to estimate transfer functions and state-space models for physical systems, specifically targeting a second-order hydraulic system and a non-linear DC-DC Boost Converter.

The goal was to calibrate experimental data, extract characteristic parameters, and validate mathematical models against real simulated data with high precision.

## 🚀 Key Projects Included

### 1. Transient Response Analysis (Linear Regression)
**System:** Second-order hydraulic system.
**Method:** Step response analysis and linear regression.
**Output:** Identified static gain ($K$), dominant time constant ($T_1$), and non-dominant time constant ($T_2$). 
**Validation:** State-space representation with non-zero initial conditions achieved an excellent tracking error (eMPN) of 6.09%.

### 2. Frequency Response Analysis (Chirp Excitation)
**System:** Second-order hydraulic system.
**Method:** Frequency sweep using a Chirp signal to determine natural frequency ($\omega_n$) and damping ratio ($\zeta$).
**Validation:** Converted to state-space matrices ($A, B, C, D$) to accurately simulate the system's frequency attenuation (low-pass filter behavior).

### 3. Parametric Identification (DC-DC Boost Converter)
**System:** Non-linear DC-DC Boost Converter.
**Method:** Excited the system around its operating point using a Pseudo-Random Binary Sequence (PRBS/SPAB).
**Models Tested:** ARX, ARMAX, Output Error (OE), Box-Jenkins (BJ), and Subspace State-Space Estimation (N4SID, SSEST).
**Best Result:** The **Box-Jenkins (BJ)** model achieved the highest accuracy with a **FIT of 92.37%** , effectively modeling both the system dynamics and the correlated noise.

## 🛠️ Tech Stack & Tools
**MATLAB & Simulink**: Data acquisition, data pre-processing (decimation, detrending), and simulation.
**System Identification Toolbox**: Utilized functions like `arx`, `armax`, `oe`, `bj`, `n4sid`, and `ssest`.
**Control Systems Theory**: Transfer functions, State-Space representation, Residual Correlation tests (Autocorrelation & Cross-correlation).

## 📂 Repository Structure
* `/scripts`: MATLAB (`.m`) source code for data analysis, regression, and model estimation.
* `/simulink_models`: `.slx` files representing the physical environments.
* `/docs`: Full technical documentation (`.pdf`) detailing mathematical proofs, parameter extraction, and comparative tables.

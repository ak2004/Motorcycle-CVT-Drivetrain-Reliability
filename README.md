# Motorcycle-CVT-Drivetrain-Reliability
Reliability analysis of a motorcycle CVT drivetrain using FMECA, Weibull distributions, RBD, Markov modeling, and MATLAB.
# Motorcycle CVT Drivetrain Reliability Analysis

Reliability engineering analysis of a motorcycle Continuously Variable Transmission (CVT) drivetrain using **FMECA, Reliability Block Diagrams (RBD), Weibull analysis, and continuous-time Markov modeling** to identify critical failure modes and quantify system reliability.

## Project Overview

The drivetrain was modeled using seven primary mechanical components responsible for transmitting engine torque to the rear wheel:

- Multi-plate clutch assembly
- Rubber drive belt
- Input sheave (primary pulley)
- Output sheave (secondary pulley)
- Gearbox
- Bearings
- Oil seals

The analysis evaluates component failure modes, system architecture, time-dependent reliability, and degraded operating states to identify the primary contributors to drivetrain failure.

---

## Failure Modes, Effects & Criticality Analysis (FMECA)

A **Failure Modes, Effects, and Criticality Analysis (FMECA)** was performed across the drivetrain components.

Risk Priority Number was calculated using:

**RPN = Severity × Occurrence × Detection**

| Component | Critical Failure Mode | RPN |
|---|---|---:|
| Rubber Drive Belt | Edge cracking / delamination | **140** |
| Input Sheave | Sliding roller weight seizure | **140** |
| Multi-plate Clutch | Friction plate wear | **128** |
| Bearings | Grease starvation / corrosion | **112** |
| Oil Seals | Lip wear / hardening | **108** |
| Output Sheave | Contra spring fracture | **96** |
| Gearbox | Gear tooth spalling | **72** |

The highest-risk failure modes were **belt edge cracking/delamination** and **input-sheave roller seizure**, each with an RPN of **140**.

The drive belt was also identified as a critical single-point failure because complete belt failure interrupts torque transmission through the drivetrain.

---

## Reliability Block Diagram

The drivetrain was represented using a **series-parallel Reliability Block Diagram**.

The multi-plate clutch was modeled as a redundant parallel subsystem, while the drive belt, input sheave, output sheave, gearbox, bearings, and oil seals were modeled in series.

![Reliability Block Diagram](images/rbd.png)

The system reliability relationship is:

$$
R_{system}(t)=
R_{clutch}(t)
R_{belt}(t)
R_{input}(t)
R_{output}(t)
R_{gearbox}(t)
R_{bearings}(t)
R_{seals}(t)
$$

The two-plate clutch subsystem was modeled as:

$$
R_{clutch}(t)=1-[1-R_{plate}(t)]^2
$$

This architecture accounts for continued drivetrain operation following failure of one clutch friction plate while treating the remaining torque-path components as nonredundant elements.

---

## Component Reliability Modeling

A one-year continuous-operation mission was defined as:

**t = 8,760 hours**

Reliability parameters were obtained from the **Barringer Weibull Database** and the **NSWC-11 Handbook of Reliability Prediction Procedures for Mechanical Equipment**.

Weibull distributions were used for the clutch, drive belt, gearbox, bearings, and oil seals. Exponential reliability models were used for the input and output sheaves.

| Component | Distribution | R(1 Year) |
|---|---|---:|
| Multi-plate Clutch | Weibull / Parallel | 0.9988 |
| Input Sheave | Exponential | 0.9869 |
| Rubber Drive Belt | Weibull | 0.7652 |
| Output Sheave | Exponential | 0.9869 |
| Gearbox | Weibull | 0.9877 |
| Bearings | Weibull | 0.8839 |
| Oil Seals | Weibull | 0.8067 |
| **Complete Drivetrain** | **Series-Parallel RBD** | **0.5243** |

---

## Weibull Reliability Analysis

Weibull probability density functions were used to examine the time-dependent failure characteristics of the mechanical components.

### Drive Belt

![Drive Belt Weibull Distribution](images/belt_weibull.png)

**β = 1.2, η = 26,280 hr**

The shape parameter indicates near-constant to mildly increasing hazard, consistent with fatigue and surface-wear failure mechanisms.

### Bearings

![Bearing Weibull Distribution](images/bearing_weibull.png)

**β = 1.3, η = 43,800 hr**

The bearing model represents a slightly increasing failure rate associated with wear, contamination, and fatigue.

### Gearbox

![Gearbox Weibull Distribution](images/gearbox_weibull.png)

**β = 2.0, η = 78,840 hr**

The higher Weibull shape parameter represents increasing wear-out behavior associated with repeated gear-tooth loading.

---

## System Reliability

Combining the component reliability values through the series-parallel RBD produced:

# 52.43% One-Year System Reliability

The result represents a **no-maintenance, continuous-operation scenario over 8,760 hours**.

The drive belt, oil seals, and bearings were identified as major contributors to overall reliability degradation, while clutch redundancy improved system reliability by allowing continued operation following failure of one friction plate.

---

## Markov Chain Reliability Model

A **three-state Continuous-Time Markov Chain (CTMC)** was developed to model transitions between fully operational, degraded, and failed drivetrain conditions.

![3-State Markov Chain Model](images/markov_chain.png)

### State 0 — Fully Operational
All drivetrain components and both clutch plates are functioning.

### State 1 — Degraded
One clutch plate has failed, but the remaining plate allows the drivetrain to continue operating.

### State F — Failed
The drivetrain can no longer transmit power. This is modeled as an absorbing state.

The state transitions are:

- **State 0 → State 1:** `2λc`
- **State 0 → State F:** `λs`
- **State 1 → State F:** `λc + λs`

where:

- `λc` = clutch plate failure rate
- `λs` = combined failure rate of all series components

The combined series-component failure rate was calculated as:

**λs = 7.358 × 10⁻⁵ failures/hr**

The resulting Markov reliability function is:

$$
R(t)=e^{-\lambda_s t}
\left[
2e^{-\lambda_c t}-e^{-2\lambda_c t}
\right]
$$

At one year:

$$
R(8760)\approx0.5243
$$

The Markov model therefore produced approximately the same **52.43% one-year reliability** as the Reliability Block Diagram analysis.

---

## Key Results

| Metric | Result |
|---|---:|
| Components Analyzed | **7** |
| Highest RPN | **140** |
| One-Year Mission | **8,760 hr** |
| Series Component Failure Rate | **7.358 × 10⁻⁵ failures/hr** |
| RBD System Reliability | **52.43%** |
| Markov System Reliability | **52.43%** |

### Major Findings

- **Belt edge cracking/delamination** and **input-sheave roller seizure** produced the highest RPN values.
- The **drive belt acts as a single-point failure** in the drivetrain torque path.
- **Clutch redundancy** enables continued operation following failure of one friction plate.
- The **drive belt, oil seals, and bearings** are major contributors to system reliability degradation.
- Independent **RBD and Markov models produced approximately the same one-year reliability result**.

---

## Engineering Recommendations

The reliability analysis identified several opportunities for preventive maintenance and drivetrain reliability improvement:

- Inspect drive-belt tension and edge cracking at regular service intervals.
- Replace degraded oil seals before lubricant loss contributes to secondary failures.
- Monitor bearings for vibration, contamination, and lubrication degradation.
- Inspect and lubricate input-sheave roller weights to reduce seizure risk.
- Verify belt alignment during installation to reduce premature belt degradation.

---

## Tools & Methods

**MATLAB** • **FMECA** • **RPN** • **Reliability Block Diagrams** • **Weibull Analysis** • **Continuous-Time Markov Chains** • **Failure Rate Analysis**

---

## Full Technical Report

The full report contains the complete **FMECA, reliability calculations, Weibull parameters, Reliability Block Diagram development, Markov transition equations, assumptions, and engineering recommendations**.

[View Full Technical Report](Motorcycle_Drivetrain_Reliability_Report.pdf)

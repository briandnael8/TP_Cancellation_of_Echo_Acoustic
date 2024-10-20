# Advanced Signal Methods - Annulation d’Écho Acoustique

This repository contains a lab focused on implementing and testing adaptive filtering techniques for acoustic echo cancellation using the Least Mean Squares (LMS) algorithm. The lab explores various parameters affecting the performance of the LMS algorithm and applies the filter to audio signals with echo to improve audio quality.

## Summary

The lab covers the following topics:

1. **LMS Algorithm Implementation:**
   - The LMS algorithm is used to adaptively filter an audio signal by minimizing the error between the desired signal and the filter output.
   - Key components include the error equation, filter output, and weight update equation, where the step size parameter (µ) controls the convergence speed.

2. **Validation of the LMS Algorithm:**
   - Tests were conducted to validate the convergence of the LMS filter coefficients toward the optimal values.
   - The effect of filter length (P) and step size (µ) on the algorithm's performance was studied to find suitable parameter settings.

3. **Application to Acoustic Echo Cancellation:**
   - The LMS filter was applied to audio signals with echo, including single and dual-voice scenarios.
   - In the dual-voice case, the algorithm successfully removed the distant voice while retaining the nearby voice, showing the effectiveness of the LMS filter in canceling echo.

4. **Experimentation:**
   - Various tests explored the influence of filter length (P) and step size (µ) on the echo cancellation performance.
   - Increasing µ speeds up convergence but can cause instability, while longer filter lengths improve echo cancellation but require more computation.

## Requirements

To run the MATLAB scripts, you will need:
- MATLAB software with Signal Processing Toolbox installed.

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/briandnael8/TP1_Echo_Cancellation.git
    ```
2. Open the MATLAB scripts (`main.m`, `algolms.m`) in MATLAB.
3. Execute the scripts to test the LMS algorithm with different parameters and audio files.

## Goal

The primary goal of this lab is to provide hands-on experience with adaptive filtering techniques for audio signal processing, focusing on acoustic echo cancellation.


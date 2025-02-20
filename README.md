# Investigating GAL1 Expression in Budding Yeast: A Multi-Dataset Study of Michaelis–Menten Model Invalidation

This repository contains code and data for the article **"Investigating GAL1 expression in budding yeast: a multi-dataset study of Michaelis–Menten model invalidation."** It provides the necessary files for reproducing the parameter estimation and model invalidation results discussed in the study.

## Repository Contents

### **Code_Results_3ODEs**
This folder contains the following files and subfolders:

- **Results_3ODEs/**: Contains results for all training-testing combinations reported in the article.
- **Dataset_ZAD4.mat**: A `.mat` file containing the four datasets used for parameter estimation and model invalidation.
- **GuessSet50_3ODEs.mat**: A `.mat` file containing 50 initial guess sets for model parameters.
- **run_gal1_3ODEs_parfor.m** and **gal1_3ODEs.m**: MATLAB scripts for executing parameter estimation using the AMIGO2 toolbox.
- **PlotnSave.m**: A MATLAB plotting function for generating result figures.
- **Residual.m**: A MATLAB statistical function for calculating FIT and AIC metrics.

## **Software Requirements**
- MATLAB
- [AMIGO2 Toolbox](https://sites.google.com/site/amigo2toolbox/) (for parameter estimation and model simulation)

## **AMIGO2 Toolbox Installation**
The full tutorial for downloading, installing, and operating the AMIGO2 Toolbox can be found [here](https://sites.google.com/site/amigo2toolbox/). Ensure that AMIGO2 is correctly set up before running the provided scripts.

## **Usage Instructions**
1. Load `Dataset_ZAD4.mat` in MATLAB.
2. Run `run_gal1_3ODEs_parfor.m` to perform parameter estimation and model invalidation.
3. Use `PlotnSave.m` to generate figures for visualization.
4. The results will be saved in the `Results_3ODEs/` folder.

For any issues or inquiries, please refer to the article or contact the repository maintainers.

---

**Citation:**
If you use this repository for your research, please cite our article:

> *Investigating GAL1 expression in budding yeast: a multi-dataset study of Michaelis–Menten model invalidation.*


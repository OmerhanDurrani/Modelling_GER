# Modelling_GER

Overview
This repository contains the data and R scripts used in the research article:
Title: How to Parameterise Gastric Evacuation Rates in Fish using a General Power Function: A Step-by-Step Guide with R
Author: Ömerhan Dürrani

Summary
The analysis of gastric evacuation (GE) data presents significant challenges because of the complex interdependencies among the factors influencing the process. To address these challenges, a general power function was developed in 1992 and further refined in 1998, providing a robust method for accurately identifying the best-fit function while simultaneously assessing the impact of various potential variables. This paper introduces and illustrates the R code developed for parameter estimation of the general power function, incorporating key variables such as fish size, meal size, and temperature. The statistical procedures outlined in this study are versatile and applicable to a wide range of GE data and can be readily extended to include additional factors influencing the GE process.



Dataset
The dataset (GER_data.csv) includes gastric evacuation (GE) data for brown trout (Salmo trutta) from Dürrani and Seyhan (2021) (expno 1-5) and rainbow trout (Oncorhynchus mykiss) from Dürrani (2022) (expno 6-14).
Variables in the CSV file:
•	expno: Experiment number
•	temp: Temperature in °C
•	predlcm: Fish total length in cm
•	predw: Fish total weight in g
•	sow: Meal size consumed by the fish at empty stomach
•	stw: Weight of the recovered stomach contents at a given postprandial time t (hours)

R Scripts
This repository contains two R scripts:
1.	Modelling_GER_1.R: Provides R code for Examples 1-6, with results detailed in Tables 1-7 of the paper.
2.	Modelling_GER_2.R: Provides R code for Example 7, with results detailed in Tables 8 and 9 of the paper.

Excel Guide
The Excel file included in this repository provides a step-by-step guide for constructing Figure 1, Figure 2a, and Figure 2b using the summarized GER model developed for brown trout and rainbow trout.

Interpretation of Results
For detailed interpretation of the output results, please refer to the research article.



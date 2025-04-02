# **Modelling_GER**

## **Overview**
This repository contains the dataset and R scripts used in the research article:  

### **Title:**  
**Modelling Gastric Evacuation Rates in Fish With a General Power Function: A Step-by-Step Guide to Parameter Estimation and Analysis Using R Statistical Software**  

### **Author:**  
**Ömerhan Dürrani**  

## **Summary**  
Accurate modelling of gastric evacuation (**GE**) is essential for optimising feeding strategies in aquaculture and improving predator–prey interaction models. **GE analysis is complex** due to the interdependence of multiple variables. To address this, a **general power function** was developed in 1992 and refined in 1998 using **non-linear regression techniques**. This method identifies the best-fit evacuation function while assessing key predictor variables. The study demonstrates the application of **R statistical software** for parameter estimation, analysing the effects of **fish size, meal size, and temperature** on **gastric evacuation rates (GER)** in **brown trout (*Salmo trutta*)** and **rainbow trout (*Oncorhynchus mykiss*)**. These statistical methods are **versatile**, suitable for a wide range of GE datasets, and can be expanded to include additional factors, making them valuable tools in **fisheries management, ecological modelling, and aquaculture**.  

## **Citation**  
> **Dürrani, Ö. (2025).** Modelling Gastric Evacuation Rates in Fish With a General Power Function: A Step-by-Step Guide to Parameter Estimation and Analysis Using R Statistical Software.  
> *Aquaculture Research, 2025(1), 7309111.*  
> [https://onlinelibrary.wiley.com/doi/full/10.1155/are/7309111](https://doi.org/10.1155/are/7309111)  

---

## **Dataset**  
The dataset (**GER_data.csv**) contains GE data from:  
- **Brown trout (*Salmo trutta*)** – Experiments 1–5 (*Dürrani & Seyhan, 2021*)  
- **Rainbow trout (*Oncorhynchus mykiss*)** – Experiments 6–14 (*Dürrani, 2022*)  

### **CSV Variables:**  
- **`expno`**: Experiment number  
- **`temp`**: Temperature (°C)  
- **`predlcm`**: Fish total length (cm)  
- **`predw`**: Fish total weight (g)  
- **`sow`**: Meal size at an empty stomach  
- **`stw`**: Weight of stomach contents at a given postprandial time (hours)  

---

## **R Scripts**  
This repository includes two R scripts:  

1. **`Modelling_GER_1.R`** – Covers Examples 1–6, corresponding to **Tables 1–7** in the paper.  
2. **`Modelling_GER_2.R`** – Covers Example 7, corresponding to **Tables 8 and 9** in the paper.  

---

## **Excel Guide**  
An **Excel file** is provided for constructing **Figure 10** and **Figures 11a & 11b**, summarising the **GER model** for both species.  

---

## **Results Interpretation**  
For detailed explanations, refer to the full research article:  
[https://onlinelibrary.wiley.com/doi/full/10.1155/are/7309111](https://doi.org/10.1155/are/7309111)  

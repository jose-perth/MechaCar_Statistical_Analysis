# MechaCar_Statistical_Analysis

## Overview

This project is the weekly challenge for week 15th of the Data Science Bootcamp. It allows us to put into practice and showcase the skills learned in Module 10 of the bootcamp.

### Purpose

Module 15.

## Results

The following files are part of the challenge.

[MechaCarChallenge.R](MechaCarChallenge.R) - R Script with linear regression analysis.
[/resources folder](/resources) - holds data available for analysis


### Deliverable 1. Linear Regression to Predict MPG

Performed a linear regression using the `MechaCar_mpg.csv`. Details of the R script can be seen here: [MechaCarChallenge.R](MechaCarChallenge.R). The expression  used is:

```R
lm( mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mechacar_df)
```

The summary of the model results can be seen here:
![Deliverable 1 Snapshot](resources/deliverable1-snapshot1.png
)

#### Significant Variables

Using a significance level (alpha) of 0.05. We can see the following variables have a significant impact on the dependent variable `mpg`.  That is, their p-value indicate they provide a non-random amount of variance to the `mpg` values.

|Variable | p-value|
|:---|:---:|
|`vehicle_length`     | 2.60e-12  |
|`ground_clearance`   | 5.21e-08  |

#### Slope of linear model

The slope of the linear model is not zero as there are 2 independent variables (see above)significantly related to the outcome variable (`mpg`)

#### Effectiveness of the model

The linear regression produces an R-squared value of **0.7149**.  This indicates that the model is effective in predicting the `mpg` of the MechaCar prototypes.

### Deliverable 2: Summary Statistics on Suspension Coils

Performed summary statistics on the PSI data in the file `Suspension_Coil.csv`.

![Deliverable 2](resources/deliverable2-snapshot1.png)

The design specifications of the coils dictate that the variance must not exceed 100 PSIs.

The summary statistics for the entire dataset, `total_summary` indicate a median of 1498.78 and a variance of 62.293.

However, further analysis of the data by grouping by `Manufacturing_lot` points to issues on *Lot3*.  The mean diverges to 1496.14 and the variance increases over the specification to 170.286.

Lots 1 and 2 show a compliance with specification with means equal to 1500 and 1500.2 and variances of 0.98 and 7.47.

A plot of the density distributions by lot helps visualise the issue with the coils from Lot3.

![Density Distribution by lot](resources/deliverable2-plot1.png)

### Deliverable 3: T-test on Suspension Coils

A One Sample t-test of all the data available compared to the specified population mean of 1500psi shows that the p-value is 0.06028. 

![p-test all values](resources/deliverable3-snapshot1.png)

This is higher than our confidence level (alpha) value of 0.05. However running t-tests for individual Lots shows that Lot3 falls under the confidence level.

Running a One Sample t-test on Lot3 data produces a p-value of 0.04168.

![p-test per lot](resources/deliverable3-snapshot2.png)

It's important to run tests on different categorical groups of the data to be able to spot problems or biases due to an specific value.

Note: I made use of a local function `lot_Pval` to calculate the p-value of the t.test for a given lot, then pulled all the unique `Manufacturing_Lot` values and looped through them, while storing the p-values into a named vector.

```r
## helper function returns p.value of t.test for Manufacturing_Lot==lot
lot_Pval = function(lot){
  return (t.test(PSI~1, data= coils_df, subset=(Manufacturing_Lot == lot), mu=1500)$p.value)
}

## generate a t.test for each existing Manufacturing_Lot
lots <- unique(coils_df$Manufacturing_Lot)
lots_pvalues <- vector()
for (lot in lots){
  lots_pvalues <- c(lots_pvalues,lot_Pval(lot))
}
## set names
names(lots_pvalues) <- lots
```

### Deliverable 4: Study Design: MechaCar vs Competition

I would proposed a study to determine whether the resale value of the MechaCar's is statistically higher than those of competitors in the same vehicle class.

The variable of interest would be the drop on value of the vehicle (`delta_price`), this is the difference between the MSRP of the new vehicle minus the advertised resale price.

Visiting car resale sites, we need to gather at least the following information to construct our sample:

- vehicle model
- vehicle year
- vehicle class
- MSRP (original price)
- resale price
- mileage

We can calculate `delta_price = MSRP - resale_price` and bucket the mileage


Hypotheses:  if the MechaCar has a better resale value than its competitors, then advertised used MechaCars will have a lower `delta_price` than competitors in the same category and with similar mileage.

ANOVA test independent variable categorical (vehicle_class), dependent variable (drop on value at resale).






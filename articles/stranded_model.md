# Dataset: Stranded Model Tutorial

*Edited by Zoë Turner 28 August 2026*

This vignette details why the `stranded_model` dataset was created, how
to load it, and gives examples of use with the caret Machine Learning
library.

The dataset contains:

- **stranded.label:** a character metric to indicate whether the patient
  is stranded, or not
- **age:** Integer - the age of the patient on admission to hospital
- **care.home.referral:** Integer - flag to indicate referred from care
  home
- **medicallysafe:** Integer - flag to indicate whether the patient is
  medically safe for example safe to be discharged but hasn’t been
- **hcop:** Integer - flag to indicate whether the patient is in a
  Health Care for Older People area
- **mental_health_care:** Integer - flag to indicate mental health care
  provision
- **period_of_previous_care:** Integer - flag to indicate previous
  periods of care
- **admit_date:** Date - admit date
- **frailty_index:** Character - specifying frailty type, if frail

## First, load the data and inspect it

``` r

library(NHSRdatasets)
library(dplyr)
library(ggplot2)
library(caret)
library(rsample)
library(varhandle)
library(tibble)

stranded_data <- NHSRdatasets::stranded_data

tibble::glimpse(stranded_data)
#> Rows: 768
#> Columns: 9
#> $ stranded.label           <chr> "Not Stranded", "Not Stranded", "Not Stranded…
#> $ age                      <int> 50, 31, 32, 69, 33, 75, 26, 64, 53, 63, 30, 7…
#> $ care.home.referral       <int> 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, …
#> $ medicallysafe            <int> 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, …
#> $ hcop                     <int> 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, …
#> $ mental_health_care       <int> 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, …
#> $ periods_of_previous_care <int> 1, 1, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 4, …
#> $ admit_date               <chr> "29/12/2020", "11/12/2020", "19/01/2021", "07…
#> $ frailty_index            <chr> "No index item", "No index item", "No index i…

prop.table(table(stranded_data$stranded.label))
#> 
#> Not Stranded     Stranded 
#>    0.5963542    0.4036458
```

This is good, it shows a relatively even split between the not stranded
and stranded labels. Please refer to the webinar on [Advanced
Modelling](https://www.youtube.com/watch?v=rO40vvKXU-4&t=1360s) to look
at how you can deal with classification imbalance using techniques such
as SMOTE (Synthetic Minority Oversampling Technique Estimation) and ROSE
(Random Oversampling Estimation), to name a few.

## Feature engineering

The next step will be to decide which features need to be engineered for
our machine learning model. We will drop the admit_date and recode the
frailty index, and perhaps allocate the age into age bands.

``` r

stranded_data <- stranded_data |>
  dplyr::mutate(stranded.label = factor(stranded.label)) |>
  dplyr::select(everything(), -c(admit_date))
```

Next, I will select the categorical variables and make these into dummy
variables, that is a numerical encoding of a categorical variable:

``` r

cats <- select_if(stranded_data, is.character)

cat_dummy <- varhandle::to.dummy(cats$frailty_index, "frail_ind")

# Converts the frailty index column to dummy encoding and sets a column called "frail_ind" prefix
cat_dummy <- cat_dummy |>
  as.data.frame() |>
  dplyr::select(-frail_ind.No_index_item) # Drop the field of interest

# Drop the frailty index from the stranded data frame and bind on our new encoding categorical variables
stranded_data <- stranded_data |>
  dplyr::select(-frailty_index) |>
  bind_cols(cat_dummy) |>
  na.omit(.)
```

The data is now ready for splitting into a simple train and validation
split, to do the machine learning on the set.

## Splitting the data

The next step is to create a simple hold out train/test split:

``` r

split <- rsample::initial_split(stranded_data, prop = 3 / 4)
train <- rsample::training(split)
test <- rsample::testing(split)
```

## Create simple Logistic Regression Model to classify stranded patients

The next step will be to create a stranded classification model, in
CARET:

``` r

# Fix the seed so that the same numbers will always be generated
set.seed(123)

glm_class_mod <- caret::train(factor(stranded.label) ~ .,
  data = train,
  method = "glm"
)
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred


glm_class_mod
#> Generalized Linear Model 
#> 
#> 524 samples
#>   9 predictor
#>   2 classes: 'Not Stranded', 'Stranded' 
#> 
#> No pre-processing
#> Resampling: Bootstrapped (25 reps) 
#> Summary of sample sizes: 524, 524, 524, 524, 524, 524, ... 
#> Resampling results:
#> 
#>   Accuracy   Kappa    
#>   0.7865238  0.4669562
```

This is a very basic model and could be improved by model choice,
hyperparameter selection, different resampling strategies, etc.

## Predicting the test set to validate model

Next, we will use the test dataset to see how our model will perform in
the wild:

``` r

preds <- predict(glm_class_mod, newdata = test) # Predict class
pred_prob <- predict(glm_class_mod, newdata = test, type = "prob") # Predict probs

# Join prediction on to actual test data frame and evaluate in confusion matrix

predicted <- data.frame(preds, pred_prob)

test <- test |>
  bind_cols(predicted) |>
  dplyr::rename(pred_class = preds)

glimpse(test)
#> Rows: 175
#> Columns: 13
#> $ stranded.label                 <fct> Not Stranded, Not Stranded, Not Strande…
#> $ age                            <int> 50, 31, 32, 53, 60, 60, 45, 46, 63, 64,…
#> $ care.home.referral             <int> 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, …
#> $ medicallysafe                  <int> 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, …
#> $ hcop                           <int> 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, …
#> $ mental_health_care             <int> 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, …
#> $ periods_of_previous_care       <int> 1, 1, 1, 5, 4, 1, 1, 1, 2, 2, 1, 10, 1,…
#> $ frail_ind.Activity_Limitation  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ frail_ind.Fall_patient_history <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, …
#> $ frail_ind.Mobility_problems    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, …
#> $ pred_class                     <fct> Not Stranded, Not Stranded, Not Strande…
#> $ Not.Stranded                   <dbl> 6.166140e-01, 7.613987e-01, 7.440161e-0…
#> $ Stranded                       <dbl> 0.3833860, 0.2386013, 0.2559839, 0.9986…
```

## Evaluating with confusion matrix

The final step is to evaluate the model:

``` r

caret::confusionMatrix(test$stranded.label, test$pred_class, positive = "Stranded")
#> Confusion Matrix and Statistics
#> 
#>               Reference
#> Prediction     Not Stranded Stranded
#>   Not Stranded          106        7
#>   Stranded               36       26
#>                                           
#>                Accuracy : 0.7543          
#>                  95% CI : (0.6836, 0.8161)
#>     No Information Rate : 0.8114          
#>     P-Value [Acc > NIR] : 0.9759          
#>                                           
#>                   Kappa : 0.3996          
#>                                           
#>  Mcnemar's Test P-Value : 1.955e-05       
#>                                           
#>             Sensitivity : 0.7879          
#>             Specificity : 0.7465          
#>          Pos Pred Value : 0.4194          
#>          Neg Pred Value : 0.9381          
#>              Prevalence : 0.1886          
#>          Detection Rate : 0.1486          
#>    Detection Prevalence : 0.3543          
#>       Balanced Accuracy : 0.7672          
#>                                           
#>        'Positive' Class : Stranded        
#> 
```

The model performs relatively well and could be improved by better
predictors, a bigger sample and class imbalance techniques.

## Conclusion

This dataset can be used for a number of classification problems and can
be the NHS’s equivalent to the iris dataset for classification, albeit
this only works for binary classification problems.

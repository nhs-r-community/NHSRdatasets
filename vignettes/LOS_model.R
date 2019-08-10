## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load, warning=FALSE, message=FALSE----------------------------------
library(NHSRdatasets)
library(dplyr)
library(ggplot2)

data("LOS_model")

head(LOS_model)

summary(LOS_model)

# 82.3% survived
prop.table(table(LOS_model$Death))

## ----VisageLOS-----------------------------------------------------------
ggplot(LOS_model, aes(x=Age)) +
  geom_histogram(alpha=0.5, col=1, fill=12, bins=20)+
  ggtitle("Distribution of Age")
ggplot(LOS_model, aes(x=LOS)) +
  geom_histogram(alpha=0.5, col=1, fill=13, bins=20)+
  ggtitle("Distribution of Length-of-Stay")

## ----glm1, collapse=TRUE-------------------------------------------------
glm_binomial <- glm(Death ~ Age + LOS, data=LOS_model, family="binomial")

summary(glm_binomial)

ModelMetrics::auc(glm_binomial)


## ----glm2----------------------------------------------------------------
glm_binomial2<- glm(Death ~ Age + LOS + Age*LOS, data=LOS_model, family="binomial")

summary(glm_binomial2)

ModelMetrics::auc(glm_binomial2)


## ----glm5----------------------------------------------------------------
LOS_model$preds <- predict(glm_binomial2, type="response")

head(LOS_model,5)

## ----glm3----------------------------------------------------------------

glm_poisson <- glm(LOS ~ Age * Death, data=LOS_model, family="poisson" )

summary(glm_poisson)


## ----glm4----------------------------------------------------------------

glm_poisson2 <- glm(LOS ~ Age + Death, data=LOS_model, family="poisson" )

AIC(glm_poisson)
AIC(glm_poisson2)

# anova(glm_poisson2, glm_poisson, test="Chisq")  will do the same thing without using the lmtest package
lmtest::lrtest(glm_poisson, glm_poisson2)


## ----od------------------------------------------------------------------
 sum(residuals(glm_poisson,type="pearson") ^2)/ df.residual(glm_poisson)
    


## ----quasi---------------------------------------------------------------
quasi<-glm(LOS ~ Age * Death, data=LOS_model, family="quasipoisson" )

summary(quasi)


## ----nb, warning=FALSE, message=FALSE------------------------------------
library(MASS)

nb <- glm.nb(LOS ~ Age * Death, data=LOS_model,)

summary(nb)


## ----glmm, warning=FALSE-------------------------------------------------
library(lme4)

glmm <- glmer(LOS ~ scale(Age) * Death + (1|Organisation), data=LOS_model, family="poisson")

summary(glmm)

## ----confint-------------------------------------------------------------
confint(glmm)



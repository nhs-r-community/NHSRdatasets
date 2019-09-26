## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(tidyverse.quiet = TRUE)

## ----load data, message=TRUE, warning=TRUE-------------------------------
library(knitr)
library(scales)
library(ggrepel)
library(lubridate)
library(tidyverse)

library(NHSRdatasets)

data("ae_attendances")

# format for display
ae_attendances %>%
  # set the period column to show in Month-Year format
  mutate_at(vars(period), format, "%b-%y") %>% 
  # set the numeric columns to have a comma at the 1000's place
  mutate_at(vars(attendances, breaches, admissions), comma) %>%
  # show the first 10 rows
  head(10) %>%
  # format as a table
  kable()

## ----england performance-------------------------------------------------
england_performance <- ae_attendances %>%
  group_by(period) %>%
  summarise_at(vars(attendances, breaches), sum) %>%
  mutate(performance = 1 - breaches / attendances)

# format for display
england_performance %>% 
  # same format options as above
  mutate_at(vars(period), format, "%b-%y") %>% 
  mutate_at(vars(attendances, breaches), comma) %>%
  # this time show the performance column as a percentage
  mutate_at(vars(performance), percent) %>%
  # show the first 10 rows and format as a table
  head(10) %>%
  kable()

## ----england performance plot--------------------------------------------
ggplot(england_performance, aes(period, performance)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = percent) +
  labs(x = "Month of attendance",
       y = "% of attendances that met the 4 hour standard",
       title = "NHS England A&E 4 Hour Performance",
       caption = "Source: NHS England Statistical Work Areas (OGL v3.0)")

## ----england performance by type-----------------------------------------
ae_attendances %>%
  group_by(period, type) %>%
  summarise_if(is.numeric, sum) %>%
  mutate(performance = 1 - breaches / attendances) %>%
  ggplot(aes(period, performance, colour = type)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = percent) +
  #facet_wrap(vars(type), nrow = 1) +
  theme(legend.position = "bottom") +
  labs(x = "Month of attendance",
       y = "% of attendances that met the 4 hour standard",
       title = "NHS England A&E 4 Hour Performance",
       subtitle = "By Department Type",
       caption = "Source: NHS England Statistical Work Areas (OGL v3.0)")

## ----performance_by_trust------------------------------------------------
performance_by_trust <- ae_attendances %>%
  group_by(org_code, period) %>%
  # make sure that this trust has a type 1 department
  filter(any(type == 1)) %>%
  summarise_at(vars(attendances, breaches), sum) %>%
  mutate(performance = 1 - breaches / attendances)

# format for display
performance_by_trust %>%
  mutate_at(vars(period), format, "%b-%y") %>% 
  mutate_at(vars(attendances, breaches), comma) %>%
  mutate_at(vars(performance), percent) %>%
  head(10) %>%
  kable()

## ----performance_by_trust_ranking----------------------------------------
performance_by_trust_ranking <- performance_by_trust %>%
  summarise(performance = 1 - sum(breaches) / sum(attendances)) %>%
  arrange(performance) %>%
  pull(org_code) %>%
  as.character()

print("Bottom 5")
head(performance_by_trust_ranking, 5)

print("Top 5")
tail(performance_by_trust_ranking, 5)

## ----performance_by_trust top 5 bottom 5 plot----------------------------
performance_by_trust %>%
  ungroup() %>%
  mutate_at(vars(org_code), fct_relevel, performance_by_trust_ranking) %>%
  filter(org_code %in% c(head(performance_by_trust_ranking, 5),
                         tail(performance_by_trust_ranking, 5))) %>%
  ggplot(aes(period, performance)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = percent) +
  facet_wrap(vars(org_code), nrow = 2) +
  theme(legend.position = "bottom") +
  labs(x = "Month of attendance",
       y = "% of attendances that met the 4 hour standard",
       title = "NHS England A&E 4 Hour Performance",
       subtitle = "Bottom 5/Top 5 over the whole 3 years",
       caption = "Source: NHS England Statistical Work Areas (OGL v3.0)")

## ----bencmarking plot----------------------------------------------------
ae_attendances %>%
  filter(period == last(period)) %>%
  group_by(org_code) %>%
  filter(any(type == 1)) %>%
  summarise_at(vars(attendances, breaches), sum) %>%
  mutate(performance = 1 - breaches/attendances,
         overall_performance = 1 - sum(breaches)/sum(attendances),
         org_code = fct_reorder(org_code, -performance)) %>%
  #
  arrange(performance) %>%
  # lets highlight the organsiations that are at the lower and upper quartile
  # and at the median. First "tile" the data into 4 groups, then we use the
  # lag function to check to see if the value changes between rows. We will get
  # NA for the first row, so replace this with FALSE
  mutate(highlight = ntile(n = 4),
         highlight = replace_na(highlight != lag(highlight), FALSE)) %>%

  ggplot(aes(org_code, performance)) +
  geom_hline(aes(yintercept = overall_performance)) +
  geom_point(aes(fill = highlight), show.legend = FALSE, pch = 21) +
  geom_text_repel(aes(label = ifelse(highlight, as.character(org_code), NA)),
                  na.rm = TRUE) +
  scale_fill_manual(values = c("TRUE" = "black",
                               "FALSE" = NA)) +
  scale_y_continuous(labels = percent) +
  theme_minimal() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.line = element_line(),
        axis.ticks.y = element_line())


devtools::install_github("debruine/faux", build_vignettes = TRUE)

library("faux")
library(tidyverse)

# dataset 1

between <- list(speaker = c(native = "Native speaker", 
                        non = "Non-native speaker"))
within <- list(test = c("pre", "post", "delay"))
mu <- data.frame(
  native    = c(10,14,12),
  non    = c(10,20,15),
  row.names = within$test
)
df <- sim_design(within, between, 
                 n = 100, mu = mu, sd = 5, r = .5,
                 empirical = TRUE, plot = TRUE)
x <- c("male", "female", "nonbinary")
df <- df %>%
  mutate(gender = sample(x, 
                         size = 200, 
                         replace = TRUE, 
                         prob = c(.45, .45, .1)))

# replace 10% of gender and speaker with NA
df_messy <- messy(df, 0.1, 2,5,6) %>%
  select(id, speaker, gender, everything())

write.csv(x = df_messy, file = "messy.csv")

# dataset 2


dat <- rnorm_multi(
  n = 100, 
  vars = 9,
  mu = c(2.5, 3.5, 4.5, 4.5, 3.5, 2.5, 3.5, 4, 6),
  sd = c(1),
  r = c(0.5), 
  varnames = c("Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9"),
  empirical = FALSE
)

dat <- round(dat, digits = 0) %>%
  mutate(id = row_number()) %>%
  select(id, everything())

write.csv(x = dat, file = "questionnaire_data.csv")

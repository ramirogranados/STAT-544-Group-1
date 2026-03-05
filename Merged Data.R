library(dplyr)
library(readr)

crashes <- read_csv("Crashes.csv") %>% mutate(CASE_ID = as.character(CASE_ID))
parties <- read_csv("Parties.csv") %>% mutate(CASE_ID = as.character(CASE_ID))
victims <- read_csv("Victims.csv") %>% mutate(CASE_ID = as.character(CASE_ID))

merged_switrs <- crashes %>%
  left_join(parties, by = "CASE_ID") %>%
  left_join(victims, by = c("CASE_ID", "PARTY_NUMBER"))

cat("Rows/Cols (crashes):", paste(dim(crashes), collapse=" x "), "\n")
cat("Rows/Cols (merged): ", paste(dim(merged_switrs), collapse=" x "), "\n")
cat("Unique CASE_IDs (crashes vs merged):", n_distinct(crashes$CASE_ID), "vs", n_distinct(merged_switrs$CASE_ID), "\n")

write_csv(merged_switrs, "merged_switrs_data.csv")

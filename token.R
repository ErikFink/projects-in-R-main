install.packages("gitcreds")
library(gitcreds)
library(usethis)

usethis::create_github_token() # e.g. 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

gitcreds::gitcreds_set()
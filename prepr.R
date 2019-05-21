library(jsonlite)
library(tidyverse)

seasons <- c(1:7)

#initialise dataframe:

subtitle_list <- tibble()

for(i in seasons) {
  path <- paste0("~/Documents/zhaw/bd/GoT/rawdata/season", i, ".json")
  
  raw <- read_json(path = path)
  
  subtitles <- enframe(raw, name = "episode_title") %>%
    rowid_to_column() %>%
    mutate(value = map(value, enframe)) %>%
    unnest() %>%
    unnest() %>%
    rename(zeile = name) %>%
    arrange(rowid, as.numeric(zeile))
  
  subtitle_list <- bind_rows(subtitle_list, subtitles)
}
  
  
  
# tidytext unnest tokens, dann gibts eine Zeile pro Token.


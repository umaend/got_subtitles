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
    arrange(rowid, as.numeric(zeile)) %>% 
    mutate(episode_title = str_sub(episode_title, 0, -5)) %>% 
    mutate(episode_nr = str_sub(episode_title, 17, 22)) %>% 
    mutate(episode_title = str_sub(episode_title, 24)) %>%
    select(-rowid) %>% 
    select(episode_nr, episode_title, everything())
  
  subtitle_list <- bind_rows(subtitle_list, subtitles)
}

write_csv(subtitle_list, path = "~/Documents/zhaw/bd/GoT/rawdata/subtitle_list.csv")
  
# tidytext unnest tokens, dann gibts eine Zeile pro Token.


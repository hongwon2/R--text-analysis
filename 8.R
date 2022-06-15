raw_moon <- readLines('speech_moon.txt',encoding = 'UTF-8')
head(raw_moon)
class(raw_moon)

library(stringr)
txt <- 'ƒ°≈≤¿∫!!∏¿¿÷¥Ÿ.xyz ¡§∏ª ∏¿¿÷¥Ÿ !@#'
txt
txt <- str_replace_all(txt,"[^∞°-∆R]",replacement = " ")


moon <- raw_moon %>% str_replace_all("^[∞°-∆R]", " ")
head(moon)

moon <- str_trim(moon)
head(moon)

#str_squish
moon = str_squish(moon)
head(moon)

library(dplyr)
moon <- as_tibble(moon)
moon
# ≈‰≈´»≠«œ±‚
# tidytxet,unnest_token()

library(tidytext)

text <- tibble(value = "¥Î«—πŒ±π¿∫ πŒ¡÷∞¯»≠±π¿Ã¥Ÿ.¥Î«—πŒ±π¿« ¡÷±«¿∫ ±ππŒø°∞‘ ¿÷∞Ì,∏µÁ ±«∑¬¿∫ ±ππŒ¿∏∑Œ∫Œ≈Õ ≥™ø¬¥Ÿ")
text
text %>% unnest_tokens(input = value, output = wordss, token = 'sentences')

text %>% unnest_tokens(input = value, output = word, token = 'words')
text %>% unnest_tokens(input = value, output = word, token = 'characters')

moon_space <- moon %>% unnest_tokens(input = value,output = word, token = 'words')


moon_space

# ∫Ûµµ∫–ºÆ
moon_space <- moon_space %>% count(word,sort = T)
moon_space

str_count('πË')
str_count('πËπËπË')

moon_space <- moon_space %>% filter(str_count(word) > 1)
moon_space

top20_moon <- moon_space %>% head(20)
top20_moon

#ggplot2
library(ggplot2)

ggplot(top20_moon, aes(x = reorder(word,n),y = n)) + 
         geom_col() +
         coord_flip()

#øˆµÂ≈¨∂ÛøÏµÂ
library(ggwordcloud)

ggplot(moon_space,aes(label = word,size = n)) +
  geom_text_wordcloud(seed = 1234) + 
  scale_radius(limits = c(3,NA), #√÷º“, √÷¥Î ¥‹æÓ∫Ûµµ
               range = c(3,30)) #√÷º“,√÷¥Î ±€¿⁄≈©±‚



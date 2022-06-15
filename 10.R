text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

source <- c('BBC','FOX','CNN')
library(dplyr)
install.packages("tidyverse")
library(tidyverse)
text.df <- tibble(source = source,text = text)
text.df
class(text.df)

#ÅäÅ«È­
library(tidytext)
unnest_tokens(tbl = text.df,output = word,input = text)

head(iris)
iris %>% head(10)

tidy.docs <- text.df %>% unnest_tokens(output = word,input = text)
print(tidy.docs, n = Inf)
tidy.docs
tidy.docs %>% count(source) %>% arrange(desc(n))

#ºÒÇÊ¿äÇÑ ´Ü¾î Á¦°Å(tidytext)
stop_words

anti_join(tidy.docs,stop_words, by = 'word')
tidy.docs

tidy.docs <- tidy.docs %>% anti_join(stop_words,by = "word")
tidy.docs

word.removed <- tibble(word = c("http","bbc.in","1g0j4agg"))
tidy.docs <- tidy.docs %>% anti_join(word.removed,by = "word")
tidy.docs$word
grep("\\d+",tidy.docs$word)

tidy.docs <- tidy.docs[-grep("\\d+",tidy.docs$word),]
tidy.docs$word

tidy.docs


#Æ¯Á¤ ´Ü¾î°¡ ¸¶À½¿¡ ¾Èµé °æ¿ì
tidy.docs$word <- gsub("ian","",tidy.docs$word)
tidy.docs$word <- gsub("economists","economy",tidy.docs$word)


library(tm)
corpus.docs <- VCorpus(VectorSource(text))
meta(corpus.docs,tag = "author",type = "local") <- source
lapply(corpus.docs, meta)
tidy(corpus.docs) %>% unnest_tokens(word,text) %>% select(source = author,word)




##############2Â÷½Ã

library(dplyr)
# ¹®ÀçÀÎ ´ëÅë·É ¿¬¼³¹® ºÒ·¯¿À±â
raw_moon <- readLines("speech_moon.txt", encoding = "UTF-8")
moon <- raw_moon %>%
  as_tibble() %>%
  mutate(president = "moon")
# ¹Ú±ÙÇı ´ëÅë·É ¿¬¼³¹® ºÒ·¯¿À±â
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")
park <- raw_park %>%
  as_tibble() %>%
  mutate(president = "park")

# µÎ µ¥ÀÌÅÍ ÇÕÄ¡±â±â
bind_speeches <- bind_rows(moon, park) %>%
  select(president, value)


bind_speeches %>% count(president)

head(bind_speeches)
tail(bind_speeches)

# ±âº»ÀûÀÎ ÀüÃ³¸®
library(stringr)
speeches <- bind_speeches %>%
  mutate(value = str_replace_all(value, "[^°¡-ÆR]", " "),
         value = str_squish(value))
speeches


# ÅäÅ«È­
library(tidytext)
library(KoNLP)
speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun) #¸í»çÃßÃâ
speeches

frequency <- speeches %>%
  count(president, word) %>% # ¿¬¼³¹® ¹× ´Ü¾îº° ºóµµ
  filter(str_count(word) > 1) # µÎ ±ÛÀÚ ÀÌ»ó ÃßÃâ
head(frequency)


# dplyr::slice_max() : °ªÀÌ Å« »óÀ§ n°³ÀÇ ÇàÀ» ÃßÃâÇØ ³»¸²Â÷¼ø Á¤·Ä
top10 <- frequency %>%
  group_by(president) %>% # presidentº°·Î ºĞ¸®
  arrange(desc(n)) %>% # »óÀ§ 10°³ ÃßÃâ
  head(10)
top10

top10 <- frequency %>%
  group_by(president) %>% # presidentº°·Î ºĞ¸®
  slice_max(n, n= 10)
top10








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
                token = extractNoun)
speeches

frequency <- speeches %>%
  count(president, word) %>% # ¿¬¼³¹® ¹× ´Ü¾îº° ºóµµ
  filter(str_count(word) > 1) # µÎ ±ÛÀÚ ÀÌ»ó ÃßÃâ
head(frequency)
tail(frequency)

# dplyr::slice_max() : °ªÀÌ Å« »óÀ§ n°³ÀÇ ÇàÀ» ÃßÃâÇØ ³»¸²Â÷¼ø Á¤·Ä
top10 <- frequency %>%
  group_by(president) %>% # presidentº°·Î ºĞ¸®
  arrange(desc(n)) %>% # »óÀ§ 10°³ ÃßÃâ
  head(10) %>% filter(president == "park")
top10

top10 <- frequency %>%
  group_by(president) %>% # presidentº°·Î ºĞ¸®
  slice_max(n, n= 10)
top10

top10 <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10, with_ties = F)
top10

library(ggplot2)
ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president)

# yÃàÀ» ÅëÀÏÇÏÁö ¾Ê°í °¢°¢ 10°³¾¿

ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")

# Ãà ÀçÁ¤¸®
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")

#tidytext::scale_x_reordered() : °¢ ´Ü¾î µÚÀÇ ¹üÁÖ Ç×¸ñ Á¦°Å

ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y") +
  scale_x_reordered() +
  labs(x = NULL) + # xÃà »èÁ¦
  theme(text = element_text(family = "nanumgothic")) # ÆùÆ®

# 11-1 ODDS Ratio


df_long <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10) %>%
  filter(word %in% c("±¹¹Î", "¿ì¸®", "Á¤Ä¡", "Çàº¹"))

df_long

# pivoting

library(tidyr)
df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n)
df_wide


df_long

#  NA¸¦ 0À¸·Î 
df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))
df_wide


frequency_wide <- frequency %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))
frequency_wide

#Odds ratio °è»ê
frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon)/(sum(moon))), # moon ¿¡¼­ ´Ü¾îÀÇ ºñÁß
         ratio_park = ((park)/(sum(park)))) # park ¿¡¼­ ´Ü¾îÀÇ ºñÁß
frequency_wide

# ´Ü¾î ºñÁß ºñ±³¸¦ À§ÇØ¼­ °¢ Çà¿¡ 1À» ´õÇÔ

frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon + 1)/(sum(moon + 1))), # moon¿¡¼­ ´Ü¾îÀÇ ºñÁß
         ratio_park = ((park + 1)/(sum(park + 1)))) # park¿¡¼­ ´Ü¾îÀÇ ºñÁß
frequency_wide


frequency_wide <- frequency_wide %>%
  mutate(odds_ratio = ratio_moon/ratio_park)
frequency_wide

#"moon"¿¡¼­ »ó´ëÀûÀÎ ºñÁß Å¬¼ö·Ï 1º¸´Ù Å« °ª
#"park"¿¡¼­ »ó´ëÀûÀÎ ºñÁß Å¬¼ö·Ï 1º¸´Ù ÀÛÀº °ª

frequency_wide %>%
  arrange(-odds_ratio)


frequency_wide %>%
  arrange(odds_ratio)


# »ó´ëÀûÀ¸·Î Áß¿äÇÑ ´Ü¾î ÃßÃâÇÏ±â
top10 <- frequency_wide %>%
  filter(rank(odds_ratio) <= 10 | rank(-odds_ratio) <= 10)
top10



top10 <- top10 %>%
  mutate(president = ifelse(odds_ratio > 1, "moon", "park"),
         n = ifelse(odds_ratio > 1, moon, park))
top10

top10 <- top10 %>%
  group_by(president) %>% 
  slice_max(n, n= 10, with_ties = F)
top10


ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y") +
  scale_x_reordered()


# ±×·¡ÇÁ º°·Î Ãà º°µµ ¼³Á¤
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free") +
  scale_x_reordered() +
  labs(x = NULL) + # xÃà »èÁ¦
  theme(text = element_text(family = "nanumgothic")) # ÆùÆ®

# ·Î±× ¿ÀÁîºñ
frequency_wide <- frequency_wide %>%
  mutate(log_odds_ratio = log(odds_ratio))
frequency_wide


frequency_wide %>%
  arrange(-log_odds_ratio)


frequency_wide %>%
  arrange(log_odds_ratio)


top10 <- frequency_wide %>%
  group_by(president = ifelse(log_odds_ratio > 0, "moon", "park")) %>%
  slice_max(abs(log_odds_ratio), n = 10, with_ties = F)
top10


top10 %>%
  arrange(-log_odds_ratio) %>%
  select(word, log_odds_ratio, president)

# ¼­·Î ´Ù¸¥ ¹æÇâÀ¸·Î ¸·´ë ±×·¡ÇÁ ±×¸®±â
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))






#2Â÷½Ã DTM ÅØ½ºÆ®¸¦ ±¸Á¶È­ ÇÏ´Â ¸¶Áö¸· ´Ü°è

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

library(tm) 
#dtmÀ» ¾Ë±â Àü Áö±İ±îÁö ÇÑ °Í ¸®¸¶ÀÎµå´Ï±î ÁıÁß!
corpus.docs <- VCorpus(VectorSource(text))
corpus.docs
lapply(corpus.docs,meta)
lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,content_transformer(tolower)) #¼Ò¹®ÀÚ º¯È¯
corpus.docs <- tm_map(corpus.docs,removeWords,stopwords('english')) #ºÒ¿ë¾î »èÁ¦
myRemove <- content_transformer(function(x,pattern){return(gsub(pattern,"",x))}) #Æ¯Á¤ ÆĞÅÏÀ» °¡Áø ºÒ¿ë¾î º¯È¯È¯
corpus.docs <- tm_map(corpus.docs,myRemove, "(f|ht)tp\\S+\\s*" ) 
corpus.docs <- tm_map(corpus.docs,removePunctuation) 

lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,removeNumbers)#¼ıÀÚ»èÁ¦
corpus.docs <- tm_map(corpus.docs,stripWhitespace)#¿©¹é»èÁ¦
corpus.docs <- tm_map(corpus.docs,content_transformer(trimws))#ÅØ½ºÆ® ¾ÕµÚ °ø¹é »èÁ¦
corpus.docs <- tm_map(corpus.docs,stemDocument)#¾î°£ ÃßÃâ
corpus.docs <- tm_map(corpus.docs,content_transformer(gsub),
                      pattern='economist',replacement = 'economi')#µ¿ÀÇ¾î Ã³¸®


lapply(corpus.docs,content)

## ¿©±â±îÁö ÀüÃ³¸® ÇÏ±â
#dtm -ÀüÃ³¸® ÇÑ°É ¹®¼­ Çü½ÄÀ¸·Î ¹Ş¾Æ¿À±â
corpus.dtm <- DocumentTermMatrix(corpus.docs,control = list(wordLengths = c(2,Inf))) #´Ü¾î µÎ°³ ÀÌ»óºÎÅÍ ÀÎÇÇ´ÏÆ® ±îÁö ¸®½ºÆ® Çü½ÄÀ¸·Î ¹Ş¾Æ¿Í
nTerms(corpus.dtm)
nDocs(corpus.dtm)
Terms(corpus.dtm)

Docs(corpus.dtm)
row.names(corpus.dtm) <- c('BBC','CNN','Fox')

inspect(corpus.dtm)



#####tidy text Çü½ÄÀÇ µ¥ÀÌÅÍ ¼Âµµ ¸®¸¶ÀÎµå ÇÏ±â
text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
source <- c('BBC','CNN','FOX')
library(dplyr)
library(tidytext)
library(SnowballC)

text.df <- tibble(source = source,text = text)
text.df

text.df$text <- gsub("(f|ht)tp\\S+\\s*","",text.df$text) #url»èÁ¦
text.df$text <- gsub("\\d+","",text.df$text) #¼ıÀÚ»èÁ¦
tidy.docs <- text.df %>% 
  unnest_tokens(output = word,input = text) %>% #ÅäÅ«È­
  anti_join(stop_words, by = 'word') %>% #ºÒ¿ë¾î »çÀüÀ» ÀÌ¿ëÇØ ºÒ¿ë¾î Á¦°Å
  mutate(word = wordStem(word))#¾î°£ÃßÃâ
tidy.docs$word <- gsub("\\S+","",tidy.docs$word)#°ø¹éÁ¦°Å
tidy.docs$word <- gsub("economist","economi",tidy.docs$word)#°ø¹éÁ¦°Å
tidy.docs


#dtm ÇØº¸±â
tidy.dtm <- tidy.docs %>% count(source,word) %>%
  cast_dtm(document = source,term = word,value = n)
tidy.dtm

Terms(tidy.dtm)
Docs(tidy.dtm)
inspect(tidy.dtm[1:2,3:5])

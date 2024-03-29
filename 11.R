
library(dplyr)
# 문재인 대통령 연설문 불러오기
raw_moon <- readLines("speech_moon.txt", encoding = "UTF-8")
moon <- raw_moon %>%
  as_tibble() %>%
  mutate(president = "moon")
# 박근혜 대통령 연설문 불러오기
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")
park <- raw_park %>%
  as_tibble() %>%
  mutate(president = "park")

# 두 데이터 합치기기
bind_speeches <- bind_rows(moon, park) %>%
  select(president, value)


bind_speeches %>% count(president)

head(bind_speeches)
tail(bind_speeches)

# 기본적인 전처리
library(stringr)
speeches <- bind_speeches %>%
  mutate(value = str_replace_all(value, "[^가-힣]", " "),
         value = str_squish(value))
speeches


# 토큰화
library(tidytext)
library(KoNLP)
speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
speeches

frequency <- speeches %>%
  count(president, word) %>% # 연설문 및 단어별 빈도
  filter(str_count(word) > 1) # 두 글자 이상 추출
head(frequency)
tail(frequency)

# dplyr::slice_max() : 값이 큰 상위 n개의 행을 추출해 내림차순 정렬
top10 <- frequency %>%
  group_by(president) %>% # president별로 분리
  arrange(desc(n)) %>% # 상위 10개 추출
  head(10) %>% filter(president == "park")
top10

top10 <- frequency %>%
  group_by(president) %>% # president별로 분리
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

# y축을 통일하지 않고 각각 10개씩

ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")

# 축 재정리
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")

#tidytext::scale_x_reordered() : 각 단어 뒤의 범주 항목 제거

ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y") +
  scale_x_reordered() +
  labs(x = NULL) + # x축 삭제
  theme(text = element_text(family = "nanumgothic")) # 폰트

# 11-1 ODDS Ratio


df_long <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10) %>%
  filter(word %in% c("국민", "우리", "정치", "행복"))

df_long

# pivoting

library(tidyr)
df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n)
df_wide


df_long

#  NA를 0으로 
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

#Odds ratio 계산
frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon)/(sum(moon))), # moon 에서 단어의 비중
         ratio_park = ((park)/(sum(park)))) # park 에서 단어의 비중
frequency_wide

# 단어 비중 비교를 위해서 각 행에 1을 더함

frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon + 1)/(sum(moon + 1))), # moon에서 단어의 비중
         ratio_park = ((park + 1)/(sum(park + 1)))) # park에서 단어의 비중
frequency_wide


frequency_wide <- frequency_wide %>%
  mutate(odds_ratio = ratio_moon/ratio_park)
frequency_wide

#"moon"에서 상대적인 비중 클수록 1보다 큰 값
#"park"에서 상대적인 비중 클수록 1보다 작은 값

frequency_wide %>%
  arrange(-odds_ratio)


frequency_wide %>%
  arrange(odds_ratio)


# 상대적으로 중요한 단어 추출하기
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


# 그래프 별로 축 별도 설정
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free") +
  scale_x_reordered() +
  labs(x = NULL) + # x축 삭제
  theme(text = element_text(family = "nanumgothic")) # 폰트

# 로그 오즈비
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

# 서로 다른 방향으로 막대 그래프 그리기
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))






#2차시 DTM 텍스트를 구조화 하는 마지막 단계

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

library(tm) 
#dtm을 알기 전 지금까지 한 것 리마인드니까 집중!
corpus.docs <- VCorpus(VectorSource(text))
corpus.docs
lapply(corpus.docs,meta)
lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,content_transformer(tolower)) #소문자 변환
corpus.docs <- tm_map(corpus.docs,removeWords,stopwords('english')) #불용어 삭제
myRemove <- content_transformer(function(x,pattern){return(gsub(pattern,"",x))}) #특정 패턴을 가진 불용어 변환환
corpus.docs <- tm_map(corpus.docs,myRemove, "(f|ht)tp\\S+\\s*" ) 
corpus.docs <- tm_map(corpus.docs,removePunctuation) 

lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,removeNumbers)#숫자삭제
corpus.docs <- tm_map(corpus.docs,stripWhitespace)#여백삭제
corpus.docs <- tm_map(corpus.docs,content_transformer(trimws))#텍스트 앞뒤 공백 삭제
corpus.docs <- tm_map(corpus.docs,stemDocument)#어간 추출
corpus.docs <- tm_map(corpus.docs,content_transformer(gsub),
                      pattern='economist',replacement = 'economi')#동의어 처리


lapply(corpus.docs,content)

## 여기까지 전처리 하기
#dtm -전처리 한걸 문서 형식으로 받아오기
corpus.dtm <- DocumentTermMatrix(corpus.docs,control = list(wordLengths = c(2,Inf))) #단어 두개 이상부터 인피니트 까지 리스트 형식으로 받아와
nTerms(corpus.dtm)
nDocs(corpus.dtm)
Terms(corpus.dtm)

Docs(corpus.dtm)
row.names(corpus.dtm) <- c('BBC','CNN','Fox')

inspect(corpus.dtm)



#####tidy text 형식의 데이터 셋도 리마인드 하기
text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
source <- c('BBC','CNN','FOX')
library(dplyr)
library(tidytext)
library(SnowballC)

text.df <- tibble(source = source,text = text)
text.df

text.df$text <- gsub("(f|ht)tp\\S+\\s*","",text.df$text) #url삭제
text.df$text <- gsub("\\d+","",text.df$text) #숫자삭제
tidy.docs <- text.df %>% 
  unnest_tokens(output = word,input = text) %>% #토큰화
  anti_join(stop_words, by = 'word') %>% #불용어 사전을 이용해 불용어 제거
  mutate(word = wordStem(word))#어간추출
tidy.docs$word <- gsub("\\S+","",tidy.docs$word)#공백제거
tidy.docs$word <- gsub("economist","economi",tidy.docs$word)#공백제거
tidy.docs


#dtm 해보기
tidy.dtm <- tidy.docs %>% count(source,word) %>%
  cast_dtm(document = source,term = word,value = n)
tidy.dtm

Terms(tidy.dtm)
Docs(tidy.dtm)
inspect(tidy.dtm[1:2,3:5])

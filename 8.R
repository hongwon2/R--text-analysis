raw_moon <- readLines('speech_moon.txt',encoding = 'UTF-8')
head(raw_moon)
class(raw_moon)

library(stringr)
txt <- 'ġŲ��!!���ִ�.xyz ���� ���ִ� !@#'
txt
txt <- str_replace_all(txt,"[^��-�R]",replacement = " ")


moon <- raw_moon %>% str_replace_all("^[��-�R]", " ")
head(moon)

moon <- str_trim(moon)
head(moon)

#str_squish
moon = str_squish(moon)
head(moon)

library(dplyr)
moon <- as_tibble(moon)
moon
# ��ūȭ�ϱ�
# tidytxet,unnest_token()

library(tidytext)

text <- tibble(value = "���ѹα��� ���ְ�ȭ���̴�.���ѹα��� �ֱ��� ���ο��� �ְ�,��� �Ƿ��� �������κ��� ���´�")
text
text %>% unnest_tokens(input = value, output = wordss, token = 'sentences')

text %>% unnest_tokens(input = value, output = word, token = 'words')
text %>% unnest_tokens(input = value, output = word, token = 'characters')

moon_space <- moon %>% unnest_tokens(input = value,output = word, token = 'words')


moon_space

# �󵵺м�
moon_space <- moon_space %>% count(word,sort = T)
moon_space

str_count('��')
str_count('����')

moon_space <- moon_space %>% filter(str_count(word) > 1)
moon_space

top20_moon <- moon_space %>% head(20)
top20_moon

#ggplot2
library(ggplot2)

ggplot(top20_moon, aes(x = reorder(word,n),y = n)) + 
         geom_col() +
         coord_flip()

#����Ŭ����
library(ggwordcloud)

ggplot(moon_space,aes(label = word,size = n)) +
  geom_text_wordcloud(seed = 1234) + 
  scale_radius(limits = c(3,NA), #�ּ�, �ִ� �ܾ��
               range = c(3,30)) #�ּ�,�ִ� ����ũ��



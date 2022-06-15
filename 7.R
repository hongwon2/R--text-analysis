string <- c('data alaysis is useful',
            'business anlyticss is helpful',
            'visualization of data is interesting for data scientists')
string

grep('data',string)
grep('data',string,value = TRUE)

string[grep('data',string)]

grepl('data',string)


#base ��Ű��

#regexpr , gregexpr
regexpr(pattern = 'data',text = string) #ù��° ��ġ��

gregexpr('data',string) #��ġ�� ��

#regematches()
regmatches(x = string, m = regexpr(pattern = 'data',text = string))
regmatches(x = string, m = gregexpr(pattern = 'data',text = string))

regmatches(string,regexpr('data',string),invert = TRUE)
regmatches(string,gregexpr('data',string),invert = TRUE)

#ġȯ�� �ϴ� �����  sub(),gsub() �� regmathches�� ����ϳ�
sub(pattern = 'data',replacement = 'text',x = string)
gsub(pattern = 'data',replacement = 'text',x = string)

#strsplit
strsplit(string," ")
unlist(strsplit(string," "))
unique(unlist(strsplit(string," ")))

#is|of|for �� ���ְ� �;�
gsub('is|of|for',"",unique(unlist(strsplit(string," "))))


#2����
#Stringr() ��Ű�� ���� ������
install.packages('stringr')
library(stringr)
string <- c('data alaysis is useful',
            'business anlyticss is helpful',
            'visualization of data is interesting for data scientists')

#grepl()�� �����ѱ�� str_detect()
str_detect(string = string, pattern = 'data')
str_detect(string = string, pattern = 'DATA')
str_detect(string = string, fixed('DATA',ignore_case = TRUE))

str_detect(c('aby','acy','a.y'),'a.y') #a.y �� ��Ÿ���ڷ� �ν�
str_detect(c('aby','acy','a.y'),fixed('a.y')) #fixed �� ����ؼ� a.y�� �ִ±״�� �ν�

#��ġ����
str_locate(string,'data')
str_locate_all(string,'data')

#���ڿ� ���� regmatches()�� ����
str_extract(string,'data')
str_extract_all(string,'data')
str_extract_all(string,'data',simplify = TRUE)

unlist(str_extract_all(string,'data'))




sentences5 <- sentences[1:5]

str_extract(sentences5,'(a|A|the|The) (\\w+)')
str_extract_all(sentences5,'(a|A|the|The) (\\w+)')
str_match(sentences5,'(a|A|the|The) (\\w+)')
str_match_all(sentences5,'(a|A|the|The) (\\w+)')



#���ڿ� ġȯ
str_replace(string,'data','text')
str_replace_all(string,'data','text')

#���ڿ� ����
str_split(string,' ')
str_split(sentences5,' ')
unlist(str_split(sentences5,' '))
unique(unlist(str_split(sentences5,' ')))

str_split(sentences5, ' ',n = 5, simplify =  TRUE)



#�߰����� stringr �Լ�
str_length(string)
str_count(string,'data')
str_count(string,'\\W+')

mon <- 1:12
str_pad(mon,width = 2, side = 'left',pad = '0')

string_pad <- str_pad(string,width = max(str_length(string)),
        side = 'both',pad = ' ')
string_pad
str_trim(string_pad)

















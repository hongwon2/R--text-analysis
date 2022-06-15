string <- c('data alaysis is useful',
            'business anlyticss is helpful',
            'visualization of data is interesting for data scientists')
string

grep('data',string)
grep('data',string,value = TRUE)

string[grep('data',string)]

grepl('data',string)


#base 패키지

#regexpr , gregexpr
regexpr(pattern = 'data',text = string) #첫번째 위치값

gregexpr('data',string) #위치값 다

#regematches()
regmatches(x = string, m = regexpr(pattern = 'data',text = string))
regmatches(x = string, m = gregexpr(pattern = 'data',text = string))

regmatches(string,regexpr('data',string),invert = TRUE)
regmatches(string,gregexpr('data',string),invert = TRUE)

#치환을 하는 방식인  sub(),gsub() 와 regmathches랑 비슷하넹
sub(pattern = 'data',replacement = 'text',x = string)
gsub(pattern = 'data',replacement = 'text',x = string)

#strsplit
strsplit(string," ")
unlist(strsplit(string," "))
unique(unlist(strsplit(string," ")))

#is|of|for 를 없애고 싶어
gsub('is|of|for',"",unique(unlist(strsplit(string," "))))


#2주차
#Stringr() 패키지 아주 유용함
install.packages('stringr')
library(stringr)
string <- c('data alaysis is useful',
            'business anlyticss is helpful',
            'visualization of data is interesting for data scientists')

#grepl()과 동일한기능 str_detect()
str_detect(string = string, pattern = 'data')
str_detect(string = string, pattern = 'DATA')
str_detect(string = string, fixed('DATA',ignore_case = TRUE))

str_detect(c('aby','acy','a.y'),'a.y') #a.y 를 메타문자로 인식
str_detect(c('aby','acy','a.y'),fixed('a.y')) #fixed 를 사용해서 a.y를 있는그대로 인식

#위치검출
str_locate(string,'data')
str_locate_all(string,'data')

#문자열 추출 regmatches()랑 같음
str_extract(string,'data')
str_extract_all(string,'data')
str_extract_all(string,'data',simplify = TRUE)

unlist(str_extract_all(string,'data'))




sentences5 <- sentences[1:5]

str_extract(sentences5,'(a|A|the|The) (\\w+)')
str_extract_all(sentences5,'(a|A|the|The) (\\w+)')
str_match(sentences5,'(a|A|the|The) (\\w+)')
str_match_all(sentences5,'(a|A|the|The) (\\w+)')



#문자열 치환
str_replace(string,'data','text')
str_replace_all(string,'data','text')

#문자열 분할
str_split(string,' ')
str_split(sentences5,' ')
unlist(str_split(sentences5,' '))
unique(unlist(str_split(sentences5,' ')))

str_split(sentences5, ' ',n = 5, simplify =  TRUE)



#추가적인 stringr 함수
str_length(string)
str_count(string,'data')
str_count(string,'\\W+')

mon <- 1:12
str_pad(mon,width = 2, side = 'left',pad = '0')

string_pad <- str_pad(string,width = max(str_length(string)),
        side = 'both',pad = ' ')
string_pad
str_trim(string_pad)


















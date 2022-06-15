txt <- 'Data Analytics is useful. Data Analytics is also interesting'
words <- c('at','bat','cat','chaenomeloes','chase','cheep','check','cheese','chick','hat','ca-t')
words2 <- c('12 Dec','OK','http://','<TITLE>Time?<TITLE>','12345','Hi there')

#텍스트의 치환
sub()
gsub()

txt <- 'Data Analytics is useful. Data Analytics is also interesting'
sub(pattern = "Data",replace = "Business",txt) # 첫번째 Data 만 바뀜
gsub(pattern = "Data",replace = "Business",txt) #Data 다 바뀜
gsub(pattern = "Data",replace = "",txt)

text2 <- c('Product.csv','order.csv','customer.csv') 
gsub(".csv",'',text2)



#2차시 - 정규표현식
# 특정 텍스트 문자열을 일관적으로 찾아낼 수 있는 패턴을 구성하는 것
words <- c('at','bat','cat','chaenomeloes','chase','cheep',
           'check','cheese','chick','hat')
grep("che",words,value=TRUE)
grep("a",words,value=TRUE)
grep("at",words,value=TRUE)

grep("[ch]",words,value=TRUE) #[c or h 가 들어간 모든 문자열]
grep("[at]",words,value=TRUE)
grep("ch|at",words,value=TRUE) # or 
grep("che|at",words,value=TRUE)

grep("ch(e|i)ck",words,value=TRUE) #앞은 ch 뒤는 ck 중간엔 ()둘중 하나

#수량자 ? * +
grep("chas?e",words,value = TRUE) #s가 없거나 한번 나타나는 것
grep("chas*e",words,value = TRUE) #s가 0 혹은 1 번일때
grep("chas+e",words,value = TRUE) #s가 한번이상

grep('ch(a*|e*)se',words,value = TRUE)

#메타문자 $ ^ . 
grep('^c',words,value = TRUE) #c로 시작하는 것
grep('t$',words,value = TRUE) #t로 끝나는 것

grep('^c.*t$',words,value = TRUE) #c로 시작되고 t로 끝나는데, 그 사이에 문자가 하나이상 인 것
grep('^[ch]?at',words,value = TRUE) #[]라서 ch로 시작되도 되고 아니어도 되고


#문자클래스
words2 <- c('12 Dec','OK','http://','<TITLE>Time?<TITLE>','12345','Hi there')

grep('[[:alnum:]]',words2,value = TRUE) #알파벳과 넘버를 포함한 모든 문자열
grep('[[:alpha:]]',words2,value = TRUE) #알파벳만 가져와라
grep('[[:digit:]]',words2,value = TRUE) #숫자만 가져와라
grep('[[:punct:]]',words2,value = TRUE) #특수문자있는거 가져와라
grep('[[:space:]]',words2,value = TRUE) #공백문자있는거 가져와라

#문자열 클래스 시퀀스
grep('\\w+',words2,value = TRUE) #모든문자열을 가져와라
grep('\\s+',words2,value = TRUE) #공백을 포함한
grep('\\D+',words2,value = TRUE) #숫자를 포함한 것을 제외한

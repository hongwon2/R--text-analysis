x <- 'we have a dream'
x
class(x)
nchar(x) #공백의 숫자까지
length(x) #하나로 침

y <- c('we','have','a','dream')
y
nchar(y)
length(y)

length(y[4])
nchar(y[4])

letters
sort(letters,decreasing = TRUE)
fox.says <- "It is only wih the HEART that one can see Rightly"
fox.says

tolower(fox.says)
toupper(fox.says)

#텍스트의 분할
fox.said <- "what is essential is invisible to the eye"
strsplit(fox.said,split = " ") #띄어쓰기 기준 단어로 나눔 주로 이걸씀
strsplit(fox.said,split = "")
class(strsplit(fox.said,split = " ")) #리스트 형식으로 반환

unlist(strsplit(fox.said,split = " "))
class(unlist(strsplit(fox.said,split = " "))) # 백터형식으로 반환

fox.said.words <- unlist(strsplit(fox.said,split = " "))
fox.said.words
fox.said.words[3]
fox.said.words[1]
unlist(strsplit(fox.said,split = " "))

strsplit(fox.said,split = " ")
strsplit(fox.said,split = " ")[[1]]
strsplit(fox.said,split = " ")[[1]][[3]]


p1 <- 'you come as four in the afternoon, then as three I shall bebind to be happy'
p2 <- 'One runs the irst of weeping a litter, if one lets gimselt ne tamed'
p3 <- 'what makes the desert beautiful is that somewhere it hides a well'


littleprince <- c(p1,p2,p3)
littleprince
strsplit(littleprince,split = " ")
strsplit(littleprince,split = " ")[[3]]
strsplit(littleprince,split = " ")[[3]][[5]]
strsplit(littleprince,split = " ")[[1]][[7]]


fox.said2 <- "WHAT IS ESSENTAL is isvisible to the Eye"
strsplit(fox.said2,split = " ")
unlist(strsplit(fox.said2,split = " "))


fox.said2.words <- strsplit(fox.said2,split = " ")[[1]]
fox.said2.words

unique(tolower(fox.said2.words)) #이즈(대소문자)가 같아져서 둘중 하나는 안나옴
unique(toupper(fox.said2.words))


#텍스트 결합
paste("Everyones",'wants','to','fly')
paste("Everyones",'wants','to','fly',sep = "-")
paste("Everyones",'wants','to','fly',sep = "")
paste0("Everyones",'wants','to','fly')

paste(fox.said2.words) #이미 하나의 벡터기 때문에 붙힐게 없다
paste(pi,sqrt(pi))
paste("25 degrees Celsius is", 25*1.8 + 32,"degree Fahrenheit")

heroes <- c('Batman',"Captin America","Hulk")
colors <- c('Black','Blue',"Green")
paste(heros,colors)

paste("Type",1:10)

paste(heroes,"wants","to","fly")

paste(fox.said2.words,collapse = " ")
paste(fox.said2.words,collapse = "-")


#2차시
paste(month.abb)
paste(month.abb, 1:12)
paste(month.abb, 1:12,sep = "-")
paste(month.abb, 1:12,collapse = "-")
paste(month.abb, 1:12,collapse = " ")

outer(1:3,1:3)
outer(c(1,2,3),c(1,2,3))

countries <- c('KOR','US',"EU")
stat <- c('GDP','Pop','Area')

outer(countries,stat, FUN = paste,sep = "-")

#고객 주문 결과를 보여주는 시나리오
customer <- "Ryu"
buysize <- 10
deliveryday <- 2

paste('hello',customer,"your order of",buysize,
      "product(s) will be delivered within", deliveryday)

#sprintf()
sprintf('hello %s your order of %s product(s) will be delivered within %s',
        customer,buysize,deliveryday)

customer <- c('Ryu','Kim','Choi')
buysize <- c(10,8,9)
deliveryday <- c(2,3,7.5)

sprintf('hello %s your order of %s product(s) will be delivered within %s',
        customer,buysize,deliveryday)

?sprintf

sprintf('hello %s your order of %s product(s) will be delivered within %.2f',
        customer,buysize,deliveryday)


#substr()
substr("Text Anlytics",start = 1, stop = 4)
substr("Text Anlytics", start = 6, stop = 14)

substring("Text Anlytics",6)
substring("Text Anlytics",2)

class <- c('Data analytics','Data visualization','Data science introduction')
substr(class,1,4)
substring(class,6)


countries <- c('Korea, KR','United states, US','China, CN')
substring(countries,nchar(countries)-1)
substr(countries,nchar(countries)-1,nchar(countries))



#grep()
?islands
head(islands)

landnames <- names(islands)
grep(pattern = "New",x = landnames)
index <- grep(pattern = "New",x = landnames)
landnames[index]
landnames[grep(pattern = "New",x = landnames)]
grep(pattern = "New",x = landnames,value = TRUE)
grep(pattern = " ",x = landnames,value = TRUE)





















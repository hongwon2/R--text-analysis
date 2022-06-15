#코퍼스
  #비정형 텍스트를 구조화된 데이터로 변환
  #내재된 패턴 탐색
  #패턴을 평가하고 해석
#타이디 텍스트
#문서 용어 행렬

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
install.packages('tm')
library(tm)
data(crude)
crude

crude[[1]]
crude[[1]]$content
crude[[1]]$meta
text

VCorpus()
getSources()

corpus.docs <- VCorpus(VectorSource(text))
class(corpus.docs)

corpus.docs

inspect(corpus.docs[1])
inspect(corpus.docs[[1]])

as.character(corpus.docs[[1]])


lapply(corpus.docs,as.character)

str(corpus.docs)

corpus.docs[[1]]$content
lapply(corpus.docs,content)       

as.vector(unlist(lapply(corpus.docs,content)))

paste(as.vector(unlist(lapply(corpus.docs,content))),collapse = " ")

corpus.docs[[1]]$meta

meta(corpus.docs[[1]])
meta(corpus.docs[[1]], tag = 'author')
meta(corpus.docs[[1]], tag = 'id')
meta(corpus.docs[[1]], tag = 'author',type = 'local') <- 'Dong-A'
meta(corpus.docs[[1]])

cor.author <- c('Dong-A','Ryu','kim')
meta(corpus.docs, tag = 'author',type = 'local') <- cor.author
lapply(corpus.docs,meta,tag = 'author')


#9-2
lapply(corpus.docs,meta)
#메타정보 추가
category <- c('health','lifestyle','business')
meta(corpus.docs, tag = 'category',type = 'local') <- category
lapply(corpus.docs, meta, tag = "category")

#메타정보 삭제
meta(corpus.docs, tag = 'origin',type = 'local') <- NULL



# 조건에 맞는 문장만 인덱싱하는 법
corpus.docs.filter <- tm_filter(corpus.docs,FUN = function(x)
  any(grep('weight|diet',content(x))))

lapply(corpus.docs.filter,content)

index <- meta(corpus.docs,"author") == 'Dong-A' | meta(corpus.docs,"author") == "Ryu"

lapply(corpus.docs[index],content)

#저장하는 법
writeCorpus(corpus.docs)
list.files(pattern = "\\.txt")


#텍스트 정제
getTransformations()

tm_map()

content_transformer()

lapply(corpus.docs,content)

#소문자로 변환
corpus.docs <- tm_map(corpus.docs,content_transformer(tolower))
lapply(corpus.docs,content)

#불용어(stopwords) 걸러내기 - 필요없는 단어
stopwords('english')
corpus.docs <- tm_map(corpus.docs,removeWords,stopwords('english'))
lapply(corpus.docs,content)

myremoves <- content_transformer(function(x,pattern)
  {return(gsub(pattern,"",x))})

corpus.docs <- tm_map(corpus.docs,myremoves,"(f|ht)tp\\S+\\s*")
lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,removePunctuation)
corpus.docs <- tm_map(corpus.docs,removeNumbers)

lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,stripWhitespace)
lapply(corpus.docs,content)

corpus.docs <- tm_map(corpus.docs,content_transformer(trimws))
lapply(corpus.docs,content)

#어간추출
corpus.docs <- tm_map(corpus.docs,stemDocument)
lapply(corpus.docs,content)

#동의어 처리
corpus.docs <- tm_map(corpus.docs,content_transformer(gsub),
                      pattern = 'economist',replacement = 'economi')
lapply(corpus.docs,content)










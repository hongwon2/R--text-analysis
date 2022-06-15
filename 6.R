txt <- 'Data Analytics is useful. Data Analytics is also interesting'
words <- c('at','bat','cat','chaenomeloes','chase','cheep','check','cheese','chick','hat','ca-t')
words2 <- c('12 Dec','OK','http://','<TITLE>Time?<TITLE>','12345','Hi there')

#�ؽ�Ʈ�� ġȯ
sub()
gsub()

txt <- 'Data Analytics is useful. Data Analytics is also interesting'
sub(pattern = "Data",replace = "Business",txt) # ù��° Data �� �ٲ�
gsub(pattern = "Data",replace = "Business",txt) #Data �� �ٲ�
gsub(pattern = "Data",replace = "",txt)

text2 <- c('Product.csv','order.csv','customer.csv') 
gsub(".csv",'',text2)



#2���� - ����ǥ����
# Ư�� �ؽ�Ʈ ���ڿ��� �ϰ������� ã�Ƴ� �� �ִ� ������ �����ϴ� ��
words <- c('at','bat','cat','chaenomeloes','chase','cheep',
           'check','cheese','chick','hat')
grep("che",words,value=TRUE)
grep("a",words,value=TRUE)
grep("at",words,value=TRUE)

grep("[ch]",words,value=TRUE) #[c or h �� �� ��� ���ڿ�]
grep("[at]",words,value=TRUE)
grep("ch|at",words,value=TRUE) # or 
grep("che|at",words,value=TRUE)

grep("ch(e|i)ck",words,value=TRUE) #���� ch �ڴ� ck �߰��� ()���� �ϳ�

#������ ? * +
grep("chas?e",words,value = TRUE) #s�� ���ų� �ѹ� ��Ÿ���� ��
grep("chas*e",words,value = TRUE) #s�� 0 Ȥ�� 1 ���϶�
grep("chas+e",words,value = TRUE) #s�� �ѹ��̻�

grep('ch(a*|e*)se',words,value = TRUE)

#��Ÿ���� $ ^ . 
grep('^c',words,value = TRUE) #c�� �����ϴ� ��
grep('t$',words,value = TRUE) #t�� ������ ��

grep('^c.*t$',words,value = TRUE) #c�� ���۵ǰ� t�� �����µ�, �� ���̿� ���ڰ� �ϳ��̻� �� ��
grep('^[ch]?at',words,value = TRUE) #[]�� ch�� ���۵ǵ� �ǰ� �ƴϾ �ǰ�


#����Ŭ����
words2 <- c('12 Dec','OK','http://','<TITLE>Time?<TITLE>','12345','Hi there')

grep('[[:alnum:]]',words2,value = TRUE) #���ĺ��� �ѹ��� ������ ��� ���ڿ�
grep('[[:alpha:]]',words2,value = TRUE) #���ĺ��� �����Ͷ�
grep('[[:digit:]]',words2,value = TRUE) #���ڸ� �����Ͷ�
grep('[[:punct:]]',words2,value = TRUE) #Ư�������ִ°� �����Ͷ�
grep('[[:space:]]',words2,value = TRUE) #���鹮���ִ°� �����Ͷ�

#���ڿ� Ŭ���� ������
grep('\\w+',words2,value = TRUE) #��繮�ڿ��� �����Ͷ�
grep('\\s+',words2,value = TRUE) #������ ������
grep('\\D+',words2,value = TRUE) #���ڸ� ������ ���� ������
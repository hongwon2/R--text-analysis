s <- read.csv(file.choose(),header = T, sep = ',',encoding = 'latin1',na.strings = "-")
write.table(s,'save_kim.csv')

#�ҷ�����(pander ��Ű��)
install.packages('pander')
library(pander)

openFileInOS("product.csv")
openFileInOS("product-with-no-header.csv")
openFileInOS("product-missing.csv")
openFileInOS('product.txt')
openFileInOS('product-fwf.txt')
openFileInOS('won-dollar.txt')
#readr ��Ű��
install.packages("readr")
library(readr)

read_csv(file = "product.csv")
read_csv(file = "product-with-no-header.csv",
         col_names = c("id","name","price"))

read_csv(file = "product-missing.csv",na = ",")

read_delim(file = "product.txt",delim = " ")
read_delim(file = "product-with-no-header.csv",delim = ",",
           col_names = c("id","name","price"))

fwf_empty()
fwf_positions()
fwf_widths()
fwf_cols()
#fwf ������ �������� ���� ���е� ����
read_fwf(file = "product-fwf.txt",
         col_positions = fwf_empty(file = "product-fwf.txt",
                                   col_names = c("id","name","price")))

read_fwf(file = "product-fwf.txt",
         col_positions = fwf_widths(widths = c(5,10,8),
                                    col_names = c("id","name","price")))

#������ ���� ĭ�� �����ʹ� read_table�� ���°� �Ϲ���(������ ��ĭ���� ó��)
read_table(file = "product-fwf.txt",
           col_names = c("id","name","price"))
read_table(file = "product.txt",col_names = c("id","name","price"))

#������ ������ �б�
read_lines(file = "won-dollar.txt")
read_lines(file = "won-dollar.txt",skip = 1) # 1�� ����
read_lines(file = "won-dollar.txt",skip = 1, n_max = 2) # 1�� ����,2�� ��������
read_file(file = "won-dollar.txt")

a <- Orange
write_csv(x = Orange,file = "orange.csv")
read_csv(file = "orange.csv")
write_delim(x = Orange,file = "orange.txt",delim = ';')
read_delim(file = "orange.txt",delim = ";")

#���ڸ� �̾Ƴ���(readr)
parse_number("$100")
class(parse_number("$100"))
parse_number("10%")
parse_number("alary per tear: $300,000")
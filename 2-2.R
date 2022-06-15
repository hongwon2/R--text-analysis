#2-2 - ¿Œµ¶ΩÃ
product <- list('A001','Mouse', 30000)
product

#[[?]] ∫§≈Õ∞™¿ª ∞°¡Æø»
product[[3]]
product[[2]]
product[[1]]
class(product[[3]])
#[?] ∏ÆΩ∫∆Æ∑Œ ∞°¡Æø»
product[2]
class(product[3])


product[[3]]*0.8
product[c(1,2)]
product[c(1,3)]
product[c(FALSE,TRUE,TRUE)]
product[-1]
product[-2]

product <- list(id = "A002",name = "Mouse", price = 30000)
product

product[["id"]]
product$name
product[c("name","price")]

product[["holder"]]
product[[4]]
product[c(4,2,5)]


lst <- list(one = 1, two = 2, three = list(alpha = 3.1, beta = 3.2))
lst

lst[["three"]]
lst[["three"]][["alpha"]]
lst$three$alpha
lst[["three"]]$alpha

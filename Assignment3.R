## Question 1
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)
data(Groceries) # read the Groceries data
class(Groceries) # determine the class type
summary(Groceries) # inspect the rows and columns

## Question 2
itemFrequencyPlot(Groceries,
                  type="relative",
                  topN=20,
                  support=0.05,
                  horiz=F,
                  col='steelblue3',
                  xlab='',
                  main='Item frequency')

## Question 3
# determine items for lhs
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.08), 
                  appearance = list (default="lhs",rhs="whipped/sour cream"), 
                  control = list (verbose=F)) # get rules that lead to buying 'whipped/sour cream'
rules_conf_lhs <- sort (rules, by="confidence", decreasing=TRUE) # 'high-confidence' rules.
inspect(head(rules_conf_lhs))
# determine items for rhs
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.08, minlen=2), 
                  appearance = list(default="rhs",lhs="whipped/sour cream"), 
                  control = list (verbose=F)) # those who bought 'whipped/sour cream' also bought..
rules_conf_rhs <- sort (rules, by="confidence", decreasing=TRUE) 
inspect(head(rules_conf_rhs))
# create rules
rules.sub1 <- subset(rules_conf_lhs, subset = lhs %in% c("whole milk", "whipped/sour cream"))
inspect(head(rules.sub1))
rules.sub2 <- subset(rules_conf_lhs, subset = lhs %in% c("yogurt", "whipped/sour cream"))
inspect(head(rules.sub2))
rules.sub3 <- subset(rules_conf_rhs, subset = rhs %in% c("other vegetables", "whipped/sour cream"))
inspect(head(rules.sub3))
rules.sub4 <- subset(rules_conf_rhs, subset = rhs %in% c("tropical fruit", "whipped/sour cream"))
inspect(head(rules.sub4))

## Question 4
subrules <- c(rules.sub1)
plot(subrules, interactive = T)

## Question 5
plot(subrules, method="graph", engine="htmlwidget")



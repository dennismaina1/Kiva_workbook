#packages
library('dplyr')
library("ggplot2")

#importing dataset
Kiva <- read.csv("D:/Projects/Athena/kiva_loans.csv", header = TRUE)

#get successful(1) and unssucessful campaigns(0)
Kiva$status <- ifelse(Kiva$funded_amount >= Kiva$loan_amount/2, "1", "0")
Kiva$status_binary <- as.integer(Kiva$status)

#get SCR(%) by country
SCR <- Kiva %>% group_by(country)%>%
  summarise(SCR = sum ((status_binary)/n())*100) %>% arrange(desc(SCR))

#view top performing regions
Top_5_performers <- head(SCR,5)
barplot(Top_5_performers$SCR, names.arg = Top_5_performers$country, main="Successful Campaigns Rate by Country",
        xlab = "Region", ylab = "SCR", col = "green")
#view poor performing regions
Bottom_5_performers <-tail(SCR,5)
barplot(Bottom_5_performers$SCR, names.arg = Bottom_5_performers$country, main = "Failed Campaigns Rate by Country",
        xlab = "Region", ylab = "SCR", col= "red")

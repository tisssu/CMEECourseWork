library(ggplot2)
library(dplyr)
library(tidyr)

MyDF = read.csv("../Data/EcolArchives-E089-51-D1.csv")
p = ggplot(MyDF,aes(x = log(Prey.mass), y = log(Predator.mass), color = Predator.lifestage)) + geom_point(shape = I(3))
p = p +facet_grid(Type.of.feeding.interaction~.) + geom_smooth(method = lm,fullrange = T)
p = p + scale_x_continuous("Prey Mass in grams") +scale_y_continuous("Predator Mass in grams")
p = p + theme(legend.position = "bottom") 
pdf("../Results/PP_Regress.pdf")
p 
dev.off()

# group the dataset by feeding type
insecDF = MyDF %>% filter(Type.of.feeding.interaction == "insectivorous")
pisciDF = MyDF %>% filter(Type.of.feeding.interaction == "piscivorous")
plankDF = MyDF%>% filter(Type.of.feeding.interaction == "planktivorous")
predaDF = MyDF %>% filter(Type.of.feeding.interaction == "predacious")
pre_pisDF = MyDF %>% filter(Type.of.feeding.interaction == "predacious/piscivorous")

# build function to make the table
make_table = function(input)
{
  output = rep(NA,5)
  model = summary(lm(log(Prey.mass)~log(Predator.mass),data = input))
  output[1] = model$coefficients[2,1]
  output[2] = model$coefficients[1,1]
  output[3] = model$r.squared[1]
  output[4] = model$fstatistic[1]
  output[5] = model$coefficients[2,4]
  output = return(output)
}

# linear regregation by predator life satge
#insectivorous
insecDF %>% group_by(Predator.lifestage) %>% summarise()
la_ju_in = make_table(insecDF)

# piscivorous
pisciDF %>% group_by(Predator.lifestage) %>% summarise()
adult_pisciDF = pisciDF %>% filter(Predator.lifestage == "adult")
ad_pi = make_table(adult_pisciDF)
juve_pisciDF = pisciDF %>% filter(Predator.lifestage == "juvenile")
ju_pi = make_table(juve_pisciDF)
la_ju_pisciDF = pisciDF %>% filter(Predator.lifestage == "larva / juvenile")
la_ju_pi = make_table(la_ju_pisciDF)
post_pisciDF = pisciDF %>% filter(Predator.lifestage == "postlarva")
po_pi = make_table(post_pisciDF)
po_ju_pisciDF = pisciDF %>% filter(Predator.lifestage == "postlarva/juvenile")
po_ju_pi = make_table(po_ju_pisciDF)

#planktivorous
plankDF %>% group_by(Predator.lifestage) %>% summarise()
adult_plankDF = plankDF %>% filter(Predator.lifestage == "adult")
ad_pl = make_table(adult_plankDF)
juve_plankDF = plankDF %>% filter(Predator.lifestage == "juvenile")
ju_pl = make_table(juve_plankDF)
la_plankDF = plankDF %>% filter(Predator.lifestage == "larva")
la_pl = make_table(la_plankDF)
la_ju_plankDF = plankDF %>% filter(Predator.lifestage == "larva / juvenile")
la_ju_pl = make_table(la_ju_plankDF)
po_ju_plankDF = plankDF %>% filter(Predator.lifestage == "postlarva/juvenile")
po_ju_pl = make_table(po_ju_plankDF)

#predacious
predaDF %>% group_by(Predator.lifestage) %>% summarise()
adult_predDF = predaDF %>% filter(Predator.lifestage == "adult")
ad_pr = make_table(adult_predDF)
juve_predDF = predaDF %>% filter(Predator.lifestage == "juvenile")
ju_pr = make_table(juve_predDF)
la_predDF = predaDF %>% filter(Predator.lifestage == "larva")
la_pr = make_table(la_predDF)
la_ju_predDF = predaDF %>% filter(Predator.lifestage == "larva / juvenile")
la_ju_pr = make_table(la_ju_predDF)
post_predDF = predaDF %>% filter(Predator.lifestage == "postlarva")
po_pr = make_table(post_predDF)
po_ju_predDF = predaDF %>% filter(Predator.lifestage == "postlarva/juvenile")
po_ju_pr = make_table(po_ju_predDF)

#predacious/piscivorous
pre_pisDF %>% group_by(Predator.lifestage) %>% summarise()
adult_pre_piDF = pre_pisDF %>% filter(Predator.lifestage == "adult")
ad_pr_pi = make_table(adult_pre_piDF)

PP_results = rbind(la_ju_in, ad_pi, ju_pi, la_ju_pi, po_pi, po_ju_pi, ad_pl, ju_pl, la_pl, la_ju_pl, po_ju_pl,
      ad_pr, ju_pr, la_pr, la_ju_pr, po_pr, po_ju_pr, ad_pr_pi)
colnames(PP_results) = c("slope", "intercept", "R^2", "F-value", "P-value")
write.csv(PP_results,"../Results/PP_Regress_Results.csv")

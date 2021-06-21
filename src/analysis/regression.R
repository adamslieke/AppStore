# Load the data
data_app <- read_csv("/data/data.csv")
view(data_app) #look at data

#create multi-lang column for reg2
df_clean <- df_clean %>%
  mutate(multi_lang = ifelse(df_clean$lang.num>1, 1, 0))
#install.packages("stargazer") #need stargazer
library(stargazer)

reg1<- lm(rating_count_tot ~ price + user_rating + prime_genre, data=df_clean, family = binomial(link = "probit"))
#model1 regression
reg2<- lm(rating_count_tot ~ price + user_rating + prime_genre + multi_lang, data=df_clean, family = binomial(link = "probit"))
#model2 regression

htmlreg <- stargazer(reg1, reg2, title="Regression Results",align=TRUE, type = "text", no.space=TRUE, out="models.txt")
#regression estimates both models

dir.create("gen/")
dir.create("gen/analysis/")
#install.packages("htmltools")
library(htmltools)
output_filename <- ("regression.html")
output_dir <- "gen/analysis/"
output_path <- file.path(output_dir, output_filename)
htmltest<- stargazer(htmlreg, output_path, type="html")
save_html(htmltest, output_path, background = "white", libdir = "lib", lang = "en")
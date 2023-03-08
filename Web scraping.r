# -*- coding: utf-8 -*-

# -- IMDB --

# **Mini Project 01 IMDB web scraping**


library(tidyverse)
library(rvest) #scrape data from internet

url<-"https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"

print(url)

#read html
imdb<-read_html(url)

imdb

#movie_title
titles<-imdb%>%
    html_nodes("h3.lister-item-header") %>%  #nodes:all node
    html_text2()  

titles[1:10]

#rating
ratings<-imdb%>%
    html_nodes("div.ratings-imdb-rating") %>%
    html_text2() %>%
    as.numeric()

ratings[1:10]

#number of votes
num_votes<-imdb%>%
    html_nodes("p.sort-num_votes-visible") %>%
    html_text2() 

#build a dataset
df<-data.frame(
    tiltle=titles,
    rating=ratings,
    num_vote=num_votes

)
head(df)







# -- SpecPhone --

# **Mini project2: Spec Phone Database**


library(tidyverse)
library(rvest) #scrape data from internet

url<-read_html("https://specphone.com/Samsung-Galaxy-A14.html")

att<-url %>%
    html_nodes("div.topic")%>%
    html_text2()

value<-url %>%
    html_nodes("div.detail")%>%
    html_text2()

data.frame(attribute=att,value=value)

#all smssung smartphones
samsung_url<-read_html("https://specphone.com/brand/Samsung")

#link to all samsung smart phone
links<-samsung_url%>%
    html_nodes("li.mobile-brand-item a") %>%     #a : child from li
    html_attr("href")

full_links<-paste0("https://specphone.com",links)

result<-data.frame()


for (link in full_links[1:5]) {
    ss_topic<-link %>%
        read_html()%>%
        html_nodes("div.topic")%>%
        html_text2()

    ss_detail<-link %>%
        read_html()%>%
        html_nodes("div.detail")%>%
        html_text2()
    tmp<-data.frame(attribute=ss_topic,
                    value=ss_detail)
    
    result<-bind_rows(result,tmp)
    print("Progress...")
}

#print(result)

print(head(result),3)

#write csv
write_csv(result,"result_ss_phone.csv")


## load library
  library(dplyr)
  
## read in data
  brand_posts <- readRDS("brand_posts.RDS")
  brand_post_comments <- do.call(rbind,readRDS("brand_post_comments.RDS"))
  brand_post_likes <- do.call(rbind,readRDS("brand_post_likes.RDS"))
    ## flatten data into one data frame
    row.names(brand_post_comments) <- NULL
    row.names(brand_post_likes) <- NULL

## get user data of people who liked the post, from_id contains the user id for this table
    ## first get 10K users from each brand randomly
    selected_users <- brand_post_likes %>% group_by(brand.Name) %>% sample_n(size = 15000)
    
    # for(i in 3550:3600){
    # user_likes_details <- getUsers(unique(selected_users$from_id[i]),token = fbAuth) 
    # print(paste0(i,"/","50"))
    # }
    
## read in already fetched like user data
    user_likes_details <- readRDS("user_likes_details2017-02-18.RDS") %>%
      select(id,name,picture)
    
    
    
    
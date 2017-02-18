## init ####
## load library
	library(httr)
	library(Rfacebook)
  library(dplyr)
  library(purrr)  

## set working directory
	setwd("./fbExp2")

## facebook module ####
	## setup fb auth
	fbAuth <- fbOAuth(app_id = "189797138165156",app_secret = "2772b6bcd06bf8ebe4c20438d50f8ac6",extended_permissions = TRUE)
	
	## read in brand data
	shave_brands <- read.csv("shave_brands.csv",stringsAsFactors = F,colClasses = c("pageID"="character"))
	
	## get post data from the pages, 100 posts for now
	  post_to_get <- 100
	  
	  for(i in 1:nrow(shave_brands)){
	    tmp <- getPage(shave_brands$pageID[i],token = fbAuth,n=post_to_get)
	    if(i==1){
	      brand_posts <- tmp
	    }else{
	      brand_posts <- rbind(brand_posts,tmp)
	    }
	  }
	  
	 ## save posts
	  saveRDS(brand_posts,"brand_posts.RDS") 
	  
	 ## get users from each post
	  brand_post_likes    <- list()
	  brand_post_comments <- list()
	  
	  for(i in 1:nrow(brand_posts)){
	   tmp <- getPost(brand_posts$id[i],token = fbAuth,comments = T)
	   
	   ## put likes in a lists
	   tmpdf <- tmp$likes
	   tmpdf$post.ID <- tmp$post$id
	   tmpdf$brand.Name <- brand_posts$from_name[i]
	   brand_post_likes[[tmp$post$id]] <- tmpdf
	   
	   ## put comments in a list
	   tmpdf <- tmp$comments
	   tmpdf$post.ID <- tmp$post$id
	   tmpdf$brand.Name <- brand_posts$from_name[i]
	   brand_post_comments[[tmp$post$id]] <- tmpdf
	   
	   ## print counter
	   print(paste0(i,"/",nrow(brand_posts)))
	 }
	 ## save data
	  saveRDS()
	 
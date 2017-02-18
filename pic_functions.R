## function do download the pics
doDL <- function(fnm,url1){
  try(download.file(url1,fnm,mode = "wb") )
}

## download in a loop, set the working directory first
setwd("profile_images")


for(i in 1:nrow(userList)){
  fName <- paste0(user_likes_details$id[i],".jpg")
  doDL(fName,user_likes_details$picture[i])
}

# upload image
# setwd("profile_images")
setwd("..")
face_api_url <- "https://westus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses"
source('D:/Syncs/BoxSync/Box Sync/rprog/hondaValidation/fbExp2/ms_api_access.R', encoding = 'UTF-8')

setwd("profile_images")
fName <- list.files()
j<- 1
for(i in 1:length(fName))
{
  profile_image = upload_file(fName[i])
  ## send pic to api and get results
  api_request <- POST(
    face_api_url,
    body = profile_image,
    add_headers(.headers = c("Content-Type"="application/octet-stream",
                             "Ocp-Apim-Subscription-Key"=api_key_ms))
  )
  
  api_result <- content(api_request)
  ## convert to dataframe
  stst <- "No"
  if(length(api_result)>0 & api_request$status_code == 200)
  {
    face_attributes <- as.data.frame(api_result[[1]]$faceAttributes$facialHair)
    face_attributes$fbid <- gsub(".jpg","",fName[i])
    face_attributes$gender <- api_result[[1]]$faceAttributes$gender
    face_attributes$smile <- api_result[[1]]$faceAttributes$smile
    if(j>1)
    {df1 <- rbind(df1,face_attributes)}
    else
    {df1 <- face_attributes}
    j<-j+1
    stst <- "Yes"
  }
  print(paste0(i," - ",stst," - ",api_request$status_code))
}

## save file
saveRDS(df1,"tw_gl_comp_face_attributes.rds")
write.csv(df1,"tw_gl_comp_face_attributes.csv",row.names = F)
setwd("..")

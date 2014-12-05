#plot on google earth 
#plotGoogle(spdf, col="red",zoom=12)
library(shiny)
library(sp)
library(ggmap)
library(rgdal)
library(RgoogleMaps)
library(plotGoogleMaps)
library(SpatialTools)
library(mapproj)

load('Med.RData')
shinyServer(function(input, output) {
  
#input city from UI (currently inactive)
  #city<-reactive({
  #city<-input$city
  #return(city)  
  #})
  
#filter the data by the 'type' and a 'search box' entered from the UI
 
    city.data<-reactive({
      input$update
      isolate({
   type<-input$type
   text.input<-input$search
   #select and index the proper set of data by input 'type'
   if(type==c("All Contacts in A Dental Office")){
   city.data<-costar.dent.data
   city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
   city.data<-city.data[city.data$match=="TRUE",]
   return(city.data)}
   
   if(type==c("General Dentist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210201 |
                                    hoovers.dent.data$TYPE==80210200 |
                                    hoovers.dent.data$TYPE==80210202,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}
   
   if(type==c("Specialized Dental Practitioners")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210100,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}
   
   if(type==c("Dental Surgeon")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210101,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Endodontist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210102,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Maxillofacial Specialist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210103,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Oral Pathologist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210104,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Orthodontist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210105,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Pedodontist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210106,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Periodontist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210107,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   if(type==c("Prosthodontist")){
     city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210108,]
     city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
     city.data<-city.data[city.data$match=="TRUE",]
     return(city.data)}  
   
   city.data<-med.data[med.data$TYPE==type,]
   city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
   city.data<-city.data[city.data$match=="TRUE",]
   return(city.data)
  })
    })
#index the proper data for the comparative analysis 
  city.data2<-reactive({
    input$update
    isolate({
      type<-input$comp.type
      text.input<-input$search
      #select and index the proper set of data by input 'type'
      if(type==c("All Contacts in A Dental Office")){
        city.data<-costar.dent.data
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}
      
      if(type==c("General Dentist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210201 |
                                       hoovers.dent.data$TYPE==80210200 |
                                       hoovers.dent.data$TYPE==80210202,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}
      
      if(type==c("Specialized Dental Practitioners")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210100,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}
      
      if(type==c("Dental Surgeon")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210101,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Endodontist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210102,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Maxillofacial Specialist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210103,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Oral Pathologist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210104,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Orthodontist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210105,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Pedodontist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210106,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Periodontist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210107,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      if(type==c("Prosthodontist")){
        city.data<-hoovers.dent.data[hoovers.dent.data$TYPE==80210108,]
        city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
        city.data<-city.data[city.data$match=="TRUE",]
        return(city.data)}  
      
      city.data<-med.data[med.data$TYPE==type,]
      city.data$match<-grepl(text.input,city.data$LEGALNAME,ignore.case=TRUE,perl=TRUE)
      city.data<-city.data[city.data$match=="TRUE",]
      return(city.data)
    })
  })

#create a spatial points data from for Google Earth download
  datasetInput <- reactive({
    input$update
    isolate({
    city.data<-city.data()
    coords<-cbind(city.data$N_LON,city.data$N_LAT)
    sp<-SpatialPoints(coords)
    spdf<-SpatialPointsDataFrame(sp, city.data)
    return(spdf)
    })})

#calcluate the total euclidian distance for all points within a list
  tab<-reactive({
    input$update
    isolate({
    tab<-city.data()
    coords<-cbind(tab$N_LON,tab$N_LAT)
    tab$dist<-
    #Use this if we want total distance, rowSums(dist1(coords))
    tab<-tab[order(-tab$dist),]
    tab<-tab[order(tab$CITY),]
    return(tab)
    })})

#calculate the euclidian distance between two complementary elements
  tab2<-reactive({
    input$update
    isolate({
      tab<-city.data()
      tab2<-city.data2()
      coords1<-cbind(tab$N_LON,tab$N_LAT)
      coords2<-cbind(tab2$N_LON,tab2$N_LAT)
      tab$dist<-apply(dist2(coords1,coords2),1,function(x)min(x))
      #Use this if we want total distance, rowSums(dist1(coords))
      tab<-tab[order(-tab$dist),]
      tab<-tab[order(tab$CITY),]
      return(tab)
    })})
#create subset with estimated lease end in days
  tab3<-reactive({
    input$update
    isolate({
      tab<-city.data()
      tab$Est_DaysTo_Lease_End<-as.numeric(Sys.Date()-tab$DOI)
      tab$Est_DaysTo_Lease_End<-(tab$Est_DaysTo_Lease_End%%(365*5))
      tab<-tab[order(tab$Est_DaysTo_Lease_End),]
      tab<-tab[order(tab$CITY),]
      return(tab)
    })})
  
  #render phoenix wide plot
  output$PHX_M<-renderPlot({
    input$map.update
    isolate({
    print(city.map+
      stat_density2d(
        aes(x = N_LON, y = N_LAT,colour="Density of Facilites"),
        size = 1, bins = 4,alpha=1/3,
        data = city.data(), geom="polygon")+
        geom_point(aes(x = N_LON, y = N_LAT,colour=subtype),
                   size = 4,data = city.data())
      )
    })
    })
  #render city specific plot
 # output$CITY<-renderPlot({
  #  city.data<-city.data()
   # city<-as.character(city())
  #  city.choice<-as.character(paste(city,c(' az')))
   # city.c.map<-qmap(city.choice,zoom=13)
    
 #   print(city.c.map+
  #    geom_point(aes(x = N_LON, y = N_LAT,colour=subtype),
   #              size = 4,data = city.data))
  #},height = 800, width = 800)
  
  #create and download file for google earth
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$type, '.kml', sep='') },
    content = function(file) {
      writeOGR(datasetInput(), file ,"med", driver="KML")    
    }
  )
#create and download file for competitive distance
  output$table<-downloadHandler(
    filename = function() { paste(input$type, '.csv', sep='') },
    content = function(file) {
      write.csv(tab(), file)    
    }
  )
#create and download file for complementary distance
 output$table2<-downloadHandler(
   filename = function() { paste(input$type," to ",input$comp.type, '.csv', sep='') },
   content = function(file) {
     write.csv(tab2(), file)    
   }
 )
#create and download list for facilites that are close to lease end
#this is the most subjective file
 output$table3<-downloadHandler(
   filename = function() { paste(input$type,"LeaseExp", '.csv', sep='') },
   content = function(file) {
     write.csv(tab3(), file)    
   }
 )
  })
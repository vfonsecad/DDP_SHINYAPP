###########################################################
#######   CLASS PROJECT DDP COURSERA - CONJOINT SIMULATOR
###########################################################
library(shiny)
library(googleVis)

Company_size<-c(rep("Small",5), rep("Medium", 5))
City<-sample(c(rep("Seattle",5), rep("Portland", 5)),10,replace=FALSE)
T_mobile<-rnorm(10,1,1)
Sprint<-rnorm(10,2,1)
Verizon<-rnorm(10,3,1)
Up_to_30<-rnorm(10,2.5,1)
a30_a50<-rnorm(10,1,1)
a50_a80<-rnorm(10,1,1)
a2MB<-rnorm(10,1,1)
a5MB<-rnorm(10,1,1)
a8MB<-rnorm(10,1,1)
No_Wi_Fi<-rnorm(10,1,1)
Customized<-rnorm(10,1,1)

data_utilities<-data.frame(Company_size,
           City,
           T_mobile,
           Sprint,
           Verizon,
           Up_to_30,
           a30_a50,
           a50_a80,
           a2MB,
           a5MB,
           a8MB,
           No_Wi_Fi,
           Customized)

names(data_utilities)<-c("Company size",
                         "City",
                         "T-mobile",
                         "Sprint",
                         "Verizon",
                         "Up to $30",
                         "$30 - $50",
                         "$50 - $80",
                         "2MB",
                         "5MB",
                         "8MB",
                         "No Wi-Fi",
                         "Customized")

shinyServer(
  function(input,output){
    #filters    
       fcomp<-reactive({
       small<-input$small
       medium<-input$med
       vcompany<-vector()
       vcompany[data_utilities[,1]=="Small"]<-small
       vcompany[data_utilities[,1]=="Medium"]<-medium
       return(as.logical(vcompany))
     })
     fcity<-reactive({
       seattle<-input$seattle
       portland<-input$portland
       vcity<-vector()
       vcity[data_utilities[,2]=="Seattle"]<-seattle
       vcity[data_utilities[,2]=="Portland"]<-portland
       return(as.logical(vcity))
     })   
     output$companies_marked<-renderText({sum(fcomp())})
     output$cities_marked<-renderPrint({sum(fcity())})
     id_record<-reactive({
     if(sum(fcomp())==0) a<-as.logical(fcity())
     else{if(sum(fcity())==0) a<-as.logical(fcomp()) else 
       a<-as.logical(fcomp()*fcity())}
     return(a)
     })
     #1
  aa<-reactive({
    prod1_def<-c(input$prod1_at1,input$prod1_at2, input$prod1_at3, input$prod1_at4)
    subdata1<-data_utilities[id_record(),which(names(data_utilities)%in%prod1_def)]    
    p<-mean(apply(subdata1,1,mean))
    return(round(p,2))
    })
  output$utility1<-renderText({aa()})
  #2
  bb<-reactive({
    prod2_def<-c(input$prod2_at1,input$prod2_at2, input$prod2_at3, input$prod2_at4)
    subdata2<-data_utilities[id_record(),which(names(data_utilities)%in%prod2_def)]    
    q<-mean(apply(subdata2,1,mean))
    return(round(q,2))
  })
  output$utility2<-renderText({bb()})
  #3
  cc<-reactive({
    prod3_def<-c(input$prod3_at1,input$prod3_at2, input$prod3_at3, input$prod3_at4)
    subdata3<-data_utilities[id_record(),which(names(data_utilities)%in%prod3_def)]    
    r<-mean(apply(subdata3,1,mean))
    return(round(r,2))
  })
  output$utility3<-renderText({cc()})

  
  ### google vis plot
  output$columnchart<-renderGvis({
    Utilities<-c(aa(),bb(),cc())
    Products<-c("Product 1", "Product 2", "Product 3")
    data_to_plot<-data.frame(Products, Utilities)     
   return(gvisColumnChart(data_to_plot,options=list(colors="['purple']")))
  })
  })
  
  

library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Arizona Healthcare Realty:  Market Analysis Training Tool"),
  
  sidebarPanel(helpText("Use the fields below to identify a medical facility type and city 
                        of interest."),
               #actionButton("update","Refresh Output"),
               # select the city of interest
               #selectInput("city", label = "Choose a City",
                #           choices = list("CHANDLER", "GILBERT","MESA",
                 #                         "PHOENIX","SCOTTSDALE","TEMPE","TUCSON"),
                  #         selected = "SCOTTSDALE"),
               selectInput("type", label = "Choose a Primary Type of Facility",
                           choices = list("AZ MEDICAL FACILITIES","SPECIAL LICENSURE - MIDWIFE",
                                          "MED-SINGLE GROUP LICENSURE/OTC","HOSPITAL",
                                          "HOME HEALTH AGENCY (HHA)","AL HOME-DIRECTED","General Dentist",
                                          "Specialized Dental Practitioners","Dental Surgeon","Endodontist",
                                          "Maxillofacial Specialist","Oral Pathologist","Orthodontist",
                                          "Pedodontist","Periodontist","Prosthodontist","All Contacts in A Dental Office"),
                           selected = "HOSPITAL"),
               
               selectInput("comp.type", label = "Choose a Complementary Type of Facility",
                           choices = list("AZ MEDICAL FACILITIES","SPECIAL LICENSURE - MIDWIFE",
                                          "MED-SINGLE GROUP LICENSURE/OTC","HOSPITAL",
                                          "HOME HEALTH AGENCY (HHA)","AL HOME-DIRECTED","General Dentist",
                                          "Specialized Dental Practitioners","Dental Surgeon","Endodontist",
                                          "Maxillofacial Specialist","Oral Pathologist","Orthodontist",
                                          "Pedodontist","Periodontist","Prosthodontist","All Contacts in A Dental Office"),
                           selected = "HOSPITAL"),
               textInput("search",label="Enter a term to search the names of facilites within the selected 'type.'",
                         value=""),p(),
               actionButton("update","Update Data")
  ),
  
  mainPanel(
    helpText("The purpose of this tool is to explore the location and types of dental, veterinarian and medical facilites 
               in the state of Arizona.  The information used in this tool is current as of July 2014.
               There is one map at the Phoenix metro area level displayed to give an idea of density.  
               The second tab gives an option to download the information into a Google Earth file for 
               futher exploration.  The third and fourth tabs are a lead generator based on 
               distance to other similar or complementary facilities."),
    tabsetPanel(
      tabPanel("Phoenix Area Map", #helpText("This function is currently disabled"),
              actionButton("map.update","Update Map"),
              plotOutput("PHX_M")
               ),
      #tabPanel("City Level Map"
               #plotOutput("CITY")
       #        ),
      tabPanel("Download to Google Earth",
               helpText("Press the download button to save the file.  Once saved locally open it with Google Earth."),
               downloadButton('downloadData', 'Download')
               ),
      tabPanel("Competitve Distance",
               helpText("This tab gives a list of leads based on how 'lonely' a facility is. 
                        Loneliness here is defined as a facilities distance to its closest like (or
                        competivie) neighbor. 
                        This list is sorted by city. Keep in mind that some of the results may 
                        not be useful due to data inconsistency. It is recommended to use 
                        Google Earth to filter/analyze the results from this list."),
               downloadButton('table','Download')
               #tableOutput("table")
               ),
      tabPanel("Complementary Distance",
                helpText("This tab gives a list of leads based on how 'lonely' a facility is. 
                        Loneliness here is defined as a facilities distance to its closest dis-similar (or
                        complementary) neighbor. 
                        This list is sorted by city. Keep in mind that some of the results may 
                        not be useful due to data inconsistency. It is recommended to use 
                        Google Earth to filter/analyze the results from this list."
                  ),
               downloadButton('table2','Download')
                ),
      tabPanel("Nearest Lease Exp",
               helpText("This tab provides a list of facilites that are nearest to their lease expiration.
                          This date is in most cases forecast in 5 year increments from a facilites founding."
                 ),
               downloadButton('table3','Download')
               )
      )
  )))
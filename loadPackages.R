# # This is a boiler plate script to chcek for packages and install and load them if they are no already
# requiredPackages = c(
#                      'shinythemes'
#                      ,'shinyBS'
#                      ,'threejs'
#                      # ,'flexdashboard'
#                      ,'d3Network'
#                      ,'igraph'
#                      ,'networkD3'
#                      ,'visNetwork'
#                      ,'data.table'
#                      ,'DT'
#                      ,'shinyAce'
#                      ,'collapsibleTree'
#                      ,'shinyjs'
#                      ,'colourpicker'
#                      ,'shinydashboard'
#                      )
#
# for(p in requiredPackages){
#   if(!require(p,character.only = TRUE)) install.packages(p)
#   library(p,character.only = TRUE)
# }
library(shinythemes)
library(shinyBS)
library(d3Network)
library(igraph)
library(networkD3)
library(visNetwork)
library(data.table)
library(knitr)
library(formattable)
library(DT)
library(shinyAce)
library(collapsibleTree)
library(shinyjs)
library(colourpicker)
library(shinydashboard)
require(sqldf)
require(leaflet)
require(shiny)
require(ggplot2)
require(reshape2)
require(plyr)
require(scales)
require(xts)
require(rex)
require(rhandsontable)

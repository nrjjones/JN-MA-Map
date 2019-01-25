################################################################################
### Environment setup
################################################################################

### Packages
library(tidyverse)        
library(readxl)
library(ggmap)
library(maps)
library(mapdata)

#source("./secrets.R")          # Loads my Google API Key

# Constants

today <- Sys.Date()

################################################################################
### Load
################################################################################

df <- read_csv("./out/JN-MA-Map data with geocode.csv")

df$open2 <- factor(df$open, 
                   labels = c("Open in Dec 2016", "Opened after Dec 2016", "Opened before Dec 2016")
                   )

################################################################################
### Geocode addresses 
################################################################################

# Only need to do this once, then load saved file
#df <- read_xlsx("./raw/JN MA Map Data.xlsx")
#tmp <- geocode(df$address)
#df <- bind_cols(df, tmp)
#write_csv(df, "./out/JN-MA-Map data with geocode.csv")

################################################################################
### Map
################################################################################

MA <- map_data("county") %>% filter(region=="massachusetts")

ggplot() + 
  geom_polygon(data=MA, aes(x = long, y = lat, group = group), color = "white") +
  geom_point(data=df, aes(x=lon, y=lat,color="red"), show.legend = FALSE) +
  coord_fixed(1.3) +
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.title = element_blank(),
    legend.title = element_blank()
  ) 

ggsave("./out/JN MA Map All.png")

ggplot() + 
  geom_polygon(data=MA, aes(x = long, y = lat, group = group), color = "white") +
  geom_point(data=df, aes(x=lon, y=lat,color=open2), show.legend = FALSE) +
  coord_fixed(1.3) +
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.title = element_blank(),
    legend.title = element_blank(),    
  ) 


ggsave("./out/JN MA Map by open.png")


################################################################################
### Analyze
################################################################################

################################################################################
### Write
###############################################################################  

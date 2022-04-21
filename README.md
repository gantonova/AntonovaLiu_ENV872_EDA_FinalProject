# AntonovaLiu_ENV872_EDA_FinalProject
Final project for EDA class exploring National Parks visitation trends during natural disasters.

Data Scource
California Fire Perimeters
https://gis.data.ca.gov/datasets/CALFIRE-Forestry::california-fire-perimeters-all/explore?location=37.260012%2C-118.992700%2C6.00&showTable=true
National Park Service VUStats Dataset
https://irma.nps.gov/STATS/Reports/Park/YOSE

.Code/
DataWrangling.Rmd -- Code for wrangling data
DataExploration.Rmd -- Code for exploratory analysis
analysis.Rmd -- Code for analyzing data
Wrangle.Rmd -- Code for wrangling data

.Data/
  Raw/
  Visitation_by_Month.csv -- Original VUStats Dataset
  Fire300milesBuffer.csv -- Original CA Wildfire data (within 300 miles to Yosemite)
  Processed/
  Yosefire.csv -- Processed dataset (conbined wildfire and visitation data)
  
.Output/
buffer.JPG -- Map for buffer zone decision
AirQUalityMap.jpg -- example of air quality impact reference for previous fires

LiuAntonova_ENV872_Project.Rmd -- Final R markdown file
LiuAntonova_ENV872_Project.pdf -- Final pdf report

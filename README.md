# sql-spotify-project-lazy-lion-fest
sql-spotify-project-lazy-lion-fest

Presentation: https://www.loom.com/share/ea9dbd3d15114219aa4b9fa07c69a97d

# Project Overview
For this project, I created a hypothetical music festival, "the Lazy Lion Fest" and used Spotify data, via the Spotify API, 
to create the "optimal" music festival using data analysis. 

# Data Collection
This was done in python using the Spotify API. I then uploaded this data to an Amazon RDS database.  

# SQL Analysis
For this portion of my analysis, I did some exploratory queries to better understand the data and then scored each artist based on the popularity of their
albums, tracks and artists to determine who should be hired to perform. Additionally, I conducted some one off queries to help different artists determine
which songs to play on their set. 

# Artist Set Lists
I then wrote a stored procedure using SQL to help create set lists for artists. This program loops through an artist's most popular songs and returns
an hour worth of music. 

# Set Time Updates
In this hypothetical festival, management wants to stay on top of updates in set times. Consequently, I created a trigger that logs changes in
set times every time a set time is changed. This will help management understand how well they stayed on schedule for future festivals. 

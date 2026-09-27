-- Exploratory Data Analysis

-- Looking at data
select * 
from streamingtrends;

-- looking at how many movies are recent
select count(*) as Total_New_Movie
from streamingtrends
where is_recent = 'True';

-- looking at how many movies are release this year
select count(*) as Total_New_Movie
from streamingtrends
where release_year = '2026';
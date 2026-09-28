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

-- looking at how many movies release per year 
select distinct release_year,count(*)
from streamingtrends
group by release_year;

-- How many movies are release recently in different language
select original_language,count(*) as Total_Movies
from streamingtrends
group by original_language;

-- which movie is highest with popularity, vote avearge
select title,popularity,vote_average,
rank() over(order by popularity desc) as Rank_Popularity,
rank() over(order by vote_average desc) as rank_vote_average
from streamingtrends;

-- looking at total Science Fiction movie
select count(*) as Total_Movies
from streamingtrends
where lower(genres) like '%science fiction%';

-- Looking total count
select sum(vote_count) as total_count
from streamingtrends;


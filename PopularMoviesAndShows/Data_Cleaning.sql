-- streaming trends

-- looking at dataset
select * 
from streamingtrends;
-- looking for nulls in title and found no nulls
select * 
from streamingtrends
where title is null;
-- looking for duplicates
select title,count(title) as record
from streamingtrends
group by title
having record > 1;

-- looking at The odyssey
select *
from streamingtrends
where title = 'The Odyssey';

-- Delete one The Odyssey from table as both are same movie
DELETE 
from streamingtrends
where title  = 'The Odyssey' and overview like 'Based%';

-- Looking at different column
select distinct search_category 
from streamingtrends;

-- only have popular as category in search_category so delete this
alter table streamingtrends
drop search_category;

-- looking at media_type 
select distinct media_type
from streamingtrends;

-- so we are only looking for media
-- drop that column
alter table streamingtrends
drop media_type;

-- looking at original_language
select distinct original_language
from streamingtrends;

-- looking for null
select * 
from streamingtrends
where title is null;

-- delete the movies before 2025
delete 
from streamingtrends
where release_year != 2025 and release_year != 2026;
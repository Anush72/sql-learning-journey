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

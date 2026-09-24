-- Data Cleaning

-- Making another table of raw data

create table layoffs_staging
select * 
from layoffs;

select * 
from layoffs_staging
where company = 'Ola';

-- checking duplicates
select *,
row_number() over(
partition by company,location,
industry,total_laid_off,percentage_laid_off,'date') as row_num
from layoffs_staging;

with duplicates
as 
(select *,
row_number() over(
partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) as row_num
from layoffs_staging
)
SELECT *  FROM
duplicates where row_num > 1;

--
create table layoffs_staging2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) as row_num
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;
delete 
from layoffs_staging2
where row_num > 1;

select * 
from layoffs_staging2
where row_num > 1;

-- standardizing data
select company
from layoffs_staging2;

update layoffs_staging2 
set company = Trim(company);

select distinct industry
from layoffs_staging2;

UPDATE layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct country
from layoffs_staging2;

update layoffs_staging2
set country = 'United States'
where country like 'United States%';

select datelayoffs_staging2
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(date,'%m/%d/%Y');

select * 
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;


-- Null Values
select * 
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select * 
from layoffs_staging2
where industry is null 
or industry = '';

# looking at Airbnb where industry is empty
select * 
from layoffs_staging2
where company LIKE 'Bally%';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry IS NULL or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 
set industry = null
where industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry IS NULL
and t2.industry is not null;


DELETE
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;


alter table layoffs_staging2
drop column row_num;

select * 
from layoffs_staging2;
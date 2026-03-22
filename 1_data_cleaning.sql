-- Data Cleaning
use world_layoffs;
Select *
from layoffs;

-- 1. Remove Duplicates
-- 2. standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns


-- 1. Remove Duplicates______________________________________________________

create table layoffs_staging
like layoffs;

Select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

with duplicate_cte as
(
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;


with duplicate_cte as
(
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
from layoffs_staging2;

insert into layoffs_staging2
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

Select *
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

Select *
from layoffs_staging2
;


-- 2. standardize the Data___________________________________________________

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

Select *
from layoffs_staging2
where industry like 'Crypto%';

select distinct location
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = 'United States'
where country like 'United States%';


select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

Select *
from layoffs_staging2;

alter table layoffs_staging2
modify column `date` date;


-- 3. Null Values or Blank Values____________________________________________

Select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
;

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

update layoffs_staging2 t1
set t1.industry = null
where t1.industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

select *
from layoffs_staging2
where industry is null
or industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


-- 4. Remove Any Columns_____________________________________________________

select *
from layoffs_staging2
;

Delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
;

alter table layoffs_staging2
drop column row_num;




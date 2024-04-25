
-- EDA Explotary Data analysis --

Select Max(total_laid_off),
	max(percentage_laid_off)
    from layoffs_staging2;
    
Select *
    from layoffs_staging2
    where percentage_laid_off = 1
    order by percentage_laid_off DESC;

Select company, sum(total_laid_off)
    from layoffs_staging2
    group by company
    order by 2 DESC;
    
Select min(`date`),max(`date`)
	from layoffs_staging2;

Select company, sum(total_laid_off)
    from layoffs_staging2
    group by company
    order by 2 DESC;

Select industry, sum(total_laid_off)
    from layoffs_staging2
    group by industry
    order by 2 DESC;

Select country, sum(total_laid_off)
    from layoffs_staging2
    group by country
    order by 2 DESC;
    
Select year(`date`),SUM(total_laid_off)
    from layoffs_staging2
    group by year(`date`)
    order by 2 DESC;
    
Select stage,SUM(total_laid_off)
    from layoffs_staging2
    group by stage
    order by 2 DESC;
    
Select company,sum(percentage_laid_off)
    from layoffs_staging2
    group by company
    order by 2 DESC;
    
 Select Substring(`date`,1,7) as 'Months', sum(total_laid_off)
	from layoffs_staging2
    Where substring(`date`,1,7) is not null
    group by substring(`date`,1,7)
    Order by 1;
    
With Rolling_total AS
	(
	Select Substring(`date`,1,7) as Months, sum(total_laid_off) as total_off
		from layoffs_staging2
		Where SUBSTRING(`date`, 1, 7) is not null
		group by SUBSTRING(`date`, 1, 7)
		Order by 1
    )
    Select Months, total_off,
    sum(total_off)
    over(order by Months) as rolling_total
    from Rolling_total;
    
Select company, year(`date`), sum(total_laid_off)
	from layoffs_staging2
    group by company,year(`date`)
    order by 3 DESC;
    
With Company_Year  (company ,years,total_laid_off) as 
(
	Select company, year(`date`), sum(total_laid_off)
	from layoffs_staging2
    group by company,year(`date`)
),
Company_Year_Rank as
(
	Select *, 
	DENSE_RANK() OVER (partition by years order by total_laid_off DESC) As Ranking 
	from Company_year
	where years is not null
)
select *
from company_Year_Rank 
where Ranking <=5; 


    
    
    
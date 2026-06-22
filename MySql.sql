use Movies_data;

SELECT DISTINCT
    genres,
    original_title,
    ROUND((revenue / budget) * 100, 2) AS ROI
FROM
    Movies_data
WHERE
    budget > 0
ORDER BY ROUND((revenue / budget) * 100, 2) DESC
LIMIT 5;

select director ,original_title ,rev
from 
(SELECT 
    director, 
    original_title,
    row_number() over(partition by director order by avg(revenue) desc) as rn,
    avg(revenue) rev from
    Movies_data group by  director, original_title) as t
where rn > 5
limit 5;

SELECT 
    genres, ROUND(AVG((revenue / budget) * 100), 2) AS ROI
FROM
    Movies_data
WHERE
    budget > 0
GROUP BY genres
ORDER BY ROI DESC
LIMIT 5;

SELECT 
    director,
    AVG(revenue) AS avg_revenue,
    AVG(popularity) AS avg_popularity
FROM Movies_data
GROUP BY director
ORDER BY avg_revenue DESC;

SELECT DISTINCT
    YEAR(release_date) AS every_year,
    COUNT(original_title) AS Trend,
    ROUND(AVG(revenue), 1) avg_rev
FROM
    Movies_data
GROUP BY YEAR(release_date)
ORDER BY avg_rev DESC;

SELECT 
    CASE
        WHEN runtime < 90 THEN 'short'
        WHEN runtime BETWEEN 90 AND 120 THEN 'medium'
        ELSE 'lagre'
    END AS runtime_performance,
    COUNT(*) AS number_of_movies,
    ROUND(AVG(revenue), 1)
FROM
    Movies_data
GROUP BY runtime_performance;

SELECT 
    production_companies,
    AVG(revenue),
    AVG(vote_average),
    AVG(popularity)
FROM
    Movies_data
GROUP BY production_companies;

WITH a AS (
    SELECT 
        genres, 
        AVG(revenue) AS avg_rev
    FROM Movies_data
    GROUP BY genres
),
b AS (
    SELECT 
        genres,
        original_title,
        revenue
    FROM Movies_data
)

SELECT 
    b.genres,
    a.avg_rev,
    b.original_title,
    b.revenue,
    CASE
        WHEN b.revenue > a.avg_rev THEN 'good'
        ELSE 'bad'
    END AS compare
FROM b
JOIN a 
ON b.genres = a.genres;

SELECT 
    original_language,
    ROUND(AVG(revenue), 1) AS avg_rev,
    ROUND(AVG(popularity), 1) AS avg_pop,
    CASE
        WHEN AVG(revenue) > 25356448 THEN 'high'
        WHEN AVG(revenue) > 1000000 THEN 'medium'
        ELSE 'low'
    END AS avg_rev_compare,
    CASE
        WHEN AVG(popularity) > 20 THEN 'high'
        WHEN AVG(popularity) > 10 THEN 'medium'
        ELSE 'low'
    END AS avg_pop_compare
FROM
    Movies_data
GROUP BY original_language
ORDER BY avg_rev DESC;

SELECT 
    vote_average,
    vote_count,
    CASE
		WHEN vote_average >= 7 AND vote_count >= 500 THEN 'Hiden gem'
        WHEN vote_average >= 7 AND vote_count >= 10000 THEN 'Expected'
        WHEN vote_average >= 7 AND vote_count >= 500 THEN 'Hiden gem'
        WHEN vote_average >= 4 AND vote_count >= 3000 THEN 'Good'
        WHEN vote_average >= 3 AND vote_count >= 5 THEN 'Big shot'
    END AS compare
FROM
    Movies_data;

SELECT 
    original_title,
    revenue,
    budget,
    vote_count,
    vote_average,
    runtime
FROM
    movies_data
WHERE
    budget < 1000000000
        AND revenue < 10000000
        AND budget != 0
        AND revenue != 0;

















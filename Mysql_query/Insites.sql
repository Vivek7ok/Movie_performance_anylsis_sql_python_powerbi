USE Movies_data;

-- =========================================================
-- 1️⃣ Highest ROI Movies + ROI by Genre
-- Business Question:
-- Which movies achieved the highest Return on Investment (ROI)
-- compared to their budget, and which genres are most profitable?
-- =========================================================

-- Top 5 movies with highest ROI
SELECT 
    genres,
    original_title,
    budget,
    revenue,
    ROUND((revenue / budget) * 100, 2) AS ROI_Percentage
FROM Movies_data
WHERE budget > 0
ORDER BY ROI_Percentage DESC
LIMIT 5;


-- Average ROI by Genre
SELECT 
    genres,
    ROUND(AVG((revenue / budget) * 100), 2) AS Avg_ROI
FROM Movies_data
WHERE budget > 0
GROUP BY genres
ORDER BY Avg_ROI DESC
LIMIT 5;



-- =========================================================
-- 2️⃣ Best Performing Directors
-- Business Question:
-- Which directors consistently create successful movies based on
-- revenue, ratings, and popularity?
-- =========================================================

SELECT 
    director,
    COUNT(*) AS total_movies,
    ROUND(AVG(revenue), 2) AS avg_revenue,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM Movies_data
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) >= 3
ORDER BY avg_revenue DESC, avg_rating DESC, avg_popularity DESC;



-- =========================================================
-- 3️⃣ Movie Release Trend Over Time
-- Business Question:
-- Which years had the highest movie releases, average revenue,
-- and audience ratings?
-- =========================================================

SELECT 
    YEAR(release_date) AS release_year,
    COUNT(*) AS total_movies,
    ROUND(AVG(revenue), 2) AS avg_revenue,
    ROUND(AVG(vote_average), 2) AS avg_rating
FROM Movies_data
GROUP BY YEAR(release_date)
ORDER BY release_year;



-- =========================================================
-- 4️⃣ Runtime vs Revenue & Ratings
-- Business Question:
-- Does movie runtime affect ratings and revenue performance?
-- =========================================================

SELECT 
    CASE
        WHEN runtime < 90 THEN 'Short Movie'
        WHEN runtime BETWEEN 90 AND 120 THEN 'Medium Movie'
        ELSE 'Long Movie'
    END AS runtime_category,

    COUNT(*) AS total_movies,
    ROUND(AVG(revenue), 2) AS avg_revenue,
    ROUND(AVG(vote_average), 2) AS avg_rating

FROM Movies_data
WHERE runtime IS NOT NULL
GROUP BY runtime_category;



-- =========================================================
-- 5️⃣ Most Successful Production Companies
-- Business Question:
-- Which production companies perform best based on revenue,
-- ratings, and popularity?
-- =========================================================

SELECT 
    production_companies,
    COUNT(*) AS total_movies,
    ROUND(AVG(revenue), 2) AS avg_revenue,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM Movies_data
WHERE production_companies IS NOT NULL
GROUP BY production_companies
ORDER BY avg_revenue DESC;



-- =========================================================
-- 6️⃣ Genre Revenue Outlier Analysis
-- Business Question:
-- Which movies performed better or worse than the average
-- revenue of their genre?
-- =========================================================

WITH genre_avg AS (
    SELECT 
        genres,
        AVG(revenue) AS avg_genre_revenue
    FROM Movies_data
    GROUP BY genres
)

SELECT 
    m.genres,
    m.original_title,
    m.revenue,
    ROUND(g.avg_genre_revenue, 2) AS avg_genre_revenue,

    CASE
        WHEN m.revenue > g.avg_genre_revenue THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance

FROM Movies_data m
JOIN genre_avg g
ON m.genres = g.genres;



-- =========================================================
-- 7️⃣ Language Performance Analysis
-- Business Question:
-- Which languages have the highest popularity, ratings,
-- and revenue performance?
-- =========================================================

SELECT 
    original_language,

    COUNT(*) AS total_movies,

    ROUND(AVG(revenue), 2) AS avg_revenue,
    ROUND(AVG(popularity), 2) AS avg_popularity,
    ROUND(AVG(vote_average), 2) AS avg_rating,

    CASE
        WHEN AVG(revenue) > 50000000 THEN 'High Revenue'
        WHEN AVG(revenue) > 10000000 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS revenue_category

FROM Movies_data
GROUP BY original_language
ORDER BY avg_revenue DESC;



-- =========================================================
-- 8️⃣ Hidden Gems vs Popular Movies
-- Business Question:
-- Which movies are highly rated but have low vote counts
-- (hidden gems), and which movies are mainstream hits?
-- =========================================================

SELECT 
    original_title,
    vote_average,
    vote_count,
    popularity,

    CASE
        WHEN vote_average >= 8 AND vote_count < 1000
            THEN 'Hidden Gem'

        WHEN vote_average >= 7 AND vote_count >= 10000
            THEN 'Mainstream Hit'

        WHEN vote_average >= 6
            THEN 'Good Movie'

        ELSE 'Average Movie'
    END AS movie_category

FROM Movies_data;



-- =========================================================
-- 9️⃣ Vote Count vs Vote Average Analysis
-- Business Question:
-- Do movies with higher vote counts usually have higher ratings?
-- =========================================================

SELECT 
    CASE
        WHEN vote_count < 1000 THEN 'Low Votes'
        WHEN vote_count BETWEEN 1000 AND 10000 THEN 'Medium Votes'
        ELSE 'High Votes'
    END AS vote_group,

    COUNT(*) AS total_movies,
    ROUND(AVG(vote_average), 2) AS avg_rating

FROM Movies_data
GROUP BY vote_group;



-- =========================================================
-- 🔟 High Budget but Low Revenue Movies
-- Business Question:
-- Which movies had huge budgets but failed at the box office?
-- =========================================================

SELECT 
    original_title,
    genres,
    budget,
    revenue,
    popularity,
    vote_average,
    runtime

FROM Movies_data

WHERE budget > 100000000
AND revenue < budget
AND budget > 0
AND revenue > 0

ORDER BY budget DESC;

create database zomato_hicounsler;

CREATE TABLE zomato (
    name VARCHAR(255) NOT NULL,
    online_order TEXT NOT NULL,
    book_table TEXT NOT NULL,
    rating DOUBLE,
    votes INT NOT NULL,
    location TEXT,
    rest_type TEXT,
    dish_liked TEXT,
    cuisines TEXT,
    approx_cost INT,
    type TEXT
);

-- Retrieve Top 5 Restaurants for Food Delivery.

SELECT 
    name, votes, rating
FROM
    zomato
WHERE
    type = 'Delivery'
ORDER BY votes DESC
LIMIT 5;

-- (2-2)
-- Top 5 Highly Rated Restaurants for Food Delivery in Banashankari.

select name, rating, location , type from zomato
where location = 'Banashankari' and type = 'Delivery'
order by rating desc
limit 5;


-- Calculate Minimum and Maximum Ratings for Restaurants in Indiranagar.

SELECT 
    (SELECT 
            rating
        FROM
            zomato
        WHERE
            location = 'Indiranagar'
        ORDER BY approx_cost ASC
        LIMIT 1) AS rating1,
    (SELECT 
            rating
        FROM
            zomato
        WHERE
            location = 'Indiranagar'
        ORDER BY approx_cost DESC
        LIMIT 1) AS rating2
FROM
    zomato
WHERE
    location = 'Indiranagar'
LIMIT 1;


-- Calculate Total Votes for Online and Offline Orders.

SELECT 
    SUM(votes) AS total_votes, online_order
FROM
    zomato
GROUP BY online_order;


-- Restaurant Statistics by Type.

SELECT 
    type,
    COUNT(name) AS number_of_restaurants,
    SUM(votes) AS total_votes,
    AVG(rating) AS avg_rating
FROM
    zomato
WHERE
    type <> 'NA'
GROUP BY type
ORDER BY total_votes DESC
LIMIT 10;


-- Restaurant with Highest Votes and Online Ordering.

SELECT 
    name, dish_liked, rating, votes
FROM
    zomato
ORDER BY votes DESC
LIMIT 1;


-- Top Restaurants with High Ratings and No Online Ordering.

SELECT 
    name, rating, votes, online_order
FROM
    zomato
WHERE
    votes >= 150 AND rating > 3
        AND online_order = 'No'
ORDER BY votes DESC
LIMIT 15;
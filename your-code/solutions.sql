use publications;
SELECT 
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
    t.title AS Publication,
    p.pub_name AS Publisher,
    p.city AS Location
FROM 
    titleauthor ta
JOIN 
    authors a ON ta.au_id = a.au_id
JOIN 
    titles t ON ta.title_id = t.title_id
JOIN 
    publishers p ON t.pub_id = p.pub_id;
    
# Who Have Published How Many At Where?
    
    SELECT 
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
    p.pub_name AS Publisher,
    p.city AS Location,
    COUNT(t.title_id) AS NumberOfPublications
FROM 
    titleauthor ta
JOIN 
    authors a ON ta.au_id = a.au_id
JOIN 
    titles t ON ta.title_id = t.title_id
JOIN 
    publishers p ON t.pub_id = p.pub_id
GROUP BY 
    a.au_id, p.pub_id
ORDER BY 
    NumberOfPublications DESC;
    
# Best Selling Authors

SELECT 
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
    SUM(t.ytd_sales) AS TotalSales
FROM 
    titleauthor ta
JOIN 
    authors a ON ta.au_id = a.au_id
JOIN 
    titles t ON ta.title_id = t.title_id
GROUP BY 
    a.au_id
ORDER BY 
    TotalSales DESC;
    
    
# Best Selling Authors Ranking

SET @rank := 0;

SELECT *
  @rank := @rank + 1 AS Rank,
    main.Author,
    main.TotalSales
FROM (
    SELECT 
        CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
        SUM(t.ytd_sales) AS TotalSales
    FROM 
        titleauthor ta
    JOIN 
        authors a ON ta.au_id = a.au_id
    JOIN 
        titles t ON ta.title_id = t.title_id
    GROUP BY 
        a.au_id
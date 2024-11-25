#Desafío 1 - ¿Quién ha publicado qué y dónde?
#En este desafío escribirás una consulta SELECT de MySQL que una varias tablas para descubrir qué títulos ha publicado 
#cada autor en qué editoriales. Tu salida debe tener al menos las siguientes columnas:
SELECT DISTINCT a.au_id, a.au_lname, a.au_fname, titles.title, publishers.pub_name
FROM authors AS a
LEFT JOIN titleauthor AS ta
	ON ta.au_id = a.au_id
	LEFT JOIN titles
		ON titles.title_id = ta.title_id
		JOIN publishers
			ON titles.pub_id = publishers.pub_id;

#Desafío 2 - ¿Quién ha publicado cuántos y dónde?
#Partiendo de tu solución en el Desafío 1, consulta cuántos títulos ha publicado cada autor en cada editorial. 

SELECT a.au_id, a.au_lname, a.au_fname, publishers.pub_name, COUNT(titles.title_id) AS title_count
FROM authors AS a
LEFT JOIN titleauthor AS ta
	ON ta.au_id = a.au_id
	LEFT JOIN titles
		ON titles.title_id = ta.title_id
		JOIN publishers
			ON titles.pub_id = publishers.pub_id
GROUP BY 4, 1, 2, 3
ORDER BY 5 DESC;

#Desafío 3 - Autores Más Vendidos
#¿Quiénes son los 3 principales autores que han vendido el mayor número de títulos? Escribe una consulta para averiguarlo.
SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, SUM(qty) AS total
FROM sales
	LEFT JOIN titleauthor AS ta
		ON ta.title_id = sales.title_id
			LEFT JOIN authors
				ON ta.au_id = authors.au_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 3;

#Desafío 4 - Ranking de Autores Más Vendidos
#Ahora modifica tu solución en el Desafío 3 para que la salida muestre a todos los 23 autores en lugar de solo los 3 principales. 
#Ten en cuenta que los autores que han vendido 0 títulos también deben aparecer en tu salida 
#(idealmente muestra 0 en lugar de NULL como TOTAL). 
#También ordena tus resultados basándose en TOTAL de mayor a menor.
SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, SUM(IFNULL(qty, 0)) AS total
FROM sales
	JOIN titleauthor AS ta
		ON ta.title_id = sales.title_id
			RIGHT JOIN authors
				ON ta.au_id = authors.au_id
GROUP BY 1,2,3
ORDER BY 4 DESC;
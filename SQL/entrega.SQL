/*2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’*/
    SELECT title
    FROM film
    WHERE rating = `R`;

/*3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40*/
    SELECT first_name As Nombre, LAST_NAME  AS Apellido
    FROM actor
    WHERE actor_id BETWEEN 30 and 40;
    /*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
    SELECT title
    FROM film
    WHERE language_id = original_language_id;
    /*Esta consulta ha presentado un desafio para mi ya que me he dado cuenta que el resultado que me arrojaba estaba vacio.
    He revisado la base de datos y me he dado cuenta que original_language_id es NULL para todas lo que significaria que todas las peliculas estan en lenguaje original.
    Por esa razon procedo a realizar una segunda consulta que considero seria mas correcta.*/
    SELECT title as Titulo
    FROM film f
    WHERE original_language_id is null;

/*5. Ordena las películas por duración de forma ascendente.*/
    SELECT title AS Titulo, length AS Duracion
    FROM film f
    ORDER BY length ASC;

/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.*/
    SELECT first_name AS Nombre, last_name AS Apellido
    FROM actor a
    WHERE last_name LIKE '%ALLEN%';

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.*/
    SELECT rating AS Clasificacion, COUNT(*) AS Total_Peliculas
    FROM film f
    GROUP BY rating
    ORDER BY Total_Peliculas DESC;

/*8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.*/
    SELECT title AS Titulo, length AS Duracion, rating AS Clasificacion
    FROM film f
    WHERE rating = 'PG-13'
    OR length > 180;
    /*Antes de realizar esta consulta he revisado la columna de length y he visto que la duracion de las peliculas esta en minutos, por lo que 3 horas serian 180 minutos.*/

/*9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/
    SELECT STDDEV(replacement_cost) AS Variabilidad
    FROM film f;

/*10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
    SELECT MAX(length) AS Mayor_duracion, MIN(length) as Menor_duracion
    FROM film f;
    
/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
    SELECT p.amount AS precio_alquiler, p.payment_date AS fecha_alquiler
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    ORDER BY r.rental_date DESC
    OFFSET 2
    LIMIT 1;

/*12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.*/
    SELECT f.title AS titulo, f.rating AS clasificacion
    FROM film f
    WHERE rating NOT IN ('G', 'NC-17');
    
/*13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/
/*14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.*/
/*15. ¿Cuánto dinero ha generado en total la empresa?*/
/*16. Muestra los 10 clientes con mayor valor de id.*/
/*17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.*/

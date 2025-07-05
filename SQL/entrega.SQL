/*2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’*/
    SELECT title
    FROM film
    WHERE f.rating = `R`;

/*3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40*/
    SELECT first_name As Nombre, LAST_NAME  AS Apellido
    FROM actor
    WHERE a.actor_id BETWEEN 30 and 40;

/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
    SELECT title
    FROM film
    WHERE f.language_id = f.original_language_id;
    /*Esta consulta ha presentado un desafio para mi ya que me he dado cuenta que el resultado que me arrojaba estaba vacio.
    He revisado la base de datos y me he dado cuenta que original_language_id es NULL para todas lo que significaria que todas las peliculas estan en lenguaje original.
    Por esa razon procedo a realizar una segunda consulta que considero seria mas correcta.*/
    SELECT title as Titulo
    FROM film f
    WHERE f.original_language_id is null;

/*5. Ordena las películas por duración de forma ascendente.*/
    SELECT title AS Titulo, length AS Duracion
    FROM film f
    ORDER BY length ASC;

/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.*/
    SELECT first_name AS Nombre, last_name AS Apellido
    FROM actor a
    WHERE a.last_name LIKE '%ALLEN%';

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.*/
    SELECT rating AS Clasificacion, COUNT(*) AS Total_Peliculas
    FROM film f
    GROUP BY f.rating
    ORDER BY Total_Peliculas DESC;

/*8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.*/
    SELECT title AS Titulo, length AS Duracion, rating AS Clasificacion
    FROM film f
    WHERE f.rating = 'PG-13'
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
    WHERE f.rating NOT IN ('G', 'NC-17');

/*13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/
    SELECT f.rating AS clasificacion, AVG(f.length) AS promedio_duracion
    FROM film f
    GROUP BY f.rating;

/*14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.*/
    SELECT f.title AS titulo, f.length AS duracion
    FROM film f
    WHERE f.length > 180;
/*15. ¿Cuánto dinero ha generado en total la empresa?*/
    SELECT SUM(amount) AS generado_alquiler
    FROM payment;
/*16. Muestra los 10 clientes con mayor valor de id.*/
    SELECT c.customer_id AS id_cliente, c.first_name AS nombre, c.last_name AS Apellido
    FROM customer c
    ORDER BY id_cliente DESC
    LIMIT 10;
/*17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'EGG IGBY';

/*18. Selecciona todos los nombres de las películas únicos.*/
/*19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.*/
/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/
/*21. ¿Cuál es la media de duración del alquiler de las películas?*/
/*22. Crea una columna con el nombre y apellidos de todos los actores y actrices.*/
/*23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.*/
/*24. Encuentra las películas con una duración superior al promedio.*/
/*25. Averigua el número de alquileres registrados por mes.*/
/*26. Encuentra el promedio, la desviación estándar y varianza del total pagado.*/
/*27. ¿Qué películas se alquilan por encima del precio medio?*/
/*28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
/*29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
/*30. Obtener los actores y el número de películas en las que ha actuado.*/
/*31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.*/
/*32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.*/
/*33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/
/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
/*36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.*/
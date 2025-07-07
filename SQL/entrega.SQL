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
    SELECT DISTINCT f.title AS titulo
    FROM film f;

/*19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.*/
    SELECT f.title AS titulo, f.length AS duracion
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy' AND f.length >180;

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/
    SELECT AVG(f.length) AS promedio_duracion, c.name
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id 
    JOIN category c ON fc.category_id = c.category_id 
    GROUP BY c.name
    HAVING AVG(f.length) > 110;

/*21. ¿Cuál es la media de duración del alquiler de las películas?*/
    SELECT AVG(r.return_date - r.rental_date) AS duracion_media_alquiler
    FROM rental r;

/*22. Crea una columna con el nombre y apellidos de todos los actores y actrices.*/
    SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo
    FROM actor a;

/*23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.*/
    SELECT DATE(r.rental_date) AS dias_alquiler, COUNT(r.rental_date) AS cantidad_alquileres
    FROM rental r
    GROUP BY DATE(r.rental_date)
    ORDER BY cantidad_alquileres DESC;

/*24. Encuentra las películas con una duración superior al promedio.*/
    SELECT f.title AS titulo, f.length AS duracion
    FROM film f
    WHERE f.length >(
        SELECT AVG(f.length)
        FROM film f);
        
/*25. Averigua el número de alquileres registrados por mes.*/
    SELECT EXTRACT(YEAR FROM r.rental_date) AS anio, EXTRACT(MONTH FROM r.rental_date) AS mes, COUNT(*) AS numero_alquileres
    FROM rental r
    GROUP BY anio, mes
    ORDER BY anio, mes;

/*26. Encuentra el promedio, la desviación estándar y varianza del total pagado.*/
    SELECT AVG(p.amount) AS promedio, STDDEV(p.amount) AS desviacion, VARIANCE(p.amount) AS varianza
    FROM payment p;

/*27. ¿Qué películas se alquilan por encima del precio medio?*/
    SELECT f.title AS titulo
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    WHERE p.amount > (
        SELECT AVG(amount) AS promedio_precio
        FROM payment p);
    
/*28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
    SELECT actor_id, COUNT(*) AS numero_peliculas
    FROM film_actor 
    GROUP BY actor_id 
    HAVING COUNT(film_id) > 40;

/*29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
    SELECT f.title AS titulo, COUNT(i.inventory_id) AS disponible
    FROM film f
    LEFT JOIN inventory i ON i.film_id = f.film_id 
    GROUP BY f.film_id
    ORDER BY disponible DESC;

/*30. Obtener los actores y el número de películas en las que ha actuado.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(fa.film_id) AS numero_peliculas
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id 
    GROUP BY a.first_name, a.last_name
    ORDER BY numero_peliculas DESC;

/*31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.*/
    SELECT f.title AS titulo, a.last_name AS apellido, a.first_name AS nombre
    FROM film f
    LEFT JOIN film_actor fa ON fa.film_id = f.film_id 
    LEFT JOIN actor a ON a.actor_id = fa.actor_id
    ORDER BY f.title, a.last_name, a.first_name;

/*32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido, f.title AS titulo
    FROM actor a
    LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
    LEFT JOIN film f ON f.film_id = fa.film_id
    ORDER BY a.first_name, a.last_name, f.title;
/*33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/
    SELECT f.title AS titulo, r.*
    FROM film f
    LEFT JOIN inventory i ON i.film_id = f.film_id 
    LEFT JOIN rental r ON r.inventory_id = i.inventory_id;

/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
    SELECT SUM(p.amount) AS dinero
    FROM payment p
    JOIN customer c ON c.customer_id = p.customer_id
    GROUP BY c.customer_id 
    ORDER BY dinero DESC
    LIMIT 5;

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
    SELECT a.first_name AS nombre, a.actor_id
    FROM actor a
    WHERE a.first_name LIKE 'JOHNNY';

/*36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.*/
    SELECT first_name AS Nombre, last_name AS Apellido
    FROM actor;

/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
    SELECT MIN(actor_id), MAX(actor_id)
    FROM actor;

/*38. Cuenta cuántos actores hay en la tabla “actor”.*/
    SELECT count(*) AS total_actores
    FROM actor;

/*39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.*/
    SELECT last_name AS apellido, first_name AS nombre
    FROM actor 
    ORDER BY apellido;

/*40. Selecciona las primeras 5 películas de la tabla “film”.*/
    SELECT *
    FROM film
    LIMIT 5;

/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?*/
    SELECT first_name AS nombre, COUNT(*) AS cantidad
    FROM actor
    GROUP BY first_name
    ORDER BY cantidad DESC;
        /*Hay dos nombres que se repiten la misma cantidad de veces(4) KENNETH y PENELOPE.*/
    
/*42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.*/
    SELECT c.first_name AS nombre, r.*
    FROM rental r
    JOIN customer c ON c.customer_id = r.customer_id;

/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.*/
    SELECT c.first_name AS nombre, c.last_name AS apellido, r.*
    FROM customer c
    LEFT JOIN rental r ON r.customer_id = c.customer_id;

/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
    SELECT f.title AS titulo, c.name AS categoria 
    FROM film f
    CROSS JOIN category c;
        /*Considero que esta consulta no aporta ninguna tipo de valor especfico ya que nos muestra todas las combinaciones posibles entre las peliculas y las categorias,
        lo cual no es necesario para el analisis de los datos.*/

/*45. Encuentra los actores que han participado en películas de la categoría 'Action'.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido, c.name AS categoria
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id 
    JOIN film f ON f.film_id = fa.film_id 
    JOIN film_category fc ON fc.film_id = f.film_id 
    JOIN category c ON c.category_id = fc.category_id 
    WHERE c.name LIKE 'Action';

/*46. Encuentra todos los actores que no han participado en películas.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido
    FROM actor a
    LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id 
    WHERE fa.film_id IS NULL;
        /*Esta consulta nos da un resultado "EN BLANCO" ya que todos los actores han participado en al menos una película.*/

/*47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(*) AS cantidad_peliculas
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id 
    ORDER BY cantidad_peliculas;

/*48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.*/
    CREATE VIEW actor_num_peliculas AS
    SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(*) AS cantidad_peliculas
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id;

/*49. Calcula el número total de alquileres realizados por cada cliente.*/
    SELECT c.first_name AS nombre, c.last_name AS apellido, count(r.rental_id) AS alquiler
    FROM customer c
    JOIN rental r ON r.customer_id = c.customer_id 
    GROUP BY c.customer_id
    ORDER BY alquiler;

/*50. Calcula la duración total de las películas en la categoría 'Action'.*/
    SELECT SUM(f.length) AS duracion_total
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id 
    JOIN category c ON c.category_id = fc.category_id 
    WHERE c.name = 'Action';

/*51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.*/
    CREATE TEMP TABLE clientes_rentas_temporal AS
        SELECT c.first_name AS nombre, c.last_name AS apellido, c.customer_id AS numero_cliente, count(r.rental_id) AS alquileres
        FROM customer c
        JOIN rental r ON r.customer_id = c.customer_id
        GROUP BY c.customer_id;

/*52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.*/
    CREATE TEMP TABLE peliculas_alquiladas AS
        SELECT f.title AS titulo, COUNT(r.rental_id) AS alquileres
        FROM film f
        JOIN inventory i ON i.film_id = f.film_id 
        JOIN rental r ON r.inventory_id = i.inventory_id 
        GROUP BY f.film_id, f.title
        HAVING COUNT(r.rental_id) >= 10;

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente
 por título de película.*/
    SELECT f.title AS titulo, c.first_name AS nombre, c.last_name AS apellido
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id 
    JOIN rental r ON r.inventory_id = i.inventory_id 
    JOIN customer c ON c.customer_id = r.customer_id 
    WHERE c.first_name ILIKE 'tammy'
    AND c.last_name ILIKE 'sanders'
    AND r.return_date IS NULL 
    ORDER BY f.title;

/*54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.*/
    SELECT a.last_name AS apellido, a.first_name AS nombre
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id 
    JOIN film f ON f.film_id = fa.film_id
    JOIN film_category fc ON f.film_id = fc.film_id 
    JOIN category c ON c.category_id = fc.category_id 
    WHERE c.name ILIKE 'sci-fi'
    ORDER BY a.last_name;

/*55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’
se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
    SELECT DISTINCT a.first_name AS nombre, a.last_name AS apellido
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    JOIN film f ON f.film_id = fa.film_id 
    JOIN inventory i ON i.film_id = f.film_id 
    JOIN rental r ON r.inventory_id = i.inventory_id 
    WHERE r.rental_date >(
        SELECT MIN(r.rental_date)
        FROM rental r
        JOIN inventory i ON i.inventory_id = r.inventory_id
        JOIN film f ON i.film_id = f.film_id
        WHERE f.title ILIKE 'spartacus cheaper')
    ORDER BY a.last_name;

/*56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.*/
    SELECT a.first_name AS nombre, a.last_name AS apellido
    FROM actor a
    WHERE a.actor_id NOT in(
        SELECT a.actor_id
        FROM actor a
        JOIN film_actor fa ON fa.actor_id = a.actor_id 
        JOIN film f ON f.film_id = fa.film_id 
        JOIN film_category fc ON fc.film_id = f.film_id 
        JOIN category c ON c.category_id = fc.category_id 
        WHERE c.name ILIKE 'music');

/*57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.*/
    SELECT f.title AS titulo
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id 
    JOIN rental r ON r.inventory_id = i.inventory_id 
    WHERE r.return_date IS NOT NULL
    AND EXTRACT(DAY FROM r.return_date - r.rental_date) > 8;
/*58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.*/
    SELECT f.title AS titulo
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id 
    WHERE fc.category_id = (
        SELECT c.category_id
        FROM category c
        WHERE c.name ILIKE 'animation');

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.*/
    SELECT f.title AS titulo
    FROM film f
    WHERE f.length = ( 
        SELECT f.length 
        FROM film f
        WHERE f.title ILIKE 'dancing fever')
    ORDER BY f.title;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.*/
    SELECT c.last_name AS apellido, c.first_name AS nombre, COUNT(r.rental_id) AS numeros_alquiler, COUNT(DISTINCT f.film_id)
    FROM customer c
    JOIN rental r ON r.customer_id = c.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id 
    JOIN film f ON i.film_id = f.film_id
    GROUP BY c.last_name, c.first_name, c.customer_id
    HAVING COUNT(DISTINCT f.film_id) >=7
    ORDER BY apellido;

/*61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/
    SELECT c.name AS categoria, COUNT(r.rental_id) AS numero_alquileres 
    FROM category c
    JOIN film_category fc ON fc.category_id = c.category_id 
    JOIN film f ON f.film_id = fc.film_id 
    JOIN inventory i ON i.film_id = f.film_id 
    JOIN rental r ON r.inventory_id = i.inventory_id 
    GROUP BY c.category_id, c.name
    ORDER BY categoria;

/*62. Encuentra el número de películas por categoría estrenadas en 2006.*/
    SELECT COUNT(f.film_id) AS numero_peliculas, c.name AS categoria
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id 
    JOIN category c ON c.category_id = fc.category_id 
    WHERE f.release_year = 2006
    GROUP BY c.category_id, c.name
    ORDER BY categoria;
/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.*/
    SELECT *
    FROM staff s
    CROSS JOIN store s2 

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
    SELECT c.customer_id AS numero_cliente, c.first_name AS nombre, c.last_name AS apellido, COUNT(r.rental_id) AS numero_alquileres
    FROM customer c
    JOIN rental r ON r.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY numero_cliente;
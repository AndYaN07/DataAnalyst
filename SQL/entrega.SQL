/*2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’*/
    SELECT title
    FROM film
    WHERE rating = `R`;
/*3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40*/
    SELECT first_name As Nombre, LAST_NAME  AS Apellido
    FROM actor
    WHERE actor_id BETWEEN 30 and 40;
    /*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head> 
        <meta charset="UTF-8"> 
        <title>Acme</title>
        <link href="/AcmeNoticias/css/main.css" rel="stylesheet" type="text/css"/>
    </head> 
    
    <body>
        <h1>Añadir rol a la DB</h1> 
         
        <form id="formulario" action="/AcmeNoticias/rol/save" method="POST"> 
            <label for="name">Nombre del Rol:</label> 
            <input id="name" type="text" name="name" ><br />                  
             
            <input type="submit" value="Guardar" /> 
        </form> 
 
        <a href="/AcmeNoticias/roles">Ver Roles</a> 
         
        <script src="/AcmeNoticias/js/functions.js"></script>
    </body> 
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html> 
<html> 
    <head> 
        <meta charset="UTF-8"> 
        <title>Acme</title>
        <link href="${sessionScope.ContextPath}/css/main.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body> 
        <nav> | <a href="${sessionScope.ContextPath}/rol/new">Crear Nueva Entrada</a> | </nav> 
        <h1>Acme-Noticias</h1> 
 
        <c:if test="${!empty requestScope.roles}"> 
            <table> 
                <tr> 
                    <th>ID</th>
                    <th>Nombre</th> 
                </tr> 
                
                <c:forEach var="rol" items="${requestScope.roles}" > 
                    <tr> 
                        <td>${rol.id}</td> 
                        <td  class="derecha">${rol.nombreRol}</td> 
                    </tr>  
                </c:forEach> 
            </table> 
        </c:if> 
        <c:if test="${empty requestScope.roles}"> 
            <p>Oops! No hay Roles todavía!</p> 
        </c:if>
            
        <script src="${sessionScope.ContextPath}/js/functions.js"></script>
 
    </body> 
</html>

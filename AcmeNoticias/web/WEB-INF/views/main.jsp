<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Noticias Acme, S.A.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${sessionScope.ContextPath}/css/main.css" rel="stylesheet" type="text/css">
    </head>

    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <section id="bienvenida" class="mb-4">
                <h2>Bienvenido a Noticias Acme, S.A.</h2>
                <p>Somos un portal de noticias digitales con cobertura internacional. Aquí encontrarás artículos clasificados por categorías como nacional, internacional, ciencia, deportes y cultura. ¡Mantente informado con nosotros!</p>
            </section>

            <section id="ultimas-noticias">
                <c:if test="${!empty requestScope.articulos}"> 
                    <h2>Últimas Publicaciones</h2>
                    <c:forEach var="articulo" items="${requestScope.articulos}" > 
                        <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="card mb-3 text-decoration-none text-dark">
                            <div class="card-body">
                                <h3 class="card-title">${articulo.titulo}</h3>
                                <p class="card-text">Autor: ${articulo.redactor.nombre}</p>
                                <p class="card-text">Fecha: ${articulo.fecha}</p>
                            </div>
                        </a>
                    </c:forEach> 
                </c:if> 
                <c:if test="${empty requestScope.articulos}"> 
                    <h2>Oops! No hay articulos todavía!</h2> 
                </c:if>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


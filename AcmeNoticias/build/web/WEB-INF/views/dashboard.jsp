<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard de Comentarios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${sessionScope.ContextPath}/css/main.css" rel="stylesheet" type="text/css">
    </head>

    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <h1 class="mb-4">Dashboard</h1>

            <section class="mb-5">
                <h2>Número medio de comentarios por artículo</h2>
                <p class="fs-4">
                    <strong>
                        <c:out value="${media}" default="0.0" />
                    </strong>
                    comentarios por artículo.
                </p>
            </section>

            <section>
                <h2>Artículos con más comentarios</h2>
                <c:if test="${not empty articulosMasComentados}">
                    <div class="list-group">
                        <c:forEach var="articulo" items="${articulosMasComentados}">
                            <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1">${articulo.titulo}</h5>
                                    <small>${fn:length(articulo.comentarios)} comentarios</small>
                                </div>
                                <p class="mb-1">Autor: ${articulo.redactor.nombre}</p>
                                <small>Fecha: ${articulo.fecha}</small>
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty articulosMasComentados}">
                    <p>No hay artículos con comentarios aún.</p>
                </c:if>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

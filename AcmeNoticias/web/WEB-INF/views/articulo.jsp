<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>${articulo.titulo} - Noticias Acme, S.A.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${sessionScope.ContextPath}/css/main.css" rel="stylesheet" type="text/css">
    </head>
    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <c:if test="${not empty requestScope.articulo}">
                <article class="mb-5">
                    <h1>${requestScope.articulo.titulo}</h1>
                    <p class="text-muted">Por <strong>${requestScope.articulo.redactor.nombre}</strong> - ${requestScope.articulo.fecha}</p>
                    <p><span class="badge bg-secondary">${requestScope.articulo.categoria.nombre}</span></p>
                    <hr>
                    <div>
                        <p>${requestScope.articulo.cuerpo}</p>
                    </div>
                </article>

                <section id="comentarios">
                    <h3>Comentarios (${fn:length(requestScope.articulo.comentarios)})</h3>
                    <c:if test="${not empty requestScope.articulo.comentarios}">
                        <ul class="list-group">
                            <c:forEach var="comentario" items="${requestScope.articulo.comentarios}">
                                <li class="list-group-item">
                                    <p class="mb-1"><strong>${comentario.nombre}</strong> dijo el ${comentario.fecha}:</p>
                                    <p class="mb-0">${comentario.cuerpo}</p>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty requestScope.articulo.comentarios}">
                        <p>No hay comentarios aún. ¡Sé el primero en comentar!</p>
                    </c:if>
                </section>

                <div class="mt-4">
                    <a href="${sessionScope.ContextPath}/main" class="btn btn-outline-primary">← Volver al inicio</a>
                </div>
            </c:if>

            <c:if test="${empty requestScope.articulo}">
                <div class="alert alert-warning">
                    <h2>Artículo no encontrado</h2>
                    <p>El artículo que estás buscando no existe o ha sido eliminado.</p>
                    <a href="${sessionScope.ContextPath}/main" class="btn btn-primary">Volver al inicio</a>
                </div>
            </c:if>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
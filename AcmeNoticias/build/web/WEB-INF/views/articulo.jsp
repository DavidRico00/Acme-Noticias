<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="shared/head.jsp" %>
        <title>${articulo.titulo} - Noticias Acme, S.A.</title>
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
                    <div class="card mt-4">
                        <div class="card-header bg-light">
                            <h4 class="mb-0">Deja tu comentario</h4>
                        </div>
                        <div class="card-body">
                            <form action="${sessionScope.ContextPath}/agregarComentario?articuloId=${requestScope.articulo.id}" method="post">

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="nombre" class="form-label">Nombre *</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="cuerpo" class="form-label">Comentario *</label>
                                    <textarea class="form-control" id="cuerpo" name="cuerpo" rows="4" required></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary">Publicar comentario</button>
                            </form>
                        </div>
                    </div>
                    <!-- Fin del formulario de comentarios -->
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Editar Comentario - Noticias Acme, S.A.</title>
    </head>
    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <section id="comentarios">                   
                <div class="card mt-4">
                    <div class="card-header bg-light">
                        <h4 class="mb-0">Edita el comentario</h4>
                    </div>
                    <div class="card-body">
                        <form action="${sessionScope.ContextPath}/comentario/modificar?id=${comentario.id}" method="post">
                            <input type="hidden" name="articuloId" value="${comentario.articulo.id}">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nombre" class="form-label">Nombre *</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" value="${comentario != null ? comentario.nombre : ''}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="cuerpo" class="form-label">Comentario *</label>
                                <textarea class="form-control" id="cuerpo" name="cuerpo" rows="4" required">${comentario != null ? comentario.cuerpo : ''}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Publicar comentario</button>
                        </form>
                    </div>
                </div>
            </section>  

            <div class="mt-4">
                <a href="${sessionScope.ContextPath}/articulo?id=${comentario.articulo.id}" class="btn btn-outline-primary">← Volver al Articulo</a>
            </div>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
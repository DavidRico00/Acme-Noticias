<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <c:if test="${categoria == null}">
            <title>Nueva Categoría - Noticias Acme, S.A</title></c:if>
        <c:if test="${categoria != null}">
            <title>Editar Categoría - Noticias Acme, S.A</title></c:if>
        </head>
        <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <c:if test="${categoria == null}">
                <h1>Crear Nueva Categoría</h1>
                <c:if test="${categoria != null}">
                    <h1>Editar Categoría</h1>

                    <form action="${sessionScope.ContextPath}/categoria/guardar" method="POST">
                        <input type="text" id="id" name="id" value="${categoria.id}" style="display: none"/>

                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" 
                                   value="${categoria.nombre != null ? categoria.nombre : ''}" required>
                        </div>

                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required><c:out value="${categoria.descripcion != null ? categoria.descripcion : ''}" /></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <a href="${sessionScope.ContextPath}/gestionCategorias" class="btn btn-secondary">Cancelar</a>
                    </form>
                </div>

                <%@include file="shared/footer.jsp" %>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>
        </html>

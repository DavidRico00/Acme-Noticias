<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Gestión Categorías - Noticias Acme, S.A</title>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0">Listado de Categorías</h1>
                <a href="${sessionScope.ContextPath}/categoria/nueva" class="btn btn-success">
                    &#43; Nueva Categoría
                </a>
            </div>

            <c:choose>
                <c:when test="${!empty requestScope.categorias}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="categoria" items="${requestScope.categorias}">
                                <tr>
                                    <td>${categoria.id}</td>
                                    <td>${categoria.nombre}</td>
                                    <td>${categoria.descripcion}</td>
                                    <td>
                                        <a href="${sessionScope.ContextPath}/categoria/editar?id=${categoria.id}" class="btn btn-sm btn-warning me-1">Editar</a>
                                        <a class="btn btn-sm btn-danger" onclick="eliminarCategoria('${sessionScope.ContextPath}', ${categoria.id})">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">No hay categorías disponibles.</div>
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

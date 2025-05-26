<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Mis Artículos - Noticias Acme, S.A</title>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0">Listado de Artículos</h1>
                <a href="${sessionScope.ContextPath}/articulo/nuevo" class="btn btn-success">
                    &#43; Nuevo Artículo
                </a>
            </div>

            <c:choose>
                <c:when test="${!empty requestScope.articulos}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Título</th>
                                <th scope="col">Cuerpo</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="articulo" items="${requestScope.articulos}">
                                <tr>
                                    <td>${articulo.id}</td>
                                    <td>${articulo.titulo}</td>
                                    <td>${articulo.cuerpo}</td>
                                    <td>
                                        <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="btn btn-sm btn-primary me-1">Ver</a>
                                        <a href="${sessionScope.ContextPath}/articulo/editar?id=${articulo.id}" class="btn btn-sm btn-warning me-1">Editar</a>
                                        <a class="btn btn-sm btn-danger" onclick="eliminarArticulo('${sessionScope.ContextPath}', ${articulo.id})">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">No hay artículos disponibles.</div>
                </c:otherwise>
            </c:choose>
        </div>


        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

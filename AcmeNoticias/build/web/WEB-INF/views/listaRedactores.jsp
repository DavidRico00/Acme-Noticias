<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Mis Redactores - Noticias Acme, S.A</title>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0">Listado de Redactores</h1>
                <a href="${sessionScope.ContextPath}/creaRedactores" class="btn btn-success">
                    &#43; Nuevo Redactores
                </a>
            </div>

            <c:choose>
                <c:when test="${!empty requestScope.redactores}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Apellidos</th>
                                <th scope="col">email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="redactores" items="${requestScope.redactores}">
                                <tr>
                                    <td>${redactores.id}</td>
                                    <td>${redactores.nombre}</td>
                                    <td>${redactores.apellido}</td>
                                    <td>${redactores.email}</td>
                                    <td>
                                        <a href="${sessionScope.ContextPath}/perfil?id=${redactores.id}" class="btn btn-sm btn-warning me-1">Editar</a>
                                        <a class="btn btn-sm btn-danger" onclick="eliminarRedactor('${sessionScope.ContextPath}', ${redactores.id})">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">No hay redactores.</div>
                </c:otherwise>
            </c:choose>
        </div>


        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

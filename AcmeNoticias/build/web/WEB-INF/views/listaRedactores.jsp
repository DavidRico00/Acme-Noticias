<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title><fmt:message key="redactores.titulo.pagina"/></title>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0"><fmt:message key="redactores.encabezado"/></h1>
                <a href="${sessionScope.ContextPath}/creaRedactores" class="btn btn-success">
                    &#43; <fmt:message key="redactores.boton.nuevo"/>
                </a>
            </div>

            <c:choose>
                <c:when test="${!empty requestScope.redactores}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col"><fmt:message key="redactores.columna.id"/></th>
                                <th scope="col"><fmt:message key="redactores.columna.nombre"/></th>
                                <th scope="col"><fmt:message key="redactores.columna.apellido"/></th>
                                <th scope="col"><fmt:message key="redactores.columna.email"/></th>
                                <th scope="col"><fmt:message key="redactores.columna.acciones"/></th>

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
                                        <a href="${sessionScope.ContextPath}/perfil?id=${redactores.id}" class="btn btn-sm btn-warning me-1"><fmt:message key="redactores.accion.editar"/></a>
                                        <a class="btn btn-sm btn-danger" onclick="eliminarRedactor('${sessionScope.ContextPath}', ${redactores.id})"><fmt:message key="redactores.accion.eliminar"/></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info"><fmt:message key="redactores.alerta.vacio"/></div>
                </c:otherwise>
            </c:choose>
        </div>


        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

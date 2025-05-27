<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title><fmt:message key="misarticulos.titulo.pagina"/></title>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0"><fmt:message key="misarticulos.titulo.seccion"/></h1>
                <a href="${sessionScope.ContextPath}/articulo/nuevo" class="btn btn-success">
                    &#43; <fmt:message key="misarticulos.boton.nuevo"/>
                </a>
            </div>

            <c:choose>
                <c:when test="${!empty requestScope.articulos}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col"><fmt:message key="misarticulos.columna.id"/></th>
                                <th scope="col"><fmt:message key="misarticulos.columna.titulo"/></th>
                                <th scope="col"><fmt:message key="misarticulos.columna.cuerpo"/></th>
                                <th scope="col"><fmt:message key="misarticulos.columna.acciones"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="articulo" items="${requestScope.articulos}">
                                <tr>
                                    <td>${articulo.id}</td>
                                    <td>${articulo.titulo}</td>
                                    <td>${articulo.cuerpo}</td>
                                    <td>
                                        <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="btn btn-sm btn-primary me-1"><fmt:message key="misarticulos.accion.ver"/></a>
                                        <a href="${sessionScope.ContextPath}/articulo/editar?id=${articulo.id}" class="btn btn-sm btn-warning me-1"><fmt:message key="misarticulos.accion.editar"/></a>
                                        <a class="btn btn-sm btn-danger" onclick="eliminarArticulo('${sessionScope.ContextPath}', ${articulo.id})"><fmt:message key="misarticulos.accion.eliminar"/></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info"><fmt:message key="misarticulos.alerta.vacio"/></div>
                </c:otherwise>
            </c:choose>
        </div>


        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

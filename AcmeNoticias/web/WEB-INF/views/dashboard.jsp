<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="shared/head.jsp" %>
        <title><fmt:message key="dashboard.titulo.pagina"/></title>
    </head>

    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <h1 class="mb-4"><fmt:message key="dashboard.titulo.seccion"/></h1>

            <section class="mb-5">
                <h2><fmt:message key="dashboard.media.titulo"/></h2>
                <p class="fs-4">
                    <strong><c:out value="${media}" default="0.0" /></strong>
                    <fmt:message key="dashboard.media.descripcion"/>
                </p>
            </section>

            <section>
                <h2><fmt:message key="dashboard.mascomentados.titulo"/></h2>
                <c:if test="${not empty articulosMasComentados}">
                    <div class="list-group">
                        <c:forEach var="articulo" items="${articulosMasComentados}">
                            <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1">${articulo.titulo}</h5>
                                    <small>${fn:length(articulo.comentarios)} comentarios</small>
                                </div>
                                <p class="mb-1">
                                    <fmt:message key="dashboard.mascomentados.autor"/>: ${articulo.redactor.nombre}
                                </p>
                                <small>
                                    <fmt:message key="dashboard.mascomentados.fecha"/>: ${articulo.fecha}
                                </small>
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty articulosMasComentados}">
                    <p><fmt:message key="dashboard.mascomentados.vacio"/></p>
                </c:if>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Noticias Acme, S.A.</title>
    </head>

    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <section id="bienvenida" class="mb-4">
                <h2><fmt:message key="bienvenida.titulo" /></h2>
                <p><fmt:message key="bienvenida.descripcion" /></p>
            </section>

            <section id="ultimas-noticias">
                <c:if test="${!empty requestScope.articulos}"> 
                    <h2><fmt:message key="ultimas.publicaciones" /></h2>
                    <c:forEach var="articulo" items="${requestScope.articulos}">
                        <div class="card shadow-sm mb-4">
                            <a href="${sessionScope.ContextPath}/articulo?id=${articulo.id}" class="text-decoration-none text-dark">
                                <div class="card-body">
                                    <h4 class="card-title mb-2">${articulo.titulo}</h4>
                                    <div class="d-flex justify-content-between text-muted mb-2" style="font-size: 0.9rem;">
                                        <span><i class="bi bi-person-fill"></i> ${articulo.redactor.nombre}</span>
                                        <span><i class="bi bi-calendar-event-fill"></i> ${articulo.fecha}</span>
                                    </div>
                                    <p class="mb-2"><span class="badge bg-secondary">${articulo.categoria.nombre}</span></p>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if> 
                <c:if test="${empty requestScope.articulos}"> 
                    <h2><fmt:message key="sin.articulos" /></h2> 
                </c:if>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


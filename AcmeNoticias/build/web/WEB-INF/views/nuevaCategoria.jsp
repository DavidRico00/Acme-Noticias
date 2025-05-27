<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <c:if test="${categoria == null}">
            <title><fmt:message key="categoria.titulo.nueva"/></title>
        </c:if>
        <c:if test="${categoria != null}">
            <title><fmt:message key="categoria.titulo.editar"/></title>
        </c:if>
    </head>
    <body>
        <%@include file="shared/header.jsp" %>

        <div class="container mt-5">

            <c:if test="${categoria == null}">
                <h1><fmt:message key="categoria.encabezado"/></h1>
            </c:if>
            <c:if test="${categoria != null}">
                <h1>Editar Categoría</h1>
            </c:if>

            <form action="${sessionScope.ContextPath}/categoria/guardar" method="POST">
                <input type="text" id="id" name="id" value="${categoria.id}" style="display: none"/>

                <div class="mb-3">
                    <label for="nombre" class="form-label"><fmt:message key="categoria.label.nombre"/></label>
                    <input type="text" class="form-control" id="nombre" name="nombre" 
                           value="${categoria.nombre != null ? categoria.nombre : ''}" required>
                </div>

                <div class="mb-3">
                    <label for="descripcion" class="form-label"><fmt:message key="categoria.label.descripcion"/></label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required><c:out value="${categoria.descripcion != null ? categoria.descripcion : ''}" /></textarea>
                </div>

                <button type="submit" class="btn btn-primary"><fmt:message key="categoria.boton.guardar"/></button>
                <a href="${sessionScope.ContextPath}/gestionCategorias" class="btn btn-secondary"><fmt:message key="categoria.boton.cancelar"/></a>
            </form>

        </div>

        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

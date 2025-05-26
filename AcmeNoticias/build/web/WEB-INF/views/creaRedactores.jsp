<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="shared/head.jsp" %>
        <title><fmt:message key="redactor.titulo.pagina"/></title>
    </head>
    <body>
        <%@ include file="shared/header.jsp" %>

        <div class="container mt-5">
            <h1><fmt:message key="redactor.encabezado"/></h1>
            <form action="${sessionScope.ContextPath}/guardarRedactor" method="POST">
                <div class="mb-3">
                    <label for="nombre" class="form-label">
                        <fmt:message key="redactor.label.nombre"/>
                    </label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                </div>

                <div class="mb-3">
                    <label for="apellido" class="form-label">
                        <fmt:message key="redactor.label.apellido"/>
                    </label>
                    <input type="text" class="form-control" id="apellido" name="apellido" required>
                </div>

                <div class="mb-3">
                    <label for="dni" class="form-label">
                        <fmt:message key="redactor.label.dni"/>
                    </label>
                    <input type="text" class="form-control" id="dni" name="dni" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">
                        <fmt:message key="redactor.label.email"/>
                    </label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-3">
                    <label for="pwd" class="form-label">
                        <fmt:message key="redactor.label.contraseña"/>
                    </label>
                    <input type="password" class="form-control" id="pwd" name="pwd" required>
                </div>

                <label for="pwd" class="form-label">
                    <fmt:message key="redactor.label.contraseña"/>
                </label>
                <a href="${sessionScope.ContextPath}/listaRedactores" class="btn btn-secondary">
                    <fmt:message key="redactor.boton.cancelar"/>
                </a>
            </form>
        </div>

        <%@ include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
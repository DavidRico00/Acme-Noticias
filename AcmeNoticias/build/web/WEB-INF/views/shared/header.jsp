<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />

<header class="header">
    <div class="encabezado">
        <div class="logonombre">
            <a href="${sessionScope.ContextPath}/main"><img class="encabezadoimg" src="${sessionScope.ContextPath}/img/logoblanco.png"/></a>
            <h1 href="${sessionScope.ContextPath}/main"><fmt:message key="header.titulo"/></h1>
        </div>
    </div>
    <div class="idiomas">
        <a href="${pageContext.request.contextPath}/main/idioma?lang=es">
            <fmt:message key="header.idioma.es"/>
        </a>
        |
        <a href="${pageContext.request.contextPath}/main/idioma?lang=en">
            <fmt:message key="header.idioma.en"/>
        </a>
    </div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">    
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/main">
                            <fmt:message key="header.inicio"/>
                        </a></li>

                    <c:if test="${sessionScope.id != null}">

                    </c:if>
                    <c:if test="${sessionScope.redactorId != null}">
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/perfil?id=${sessionScope.id}">
                                <fmt:message key="header.perfil"/>
                            </a></li>
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/misarticulos?id=${sessionScope.id}">
                                <fmt:message key="header.misarticulos"/>
                            </a></li>
                    </c:if>
                    <c:if test="${sessionScope.adminId != null}">
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/dashboard">
                                <fmt:message key="header.dashboard"/>
                            </a></li>
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/gestionCategorias">
                                <fmt:message key="header.gestion.categorias"/>
                            </a></li>
                    </c:if>
                    <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/listaRedactores">
                            <fmt:message key="header.lista.redactores"/>
                        </a></li>

                </ul>

                <ul class="navbar-nav ms-auto">
                    <c:if test="${sessionScope.id == null}">
                        <a href="${sessionScope.ContextPath}/login" class="btn btn-light encabezadobtn">
                            <fmt:message key="header.login"/>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.id != null}">
                        <a href="${sessionScope.ContextPath}/logout" class="btn btn-danger encabezadobtn">
                            <fmt:message key="header.logout"/>
                        </a>
                    </c:if>
                </ul>
            </div>      
        </div>
    </nav>
</header>


<%-- 
    Document   : header
    Created on : 18 may 2025, 20:34:08
    Author     : Antonio
--%>
<header class="header">
    <div class="encabezado">
        <div class="logonombre">
            <a href="/noticiasacme/main"><img class="encabezadoimg" src="/noticiasacme/img/logo.png"/></a>
            <h1 href="/noticiasacme/main">Noticias Acme, S.A.</h1>
        </div>
        <c:if test="${sessionScope.email == null}">
            <a href="/noticiasacme/login" class="btn btn-light encabezadobtn">Iniciar sesión</a>
        </c:if>
        <c:if test="${sessionScope.email != null}">
            <a href="/noticiasacme/logout" class="btn btn-danger encabezadobtn">Cerrar sesión</a>
        </c:if>
    </div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/noticiasacme/categorias">Categorías</a></li>
                    <li class="nav-item"><a class="nav-link" href="/noticiasacme/articulos">Artículos</a></li>
                    <li class="nav-item"><a class="nav-link" href="/noticiasacme/perfil">Perfil</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>


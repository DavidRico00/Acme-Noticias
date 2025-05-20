<header class="header">
    <div class="encabezado">
        <div class="logonombre">
            <a href="${sessionScope.ContextPath}/main"><img class="encabezadoimg" src="${sessionScope.ContextPath}/img/logoblanco.png"/></a>
            <h1 href="${sessionScope.ContextPath}/main">Noticias Acme, S.A.</h1>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">    
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/main">Inicio</a></li>
                    <c:if test="${sessionScope.id != null}">
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/perfil?id=${sessionScope.id}">Perfil</a></li>
                    </c:if>
                    <c:if test="${sessionScope.redactor != null}">
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/misarticulos?id=${sessionScope.id}">Mis Articulos</a></li>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <li class="nav-item"><a class="nav-link" href="${sessionScope.ContextPath}/dashboard">Dashboard</a></li>
                    </c:if>
                </ul>

                <ul class="navbar-nav ms-auto">
                    <c:if test="${sessionScope.id == null}">
                        <a href="${sessionScope.ContextPath}/login" class="btn btn-light encabezadobtn">Iniciar sesión</a>
                    </c:if>
                    <c:if test="${sessionScope.id != null}">
                        <a href="${sessionScope.ContextPath}/logout" class="btn btn-danger encabezadobtn">Cerrar sesión</a>
                    </c:if>
                </ul>
            </div>      
        </div>
    </nav>
</header>


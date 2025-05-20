<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${articulo.titulo} - Noticias Acme, S.A</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body class="body">
        <%@include file="shared/header.jsp" %>
        
        <main class="container my-5">
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${sessionScope.ContextPath}/home">Inicio</a></li>
                    <li class="breadcrumb-item"><a href="${sessionScope.ContextPath}/categoria?id=${articulo.categoria.id}">${articulo.categoria.nombre}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${articulo.titulo}</li>
                </ol>
            </nav>
            
            <article class="mb-5">
                <header class="mb-4">
                    <h1 class="display-4 fw-bold">${articulo.titulo}</h1>
                    <div class="d-flex justify-content-between align-items-center text-muted mb-4">
                        <div>
                            <i class="bi bi-person-circle me-2"></i>Por: 
                            <a href="${sessionScope.ContextPath}/redactor?id=${articulo.redactor.id}" class="text-decoration-none">
                                ${articulo.redactor.nombre}
                            </a>
                        </div>
                        <div>
                            <i class="bi bi-calendar3 me-2"></i>${articulo.fecha}
                        </div>
                    </div>
                </header>
                
                <c:if test="${not empty articulo.imagenUrl}">
                    <div class="text-center mb-4">
                        <img src="${articulo.imagenUrl}" alt="${articulo.titulo}" class="img-fluid rounded shadow-sm" style="max-height: 500px;">
                        <c:if test="${not empty articulo.imagenDescripcion}">
                            <figcaption class="figure-caption text-center mt-2">${articulo.imagenDescripcion}</figcaption>
                        </c:if>
                    </div>
                </c:if>
                
                <!-- Resumen del artículo -->
                <div class="lead mb-4 p-3 bg-light rounded">
                    ${articulo.resumen}
                </div>
                
                <!-- Contenido principal del artículo -->
                <div class="article-content mb-4">
                    ${articulo.contenido}
                </div>
                
                <!-- Etiquetas -->
                <c:if test="${not empty articulo.etiquetas}">
                    <div class="my-4">
                        <c:forEach var="etiqueta" items="${articulo.etiquetas}">
                            <a href="${sessionScope.ContextPath}/etiqueta?id=${etiqueta.id}" class="badge bg-secondary text-decoration-none me-1">
                                ${etiqueta.nombre}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
                
                <div class="d-flex justify-content-end mb-4">
                    <div class="share-buttons">
                        <span class="me-2">Compartir:</span>
                        <a href="#" class="text-decoration-none me-2"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-decoration-none me-2"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-decoration-none me-2"><i class="bi bi-linkedin"></i></a>
                        <a href="#" class="text-decoration-none"><i class="bi bi-envelope"></i></a>
                    </div>
                </div>
            </article>
            
            <section id="articulos-relacionados" class="mb-5">
                <h3 class="border-bottom pb-2 mb-4">Artículos relacionados</h3>
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <c:forEach var="relacionado" items="${articulosRelacionados}" varStatus="status">
                        <c:if test="${status.index < 3}">
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <c:if test="${not empty relacionado.imagenUrl}">
                                        <img src="${relacionado.imagenUrl}" class="card-img-top" alt="${relacionado.titulo}" style="height: 180px; object-fit: cover;">
                                    </c:if>
                                    <div class="card-body">
                                        <h5 class="card-title">${relacionado.titulo}</h5>
                                        <p class="card-text small">${relacionado.resumen}</p>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <a href="${sessionScope.ContextPath}/articulo?id=${relacionado.id}" class="btn btn-sm btn-outline-primary">Leer más</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </section>
            
            <section id="comentarios" class="mb-5">
                <h3 class="border-bottom pb-2 mb-4">Comentarios (${comentarios.size()})</h3>
                
                <c:if test="${not empty sessionScope.usuario}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <form action="${sessionScope.ContextPath}/agregarComentario" method="post">
                                <input type="hidden" name="articuloId" value="${articulo.id}">
                                <div class="mb-3">
                                    <label for="comentario" class="form-label">Deja tu comentario</label>
                                    <textarea class="form-control" id="comentario" name="contenido" rows="3" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Enviar comentario</button>
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.usuario}">
                    <div class="alert alert-info mb-4">
                        <a href="${sessionScope.ContextPath}/login" class="alert-link">Inicia sesión</a> para dejar un comentario.
                    </div>
                </c:if>
                
                <c:if test="${not empty comentarios}">
                    <div class="comentarios-lista">
                        <c:forEach var="comentario" items="${comentarios}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h6 class="fw-bold mb-0">${comentario.usuario.nombre}</h6>
                                        <small class="text-muted">${comentario.fecha}</small>
                                    </div>
                                    <p class="mb-0">${comentario.contenido}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty comentarios}">
                    <div class="alert alert-light text-center">
                        No hay comentarios todavía. ¡Sé el primero en comentar!
                    </div>
                </c:if>
            </section>
        </main>
        
        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
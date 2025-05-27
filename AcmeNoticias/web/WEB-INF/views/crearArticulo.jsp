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
        <c:if test="${empty articulo}">
            <title><fmt:message key="articulo.titulo.pagina"/></title>
        </c:if>
        <c:if test="${not empty articulo}">
            <title>Editar Artículo - Noticias Acme, S.A</title>
        </c:if>
    </head>
    <body class="body">
        <%@include file="shared/header.jsp" %>

        <main class="container my-5">

            <section class="mb-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <c:if test="${empty articulo}">
                            <h2 class="h4 mb-0"><i class="bi bi-file-earmark-plus me-2"></i><fmt:message key="articulo.encabezado"/></h2>
                        </c:if>
                        <c:if test="${not empty articulo}">
                            <h2 class="h4 mb-0"><i class="bi bi-file-earmark-plus me-2"></i>Editar Artículo</h2>
                        </c:if>
                    </div>
                    <div class="card-body">
                      
                      <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${requestScope.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty requestScope.success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${requestScope.success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form action="${sessionScope.ContextPath}/articulo/guardar" method="post" id="formArticulo">
                            <input type="hidden" name="redactorId" value="${redactorId}">
                            <input type="hidden" name="contenidoHtml" id="contenidoHtml">
                            <c:if test="${not empty articulo}">
                                <input type="hidden" name="articuloId" value="${articulo.id}">
                            </c:if>

                            <div class="mb-3">
                                <label for="titulo" class="form-label"><fmt:message key="articulo.label.titulo"/> *</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" value="${articulo != null ? articulo.titulo : ''}"
                                       placeholder="<fmt:message key='articulo.placeholder.titulo'/>" required maxlength="200">
                            </div>

                            <div class="mb-3">
                                <label for="categoriaId" class="form-label">
                                    <fmt:message key="articulo.label.categoria"/>
                                </label>
                                <select class="form-select" id="categoriaId" name="categoriaId" required>

                                    <option value="" disabled <c:if test="${empty articulo.categoria.nombre}">selected</c:if>>
                                            <fmt:message key="articulo.option.categoria"/>
                                        </option>

                                    <c:forEach var="categoria" items="${requestScope.categorias}">
                                        <option value="${categoria.id}"
                                                <c:if test="${not empty articulo.categoria and categoria.id == articulo.categoria.id}">selected</c:if>>
                                            ${categoria.nombre}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="editor" class="form-label">
                                    <fmt:message key="articulo.label.contenido"/>
                                </label>
                                <div id="editor" style="min-height: 300px;"></div>
                                <div class="form-text">
                                    <fmt:message key="articulo.texto.editor"/>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">

                                <button type="button" class="btn btn-outline-secondary" onclick="location.href = '${sessionScope.ContextPath}/misarticulos?id=${redactorId}'">
                                    <i class="bi bi-x-circle me-1"></i><fmt:message key="articulo.boton.cancelar"/>
                                </button>
                                <button type="submit" class="btn btn-primary" id="btnPublicar">
                                    <i class="bi bi-send me-1"></i>
                                    <fmt:message key="articulo.boton.publicar"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.min.js"></script>

        <script>
                                    const quill = new Quill('#editor', {
                                        theme: 'snow',
                                        modules: {
                                            toolbar: [
                                                [{'header': [1, 2, 3, 4, 5, 6, false]}],
                                                ['bold', 'italic', 'underline', 'strike'],
                                                [{'list': 'ordered'}, {'list': 'bullet'}],
                                                ['blockquote', 'code-block'],
                                                [{'color': []}, {'background': []}],
                                                [{'align': []}],
                                                ['clean']
                                            ]
                                        }
                                    });


            <c:if test="${not empty articulo.cuerpo}">
                                    const contenidoGuardado = `<c:out value="${articulo.cuerpo}" escapeXml="true"/>`
                                            .replace(/&lt;/g, "<")
                                            .replace(/&gt;/g, ">")
                                            .replace(/&amp;/g, "&");
                                    quill.root.innerHTML = contenidoGuardado;
            </c:if>

                                    document.getElementById('formArticulo').addEventListener('submit', function (e) {
                                        document.getElementById('contenidoHtml').value = quill.root.innerHTML;
                                        // Si el campo de título o resumen están vacíos, detener el envío
                                        if (!document.getElementById('titulo').value.trim() ||
                                                !document.getElementById('categoriaId').value) {
                                            e.preventDefault();
                                            alert('Por favor completa todos los campos obligatorios');
                                        }
                                    });

                                    document.getElementById('btnBorrador').addEventListener('click', function () {
                                        document.getElementById('publicado').checked = false;
                                        document.getElementById('contenidoHtml').value = quill.root.innerHTML;
                                        document.getElementById('formArticulo').submit();
                                    });

        </script>
    </body>
</html>
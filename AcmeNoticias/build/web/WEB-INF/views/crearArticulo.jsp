<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="shared/head.jsp" %>
        <title><fmt:message key="articulo.titulo.pagina"/></title>
    </head>
    <body class="body">
        <%@include file="shared/header.jsp" %>

        <main class="container my-5">


            <section class="mb-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h2 class="h4 mb-0">
                            <i class="bi bi-file-earmark-plus me-2"></i>
                            <fmt:message key="articulo.encabezado"/>
                        </h2>
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

                        <form action="${sessionScope.ContextPath}/admin/guardarArticulo" method="post" enctype="multipart/form-data" id="formArticulo">
                            <input type="hidden" name="redactorId" value="${sessionScope.usuario.id}">
                            <input type="hidden" name="contenidoHtml" id="contenidoHtml">

                            <div class="mb-3">
                                <label for="titulo" class="form-label">
                                    <fmt:message key="articulo.label.titulo"/>
                                </label>
                                <input type="text" class="form-control" id="titulo" name="titulo" 
                                       placeholder="<fmt:message key='articulo.placeholder.titulo'/>" required maxlength="200">
                            </div>


                            <div class="mb-3">
                                <label for="categoriaId" class="form-label">
                                    <fmt:message key="articulo.label.categoria"/>
                                </label>
                                <select class="form-select" id="categoriaId" name="categoriaId" required>
                                    <option value="" selected disabled>
                                    <fmt:message key="articulo.option.categoria"/>
                                    </option>
                                    <c:forEach var="categoria" items="${requestScope.categorias}">
                                        <option value="${categoria.id}">${categoria.nombre}</option>
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
                                <button type="button" class="btn btn-outline-secondary" onclick="location.href = '${sessionScope.ContextPath}/admin/articulos'">
                                    <i class="bi bi-x-circle me-1"></i>
                                    <fmt:message key="articulo.boton.cancelar"/>
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

                                    document.getElementById('formArticulo').addEventListener('submit', function (e) {
                                        document.getElementById('contenidoHtml').value = quill.root.innerHTML;

                                        // Si el campo de título o resumen están vacíos, detener el envío
                                        if (!document.getElementById('titulo').value.trim() ||
                                                !document.getElementById('resumen').value.trim() ||
                                                !document.getElementById('categoriaId').value) {
                                            e.preventDefault();
                                            alert('<fmt:message key="articulo.alerta.campos"/>');
                                        }
                                    });

                                    document.getElementById('btnBorrador').addEventListener('click', function () {
                                        document.getElementById('publicado').checked = false;
                                        document.getElementById('contenidoHtml').value = quill.root.innerHTML;
                                        document.getElementById('formArticulo').submit();
                                    });

                                    document.getElementById('imagen').addEventListener('change', function (e) {
                                        const file = e.target.files[0];
                                        if (file) {
                                            if (file.size > 5 * 1024 * 1024) {
                                                alert('<fmt:message key="articulo.alerta.peso"/>');
                                                e.target.value = '';
                                            }
                                        }
                                    });
        </script>
    </body>
</html>
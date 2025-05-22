<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="shared/head.jsp" %>
        <title>Perfil usuario</title>
    </head>
    <%@include file="shared/header.jsp" %>
    <body>
        <div class="contenedor-perfil">
            <c:if test= "${!empty requestScope.msg}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.msg}
                </div>
                <c:remove var="msg" scope="session"/>
            </c:if>
            <div class="perfil-detalles">
                <form action="${sessionScope.ContextPath}/perfil/editarperfil" method="POST" enctype="multipart/form-data">
                    <input type="text" id="id" name="id" value="${requestScope.redactor.id}" style="display: none"/>
                    <div class="profile-picture">
                        <c:if test="${!empty requestScope.redactor.rutaimg}">
                            <img src="${sessionScope.ContextPath}${requestScope.redactor.rutaimg}"/>
                        </c:if>
                        <c:if test="${empty requestScope.redactor.rutaimg}">
                            <img src="${sessionScope.ContextPath}/img/default.jpg"/>
                        </c:if>
                    </div>
                    
                    <h2 class="titulostabla">${requestScope.redactor.nombre} ${requestScope.redactor.apellido}</h2>
                    <div class="inputs-perfil">
                        <label>
                            <strong>Correo electrónico</strong> <input type="text" id="email" name="email" value="${requestScope.redactor.email}" disabled="true"/>
                        </label>
                        <label>
                            <strong>DNI</strong> <input type="text" id="dni" name="dni" value="${requestScope.redactor.dni}" disabled="true"/>
                        </label>
                        <input type="file" id="profileimg" name="profileimg" style="display: none">
                    </div>
                            
                    <button type="submit" class="btn btn-success editar-perfil" style="margin: 1rem; display: none" id="guardarPerfil">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-floppy" viewBox="0 0 16 16">
                        <path d="M11 2H9v3h2z"/>
                        <path d="M1.5 0h11.586a1.5 1.5 0 0 1 1.06.44l1.415 1.414A1.5 1.5 0 0 1 16 2.914V14.5a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 14.5v-13A1.5 1.5 0 0 1 1.5 0M1 1.5v13a.5.5 0 0 0 .5.5H2v-4.5A1.5 1.5 0 0 1 3.5 9h9a1.5 1.5 0 0 1 1.5 1.5V15h.5a.5.5 0 0 0 .5-.5V2.914a.5.5 0 0 0-.146-.353l-1.415-1.415A.5.5 0 0 0 13.086 1H13v4.5A1.5 1.5 0 0 1 11.5 7h-7A1.5 1.5 0 0 1 3 5.5V1H1.5a.5.5 0 0 0-.5.5m3 4a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V1H4zM3 15h10v-4.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5z"/>
                        </svg>
                        Guardar
                    </button>
                </form>
                <button class="btn btn-danger editar-perfil" style="margin: 1rem; display: none" id="cancelarPerfil" onclick="location.reload()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                    <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
                    </svg>
                    Cancelar
                </button>
                <button class="btn btn-primary" style="margin: 1rem;" id="editarPerfil" onclick="activarBotones()" >
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                    <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
                    </svg>
                    Editar perfil
                </button>
            </div>
    </body>
    <%@include file="shared/footer.jsp" %>
</html>

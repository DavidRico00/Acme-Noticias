<%-- 
    Document   : main
    Created on : 18 may 2025, 20:40:17
    Author     : Antonio
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Noticias Acme, S.A.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="/noticiasacme/css/styles.css" rel="stylesheet" type="text/css">
    </head>
    <body class="body">

        <%@include file="shared/header.jsp" %>

        <main class="container my-5">
            <section id="bienvenida" class="mb-4">
                <h2>Bienvenido a Noticias Acme, S.A.</h2>
                <p>Somos un portal de noticias digitales con cobertura internacional. Aquí encontrarás artículos clasificados por categorías como nacional, internacional, ciencia, deportes y cultura. ¡Mantente informado con nosotros!</p>
            </section>

            <section id="ultimas-noticias">
                <h2>Últimas Publicaciones</h2>
                <div class="card mb-3">
                    <div class="card-body">
                        <h3 class="card-title">Inteligencia Artificial: Avances en 2025</h3>
                        <p class="card-text">La IA continúa transformando sectores clave como la medicina, la educación y la comunicación. Conoce las últimas innovaciones.</p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <h3 class="card-title">Cumbre Internacional sobre el Cambio Climático</h3>
                        <p class="card-text">Líderes mundiales se reúnen para abordar los desafíos ambientales más urgentes. Te contamos qué acuerdos se han alcanzado.</p>
                    </div>
                </div>
            </section>
        </main>

        <%@include file="shared/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


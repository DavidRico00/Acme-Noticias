<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión - Noticias Acme, S.A.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${sessionScope.ContextPath}/css/main.css" rel="stylesheet" type="text/css">
    </head>

    <body class="body d-flex align-items-center justify-content-center vh-100">

        <main class="container" style="max-width: 400px;">        
            <div class="card shadow rounded-4">
                <div class="card-body">
                    
                    <c:if test="${!empty requestScope.msg}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${requestScope.msg}
                        </div>
                    </c:if>

                    <h2 class="card-title text-center mb-4">Iniciar Sesión</h2>

                    <form action="${sessionScope.ContextPath}/login/check" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required autofocus>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Entrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

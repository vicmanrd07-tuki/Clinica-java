<%-- 
    Document   : index
    Created on : 21/10/2026, 10:32:59 p. m.
    Author     : helen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    </head>
    <body>
      
     
    <div class="pagina">
         
        <div class="lado-imagen">
            <img src="${pageContext.request.contextPath}/img/bienvenido.png" alt="Bienvenido a Mednova">
        </div>

        <div class="lado-formulario">
            
            <div class="cuadrado">
                <div class="inicio-sesion">
                    <div>Iniciar Sesion</div>
                        
                </div>
               <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
    <div class="campo">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
    </div>

    <div class="campo">
        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required>
    </div>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <button type="submit" class="btn-enviar">Enviar</button>
</form>
            </div>
        </div>

    </div>
</body>
</html>

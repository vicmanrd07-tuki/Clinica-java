<%-- 
    Document   : inicio
    Created on : 26/10/2026, 7:24:57 p. m.
    Author     : helen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Panel User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fondiko.css">

</head>

<body>
    <form action="${pageContext.request.contextPath}/formulario/formularioConsulta.jsp" method="GET">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MedNova</a>

            <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Horarios</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Especialidades</a>
                    </li>
                    
                    
                </ul>

                <span class="navbar-text me-3">
                     ${sessionScope.usuario.nombre}
                </span>
                <a class="btn btn-outline-danger btn-sm"
                   href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
            </div>
        </div>
    </nav>
            
            
            <img src="${pageContext.request.contextPath}/img/logan.png" alt="Logo" width="300" height="300" class="d-block mx-auto"/> 

    <div class="container mt-0" >
        
        <h1 class="texto-bienvenida">Bienvenido a MedNova, ${sessionScope.usuario.nombre}</h1>
       
    </div>
        <div class="d-flex flex-wrap justify-content-center gap-3">
        <button type="submit" class="btn btn-mednova mt-4" class="mx-auto" name="agendar-cita" href="/formulario/formularioConsulta.jsp">Agendar tu cita médica</button>
        
        <button type="submit" class="btn btn-mednova mt-4" name="historial" >Consultar su historial médico</button>
        
        
        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
        
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<% 
    String mensaje = (String) session.getAttribute("mensaje");
    String tipo = (String) session.getAttribute("tipoMensaje");
    if (mensaje != null) {
%>
<script>
    Swal.fire({
        icon: '<%= tipo %>',
        title: '<%= "success".equals(tipo) ? "¡Listo!" : "Horario no disponible" %>',
        text: '<%= mensaje %>'
    });
</script>
<%
        session.removeAttribute("mensaje");
        session.removeAttribute("tipoMensaje");
    }
%>
</body>

</html>
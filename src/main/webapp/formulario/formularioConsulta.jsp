<%-- 
    Document   : formularioConsulta
    Created on : 29/10/2026, 8:13:55 p. m.
    Author     : helen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel consulta</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <meta name="viewport" content="width=device-width, initial-scale=1"><!-- comment -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estiloconsulta.css">
        
    </head>
    <body>
       
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
            <form action="${pageContext.request.contextPath}/consultas" method="post">
            <h1>Agenda tu cita</h1>  
            
            <div class="cuadrado">
            
            <h2>Datos Generales</h2>
        <div class="campo">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        </div>
        <div class="campo">
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required>
        </div>
        <div class="campo">
        <label for="cui">Cui:</label>
        <input type="text" id="cui" name="cui" required>
        </div>
        <div class="campo">
        <label for="fechaNacimiento">Fecha de nacimiento:</label>
        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required>
        </div>
        <div class="campo">
        <label for="telefono">Teléfono</label>
        <input type="text" id="telefono" name="telefono" required>
        </div>
        <div class="campo">
        <label for="correo">Correo:</label>
        <input type="text" id="correo" name="correo" required>
        </div>
        
            <h2>Datos Para Consulta</h2>
            <div class="campo">
        <label for="especialidad">Especialidad:</label>
        <select id="especialidad" name="especialidad">
        <option value="">-- Seleccione --</option>
        <option value="general">Medicina General</option>
        <option value="pediatria">Pediatría</option>
        <option value="ginecologia">Ginecología</option>
        <option value="traumatologia">Traumatologia</option>
        </select>
        </div>
        <div class="campo">
        <label for="doctor">Doctor:</label>
        <select id="doctor" name="doctor" required>
        <option value="">-- Seleccione especialidad primero --</option>
        
        </select>
        <script>
             const doctores = {
        general: [
            { id: 1, nombre: "Dr. Carlos Méndez" },
            { id: 2, nombre: "Dra. Ana López" }
        ],
        pediatria: [
            { id: 3, nombre: "Dr. Luis Ramírez" },
            { id: 4, nombre: "Dra. María Torres" }
        ],
        ginecologia: [
            { id: 5, nombre: "Dra. Sofía Castillo" },
            { id: 6, nombre: "Dra. Elena Morales" }
        ],
        traumatologia: [
            {id: 7, nombre: "Dr. Antonio Pintus"},
            {id: 8, nombre: "Dr. Dany Salguero"}
        ]
    };
    const selEspecialidad = document.getElementById("especialidad");
    const selDoctor = document.getElementById("doctor");

    selEspecialidad.addEventListener("change", function () {
        // Limpiar la segunda lista
        selDoctor.innerHTML = '<option value="">-- Seleccione doctor --</option>';

        const lista = doctores[this.value];

        if (lista) {
            lista.forEach(function (d) {
                const opcion = document.createElement("option");
                opcion.value = d.id;
                opcion.textContent = d.nombre;
                selDoctor.appendChild(opcion);
            });
            selDoctor.disabled = false;
        } else {
            selDoctor.disabled = true;
        }
    });
         </script>   
        
        </div>
            
            <div class="campo">
        <label for="causa">Razón de la consulta:</label>
        <textarea type="text" class="causa" id="causa" name="causa" required></textarea>
        </div>
          
      <div class="campo">
        <label for="fechaCita">Fecha de la cita:</label>
        <input type="date" id="fechaCita" name="fechaCita" required>
        <script>
    document.getElementById("fechaCita").min = new Date().toISOString().split("T")[0];
</script>
        </div>
            
            <div class="campo">
        <label for="hora">Hora:</label>
<select id="hora" name="hora" required>
    <option value="">-- Seleccione --</option>
    <option value="08:00">08:00</option>
    <option value="08:30">08:30</option>
    <option value="09:00">09:00</option>
    <option value="09:30">09:30</option>
    <option value="10:00">10:00</option>
    <option value="10:30">10:30</option>
    <option value="11:00">11:00</option>
    <option value="11:30">11:30</option>
    <option value="14:00">14:00</option>
    <option value="14:30">14:30</option>
    <option value="15:00">15:00</option>
    <option value="15:30">15:30</option>
</select>
        </div>
            
            <div>
                <button type="submit" class="btn btn-generar mt-3" >Generar Consulta</button>
            </div>    
            </div>
            </form>
    </body>
</html>

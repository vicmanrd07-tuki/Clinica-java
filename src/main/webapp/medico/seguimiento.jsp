<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dar seguimiento | MedNova</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --navy: #24406b;
            --blue: #4a86c8;
            --blue-dark: #3a6fae;
            --teal: #3b7a7e;
            --sky: #87ceeb;
            --mist: #eef5f7;
            --line: #d5e2e6;
            --ink: #1f2d3d;
            --muted: #5c6f80;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Montserrat", "Segoe UI", Arial, sans-serif;
            color: var(--ink);
            background: var(--mist);
            line-height: 1.5;
        }

        /* Barra superior */
        .topbar {
            background: #fff;
            border-bottom: 1px solid var(--line);
            display: flex;
            align-items: center;
            gap: 24px;
            padding: 14px 32px;
        }
        .brand {
            font-weight: 700;
            font-size: 1.25rem;
            color: var(--navy);
            text-decoration: none;
            letter-spacing: .04em;
        }
        .brand span { color: var(--blue); }
        .topbar nav { display: flex; gap: 20px; flex: 1; }
        .topbar nav a {
            color: var(--muted);
            text-decoration: none;
            font-weight: 500;
            padding: 4px 0;
            border-bottom: 2px solid transparent;
        }
        .topbar nav a:hover { color: var(--navy); }
        .topbar nav a.activo { color: var(--navy); border-bottom-color: var(--blue); }
        .usuario { color: var(--muted); font-size: .95rem; }
        .salir {
            color: #b3392f;
            border: 1px solid #e3b4af;
            border-radius: 999px;
            padding: 6px 16px;
            text-decoration: none;
            font-size: .9rem;
            font-weight: 500;
        }
        .salir:hover { background: #fbeceb; }

        /* Contenido */
        main { max-width: 980px; margin: 40px auto 64px; padding: 0 20px; }
        h1 { margin: 0 0 6px; font-size: 1.9rem; color: var(--navy); }
        .subtitulo { margin: 0 0 28px; color: var(--muted); }

        .tarjeta {
            display: grid;
            grid-template-columns: 300px 1fr;
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(36, 64, 107, .12);
        }

        /* Panel izquierdo: la cita anterior */
        .anterior {
            background: var(--teal);
            color: #fff;
            padding: 36px 28px;
        }
        .anterior h2 { margin: 0 0 24px; font-size: 1.1rem; font-weight: 600; }
        .dato { margin-bottom: 20px; }
        .dato small { display: block; opacity: .8; font-size: .8rem; margin-bottom: 2px; }
        .dato strong { font-weight: 600; font-size: 1.05rem; }
        .linea {
            margin-top: 28px;
            padding-top: 22px;
            border-top: 1px dashed rgba(255, 255, 255, .5);
            font-size: .9rem;
            opacity: .95;
        }

        /* Panel derecho: formulario */
        .formulario { padding: 36px 40px; }
        .formulario h2 { margin: 0 0 22px; font-size: 1.1rem; color: var(--navy); }
        .campo { margin-bottom: 22px; }
        .campo > label, .grupo-titulo {
            display: block;
            font-weight: 600;
            font-size: .92rem;
            color: var(--navy);
            margin-bottom: 8px;
        }
        textarea, input[type="date"] {
            width: 100%;
            font: inherit;
            padding: 12px 14px;
            border: 1.5px solid var(--line);
            border-radius: 12px;
            background: #fafcfd;
            color: var(--ink);
        }
        textarea { min-height: 96px; resize: vertical; }
        textarea:focus, input[type="date"]:focus {
            outline: none;
            border-color: var(--blue);
            box-shadow: 0 0 0 3px rgba(74, 134, 200, .2);
        }

        /* Horas como botones */
        .jornada { margin-bottom: 12px; }
        .jornada p { margin: 0 0 6px; font-size: .85rem; color: var(--muted); }
        .horas { display: flex; flex-wrap: wrap; gap: 8px; }
        .horas input { position: absolute; opacity: 0; pointer-events: none; }
        .horas label {
            padding: 8px 16px;
            border: 1.5px solid var(--line);
            border-radius: 999px;
            background: #fff;
            cursor: pointer;
            font-size: .92rem;
            font-weight: 500;
            transition: background .15s, border-color .15s, color .15s;
        }
        .horas label:hover { border-color: var(--blue); }
        .horas input:checked + label {
            background: var(--blue);
            border-color: var(--blue);
            color: #fff;
        }
        .horas input:focus-visible + label {
            outline: 3px solid rgba(74, 134, 200, .45);
            outline-offset: 2px;
        }

        /* Botones */
        .acciones { display: flex; gap: 12px; align-items: center; margin-top: 30px; }
        .btn-guardar {
            background: var(--blue);
            color: #fff;
            border: 0;
            border-radius: 999px;
            padding: 13px 30px;
            font: inherit;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-guardar:hover { background: var(--blue-dark); }
        .btn-guardar:focus-visible { outline: 3px solid rgba(74, 134, 200, .45); outline-offset: 2px; }
        .btn-cancelar {
            color: var(--muted);
            text-decoration: none;
            padding: 13px 18px;
            border-radius: 999px;
            font-weight: 500;
        }
        .btn-cancelar:hover { background: var(--mist); color: var(--navy); }

        @media (max-width: 760px) {
            .topbar { flex-wrap: wrap; padding: 12px 16px; gap: 12px; }
            .usuario { display: none; }
            .tarjeta { grid-template-columns: 1fr; }
            .formulario { padding: 28px 22px; }
        }
    </style>
</head>
<body>

    <header class="topbar">
        <a class="brand" href="${pageContext.request.contextPath}/medico/inicio.jsp">Med<span>Nova</span></a>
        <nav>
            <a href="${pageContext.request.contextPath}/medico/inicio.jsp">Inicio</a>
            <a class="activo" href="${pageContext.request.contextPath}/medico/citas">Citas</a>
        </nav>
        <span class="usuario">${sessionScope.usuario.nombre}</span>
        <a class="salir" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </header>

    <main>
        <h1>Dar seguimiento</h1>
        <p class="subtitulo">Programa la siguiente visita del paciente.</p>

        <form class="tarjeta" action="${pageContext.request.contextPath}/medico/seguimiento" method="post">

            <!-- Solo se envía el id de la cita; el servidor busca el resto en la base -->
            <input type="hidden" name="idOrigen" value="${citaOrigen.idCita}">

            <aside class="anterior">
                <h2>Cita anterior</h2>
                <div class="dato">
                    <small>Paciente</small>
                    <strong>${citaOrigen.nombrePaciente}</strong>
                </div>
                <div class="dato">
                    <small>Fecha</small>
                    <strong>${citaOrigen.fechaCita}</strong>
                </div>
                <div class="dato">
                    <small>Causa</small>
                    <strong>${citaOrigen.causa}</strong>
                </div>
                <div class="linea">La nueva cita quedará enlazada a esta visita.</div>
            </aside>

            <section class="formulario">
                <h2>Nueva cita</h2>

                <div class="campo">
                    <label for="causa">Razón del seguimiento</label>
                    <textarea id="causa" name="causa" required>Seguimiento</textarea>
                </div>

                <div class="campo">
                    <label for="fecha">Fecha</label>
                    <input type="date" id="fecha" name="fecha" required>
                </div>

                <div class="campo">
                    <span class="grupo-titulo">Hora</span>

                    <div class="jornada">
                        <p>Mañana</p>
                        <div class="horas">
                            <input type="radio" name="hora" id="h0800" value="08:00" required><label for="h0800">08:00</label>
                            <input type="radio" name="hora" id="h0830" value="08:30"><label for="h0830">08:30</label>
                            <input type="radio" name="hora" id="h0900" value="09:00"><label for="h0900">09:00</label>
                            <input type="radio" name="hora" id="h0930" value="09:30"><label for="h0930">09:30</label>
                            <input type="radio" name="hora" id="h1000" value="10:00"><label for="h1000">10:00</label>
                            <input type="radio" name="hora" id="h1030" value="10:30"><label for="h1030">10:30</label>
                            <input type="radio" name="hora" id="h1100" value="11:00"><label for="h1100">11:00</label>
                            <input type="radio" name="hora" id="h1130" value="11:30"><label for="h1130">11:30</label>
                        </div>
                    </div>

                    <div class="jornada">
                        <p>Tarde</p>
                        <div class="horas">
                            <input type="radio" name="hora" id="h1400" value="14:00"><label for="h1400">14:00</label>
                            <input type="radio" name="hora" id="h1430" value="14:30"><label for="h1430">14:30</label>
                            <input type="radio" name="hora" id="h1500" value="15:00"><label for="h1500">15:00</label>
                            <input type="radio" name="hora" id="h1530" value="15:30"><label for="h1530">15:30</label>
                        </div>
                    </div>
                </div>

                <div class="acciones">
                    <button type="submit" class="btn-guardar">Guardar seguimiento</button>
                    <a class="btn-cancelar" href="${pageContext.request.contextPath}/medico/citas">Cancelar</a>
                </div>
            </section>
        </form>
    </main>

    <script>
        // No permite elegir días anteriores a hoy
        document.getElementById("fecha").min = new Date().toISOString().split("T")[0];
    </script>
</body>
</html>
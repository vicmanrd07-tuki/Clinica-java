<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mis citas | MedNova</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --navy: #24406b;
            --blue: #4a86c8;
            --blue-dark: #3a6fae;
            --teal: #3b7a7e;
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
        main { max-width: 1040px; margin: 40px auto 64px; padding: 0 20px; }
        h1 { margin: 0 0 6px; font-size: 1.9rem; color: var(--navy); }
        .subtitulo { margin: 0 0 28px; color: var(--muted); }

        /* Avisos */
        .aviso {
            padding: 14px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .aviso.ok    { background: #dff1e6; color: #226a3d; }
        .aviso.error { background: #fbe4e1; color: #9c2f26; }

        .tarjeta {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(36, 64, 107, .12);
            overflow: hidden;
        }
        .tabla-scroll { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 760px; }
        thead th {
            background: var(--teal);
            color: #fff;
            text-align: left;
            font-weight: 600;
            font-size: .92rem;
            padding: 16px 20px;
        }
        tbody td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--line);
            vertical-align: middle;
        }
        tbody tr:last-child td { border-bottom: 0; }
        tbody tr:hover { background: #f6fafb; }
        .paciente { font-weight: 600; color: var(--navy); }

        /* Estado de la cita */
        .estado {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 999px;
            font-size: .85rem;
            font-weight: 600;
        }
        .estado.programada { background: #e1edf9; color: #2a5d96; }
        .estado.atendida   { background: #dff1e6; color: #226a3d; }
        .estado.cancelada  { background: #fbe4e1; color: #9c2f26; }

        /* Botón de acción */
        .btn-seguimiento {
            display: inline-block;
            background: var(--blue);
            color: #fff;
            text-decoration: none;
            padding: 8px 18px;
            border-radius: 999px;
            font-size: .9rem;
            font-weight: 600;
            white-space: nowrap;
        }
        .btn-seguimiento:hover { background: var(--blue-dark); }
        .btn-seguimiento:focus-visible { outline: 3px solid rgba(74, 134, 200, .45); outline-offset: 2px; }

        /* Cuando ya no se puede dar seguimiento */
        .etiqueta-seguimiento {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            background: #eaf4f4;
            color: var(--teal);
            font-size: .85rem;
            font-weight: 600;
            white-space: nowrap;
        }
        .sin-accion { color: var(--muted); }

        /* Sin citas */
        .vacio { padding: 48px 20px; text-align: center; color: var(--muted); }
        .vacio strong { display: block; color: var(--navy); font-size: 1.1rem; margin-bottom: 4px; }

        .volver {
            display: inline-block;
            margin-top: 24px;
            color: var(--muted);
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 999px;
        }
        .volver:hover { background: #fff; color: var(--navy); }

        @media (max-width: 760px) {
            .topbar { flex-wrap: wrap; padding: 12px 16px; gap: 12px; }
            .usuario { display: none; }
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
        <h1>Mis citas</h1>
        <p class="subtitulo">Revisa tus citas y programa el seguimiento de cada paciente.</p>

        <c:if test="${param.ok == '1'}">
            <div class="aviso ok">Seguimiento programado correctamente.</div>
        </c:if>
        <c:if test="${param.error == 'cita'}">
            <div class="aviso error">No se encontró esa cita o no pertenece a tu agenda.</div>
        </c:if>
        <c:if test="${param.error == 'fecha'}">
            <div class="aviso error">La fecha del seguimiento no puede ser anterior a hoy.</div>
        </c:if>
        <c:if test="${param.error == 'datos'}">
            <div class="aviso error">Faltan datos o tienen un formato incorrecto. Intenta de nuevo.</div>
        </c:if>
        <c:if test="${param.error == 'guardar'}">
            <div class="aviso error">No se pudo guardar el seguimiento. Intenta de nuevo.</div>
        </c:if>
        <c:if test="${param.error == 'horario'}">
            <div class="aviso error">Ya tienes una cita a esa fecha y hora. Elige otro horario.</div>
        </c:if>
        <c:if test="${param.error == 'cancelada'}">
            <div class="aviso error">No se puede dar seguimiento a una cita cancelada.</div>
        </c:if>
        <c:if test="${param.error == 'yaseguimiento'}">
            <div class="aviso error">Esa cita ya tiene un seguimiento programado.</div>
        </c:if>

        <div class="tarjeta">
            <c:choose>
                <c:when test="${empty citas}">
                    <div class="vacio">
                        <strong>No tienes citas todavía</strong>
                        Cuando recepción agende una cita contigo, aparecerá aquí.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="tabla-scroll">
                        <table>
                            <thead>
                                <tr>
                                    <th>Paciente</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    <th>Causa</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${citas}">
                                    <tr>
                                        <td class="paciente">${c.nombrePaciente}</td>
                                        <td>${c.fechaCita}</td>
                                        <td>${c.horaInicio}</td>
                                        <td>${c.causa}</td>
                                        <td><span class="estado ${c.estado}">${c.estado}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${c.estado == 'cancelada'}">
                                                    <span class="sin-accion">No disponible</span>
                                                </c:when>
                                                <c:when test="${c.tieneSeguimiento}">
                                                    <span class="etiqueta-seguimiento">Seguimiento programado</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="btn-seguimiento"
                                                       href="${pageContext.request.contextPath}/medico/seguimiento?id=${c.idCita}">
                                                        Dar seguimiento
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <a class="volver" href="${pageContext.request.contextPath}/medico/inicio.jsp">Volver al inicio</a>
    </main>
</body>
</html>
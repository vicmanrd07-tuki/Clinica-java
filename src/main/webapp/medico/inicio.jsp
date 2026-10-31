<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inicio | MedNova</title>
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
            min-height: 100vh;
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

        /* Bienvenida */
        main { max-width: 980px; margin: 56px auto 64px; padding: 0 20px; }
        .bienvenida {
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: #fff;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(36, 64, 107, .12);
        }
        .texto { padding: 56px 48px; }
        .texto h1 {
            margin: 0 0 12px;
            font-size: 2.2rem;
            line-height: 1.2;
            color: var(--navy);
        }
        .texto p { margin: 0 0 32px; color: var(--muted); max-width: 36ch; }

        .btn-principal {
            display: inline-block;
            background: var(--blue);
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 16px 36px;
            border-radius: 999px;
            transition: background .2s;
        }
        .btn-principal:hover { background: var(--blue-dark); }
        .btn-principal:focus-visible { outline: 3px solid rgba(74, 134, 200, .45); outline-offset: 3px; }

        /* Panel de color con la marca */
        .marca {
            background: var(--teal);
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            text-align: center;
        }
        .marca .logo { font-size: 2.6rem; font-weight: 700; letter-spacing: .06em; }
        .marca .logo span { color: #bfe3f7; }
        .marca .lema { margin-top: 10px; opacity: .9; font-size: 1rem; }

        @media (max-width: 760px) {
            .topbar { flex-wrap: wrap; padding: 12px 16px; gap: 12px; }
            .usuario { display: none; }
            .bienvenida { grid-template-columns: 1fr; }
            .texto { padding: 36px 24px; }
            .marca { order: -1; padding: 28px; }
        }
    </style>
</head>
<body>

    <header class="topbar">
        <a class="brand" href="${pageContext.request.contextPath}/medico/inicio.jsp">Med<span>Nova</span></a>
        <nav>
            <a class="activo" href="${pageContext.request.contextPath}/medico/inicio.jsp">Inicio</a>
            <a href="${pageContext.request.contextPath}/medico/citas">Citas</a>
        </nav>
        <span class="usuario">${sessionScope.usuario.nombre}</span>
        <a class="salir" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </header>

    <main>
        <section class="bienvenida">
            <div class="texto">
                <h1>Bienvenido, ${sessionScope.usuario.nombre}</h1>
                <p>Revisa tus citas y programa el seguimiento de tus pacientes.</p>
                <a class="btn-principal" href="${pageContext.request.contextPath}/medico/citas">Consultar citas</a>
            </div>
            <div class="marca">
                <div class="logo">Med<span>Nova</span></div>
                <div class="lema">Tu salud, nuestra prioridad</div>
            </div>
        </section>
    </main>
</body>
</html>
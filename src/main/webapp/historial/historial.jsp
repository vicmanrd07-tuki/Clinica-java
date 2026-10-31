<%-- 
    Document   : select
    Created on : 28/10/2026, 9:37:24p.m.
    Author     : Lenovo
--%>

<%@page contentType="Historiales de consultas pasadas" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="es">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Historial Médico</title>
      <style>
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
          font-family: Arial, sans-serif;
        }

        body {
          background-color: #f4f6f8;
          color: #333;
          padding: 20px;
        }

        .container {
          max-width: 1000px;
          margin: 0 auto;
          background: #ffffff;
          padding: 20px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h2 {
          margin-bottom: 15px;
          color: #2c3e50;
        }

        .search-box {
          margin-bottom: 15px;
        }

        .search-box input {
          width: 100%;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 4px;
          font-size: 14px;
        }

        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 10px;
        }

        th, td {
          border: 1px solid #ddd;
          padding: 12px;
          text-align: left;
        }

        th {
          background-color: #2c3e50;
          color: white;
        }

        tr:nth-child(even) {
          background-color: #f9f9f9;
        }

        tr:hover {
          background-color: #f1f1f1;
        }

        .badge {
          display: inline-block;
          padding: 4px 8px;
          background-color: #e3f2fd;
          color: #1565c0;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }
      </style>
    </head>
    <body>

      <div class="container">
        <h2>Historial Médico</h2>

        <div class="search-box">
          <input type="text" id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar por usuario, paciente, doctor, consulta...">
        </div>

        <table id="tablaHistorial">
          <thead>
            <tr>
              <th>Usuario</th>
              <th>No. Consulta</th>
              <th>Paciente</th>
              <th>Fecha</th>
              <th>Doctor</th>
              <th>Especialidad</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>mgarcia</td>
              <td><span class="badge">C-2026-001</span></td>
              <td>Juan Pérez</td>
              <td>15/01/2026</td>
              <td>Dr. Carlos Mendoza</td>
              <td>Cardiología</td>
            </tr>
            <tr>
              <td>mgarcia</td>
              <td><span class="badge">C-2026-002</span></td>
              <td>Ana Gómez</td>
              <td>03/05/2026</td>
              <td>Dra. Laura Torres</td>
              <td>Traumatología</td>
            </tr>
            <tr>
              <td>jlopez</td>
              <td><span class="badge">C-2026-003</span></td>
              <td>Roberto Silva</td>
              <td>10/08/2026</td>
              <td>Dr. Ricardo Morales</td>
              <td>Medicina General</td>
            </tr>
            <tr>
              <td>jlopez</td>
              <td><span class="badge">C-2026-004</span></td>
              <td>María Rodríguez</td>
              <td>22/10/2026</td>
              <td>Dra. Elena Vargas</td>
              <td>Medicina Interna</td>
            </tr>
          </tbody>
        </table>
      </div>

      <script>
        function filtrarTabla() {
          const input = document.getElementById("searchInput");
          const filter = input.value.toLowerCase();
          const table = document.getElementById("tablaHistorial");
          const tr = table.getElementsByTagName("tr");

          for (let i = 1; i < tr.length; i++) {
            let textRow = tr[i].textContent || tr[i].innerText;
            if (textRow.toLowerCase().indexOf(filter) > -1) {
              tr[i].style.display = "";
            } else {
              tr[i].style.display = "none";
            }
          }
        }
      </script>

    </body>
    </html>
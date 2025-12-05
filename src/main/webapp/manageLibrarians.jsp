<%@ page import="java.util.List, eLibrary.AdminLibrarianServlet.LibrarianRow" %>
<%
  List<LibrarianRow> libs = (List<LibrarianRow>) request.getAttribute("libs");
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Manage Librarians</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Modern Creative UI -->
<style>
    body {
        background: linear-gradient(135deg, #e3ecf7, #ffffff);
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }

    .page-container {
        max-width: 1100px;
        margin: auto;
        padding-top: 50px;
    }

    .header-card {
        backdrop-filter: blur(12px);
        background: rgba(255,255,255,0.7);
        border-radius: 18px;
        padding: 22px 30px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid rgba(255,255,255,0.4);
    }

    h3 {
        margin: 0;
        font-weight: 600;
        color: #2c3e50;
    }

    .table-card {
        margin-top: 25px;
        padding: 20px;
        background: rgba(255,255,255,0.8);
        border-radius: 18px;
        backdrop-filter: blur(10px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        border: 1px solid rgba(255,255,255,0.5);
    }

    table thead {
        background: #2c3e50;
        color: #ffffff;
        border-radius: 12px;
    }

    table tbody tr {
        transition: all 0.2s ease;
    }

    table tbody tr:hover {
        background: rgba(44, 62, 80, 0.06);
        transform: scale(1.005);
    }

    .btn-primary {
        background: #2c3e50;
        border-radius: 8px;
        border: none;
    }

    .btn-primary:hover {
        background: #1b2836;
    }

    .btn-danger {
        background: #d9534f;
        border-radius: 8px;
        border: none;
    }

    .btn-danger:hover {
        background: #b8423f;
    }

    .btn-success {
        background: #27ae60;
        border-radius: 8px;
        border: none;
    }

    .btn-success:hover {
        background: #1f8a4e;
    }

    .back-btn {
        margin-top: 20px;
        border-radius: 8px;
    }
</style>
</head>

<body>

<div class="page-container">

  <!-- Header Section -->
  <div class="header-card">
    <h3>Manage Librarians</h3>
    <a class="btn btn-success px-4" 
       href="${pageContext.request.contextPath}/admin/librarian?action=add">
      Add Librarian
    </a>
  </div>

  <!-- Table Section -->
  <div class="table-card">
    <table class="table table-hover table-bordered align-middle text-center">
      <thead>
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>Name</th>
          <th>Email</th>
          <th width="160px">Actions</th>
        </tr>
      </thead>

      <tbody>
      <% if (libs != null) {
           for (LibrarianRow l : libs) { %>
        <tr>
          <td><%= l.libId %></td>
          <td><%= l.username %></td>
          <td><%= l.name %></td>
          <td><%= l.email %></td>
          <td>
            <a class="btn btn-sm btn-primary px-3"
               href="${pageContext.request.contextPath}/admin/librarian?action=edit&libId=<%= l.libId %>">
              Edit
            </a>
            <a class="btn btn-sm btn-danger px-3"
               href="${pageContext.request.contextPath}/admin/librarian?action=delete&libId=<%= l.libId %>"
               onclick="return confirm('Are you sure you want to delete this librarian?');">
              Delete
            </a>
          </td>
        </tr>
      <% } } else { %>
        <tr>
          <td colspan="5" class="text-muted">No librarians found</td>
        </tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <a href="${pageContext.request.contextPath}/adminDashboard.jsp" 
     class="btn btn-secondary back-btn px-4">
    Back
  </a>

</div>

</body>
</html>

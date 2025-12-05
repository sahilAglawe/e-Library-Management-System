<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
  HttpSession s = request.getSession(false);
  if (s == null || s.getAttribute("librarianUser") == null) {
      response.sendRedirect("librarianLogin.jsp");
      return;
  }
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Librarian Dashboard</title>

<!-- Bootstrap + Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        background: #f5f7fa;
        font-family: "Segoe UI", sans-serif;
    }

    /* Sidebar */
    .sidebar {
        height: 100vh;
        width: 250px;
        background: #1f2633;
        color: #fff;
        position: fixed;
        top: 0;
        left: 0;
        padding-top: 30px;
        box-shadow: 0 0 10px rgba(0,0,0,0.4);
    }

    .sidebar h4 {
        text-align: center;
        margin-bottom: 25px;
        font-weight: 600;
    }

    .sidebar a {
        display: block;
        padding: 12px 20px;
        color: #cfd4da;
        text-decoration: none;
        font-size: 16px;
        margin: 5px 0;
        border-radius: 5px;
    }

    .sidebar a:hover {
        background: #2e3747;
        color: #fff;
    }

    .sidebar i { margin-right: 10px; }

    /* Main content */
    .main-content {
        margin-left: 260px;
        padding: 30px;
    }

    .card-box {
        padding: 25px;
        border-radius: 12px;
        background: #fff;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        transition: 0.2s;
    }

    .card-box:hover {
        transform: translateY(-4px);
    }
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Librarian Panel</h4>

    <a class="active" href="#">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>

    <a href="book?action=list">
        <i class="bi bi-book-half"></i> Manage Books
    </a>

    <a href="student?action=list">
        <i class="bi bi-people"></i> Manage Students
    </a>

    <a href="book?action=issueForm">
        <i class="bi bi-arrow-left-right"></i> Issue / Return
    </a>

    <a href="librarianLogout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h2 class="fw-bold">Welcome, <span class="text-primary"><%= s.getAttribute("librarianName") %></span></h2>
    <p class="text-muted">Manage daily library operations from here.</p>

    <div class="row g-4 mt-3">

        <div class="col-md-4">
            <a href="book?action=list" class="text-decoration-none text-dark">
                <div class="card-box">
                    <h4><i class="bi bi-book-half text-primary"></i> Books</h4>
                    <p>View & manage library books</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="student?action=list" class="text-decoration-none text-dark">
                <div class="card-box">
                    <h4><i class="bi bi-person-lines-fill text-success"></i> Students</h4>
                    <p>Manage student records</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="book?action=issueForm" class="text-decoration-none text-dark">
                <div class="card-box">
                    <h4><i class="bi bi-arrow-left-right text-warning"></i> Issue / Return</h4>
                    <p>Issue books & manage returns</p>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>

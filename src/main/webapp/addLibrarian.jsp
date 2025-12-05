<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add Librarian</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #eef2f3 0%, #dfe9f3 100%);
            font-family: "Inter", "Segoe UI", sans-serif;
        }

        .glass-card {
            max-width: 650px;
            margin: 60px auto;
            padding: 40px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.10);
        }

        .glass-card h3 {
            text-align: center;
            font-weight: 700;
            color: #2c3e50;
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
        }

        .form-control {
            height: 48px;
            border-radius: 10px;
        }

        .btn-lg {
            border-radius: 10px;
            font-size: 16px;
            padding: 12px 18px;
        }

        .btn-success {
            background: #27ae60;
            border: none;
        }

        .btn-success:hover {
            background: #219150;
        }

        .btn-secondary {
            background: #95a5a6;
            border: none;
        }

        .btn-secondary:hover {
            background: #7e8c8d;
        }

        .error-box {
            color: #e74c3c;
            font-weight: 600;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>

<body>

<div class="glass-card">
    <h3><i class="bi bi-person-plus-fill text-primary"></i> Add Librarian</h3>

    <form action="${pageContext.request.contextPath}/admin/librarian" method="post">
        <input type="hidden" name="action" value="create">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input class="form-control"
                   name="username"
                   placeholder="Enter username"
                   required
                   value="<%= (request.getAttribute("username") == null) ? "" : request.getAttribute("username") %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input class="form-control"
                   type="password"
                   name="password"
                   placeholder="Enter password"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input class="form-control"
                   name="name"
                   placeholder="Full name"
                   value="<%= (request.getAttribute("name") == null) ? "" : request.getAttribute("name") %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input class="form-control"
                   type="email"
                   name="email"
                   placeholder="Enter email"
                   value="<%= (request.getAttribute("email") == null) ? "" : request.getAttribute("email") %>">
        </div>

        <div class="d-flex justify-content-between mt-4">
            <button class="btn btn-success btn-lg">
                <i class="bi bi-check2-circle"></i> Add Librarian
            </button>

            <a href="${pageContext.request.contextPath}/admin/librarian?action=list"
               class="btn btn-secondary btn-lg">
                <i class="bi bi-card-list"></i> View List
            </a>
        </div>
    </form>

    <div class="error-box">
        <%= (request.getAttribute("error") == null) ? "" : request.getAttribute("error") %>
    </div>
</div>

</body>
</html>

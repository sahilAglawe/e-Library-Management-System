<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>E-Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            min-height: 100vh;
        }

        .page-title {
            font-weight: 700;
            font-size: 2.4rem;
            text-align: center;
            margin-bottom: 50px;
            color: #0a3d62;
        }

        .hero-card {
            background: #ffffffd9;
            backdrop-filter: blur(8px);
            border-radius: 22px;
            padding: 40px 25px;
            height: 360px;         /* Increased Height */
            box-shadow: 0 8px 22px rgba(0,0,0,0.08);
            transition: 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: center; /* Vertical center */
            align-items: center;     /* Horizontal center */
            text-align: center;
        }

        .hero-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }

        .icon-box {
            width: 80px; 
            height: 80px;
            border-radius: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 40px;
            margin-bottom: 18px;
        }

        .admin-icon {
            background: #e3f2fd;
            color: #0d6efd;
        }

        .lib-icon {
            background: #e8f5e9;
            color: #198754;
        }
    </style>
</head>

<body>

<div class="container py-5">

    <h1 class="page-title">📚 E-Library Management System</h1>

    <div class="row g-4 justify-content-center">

        <!-- ADMIN CARD -->
        <div class="col-md-5">
            <div class="hero-card">
                <div class="icon-box admin-icon">👨‍💼</div>
                <h3 class="mb-2 mt-1">Admin</h3>
                <p class="text-secondary px-3">
                    Manage librarians and system operations with privileged access.
                </p>
                <a href="adminLogin.jsp" class="btn btn-primary px-4 mt-2">Admin Login</a>
            </div>
        </div>

        <!-- LIBRARIAN CARD -->
        <div class="col-md-5">
            <div class="hero-card">
                <div class="icon-box lib-icon">📖</div>
                <h3 class="mb-2 mt-1">Librarian</h3>
                <p class="text-secondary px-3">
                    Handle books, maintain records, and manage student library activity.
                </p>
                <a href="librarianLogin.jsp" class="btn btn-success px-4 mt-2">Librarian Login</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>

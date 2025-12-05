<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Librarian Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        min-height: 100vh;
        background: linear-gradient(135deg, #e8f5e9, #ffffff);
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .login-card {
        width: 420px;
        padding: 35px 30px;
        border-radius: 22px;
        background: #ffffffd9;
        backdrop-filter: blur(10px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        animation: fadeIn 0.5s ease;
    }

    .login-card:hover {
        transform: translateY(-4px);
        transition: 0.3s ease;
        box-shadow: 0 14px 35px rgba(0,0,0,0.15);
    }

    .librarian-icon {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        background: #e8f5e9;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 45px;
        margin: auto;
        margin-bottom: 18px;
        color: #2e7d32;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

</head>

<body>

<div class="login-card">

    <div class="librarian-icon">📚</div>

    <h3 class="text-center mb-3">Librarian Login</h3>

    <form action="librarianLogin" method="post">
        <div class="mb-3">
            <input class="form-control form-control-lg"
                   name="username" placeholder="Enter Username" required>
        </div>

        <div class="mb-3">
            <input class="form-control form-control-lg"
                   name="password" type="password" placeholder="Enter Password" required>
        </div>

        <button class="btn btn-success w-100 btn-lg">Login</button>
    </form>

    <div class="text-danger text-center mt-3">
        <%= (request.getAttribute("error")==null)?"":request.getAttribute("error") %>
    </div>
</div>

</body>
</html>

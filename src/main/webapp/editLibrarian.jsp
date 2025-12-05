<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Edit Librarian</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <div class="container" style="max-width:700px;">
    <h3>Edit Librarian</h3>
    <form action="${pageContext.request.contextPath}/admin/librarian" method="post" class="w-50">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="libId" value="<%= request.getAttribute("libId") %>">

      <div class="mb-2"><input class="form-control" name="username" value="<%= request.getAttribute("username") %>" required></div>
      <div class="mb-2"><input class="form-control" name="password" value="<%= request.getAttribute("password") %>" required></div>
      <div class="mb-2"><input class="form-control" name="name" value="<%= request.getAttribute("name") %>"></div>
      <div class="mb-2"><input class="form-control" name="email" value="<%= request.getAttribute("email") %>"></div>
      <button class="btn btn-primary">Update</button>
      <a href="${pageContext.request.contextPath}/admin/librarian?action=list" class="btn btn-secondary ms-2">Cancel</a>
    </form>
  </div>
</body>
</html>

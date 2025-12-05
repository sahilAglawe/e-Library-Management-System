<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Edit Book</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <h3>Edit Book</h3>
  <form action="book" method="post" class="w-50">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="bookId" value="<%= request.getAttribute("bookId") %>">
    <div class="mb-2"><input class="form-control" name="bookName" value="<%= request.getAttribute("bookName") %>" required></div>
    <div class="mb-2"><input class="form-control" name="author" value="<%= request.getAttribute("author") %>" required></div>
    <div class="mb-2"><input class="form-control" name="publishedYear" value="<%= request.getAttribute("publishedYear") %>" type="number" required></div>
    <div class="mb-2"><input class="form-control" name="noOfCopies" value="<%= request.getAttribute("noOfCopies") %>" type="number" required></div>
    <button class="btn btn-primary">Update</button>
  </form>
</body>
</html>

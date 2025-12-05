<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Add Book</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <h3>Add Book</h3>
  <form action="book" method="post" class="w-50">
    <input type="hidden" name="action" value="create">
    <div class="mb-2"><input class="form-control" name="bookName" placeholder="Book Name" required></div>
    <div class="mb-2"><input class="form-control" name="author" placeholder="Author" required></div>
    <div class="mb-2"><input class="form-control" name="publishedYear" placeholder="Published Year" type="number" required></div>
    <div class="mb-2"><input class="form-control" name="noOfCopies" placeholder="No. of Copies" type="number" value="1" required></div>
    <button class="btn btn-success">Add</button>
  </form>
</body>
</html>

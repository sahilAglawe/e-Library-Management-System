<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Add Student</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <h3>Add Student</h3>
  <form action="student" method="post" class="w-50">
    <input type="hidden" name="action" value="create">
    <div class="mb-2"><input class="form-control" name="studName" placeholder="Student Name" required></div>
    <div class="mb-2"><input class="form-control" name="year" placeholder="Year (e.g., 2nd)" required></div>
    <button class="btn btn-success">Add</button>
  </form>
</body>
</html>

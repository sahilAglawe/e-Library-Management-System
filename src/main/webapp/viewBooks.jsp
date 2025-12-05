<%@ page import="java.util.List, eLibrary.BookServlet.BookRow" %>
<%
  List<BookRow> books = (List<BookRow>) request.getAttribute("books");
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Books</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<div class="container mt-4">

  <h2 class="mb-3">Books</h2>

  <a class="btn btn-success mb-3" href="book?action=addForm">Add Book</a>

  <table class="table table-bordered">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Author</th>
        <th>Year</th>
        <th>Copies</th>
        <th>Actions</th>
      </tr>
    </thead>

    <tbody>
    <% if (books != null) {
         for (BookRow b : books) { %>
          <tr>
            <td><%= b.bookId %></td>
            <td><%= b.bookName %></td>
            <td><%= b.author %></td>
            <td><%= b.year %></td>
            <td><%= b.copies %></td>
            <td>
              <a href="book?action=editForm&bookId=<%= b.bookId %>" class="btn btn-primary btn-sm">Edit</a>
              <a href="book?action=delete&bookId=<%= b.bookId %>" class="btn btn-danger btn-sm"
                 onclick="return confirm('Delete this book?')">Delete</a>
            </td>
          </tr>
    <% }
       } %>
    </tbody>
  </table>

</div>

</body>
</html>

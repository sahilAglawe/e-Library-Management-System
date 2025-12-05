<%@ page import="java.util.List, eLibrary.BookServlet.StudentRow, eLibrary.BookServlet.IssuedRow" %>
<%
  List<StudentRow> students = (List<StudentRow>) request.getAttribute("students");
  List<IssuedRow> issued = (List<IssuedRow>) request.getAttribute("issued");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Issue/Return</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <h3>Issue Book</h3>
  <div class="text-success"><%= (request.getAttribute("message")==null)?"":request.getAttribute("message") %></div>
  <div class="text-danger"><%= (request.getAttribute("error")==null)?"":request.getAttribute("error") %></div>

  <form action="book" method="post" class="w-50 mb-4">
    <input type="hidden" name="action" value="issue">
    <div class="mb-2"><input class="form-control" name="bookId" placeholder="Book ID" required></div>
    <div class="mb-2">
      <select name="studId" class="form-control" required>
        <option value="">Select student</option>
        <% if (students!=null) for (StudentRow s: students) { %>
          <option value="<%= s.studId %>"><%= s.studName %> (ID:<%= s.studId %>)</option>
        <% } %>
      </select>
    </div>
    <div class="mb-2"><label>Issue Date</label><input class="form-control" name="issueDate" type="date" required></div>
    <div class="mb-2"><label>Due Date</label><input class="form-control" name="returningDate" type="date" required></div>
    <button class="btn btn-success">Issue</button>
  </form>

  <hr>
  <h3>Return Book</h3>
  <form action="book" method="post" class="w-50 mb-3">
    <input type="hidden" name="action" value="return">
    <div class="mb-2">
      <select name="regId" class="form-control" required>
        <option value="">Select issued entry</option>
        <% if (issued!=null) for (IssuedRow r: issued) { %>
          <option value="<%= r.regId %>">Reg:<%= r.regId %> - <%= r.bookName %> to <%= r.studName %> (issued on <%= r.issueDate %>)</option>
        <% } %>
      </select>
    </div>
    <div class="mb-2"><label>Return Date</label><input class="form-control" name="returnDate" type="date" required></div>
    <button class="btn btn-warning">Return</button>
  </form>

  <a class="btn btn-secondary" href="librarianDashboard.jsp">Back</a>
</body>
</html>

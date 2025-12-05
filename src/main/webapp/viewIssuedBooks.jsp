<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, eLibrary.DBConnection" %>
<%
  class R { public int regId; public String bookName; public String studName; public Date issueDate; public Date dueDate; public String status;
    public R(int regId,String bookName,String studName,Date issueDate,Date dueDate,String status){this.regId=regId;this.bookName=bookName;this.studName=studName;this.issueDate=issueDate;this.dueDate=dueDate;this.status=status;}
  }
  List<R> data = new ArrayList<>();
  try (Connection con = DBConnection.getConnection();
       PreparedStatement ps = con.prepareStatement("SELECT regId, bookName, studName, issueDate, returningDate, status FROM libraryregister ORDER BY regId DESC");
       ResultSet rs = ps.executeQuery()) {
    while (rs.next()) {
      data.add(new R(rs.getInt("regId"), rs.getString("bookName"), rs.getString("studName"), rs.getDate("issueDate"), rs.getDate("returningDate"), rs.getString("status")));
    }
  } catch(Exception e){ e.printStackTrace(); }
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Issued Records</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
  <h3>Issued / Returned Records</h3>
  <table class="table table-bordered"><thead><tr><th>RegId</th><th>Book</th><th>Student</th><th>Issue</th><th>Due</th><th>Status</th></tr></thead>
    <tbody>
      <% for (R r : data) { %>
        <tr>
          <td><%= r.regId %></td>
          <td><%= r.bookName %></td>
          <td><%= r.studName %></td>
          <td><%= r.issueDate %></td>
          <td><%= r.dueDate %></td>
          <td><%= r.status %></td>
        </tr>
      <% } %>
    </tbody>
  </table>
  <a class="btn btn-secondary" href="librarianDashboard.jsp">Back</a>
</body>
</html>

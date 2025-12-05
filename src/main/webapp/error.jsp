<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Error</title>
</head>
<body>
  <h3>Something went wrong</h3>
  <pre><%= request.getAttribute("error") == null ? "Unknown error" : request.getAttribute("error") %></pre>
  <a href="index.jsp">Home</a>
</body>
</html>

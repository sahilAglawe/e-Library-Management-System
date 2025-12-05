package eLibrary;

import eLibrary.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/book")
public class BookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null || action.equals("list")) {
            // list books
            List<BookRow> books = new ArrayList<>();
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT bookId, bookName, author, publishedYear, NoOfCopies FROM book");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(new BookRow(
                            rs.getInt("bookId"),
                            rs.getString("bookName"),
                            rs.getString("author"),
                            rs.getInt("publishedYear"),
                            rs.getInt("NoOfCopies")
                    ));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("books", books);
            req.getRequestDispatcher("/viewBooks.jsp").forward(req, resp);
            return;
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/addBook.jsp").forward(req, resp);
            return;
        } else if (action.equals("edit")) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM book WHERE bookId=?")) {
                ps.setInt(1, bookId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        req.setAttribute("bookId", rs.getInt("bookId"));
                        req.setAttribute("bookName", rs.getString("bookName"));
                        req.setAttribute("author", rs.getString("author"));
                        req.setAttribute("publishedYear", rs.getInt("publishedYear"));
                        req.setAttribute("noOfCopies", rs.getInt("NoOfCopies"));
                        req.getRequestDispatcher("/editBook.jsp").forward(req, resp);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect("book?action=list");
            return;
        } else if (action.equals("delete")) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("DELETE FROM book WHERE bookId=?")) {
                ps.setInt(1, bookId);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect("book?action=list");
            return;
        } else if (action.equals("issueForm") || action.equals("returnForm")) {
            // prepare lists for issue/return view
            List<StudentRow> students = new ArrayList<>();
            List<IssuedRow> issued = new ArrayList<>();
            List<IssuedRow> returned = new ArrayList<>();

            try (Connection con = DBConnection.getConnection()) {
                // students
                try (PreparedStatement ps = con.prepareStatement("SELECT studId, studName FROM student");
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        students.add(new StudentRow(rs.getInt("studId"), rs.getString("studName")));
                    }
                }

                // currently issued entries (status = 'issued')
                try (PreparedStatement ps2 = con.prepareStatement(
                        "SELECT regId, bookId, bookName, studId, studName, issueDate, returningDate " +
                                "FROM libraryregister WHERE status='issued' ORDER BY issueDate DESC");
                     ResultSet rs2 = ps2.executeQuery()) {
                    while (rs2.next()) {
                        // returningDate -> dueDate
                        Date issueDate = rs2.getDate("issueDate");
                        Date dueDate = rs2.getDate("returningDate");
                        issued.add(new IssuedRow(
                                rs2.getInt("regId"),
                                rs2.getInt("bookId"),
                                rs2.getString("bookName"),
                                rs2.getInt("studId"),
                                rs2.getString("studName"),
                                issueDate,
                                dueDate,
                                null // returnDate is null for active issues
                        ));
                    }
                }

                // returned entries (status = 'returned'), include actual returnDate
                try (PreparedStatement ps3 = con.prepareStatement(
                        "SELECT regId, bookId, bookName, studId, studName, issueDate, returningDate, returnDate " +
                                "FROM libraryregister WHERE status='returned' ORDER BY returnDate DESC");
                     ResultSet rs3 = ps3.executeQuery()) {
                    while (rs3.next()) {
                        Date issueDate = rs3.getDate("issueDate");
                        Date dueDate = rs3.getDate("returningDate");
                        Date returnDate = rs3.getDate("returnDate");
                        returned.add(new IssuedRow(
                                rs3.getInt("regId"),
                                rs3.getInt("bookId"),
                                rs3.getString("bookName"),
                                rs3.getInt("studId"),
                                rs3.getString("studName"),
                                issueDate,
                                dueDate,
                                returnDate
                        ));
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            req.setAttribute("students", students);
            req.setAttribute("issued", issued);
            req.setAttribute("returned", returned);
            req.getRequestDispatcher("/issueReturn.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect("book?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            String bookName = req.getParameter("bookName");
            String author = req.getParameter("author");
            int year = Integer.parseInt(req.getParameter("publishedYear"));
            int copies = Integer.parseInt(req.getParameter("noOfCopies"));
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("INSERT INTO book (bookName, author, publishedYear, NoOfCopies) VALUES (?,?,?,?)")) {
                ps.setString(1, bookName);
                ps.setString(2, author);
                ps.setInt(3, year);
                ps.setInt(4, copies);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect("book?action=list");
            return;
        } else if ("update".equals(action)) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            String bookName = req.getParameter("bookName");
            String author = req.getParameter("author");
            int year = Integer.parseInt(req.getParameter("publishedYear"));
            int copies = Integer.parseInt(req.getParameter("noOfCopies"));
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("UPDATE book SET bookName=?, author=?, publishedYear=?, NoOfCopies=? WHERE bookId=?")) {
                ps.setString(1, bookName);
                ps.setString(2, author);
                ps.setInt(3, year);
                ps.setInt(4, copies);
                ps.setInt(5, bookId);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect("book?action=list");
            return;
        } else if ("issue".equals(action)) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            int studId = Integer.parseInt(req.getParameter("studId"));
            Date issueDate = Date.valueOf(req.getParameter("issueDate"));
            Date dueDate = Date.valueOf(req.getParameter("returningDate"));
            String message = null, error = null;
            Connection con = null;
            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false);

                // 1) lock and check book copies
                try (PreparedStatement ps = con.prepareStatement("SELECT NoOfCopies, bookName, author FROM book WHERE bookId=? FOR UPDATE")) {
                    ps.setInt(1, bookId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) throw new SQLException("Book not found");
                        int copies = rs.getInt("NoOfCopies");
                        String bookName = rs.getString("bookName");
                        String author = rs.getString("author");
                        if (copies <= 0) throw new SQLException("No copies available");

                        // 2) lock and check student count
                        try (PreparedStatement ps2 = con.prepareStatement("SELECT noOfBooksIssued, studName, year FROM student WHERE studId=? FOR UPDATE")) {
                            ps2.setInt(1, studId);
                            try (ResultSet rs2 = ps2.executeQuery()) {
                                if (!rs2.next()) throw new SQLException("Student not found");
                                int issued = rs2.getInt("noOfBooksIssued");
                                String studName = rs2.getString("studName");
                                String year = rs2.getString("year");
                                if (issued >= 4) throw new SQLException("Student already has 4 books");

                                // decrement book copies
                                try (PreparedStatement ps3 = con.prepareStatement("UPDATE book SET NoOfCopies=NoOfCopies-1 WHERE bookId=?")) {
                                    ps3.setInt(1, bookId);
                                    ps3.executeUpdate();
                                }
                                // increment student's count
                                try (PreparedStatement ps4 = con.prepareStatement("UPDATE student SET noOfBooksIssued=noOfBooksIssued+1 WHERE studId=?")) {
                                    ps4.setInt(1, studId);
                                    ps4.executeUpdate();
                                }
                                // insert into register
                                try (PreparedStatement ps5 = con.prepareStatement("INSERT INTO libraryregister (bookId, bookName, author, issueDate, returningDate, studId, studName, year, status) VALUES (?,?,?,?,?,?,?,?,?)")) {
                                    ps5.setInt(1, bookId);
                                    ps5.setString(2, bookName);
                                    ps5.setString(3, author);
                                    ps5.setDate(4, issueDate);
                                    ps5.setDate(5, dueDate);
                                    ps5.setInt(6, studId);
                                    ps5.setString(7, studName);
                                    ps5.setString(8, year);
                                    ps5.setString(9, "issued");
                                    ps5.executeUpdate();
                                }
                                con.commit();
                                message = "Book issued successfully.";
                            }
                        }
                    }
                }
            } catch (Exception ex) {
                try { if (con != null) con.rollback(); } catch (Exception ignore) {}
                error = ex.getMessage();
                ex.printStackTrace();
            } finally {
                try { if (con != null) con.setAutoCommit(true); if (con != null) con.close(); } catch (Exception ignore) {}
            }
            if (error != null) req.setAttribute("error", error);
            if (message != null) req.setAttribute("message", message);
            // refresh issue/return form with lists
            doGet(req, resp);
            return;
        } else if ("return".equals(action)) {
            int regId = Integer.parseInt(req.getParameter("regId"));
            Date returnDate = Date.valueOf(req.getParameter("returnDate"));
            String message = null, error = null;
            Connection con = null;
            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false);
                // lock register
                try (PreparedStatement ps = con.prepareStatement("SELECT bookId, studId, status FROM libraryregister WHERE regId=? FOR UPDATE")) {
                    ps.setInt(1, regId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) throw new SQLException("Issue record not found");
                        String status = rs.getString("status");
                        if (!"issued".equalsIgnoreCase(status)) throw new SQLException("Already returned or invalid status");
                        int bookId = rs.getInt("bookId");
                        int studId = rs.getInt("studId");

                        // update register
                        try (PreparedStatement up = con.prepareStatement("UPDATE libraryregister SET returnDate=?, status='returned' WHERE regId=?")) {
                            up.setDate(1, returnDate); up.setInt(2, regId); up.executeUpdate();
                        }
                        // increment book copies
                        try (PreparedStatement up2 = con.prepareStatement("UPDATE book SET NoOfCopies=NoOfCopies+1 WHERE bookId=?")) {
                            up2.setInt(1, bookId); up2.executeUpdate();
                        }
                        // decrement student issued count (safeguard >=0)
                        try (PreparedStatement up3 = con.prepareStatement("UPDATE student SET noOfBooksIssued = GREATEST(0, noOfBooksIssued-1) WHERE studId=?")) {
                            up3.setInt(1, studId); up3.executeUpdate();
                        }
                        con.commit();
                        message = "Book returned successfully.";
                    }
                }
            } catch (Exception ex) {
                try { if (con != null) con.rollback(); } catch (Exception ignore) {}
                error = ex.getMessage();
                ex.printStackTrace();
            } finally {
                try { if (con != null) con.setAutoCommit(true); if (con != null) con.close(); } catch (Exception ignore) {}
            }
            if (error != null) req.setAttribute("error", error);
            if (message != null) req.setAttribute("message", message);
            doGet(req, resp);
            return;
        }

        resp.sendRedirect("book?action=list");
    }

    // helper classes for passing to JSP
    public static class BookRow {
        public int bookId; public String bookName; public String author; public int year; public int copies;
        public BookRow(int id, String name, String author, int year, int copies) { this.bookId=id;this.bookName=name;this.author=author;this.year=year;this.copies=copies;}
    }
    public static class StudentRow { public int studId; public String studName; public StudentRow(int id,String name){this.studId=id;this.studName=name;} }

    public static class IssuedRow {
        public int regId; public int bookId; public String bookName; public int studId; public String studName; public Date issueDate; public Date dueDate; public Date returnDate;
        public IssuedRow(int regId,int bookId,String bookName,int studId,String studName, Date issueDate, Date dueDate, Date returnDate){
            this.regId=regId;this.bookId=bookId;this.bookName=bookName;this.studId=studId;this.studName=studName;this.issueDate=issueDate;this.dueDate=dueDate;this.returnDate=returnDate;
        }
    }
}

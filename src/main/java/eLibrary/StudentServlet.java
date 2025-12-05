package eLibrary;

import eLibrary.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.equals("list")) {
            List<StudentRow> students = new ArrayList<>();
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT studId, studName, year, noOfBooksIssued FROM student");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) students.add(new StudentRow(rs.getInt("studId"), rs.getString("studName"), rs.getString("year"), rs.getInt("noOfBooksIssued")));
            } catch (Exception e) { e.printStackTrace(); }
            req.setAttribute("students", students);
            req.getRequestDispatcher("/viewStudents.jsp").forward(req, resp);
            return;
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/addStudent.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("student?action=list");
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            String studName = req.getParameter("studName");
            String year = req.getParameter("year");
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("INSERT INTO student (studName, year, noOfBooksIssued) VALUES (?,?,0)")) {
                ps.setString(1, studName);
                ps.setString(2, year);
                ps.executeUpdate();
            } catch (Exception e) { e.printStackTrace(); }
            resp.sendRedirect("student?action=list");
            return;
        }
        resp.sendRedirect("student?action=list");
    }

    public static class StudentRow { public int studId; public String studName; public String year; public int noOfBooks; public StudentRow(int id,String name,String year,int noOfBooks){this.studId=id;this.studName=name;this.year=year;this.noOfBooks=noOfBooks;} }
}
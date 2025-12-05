package eLibrary;

import eLibrary.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/librarianLogin")
public class LibrarianLoginServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT libId, name FROM librarian WHERE username=? AND password=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = req.getSession();
                        session.setAttribute("librarianUser", username);
                        session.setAttribute("librarianName", rs.getString("name"));
                        resp.sendRedirect("librarianDashboard.jsp");
                        return;
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }

        req.setAttribute("error", "Invalid librarian credentials");
        req.getRequestDispatcher("librarianLogin.jsp").forward(req, resp);
    }
}
package eLibrary;

import eLibrary.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT adminId FROM admin WHERE username=? AND password=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = req.getSession();
                        session.setAttribute("adminUser", username);
                        resp.sendRedirect("adminDashboard.jsp");
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.setAttribute("error", "Invalid admin credentials");
        req.getRequestDispatcher("adminLogin.jsp").forward(req, resp);
    }
}
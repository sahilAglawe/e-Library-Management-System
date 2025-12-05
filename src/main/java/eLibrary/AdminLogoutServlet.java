package eLibrary;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/adminLogout")
public class AdminLogoutServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s != null) s.invalidate();
        resp.sendRedirect("index.jsp");
    }
}
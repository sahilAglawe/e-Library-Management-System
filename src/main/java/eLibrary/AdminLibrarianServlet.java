package eLibrary;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/librarian")
public class AdminLibrarianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.equals("list")) {
            listLibrarians(req, resp);
            return;
        }

        if ("add".equals(action)) {
            
            req.getRequestDispatcher("/addLibrarian.jsp").forward(req, resp);
            return;
        }

        if ("edit".equals(action)) {
            String idS = req.getParameter("libId");
            if (idS == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
                return;
            }
            int libId = Integer.parseInt(idS);
            showEditForm(libId, req, resp);
            return;
        }

        if ("delete".equals(action)) {
            String idS = req.getParameter("libId");
            if (idS != null) {
                int libId = Integer.parseInt(idS);
                deleteLibrarian(libId);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
            return;
        }

        
        resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
    }

  
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            createLibrarian(req, resp);
            return;
        } else if ("update".equals(action)) {
            updateLibrarian(req, resp);
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
    }

   

    private void listLibrarians(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<LibrarianRow> list = new ArrayList<>();
        String sql = "SELECT libId, username, name, email FROM librarian ORDER BY libId DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new LibrarianRow(rs.getInt("libId"), rs.getString("username"), rs.getString("name"), rs.getString("email")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error loading librarians: " + e.getMessage());
        }
        req.setAttribute("libs", list);
        req.getRequestDispatcher("/manageLibrarians.jsp").forward(req, resp);
    }

    private void showEditForm(int libId, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sql = "SELECT libId, username, password, name, email FROM librarian WHERE libId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, libId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    req.setAttribute("libId", rs.getInt("libId"));
                    req.setAttribute("username", rs.getString("username"));
                    req.setAttribute("password", rs.getString("password"));
                    req.setAttribute("name", rs.getString("name"));
                    req.setAttribute("email", rs.getString("email"));
                    req.getRequestDispatcher("/editLibrarian.jsp").forward(req, resp);
                    return;
                } else {
                    req.setAttribute("error", "Librarian not found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error fetching librarian: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
    }

    private void deleteLibrarian(int libId) {
        String sql = "DELETE FROM librarian WHERE libId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, libId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
           
        }
    }

    private void createLibrarian(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        String sql = "INSERT INTO librarian (username, password, name, email) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, name);
            ps.setString(4, email);
            ps.executeUpdate();
           
            resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
            return;
        } catch (SQLIntegrityConstraintViolationException ex) {
            
            req.setAttribute("error", "Username already exists");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error adding librarian: " + e.getMessage());
        }
  
        req.setAttribute("username", username);
        req.setAttribute("name", name);
        req.setAttribute("email", email);
        req.getRequestDispatcher("/addLibrarian.jsp").forward(req, resp);
    }

    private void updateLibrarian(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String libIdS = req.getParameter("libId");
        if (libIdS == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
            return;
        }
        int libId = Integer.parseInt(libIdS);
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        String sql = "UPDATE librarian SET username=?, password=?, name=?, email=? WHERE libId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, name);
            ps.setString(4, email);
            ps.setInt(5, libId);
            ps.executeUpdate();
            resp.sendRedirect(req.getContextPath() + "/admin/librarian?action=list");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error updating librarian: " + e.getMessage());
            // keep submitted values for the edit form
            req.setAttribute("libId", libId);
            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/editLibrarian.jsp").forward(req, resp);
        }
    }

    public static class LibrarianRow {
        public int libId;
        public String username;
        public String name;
        public String email;

        public LibrarianRow(int libId, String username, String name, String email) {
            this.libId = libId;
            this.username = username;
            this.name = name;
            this.email = email;
        }
    }
}

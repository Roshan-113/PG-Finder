package com.pgfinder.servlet.owner;

import com.pgfinder.config.DatabaseConfig;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/owner/documents")
@MultipartConfig(maxFileSize = 10485760) // 10MB
public class OwnerDocumentsServlet extends HttpServlet {
    private Gson gson;
    private static final String UPLOAD_DIR = "uploads/owner-documents";
    
    @Override
    public void init() {
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        List<Map<String, Object>> documents = getOwnerDocuments(ownerId);
        
        request.setAttribute("documents", documents);
        request.setAttribute("pageTitle", "Documents");
        request.setAttribute("currentPage", "documents");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/documents.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (session == null || session.getAttribute("userId") == null) {
                result.put("success", false);
                result.put("message", "Please login first");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            int ownerId = (int) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            System.out.println("Documents - Action: " + action + ", Owner: " + ownerId);
            
            if ("upload".equals(action)) {
                String documentType = request.getParameter("documentType");
                
                if (documentType == null || documentType.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Please select document type");
                    response.getWriter().write(gson.toJson(result));
                    return;
                }
                
                Part filePart = request.getPart("document");
                if (filePart == null || filePart.getSize() == 0) {
                    result.put("success", false);
                    result.put("message", "Please select a document file");
                    response.getWriter().write(gson.toJson(result));
                    return;
                }
                
                System.out.println("Uploading document type: " + documentType + ", size: " + filePart.getSize());
                
                // Get file extension
                String fileName = filePart.getSubmittedFileName();
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                
                // Validate file type
                if (!isValidDocumentType(fileExtension)) {
                    result.put("success", false);
                    result.put("message", "Only PDF, JPG, PNG files are allowed");
                    response.getWriter().write(gson.toJson(result));
                    return;
                }
                
                // Generate unique filename
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Create upload directory
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                    System.out.println("Created upload directory: " + uploadPath);
                }
                
                // Save file
                Path filePath = Paths.get(uploadPath, uniqueFileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("File saved to: " + filePath);
                }
                
                // Generate URL
                String documentUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + uniqueFileName;
                
                // Save to database
                boolean saved = saveDocumentToDatabase(ownerId, documentType, documentUrl);
                
                if (saved) {
                    result.put("success", true);
                    result.put("message", "Document uploaded successfully");
                    System.out.println("Document saved to database");
                } else {
                    Files.deleteIfExists(filePath);
                    result.put("success", false);
                    result.put("message", "Failed to save document to database");
                }
                
            } else if ("delete".equals(action)) {
                int documentId = Integer.parseInt(request.getParameter("documentId"));
                
                String documentUrl = getDocumentUrl(documentId, ownerId);
                if (documentUrl != null) {
                    boolean deleted = deleteDocumentFromDatabase(documentId, ownerId);
                    if (deleted) {
                        // Try to delete physical file
                        try {
                            String fileName = documentUrl.substring(documentUrl.lastIndexOf("/") + 1);
                            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                            Path filePath = Paths.get(uploadPath, fileName);
                            Files.deleteIfExists(filePath);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        
                        result.put("success", true);
                        result.put("message", "Document deleted successfully");
                    } else {
                        result.put("success", false);
                        result.put("message", "Failed to delete document");
                    }
                } else {
                    result.put("success", false);
                    result.put("message", "Document not found");
                }
                
            } else {
                result.put("success", false);
                result.put("message", "Invalid action");
            }
        } catch (Exception e) {
            System.err.println("Error in documents: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    private boolean isValidDocumentType(String extension) {
        return extension.equalsIgnoreCase(".pdf") || 
               extension.equalsIgnoreCase(".jpg") || 
               extension.equalsIgnoreCase(".jpeg") || 
               extension.equalsIgnoreCase(".png");
    }
    
    private List<Map<String, Object>> getOwnerDocuments(int ownerId) {
        List<Map<String, Object>> documents = new ArrayList<>();
        String sql = "SELECT * FROM owner_documents WHERE owner_id = ? ORDER BY uploaded_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> doc = new HashMap<>();
                doc.put("documentId", rs.getInt("document_id"));
                doc.put("documentType", rs.getString("document_type"));
                doc.put("documentUrl", rs.getString("document_url"));
                doc.put("verificationStatus", rs.getString("verification_status"));
                doc.put("uploadedAt", rs.getTimestamp("uploaded_at"));
                documents.add(doc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return documents;
    }
    
    private boolean saveDocumentToDatabase(int ownerId, String documentType, String documentUrl) {
        String sql = "INSERT INTO owner_documents (owner_id, document_type, document_url, verification_status) " +
                    "VALUES (?, ?, ?, 'pending')";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            pstmt.setString(2, documentType);
            pstmt.setString(3, documentUrl);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error saving document: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    private String getDocumentUrl(int documentId, int ownerId) {
        String sql = "SELECT document_url FROM owner_documents WHERE document_id = ? AND owner_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, documentId);
            pstmt.setInt(2, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("document_url");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private boolean deleteDocumentFromDatabase(int documentId, int ownerId) {
        String sql = "DELETE FROM owner_documents WHERE document_id = ? AND owner_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, documentId);
            pstmt.setInt(2, ownerId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

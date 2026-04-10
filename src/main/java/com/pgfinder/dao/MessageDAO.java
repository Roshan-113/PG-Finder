package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class MessageDAO {
    
    // Get all conversations for a user
    public List<Map<String, Object>> getConversations(int userId) {
        List<Map<String, Object>> conversations = new ArrayList<>();
        String sql = "SELECT DISTINCT " +
                    "CASE WHEN m.sender_id = ? THEN m.receiver_id ELSE m.sender_id END as other_user_id, " +
                    "u.name as other_user_name, " +
                    "u.user_type, " +
                    "l.title as listing_title, " +
                    "(SELECT message_text FROM messages WHERE " +
                    "(sender_id = ? AND receiver_id = other_user_id) OR " +
                    "(sender_id = other_user_id AND receiver_id = ?) " +
                    "ORDER BY created_at DESC LIMIT 1) as last_message, " +
                    "(SELECT created_at FROM messages WHERE " +
                    "(sender_id = ? AND receiver_id = other_user_id) OR " +
                    "(sender_id = other_user_id AND receiver_id = ?) " +
                    "ORDER BY created_at DESC LIMIT 1) as last_message_time, " +
                    "(SELECT COUNT(*) FROM messages WHERE " +
                    "sender_id = other_user_id AND receiver_id = ? AND is_read = FALSE) as unread_count " +
                    "FROM messages m " +
                    "JOIN users u ON u.user_id = CASE WHEN m.sender_id = ? THEN m.receiver_id ELSE m.sender_id END " +
                    "LEFT JOIN pg_listings l ON m.listing_id = l.listing_id " +
                    "WHERE m.sender_id = ? OR m.receiver_id = ? " +
                    "ORDER BY last_message_time DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, userId);
            pstmt.setInt(4, userId);
            pstmt.setInt(5, userId);
            pstmt.setInt(6, userId);
            pstmt.setInt(7, userId);
            pstmt.setInt(8, userId);
            pstmt.setInt(9, userId);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> conv = new HashMap<>();
                conv.put("otherUserId", rs.getInt("other_user_id"));
                conv.put("otherUserName", rs.getString("other_user_name"));
                conv.put("userType", rs.getString("user_type"));
                conv.put("listingTitle", rs.getString("listing_title"));
                conv.put("lastMessage", rs.getString("last_message"));
                conv.put("lastMessageTime", rs.getTimestamp("last_message_time"));
                conv.put("unreadCount", rs.getInt("unread_count"));
                conversations.add(conv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conversations;
    }
    
    // Get messages between two users
    public List<Message> getMessagesBetweenUsers(int userId1, int userId2) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT m.*, " +
                    "s.name as sender_name, " +
                    "r.name as receiver_name, " +
                    "l.title as listing_title " +
                    "FROM messages m " +
                    "JOIN users s ON m.sender_id = s.user_id " +
                    "JOIN users r ON m.receiver_id = r.user_id " +
                    "LEFT JOIN pg_listings l ON m.listing_id = l.listing_id " +
                    "WHERE (m.sender_id = ? AND m.receiver_id = ?) " +
                    "OR (m.sender_id = ? AND m.receiver_id = ?) " +
                    "ORDER BY m.created_at ASC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId1);
            pstmt.setInt(2, userId2);
            pstmt.setInt(3, userId2);
            pstmt.setInt(4, userId1);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                messages.add(extractMessageFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
    
    // Send a message
    public boolean sendMessage(Message message) {
        String sql = "INSERT INTO messages (sender_id, receiver_id, listing_id, message_text) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, message.getSenderId());
            pstmt.setInt(2, message.getReceiverId());
            if (message.getListingId() != null) {
                pstmt.setInt(3, message.getListingId());
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            pstmt.setString(4, message.getMessageText());
            
            int affected = pstmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    message.setMessageId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Mark messages as read
    public boolean markAsRead(int senderId, int receiverId) {
        String sql = "UPDATE messages SET is_read = TRUE " +
                    "WHERE sender_id = ? AND receiver_id = ? AND is_read = FALSE";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, senderId);
            pstmt.setInt(2, receiverId);
            return pstmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get unread message count
    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM messages WHERE receiver_id = ? AND is_read = FALSE";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private Message extractMessageFromResultSet(ResultSet rs) throws SQLException {
        Message message = new Message();
        message.setMessageId(rs.getInt("message_id"));
        message.setSenderId(rs.getInt("sender_id"));
        message.setReceiverId(rs.getInt("receiver_id"));
        
        int listingId = rs.getInt("listing_id");
        message.setListingId(rs.wasNull() ? null : listingId);
        
        message.setMessageText(rs.getString("message_text"));
        message.setRead(rs.getBoolean("is_read"));
        message.setCreatedAt(rs.getTimestamp("created_at"));
        message.setSenderName(rs.getString("sender_name"));
        message.setReceiverName(rs.getString("receiver_name"));
        message.setListingTitle(rs.getString("listing_title"));
        return message;
    }
}

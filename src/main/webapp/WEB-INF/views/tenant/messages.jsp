<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="messages-container">
    <div class="messages-header">
        <h1>Messages</h1>
        <div class="header-actions">
            <button class="btn-icon" onclick="refreshConversations()">
                <i class="fas fa-sync-alt"></i>
            </button>
        </div>
    </div>

    <div class="messages-layout">
        <!-- Conversations Sidebar -->
        <div class="conversations-sidebar">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search conversations..." onkeyup="searchConversations()">
            </div>
            
            <div id="conversationsList" class="conversations-list">
                <c:choose>
                    <c:when test="${not empty conversations}">
                        <c:forEach var="conv" items="${conversations}">
                            <div class="conversation-item" data-user-id="${conv.otherUserId}" onclick="selectConversation(${conv.otherUserId}, '${conv.otherUserName}', '${conv.userType}')">
                                <div class="conv-avatar">
                                    <c:choose>
                                        <c:when test="${conv.userType == 'owner'}">
                                            <i class="fas fa-home"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="conv-content">
                                    <div class="conv-header">
                                        <h4>${conv.otherUserName}</h4>
                                        <span class="conv-time">
                                            <fmt:formatDate value="${conv.lastMessageTime}" pattern="HH:mm"/>
                                        </span>
                                    </div>
                                    <p class="conv-preview">${conv.lastMessage}</p>
                                    <c:if test="${not empty conv.listingTitle}">
                                        <span class="conv-listing"><i class="fas fa-building"></i> ${conv.listingTitle}</span>
                                    </c:if>
                                </div>
                                <c:if test="${conv.unreadCount > 0}">
                                    <span class="unread-badge">${conv.unreadCount}</span>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-comments"></i>
                            <p>No conversations yet</p>
                            <small>Start messaging PG owners</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Chat Area -->
        <div class="chat-area" id="chatArea">
            <div class="empty-chat">
                <i class="fas fa-comment-dots"></i>
                <h3>Select a conversation</h3>
                <p>Choose a conversation from the left to start messaging</p>
            </div>
        </div>
    </div>
</div>

<style>
.messages-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

.messages-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.messages-header h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
    color: #111827;
}

.header-actions {
    display: flex;
    gap: 0.5rem;
}

.btn-icon {
    width: 2.5rem;
    height: 2.5rem;
    border: none;
    background: white;
    border-radius: 0.5rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #6b7280;
    transition: all 0.2s;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.btn-icon:hover {
    background: #f3f4f6;
    color: #2563eb;
}

.messages-layout {
    display: grid;
    grid-template-columns: 380px 1fr;
    gap: 1.5rem;
    height: calc(100vh - 200px);
    min-height: 600px;
}

.conversations-sidebar {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.search-box {
    padding: 1rem;
    border-bottom: 1px solid #e5e7eb;
    position: relative;
}

.search-box i {
    position: absolute;
    left: 1.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: #9ca3af;
}

.search-box input {
    width: 100%;
    padding: 0.75rem 0.75rem 0.75rem 2.5rem;
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    outline: none;
    transition: border-color 0.2s;
}

.search-box input:focus {
    border-color: #2563eb;
}

.conversations-list {
    flex: 1;
    overflow-y: auto;
}

.conversation-item {
    padding: 1rem;
    border-bottom: 1px solid #f3f4f6;
    cursor: pointer;
    transition: background 0.2s;
    display: flex;
    gap: 0.75rem;
    position: relative;
}

.conversation-item:hover {
    background: #f9fafb;
}

.conversation-item.active {
    background: #eff6ff;
    border-left: 3px solid #2563eb;
}

.conv-avatar {
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.25rem;
    flex-shrink: 0;
}

.conv-content {
    flex: 1;
    min-width: 0;
}

.conv-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.25rem;
}

.conv-header h4 {
    margin: 0;
    font-size: 0.9375rem;
    font-weight: 600;
    color: #111827;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.conv-time {
    font-size: 0.75rem;
    color: #6b7280;
    flex-shrink: 0;
    margin-left: 0.5rem;
}

.conv-preview {
    margin: 0;
    font-size: 0.875rem;
    color: #6b7280;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.conv-listing {
    display: inline-block;
    margin-top: 0.25rem;
    font-size: 0.75rem;
    color: #2563eb;
    background: #eff6ff;
    padding: 0.125rem 0.5rem;
    border-radius: 0.25rem;
}

.unread-badge {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: #2563eb;
    color: white;
    font-size: 0.75rem;
    font-weight: 600;
    padding: 0.125rem 0.5rem;
    border-radius: 9999px;
    min-width: 1.25rem;
    text-align: center;
}

.chat-area {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.empty-chat {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #9ca3af;
}

.empty-chat i {
    font-size: 4rem;
    margin-bottom: 1rem;
}

.empty-chat h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.25rem;
    color: #6b7280;
}

.empty-chat p {
    margin: 0;
    font-size: 0.875rem;
}

.empty-state {
    padding: 3rem 1rem;
    text-align: center;
    color: #9ca3af;
}

.empty-state i {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.empty-state p {
    margin: 0.5rem 0;
    font-size: 1rem;
    color: #6b7280;
}

.empty-state small {
    font-size: 0.875rem;
}

.chat-header {
    padding: 1rem 1.5rem;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.chat-user-info {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.chat-avatar {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1rem;
}

.chat-user-details h3 {
    margin: 0;
    font-size: 1rem;
    font-weight: 600;
    color: #111827;
}

.chat-user-details p {
    margin: 0;
    font-size: 0.75rem;
    color: #10b981;
}

.chat-actions {
    display: flex;
    gap: 0.5rem;
}

.messages-area {
    flex: 1;
    overflow-y: auto;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.message-group {
    display: flex;
    gap: 0.75rem;
}

.message-group.sent {
    justify-content: flex-end;
}

.message-avatar {
    width: 2rem;
    height: 2rem;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 0.875rem;
    flex-shrink: 0;
}

.message-content {
    max-width: 60%;
}

.message-bubble {
    padding: 0.75rem 1rem;
    border-radius: 1rem;
    font-size: 0.875rem;
    line-height: 1.5;
    word-wrap: break-word;
}

.message-group.received .message-bubble {
    background: #f3f4f6;
    color: #111827;
    border-bottom-left-radius: 0.25rem;
}

.message-group.sent .message-bubble {
    background: #2563eb;
    color: white;
    border-bottom-right-radius: 0.25rem;
}

.message-time {
    font-size: 0.75rem;
    color: #9ca3af;
    margin-top: 0.25rem;
}

.message-group.sent .message-time {
    text-align: right;
}

.message-input-area {
    padding: 1rem 1.5rem;
    border-top: 1px solid #e5e7eb;
    display: flex;
    gap: 0.75rem;
    align-items: center;
}

.message-input-area input {
    flex: 1;
    padding: 0.75rem 1rem;
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    outline: none;
    transition: border-color 0.2s;
}

.message-input-area input:focus {
    border-color: #2563eb;
}

.btn-send {
    padding: 0.75rem 1.5rem;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-send:hover {
    background: #1d4ed8;
}

.btn-send:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}
</style>

<script>
let currentUserId = null;
let currentUserName = '';
let currentUserType = '';
let messageCheckInterval = null;

// Auto-open conversation if coming from roommate finder or PG details
window.addEventListener('DOMContentLoaded', function() {
    const openRoommateId = '${openRoommateId}';
    const openRoommateName = '${openRoommateName}';
    const openListingId = '${openListingId}';
    
    if (openRoommateId && openRoommateName && openRoommateId !== '') {
        const existingConv = document.querySelector('.conversation-item[data-user-id="' + openRoommateId + '"]');
        if (existingConv) {
            existingConv.click();
        } else {
            selectConversation(parseInt(openRoommateId), decodeURIComponent(openRoommateName), 'owner');
            // If coming from a listing, pre-fill a greeting
            if (openListingId && openListingId !== '') {
                setTimeout(() => {
                    const input = document.getElementById('messageInput');
                    if (input) input.focus();
                }, 300);
            }
        }
    }
});

function selectConversation(userId, userName, userType) {
    currentUserId = userId;
    currentUserName = userName;
    currentUserType = userType;
    
    // Update active state
    document.querySelectorAll('.conversation-item').forEach(item => {
        item.classList.remove('active');
    });
    
    const clickedItem = document.querySelector('.conversation-item[data-user-id="' + userId + '"]');
    if (clickedItem) {
        clickedItem.classList.add('active');
    }
    
    // Load messages
    loadMessages(userId);
    
    // Start auto-refresh
    if (messageCheckInterval) {
        clearInterval(messageCheckInterval);
    }
    messageCheckInterval = setInterval(() => loadMessages(userId), 5000);
}

function loadMessages(otherUserId) {
    fetch('${pageContext.request.contextPath}/tenant/messages?action=getMessages&otherUserId=' + otherUserId)
        .then(response => response.json())
        .then(messages => {
            displayMessages(messages);
        })
        .catch(error => console.error('Error loading messages:', error));
}

function displayMessages(messages) {
    const chatArea = document.getElementById('chatArea');
    const userId = ${sessionScope.userId != null ? sessionScope.userId : 0};
    
    let html = '<div class="chat-header">';
    html += '<div class="chat-user-info">';
    html += '<div class="chat-avatar">';
    html += currentUserType === 'owner' ? '<i class="fas fa-home"></i>' : '<i class="fas fa-user"></i>';
    html += '</div>';
    html += '<div class="chat-user-details">';
    html += '<h3>' + escapeHtml(currentUserName) + '</h3>';
    html += '<p>' + (currentUserType === 'owner' ? 'PG Owner' : 'Tenant') + '</p>';
    html += '</div></div>';
    html += '<div class="chat-actions">';
    html += '<button class="btn-icon" onclick="loadMessages(' + currentUserId + ')"><i class="fas fa-sync-alt"></i></button>';
    html += '</div></div>';
    
    html += '<div class="messages-area" id="messagesArea">';
    
    if (!messages || messages.length === 0) {
        html += '<div class="empty-state" style="flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;">';
        html += '<i class="fas fa-comment" style="font-size:3rem;color:#d1d5db;margin-bottom:1rem;"></i>';
        html += '<p style="color:#6b7280;margin:0;">No messages yet</p>';
        html += '<small style="color:#9ca3af;">Start the conversation!</small>';
        html += '</div>';
    } else {
        messages.forEach(function(msg) {
            // Gson serializes Java fields — senderId maps to senderId
            const senderId = msg.senderId || msg.sender_id;
            const isSent = senderId === userId;
            html += '<div class="message-group ' + (isSent ? 'sent' : 'received') + '">';
            if (!isSent) {
                html += '<div class="message-avatar">';
                html += currentUserType === 'owner' ? '<i class="fas fa-home"></i>' : '<i class="fas fa-user"></i>';
                html += '</div>';
            }
            html += '<div class="message-content">';
            html += '<div class="message-bubble">' + escapeHtml(msg.messageText || msg.message_text || '') + '</div>';
            html += '<div class="message-time">' + formatTime(msg.createdAt || msg.created_at) + '</div>';
            html += '</div>';
            if (isSent) {
                html += '<div class="message-avatar" style="background:linear-gradient(135deg,#2563eb,#1d4ed8);">';
                html += '<i class="fas fa-user"></i>';
                html += '</div>';
            }
            html += '</div>';
        });
    }
    
    html += '</div>';
    html += '<div class="message-input-area">';
    html += '<input type="text" id="messageInput" placeholder="Type a message..." onkeypress="handleKeyPress(event)" autocomplete="off">';
    html += '<button class="btn-send" onclick="sendMessage()"><i class="fas fa-paper-plane"></i> Send</button>';
    html += '</div>';
    
    chatArea.innerHTML = html;
    
    const messagesArea = document.getElementById('messagesArea');
    if (messagesArea) messagesArea.scrollTop = messagesArea.scrollHeight;
    
    // Focus input
    const input = document.getElementById('messageInput');
    if (input) input.focus();
}

function sendMessage() {
    const input = document.getElementById('messageInput');
    const messageText = input.value.trim();
    
    if (!messageText || !currentUserId) {
        console.log('No message text or user ID');
        return;
    }
    
    console.log('Sending message to user:', currentUserId);
    
    fetch('${pageContext.request.contextPath}/tenant/messages', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'action=sendMessage&receiverId=' + currentUserId + '&messageText=' + encodeURIComponent(messageText)
    })
    .then(response => {
        console.log('Response status:', response.status);
        return response.json();
    })
    .then(data => {
        console.log('Response data:', data);
        if (data.success) {
            input.value = '';
            loadMessages(currentUserId);
        } else {
            alert('Failed to send message. Please try again.');
        }
    })
    .catch(error => {
        console.error('Error sending message:', error);
        alert('An error occurred while sending the message.');
    });
}

function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

function searchConversations() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const conversations = document.querySelectorAll('.conversation-item');
    
    conversations.forEach(conv => {
        const name = conv.querySelector('h4').textContent.toLowerCase();
        const preview = conv.querySelector('.conv-preview').textContent.toLowerCase();
        
        if (name.includes(searchTerm) || preview.includes(searchTerm)) {
            conv.style.display = 'flex';
        } else {
            conv.style.display = 'none';
        }
    });
}

function refreshConversations() {
    location.reload();
}

function formatTime(timestamp) {
    const date = new Date(timestamp);
    const now = new Date();
    const diff = now - date;
    
    if (diff < 60000) return 'Just now';
    if (diff < 3600000) return Math.floor(diff / 60000) + ' min ago';
    if (diff < 86400000) return date.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Cleanup on page unload
window.addEventListener('beforeunload', () => {
    if (messageCheckInterval) {
        clearInterval(messageCheckInterval);
    }
});
</script>

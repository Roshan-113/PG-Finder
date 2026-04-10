<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Page</title>
</head>
<body style="background: red; padding: 50px;">
    <h1 style="color: white; font-size: 48px;">TEST PAGE - If you see this, JSP is working!</h1>
    <p style="color: white; font-size: 24px;">Current Page: ${currentPage}</p>
    <p style="color: white; font-size: 24px;">Listings Count: ${listings != null ? listings.size() : 'null'}</p>
</body>
</html>

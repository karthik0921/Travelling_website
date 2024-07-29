<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
    String e_mail = request.getParameter("email");
    String pass_word = request.getParameter("password");
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/login";
    String dbUser = "root";
    String dbPassword = "root";
    // JDBC variables
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Connect to the database
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        String check_login="SELECT email,password FROM signup where email=? and password=?";
        pstmt=conn.prepareStatement(check_login);
        pstmt.setString(1,e_mail);
        pstmt.setString(2,pass_word);

        ResultSet rs=pstmt.executeQuery();

        boolean status=rs.next();

        if(status){
            response.sendRedirect("index.html");
        }else{
            %>
            <script>
            alert("The user is not available!!!");
            window.location.href = "signin1.html";
            </script>
            <%
        }

    } catch (ClassNotFoundException | SQLException ex) {
        ex.printStackTrace();
        response.getWriter().println("Error: " + ex.getMessage());
    } finally {
        // Close JDBC objects
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    %>
</body>
</html>
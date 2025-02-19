<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background:  white; no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 200%;
            max-width: 500px;
            margin: 100px auto;
            background: white;
            padding: 40px;
            border-radius: 8px;
        }
        body{
            font-weight:bold;
            font-size: 34px;
            font-family:Times new roman;
            text-align: center;
            color:black;
        }
        a { 
            font-size: 24px;
            display: block;
            text-align: center;
            color: blue;
            font-family:times new roman;
            margin-top: 10px;
        }
     
    </style>
</head>
<body>

<marquee direction="right">your enter is wrong</marquee>

<div class="container">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String userid = request.getParameter("userid");
session.setAttribute("userid", userid);
String password = request.getParameter("password");
Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb1", "root", "Vsj@2001");
Statement st = con.createStatement();
String uid = request.getParameter("usr");
String pass = request.getParameter("password");
ResultSet rs = st.executeQuery("select * from users where userid='" + uid + "' and password='" + pass + "'");
try {
    if(rs.next()) {
        out.println("success...");
        response.sendRedirect("success.html");
    } else {
        out.print("plz try again.....");
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
<a href="index.html">Retry</a>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buy Stocks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .form-container {
            margin: 20px auto;
            text-align: center;
        }
        input[type="text"], input[type="number"], select, button {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        /* Navigation bar styling */
               		        /* Navigation Bar */
        .nav-container {
            background-color: #2980B9;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 8px;
            margin-bottom: 40px;
        }

        .nav-links a {
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 10px 20px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #1F618D;
            border-radius: 5px;
        }

        .logout-button a {
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 10px 20px;
            background-color: #E74C3C;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .logout-button a:hover {
            background-color: #C0392B;
        }
                header {
                font-family: 'Roboto', sans-serif;
            background-color: #1F3A64;
            color: white;
            text-align: center;
            padding: 30px;
            margin-bottom: 30px;
        }

        header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin: 0;
        }

        header p {
            font-size: 1.2rem;
            margin-top: 10px;
        }

    </style>
</head>

<body>
    <header>
        <h1>Buy Stocks</h1>
        <p>The Stock Market: Where Dreams Take Flight.</p>
    </header>
    <div class="container">
        <!-- Navigation Section -->
        <div class="nav-container">
            <div class="nav-links">
                <a href="success.html"><b>Home</b></a>
                <a href="about.html"><b>About Us</b></a>
                <a href="market.jsp"><b>Market</b></a>
                <a href="fund.html"><b>Mutual Funds</b></a>
                <a href="update.html"><b>Growth</b></a>
                <a href="contact.html"><b>Contact Us</b></a>
            </div>
            <div class="logout-button">
                <a href="logout.html"><b>Logout</b></a>
            </div>
        </div>
        <table>
            <tr>
                <th>Stock ID</th>
                <th>Symbol</th>
                <th>Name</th>
                <th>Price (USD)</th>
                <th>Sector</th>
                <th>Available Quantity</th>
                <th>Action</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb1", "root", "Vsj@2001");

                    // Query to fetch stocks
                    String query = "SELECT * FROM stocks";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int stockId = rs.getInt("id");
                        String symbol = rs.getString("symbol");
                        String name = rs.getString("name");
                        float price = rs.getFloat("price");
                        String sector = rs.getString("sector");
                        int availableQuantity = rs.getInt("available_quantity");
            %>
            <tr>
                <td><%= stockId %></td>
                <td><%= symbol %></td>
                <td><%= name %></td>
                <td><%= price %></td>
                <td><%= sector %></td>
                <td><%= availableQuantity %></td>
                <td>
                    <form action="payment.jsp" method="post" onsubmit="return calculateTotal(this)">
                        <input type="hidden" name="stockId" value="<%= stockId %>">
                        <input type="hidden" name="stockPrice" value="<%= price %>">

                        <input type="hidden" name="totalAmount" id="totalAmount<%= stockId %>">
                        <button type="submit">Buy</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>
    <script>
        function calculateTotal(form) {
            const price = parseFloat(form.stockPrice.value);
            const quantity = parseInt(form.quantity.value, 10);
            const total = price * quantity;
            form.totalAmount.value = total.toFixed(2);
            return true;
        }
    </script>
</body>
</html>

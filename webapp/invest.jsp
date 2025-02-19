<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invest</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
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
        .invest-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
    <script>
        function fetchStockPrice(stockId) {
            if (stockId === "") {
                document.getElementById('stockPrice').value = "";
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById('stockPrice').value = xhr.responseText;
                }
            };
            xhr.open("GET", "fetch_stock_price.jsp?stockid=" + stockId, true);
            xhr.send();
        }
        
        function calculateAmount() {
            var quantity = document.getElementById('quantity').value;
            var stockPrice = document.getElementById('stockPrice').value;
            var amount = quantity * stockPrice;
            document.getElementById('amount').value = amount;
        }
    </script>
</head>
<body>
    <header>
        <h1>Invest on your stocks</h1>
        <p>The Future is Yours to Invest In.</p>
    </header>
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

    <div class="invest-section">
        <h2>Make an Investment</h2>
        <form action="payment_invest.jsp" method="post" onsubmit="calculateAmount()">
            <div class="form-group">
                <label for="userid">User ID:</label>
                <input type="text" class="form-control" id="userid" name="userid" required>
            </div>

            <div class="form-group">
                <label for="stockid">Stock:</label>
                <select class="form-control" id="stockid" name="stockid" onchange="fetchStockPrice(this.value)" required>
                    <option value="">---Select Stock---</option>
                    <%
                        // Database connection details
                        String url = "jdbc:mysql://localhost:3306/userdb1";
                        String dbUser = "root";
                        String dbPassword = "Vsj@2001";
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(url, dbUser, dbPassword);

                            // Query to fetch available stocks
                            String query = "SELECT id, name FROM stocks";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();

                            // Populate the dropdown list
                            while (rs.next()) {
                                String stockId = rs.getString("id");
                                String stockName = rs.getString("name");
                                out.println("<option value='" + stockId + "'>" + stockName + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<option value=''>Error loading stocks</option>");
                        } finally {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity to Invest:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
            </div>

            <div class="form-group">
                <label for="strategy">Investment Strategy:</label>
                <select class="form-control" id="strategy" name="strategy" required>
                    <option value="choice">---Select your strategy---</option>
                    <option value="long-term">Long Term</option>
                    <option value="short-term">Short Term</option>
                </select>
            </div>

            <div class="form-group">
                <label for="rate">Rate (%):</label>
                <select class="form-control" id="rate" name="rate" required>
                    <option value="choice">---Select the type fund---</option>
                    <option value="equity">Equity Fund</option>
                    <option value="debt">Debt Fund</option>
                    <option value="balanced">Balanced Fund</option>
                </select>
            </div>

            <div class="form-group">
                <label for="amount">Amount (USD):</label>
                <input type="text" class="form-control" id="amount_display" name="amount_display" readonly>
                <input type="hidden" id="amount" name="amount">
            </div>

            <!-- Hidden field for storing stock price -->
            <input type="hidden" id="stockPrice" name="stockPrice">

            <button type="submit" class="btn btn-primary">Proceed to Payment</button>
        </form>
    </div>
</body>
</html>

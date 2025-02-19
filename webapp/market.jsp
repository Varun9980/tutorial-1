<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Market Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">
 	<style>
        body {
		    font-family: 'Poppins', sans-serif;
		    background-color: #f8f9fa; /* Keep it light */
		    margin: 0;
		    padding: 0;
		}

		.chart-container {
		    display: flex;
		    justify-content: center;
		    position: relative;
		    height: 400px; /* Set a fixed height for the chart */
		    margin-bottom: 20px;
		    max-width: 100%; /* Ensure the chart doesn't overflow horizontally */
		}
		
		@media (max-width: 768px) {
		    .chart-container {
		        height: 300px; /* Reduce the height on smaller screens */
		    }
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
            background-color: #1F3A64;
        font-family: 'Roboto', sans-serif;
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
		.table th {
		    background-color: #3498db; /* Brighter blue for table header */
		    color: white;
		}
		
		.positive {
		    color: #2ecc71; /* Light green */
		}
		
		.negative {
		    color: #e74c3c; /* Light red */
		}
		
		.market-section {
		    margin: 0 20px;
		    padding: 10px;
		    background-color: white;
		    border-radius: 8px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		table tbody tr:nth-child(odd) {
		    background-color: #ffffff; /* White for odd rows */
		}
		
		table tbody tr:nth-child(even) {
		    background-color: #ecf0f1; /* Light grey for even rows */
		}

    </style>
</head>

<body>
    <header>
        <h1>Stock Market Dashboard</h1>
        <p>Lets explore the trending stocks.</p>
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
<div><br>
<center><h2 style="font-size:200%; color:#007bff;"><b>Stock Market Trend of the Year 2024</b></h2></center>
    <!-- Stock Market Trend Graph (Centered) -->
    <section class="chart-container">
        <canvas id="marketTrendChart"></canvas>
    </section>

    <section class="graph-explanation">
        <p>This graph shows the stock market trend over the past year. It represents the monthly market value changes of stocks, helping you understand how the market has evolved.</p>
    </section>
</div>

<section class="intro-table">
	<p style="font-size:200%;"><b>Most Trending Stocks</b></p>
</section>


<section class="market-section">
<section class="search-options">
	<div class="search-container">
    	<input type="text" id="searchBar" placeholder="Search Stocks..." onkeyup="searchStocks()">
    </div>
</section><br>
        <table id="stockTable" class="table table-striped">
            <thead>
                <tr>
                    <th>Stock Symbol</th>
                    <th>Stock Name</th>
                    <th>Current Price</th>
                    <th>Price Change (±%)</th>
                    <th>Market Cap</th>
                    <th>Volume</th>

                </tr>
            </thead>
            <tbody>
                <%
                    String url = "jdbc:mysql://localhost:3306/userdb1";
                    String dbUser = "root";
                    String dbPassword = "Vsj@2001";

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(url, dbUser, dbPassword);

                        String query = "SELECT * FROM stocks";
                        ps = con.prepareStatement(query);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String symbol = rs.getString("symbol");
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            double priceChange = rs.getDouble("price_change");
                            String marketCap = rs.getString("market_cap");
                            String volume = rs.getString("volume");


                            String priceChangeClass = priceChange >= 0 ? "positive" : "negative";

                            out.println("<tr>");
                            out.println("<td>" + symbol + "</td>");
                            out.println("<td>" + name + "</td>");
                            out.println("<td>$" + price + "</td>");
                            out.println("<td class='" + priceChangeClass + "'>" + priceChange + "%</td>");
                            out.println("<td>" + marketCap + "</td>");
                            out.println("<td>" + volume + "</td>");

                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>
            </tbody>
        </table>
    </section>
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>

        function searchStocks() {
            const searchTerm = document.getElementById("searchBar").value.toLowerCase();
            const stockTableRows = document.querySelectorAll("#stockTable tbody tr");

            stockTableRows.forEach(row => {
                const stockName = row.cells[1].textContent.toLowerCase();
                const stockSymbol = row.cells[0].textContent.toLowerCase();

                if (stockName.includes(searchTerm) || stockSymbol.includes(searchTerm)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        // Initialize Chart.js chart
        const ctx = document.getElementById("marketTrendChart").getContext("2d");
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Market Value',
                    data: [120, 130, 140, 150, 160, 170, 180, 190, 195, 200, 210, 220],
                    fill: false,
                    borderColor: 'rgba(0, 123, 255, 1)',
                    tension: 0.1
                }]
            }
        });

        // Call filter on initial load
        filterStocks();
    </script>

</body>
</html>


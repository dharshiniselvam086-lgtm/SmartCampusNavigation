<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <title>Welcome</title>
        <link rel="stylesheet" href="style.css">
    </head>

    <body>

        <div class="container">

            <h1>Smart Campus Navigation</h1>

            <h2>Welcome, <%= session.getAttribute("username") %>!</h2>

            <p>You have successfully logged in.</p>

            <a href="campus">
                <button>Explore Campus</button>
            </a>

            <br><br>

            <a href="logout">
                <button>Logout</button>
            </a>

        </div>

    </body>

    </html>
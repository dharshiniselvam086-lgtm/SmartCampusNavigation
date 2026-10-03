<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Smart Campus - Login</title>

        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            body {
                min-height: 100vh;
                background: linear-gradient(135deg, #0f172a, #1e3a8a);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .login-wrapper {
                width: 900px;
                min-height: 520px;
                background: white;
                border-radius: 24px;
                overflow: hidden;
                display: flex;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
            }

            .left-panel {
                width: 50%;
                padding: 55px;
                background: linear-gradient(160deg, #1d4ed8, #0f172a);
                color: white;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .logo {
                font-size: 42px;
                margin-bottom: 20px;
            }

            .left-panel h1 {
                font-size: 38px;
                margin-bottom: 15px;
            }

            .left-panel p {
                font-size: 16px;
                line-height: 1.7;
                opacity: 0.9;
            }

            .features {
                margin-top: 30px;
            }

            .features p {
                margin: 12px 0;
            }

            .right-panel {
                width: 50%;
                padding: 60px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .right-panel h2 {
                font-size: 30px;
                color: #0f172a;
                margin-bottom: 10px;
            }

            .subtitle {
                color: #64748b;
                margin-bottom: 35px;
            }

            label {
                display: block;
                font-weight: bold;
                color: #334155;
                margin-bottom: 8px;
            }

            input {
                width: 100%;
                padding: 15px;
                border: 1px solid #cbd5e1;
                border-radius: 10px;
                font-size: 15px;
                outline: none;
                margin-bottom: 22px;
            }

            input:focus {
                border-color: #2563eb;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
            }

            button {
                width: 100%;
                padding: 15px;
                border: none;
                border-radius: 10px;
                background: #2563eb;
                color: white;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
            }

            button:hover {
                background: #1d4ed8;
            }

            .footer {
                margin-top: 25px;
                text-align: center;
                font-size: 13px;
                color: #94a3b8;
            }

            @media (max-width: 750px) {
                .login-wrapper {
                    width: 92%;
                    flex-direction: column;
                }

                .left-panel,
                .right-panel {
                    width: 100%;
                }

                .left-panel {
                    padding: 35px;
                }

                .right-panel {
                    padding: 35px;
                }
            }
        </style>
    </head>

    <body>

        <div class="login-wrapper">

            <div class="left-panel">

                <div class="logo">🧭</div>

                <h1>Smart Campus</h1>

                <p>
                    Navigate your campus smarter.
                    Find classrooms, laboratories, offices,
                    library and other important locations easily.
                </p>

                <div class="features">
                    <p>📍 Smart Location Search</p>
                    <p>🗺️ Campus Navigation</p>
                    <p>🔎 Quick Location Finder</p>
                </div>

            </div>


            <div class="right-panel">

                <h2>Welcome Back</h2>

                <p class="subtitle">
                    Login to explore your campus
                </p>

                <form action="login" method="post">

                    <label for="username">
                        Username
                    </label>

                    <input type="text" id="username" name="username" placeholder="Enter your username" required>

                    <button type="submit">
                        Login to Campus
                    </button>

                </form>

                <div class="footer">
                    Smart Campus Navigation System
                </div>

            </div>

        </div>

    </body>

    </html>
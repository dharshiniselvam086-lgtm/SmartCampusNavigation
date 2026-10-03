<%@ page import="java.util.ArrayList" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <!DOCTYPE html>

        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            ```
            <title>Smart Campus Navigation</title>

            <link rel="stylesheet" href="style.css">

            <style>
                body {
                    margin: 0;
                    background: #f5f3ff;
                }

                .dashboard {
                    min-height: 100vh;
                }

                /* TOP BAR */
                .topbar {
                    background: linear-gradient(110deg, #312e81, #6366f1, #7c3aed);
                    color: white;
                    padding: 18px 35px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    box-shadow: 0 8px 25px rgba(79, 70, 229, 0.25);
                }

                .brand h2 {
                    margin: 0;
                    font-size: 23px;
                }

                .brand span {
                    font-size: 12px;
                    opacity: 0.8;
                }

                .logout-btn {
                    color: white;
                    text-decoration: none;
                    background: rgba(255, 255, 255, 0.15);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                    padding: 10px 18px;
                    border-radius: 10px;
                    transition: 0.3s;
                }

                .logout-btn:hover {
                    background: white;
                    color: #4f46e5;
                }

                /* MAIN */
                .main-content {
                    padding: 35px 5%;
                    max-width: 1450px;
                    margin: auto;
                }

                /* HERO */
                .campus-hero {
                    background: linear-gradient(120deg, #4338ca, #6366f1, #a855f7);
                    color: white;
                    padding: 35px;
                    border-radius: 24px;
                    margin-bottom: 30px;
                    box-shadow: 0 15px 35px rgba(79, 70, 229, 0.2);
                }

                .campus-hero h1 {
                    margin: 0 0 10px;
                    font-size: 34px;
                }

                .campus-hero p {
                    margin: 0;
                    opacity: 0.9;
                }

                /* STATS */
                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 18px;
                    margin-bottom: 30px;
                }

                .stat-card {
                    background: white;
                    padding: 22px;
                    border-radius: 18px;
                    box-shadow: 0 8px 25px rgba(79, 70, 229, 0.07);
                    border: 1px solid #e9e7ff;
                }

                .stat-card h3 {
                    margin: 0;
                    color: #312e81;
                    font-size: 25px;
                }

                .stat-card p {
                    margin: 7px 0 0;
                    color: #64748b;
                    font-size: 13px;
                }

                /* MAP */
                .map-section {
                    background: white;
                    border-radius: 24px;
                    padding: 25px;
                    margin-bottom: 30px;
                    box-shadow: 0 10px 30px rgba(79, 70, 229, 0.08);
                }

                .map-section h2 {
                    margin-top: 0;
                    color: #312e81;
                }

                .map-wrapper {
                    position: relative;
                    width: 100%;
                    height: 520px;

                    background:
                        linear-gradient(90deg,
                            rgba(99, 102, 241, 0.04) 1px,
                            transparent 1px),
                        linear-gradient(rgba(99, 102, 241, 0.04) 1px,
                            transparent 1px);

                    background-size: 40px 40px;

                    border-radius: 20px;
                    border: 2px solid #e0e7ff;
                    overflow: hidden;
                }

                .campus-road {
                    position: absolute;
                    background: #e2e8f0;
                    border-radius: 20px;
                }

                .road-horizontal {
                    left: 5%;
                    right: 5%;
                    top: 48%;
                    height: 45px;
                }

                .road-vertical {
                    top: 5%;
                    bottom: 5%;
                    left: 48%;
                    width: 45px;
                }

                /* BUILDINGS */
                .building {
                    position: absolute;
                    width: 150px;
                    min-height: 85px;
                    background: white;
                    border: 2px solid #c7d2fe;
                    border-radius: 16px;
                    padding: 12px;
                    cursor: pointer;
                    box-shadow: 0 8px 20px rgba(79, 70, 229, 0.12);
                    transition: 0.25s;
                    z-index: 5;
                    text-align: center;
                }

                .building:hover {
                    transform: translateY(-5px) scale(1.03);
                    border-color: #6366f1;
                    box-shadow: 0 15px 30px rgba(79, 70, 229, 0.22);
                }

                .building.active {
                    border-color: #7c3aed;
                    background: #eef2ff;
                    box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
                }

                .building-icon {
                    font-size: 27px;
                    margin-bottom: 6px;
                }

                .building-name {
                    font-size: 12px;
                    font-weight: 800;
                    color: #312e81;
                }

                /* BUILDING POSITIONS */
                #building1 {
                    left: 8%;
                    top: 12%;
                }

                #building2 {
                    left: 8%;
                    bottom: 10%;
                }

                #building3 {
                    right: 8%;
                    top: 12%;
                }

                #building4 {
                    right: 8%;
                    bottom: 10%;
                }

                #building5 {
                    left: 40%;
                    top: 5%;
                }

                #building6 {
                    left: 40%;
                    bottom: 5%;
                }

                /* ROUTE SVG */
                #routeSvg {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    pointer-events: none;
                    z-index: 4;
                }

                .route-line {
                    fill: none;
                    stroke: #ef4444;
                    stroke-width: 6;
                    stroke-linecap: round;
                    stroke-linejoin: round;
                    stroke-dasharray: 12 8;
                    filter: drop-shadow(0 3px 5px rgba(239, 68, 68, 0.3));
                    animation: routeAnimation 1s linear infinite;
                }

                @keyframes routeAnimation {
                    from {
                        stroke-dashoffset: 0;
                    }

                    to {
                        stroke-dashoffset: -20;
                    }
                }

                .route-point {
                    fill: white;
                    stroke: #ef4444;
                    stroke-width: 5;
                }

                /* MOVING NAVIGATION MARKER */
                .route-marker {
                    position: absolute;
                    width: 42px;
                    height: 42px;
                    background: #4f46e5;
                    border: 4px solid white;
                    border-radius: 50%;
                    display: none;
                    align-items: center;
                    justify-content: center;
                    font-size: 23px;
                    z-index: 20;
                    transform: translate(-50%, -50%);
                    box-shadow:
                        0 0 0 5px rgba(79, 70, 229, 0.18),
                        0 8px 20px rgba(79, 70, 229, 0.35);
                    transition:
                        left 1.2s ease-in-out,
                        top 1.2s ease-in-out;
                }

                .route-marker::after {
                    content: "";
                    position: absolute;
                    width: 55px;
                    height: 55px;
                    border-radius: 50%;
                    border: 2px solid rgba(99, 102, 241, 0.35);
                    animation: markerPulse 1.5s infinite;
                }

                @keyframes markerPulse {
                    0% {
                        transform: scale(0.7);
                        opacity: 1;
                    }

                    100% {
                        transform: scale(1.4);
                        opacity: 0;
                    }
                }

                /* ROUTE CONTROL */
                .animation-control {
                    display: none;
                    margin-top: 15px;
                    padding: 12px 16px;
                    border-radius: 12px;
                    background: #eef2ff;
                    color: #3730a3;
                    font-size: 13px;
                    font-weight: 700;
                }

                /* ROUTE SECTION */
                .route-section {
                    background: white;
                    padding: 28px;
                    border-radius: 22px;
                    margin-bottom: 30px;
                    box-shadow: 0 10px 30px rgba(79, 70, 229, 0.08);
                }

                .route-section h2 {
                    margin-top: 0;
                    color: #312e81;
                }

                .route-form {
                    display: grid;
                    grid-template-columns: 1fr 1fr auto;
                    gap: 15px;
                    align-items: end;
                }

                .route-field label {
                    display: block;
                    margin-bottom: 8px;
                    font-size: 13px;
                    font-weight: 700;
                    color: #475569;
                }

                .route-field select {
                    width: 100%;
                    padding: 14px;
                    border-radius: 12px;
                    border: 1px solid #cbd5e1;
                    background: #fafaff;
                    font-size: 14px;
                }

                .route-btn {
                    height: 48px;
                }

                /* SEARCH */
                .search-section {
                    background: white;
                    padding: 28px;
                    border-radius: 22px;
                    margin-bottom: 30px;
                    box-shadow: 0 10px 30px rgba(79, 70, 229, 0.08);
                }

                .search-section h2 {
                    margin-top: 0;
                    color: #312e81;
                }

                .search-box {
                    display: flex;
                    gap: 12px;
                }

                #searchResult,
                #routeResult {
                    margin-top: 20px;
                }

                /* LOCATION CARDS */
                .locations-title {
                    color: #312e81;
                    margin: 35px 0 20px;
                }

                .location-grid {
                    display: grid;
                    grid-template-columns:
                        repeat(auto-fit, minmax(240px, 1fr));
                    gap: 20px;
                }

                .location-card {
                    background: white;
                    padding: 22px;
                    border-radius: 18px;
                    border: 1px solid #e9e7ff;
                    box-shadow: 0 8px 25px rgba(79, 70, 229, 0.06);
                    transition: 0.25s;
                }

                .location-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 15px 30px rgba(79, 70, 229, 0.12);
                }

                .location-card h3 {
                    color: #312e81;
                    margin-top: 0;
                }

                .location-card p {
                    color: #64748b;
                    font-size: 13px;
                    line-height: 1.6;
                }

                .status {
                    display: inline-block;
                    padding: 6px 12px;
                    border-radius: 20px;
                    font-size: 11px;
                    font-weight: 800;
                }

                .available {
                    background: #dcfce7;
                    color: #15803d;
                }

                .occupied {
                    background: #fee2e2;
                    color: #b91c1c;
                }

                .maintenance {
                    background: #fef3c7;
                    color: #b45309;
                }

                /* DETAILS POPUP */
                .details-overlay {
                    display: none;
                    position: fixed;
                    inset: 0;
                    background: rgba(15, 23, 42, 0.55);
                    z-index: 1000;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .details-popup {
                    width: min(450px, 100%);
                    background: white;
                    border-radius: 22px;
                    padding: 28px;
                    position: relative;
                    box-shadow: 0 25px 60px rgba(15, 23, 42, 0.25);
                    animation: popupIn 0.25s ease;
                }

                .details-popup h2 {
                    color: #312e81;
                    margin-top: 0;
                    padding-right: 35px;
                }

                .details-popup p {
                    color: #475569;
                    line-height: 1.7;
                }

                .close-popup {
                    position: absolute;
                    right: 18px;
                    top: 15px;
                    width: 38px;
                    height: 38px;
                    border-radius: 50%;
                    border: none;
                    background: #eef2ff;
                    color: #4338ca;
                    font-size: 20px;
                    cursor: pointer;
                    padding: 0;
                }

                .popup-content {
                    margin-top: 15px;
                }

                .popup-status {
                    display: inline-block;
                    padding: 7px 14px;
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 800;
                    margin-top: 5px;
                }

                .popup-available {
                    background: #dcfce7;
                    color: #15803d;
                }

                .popup-occupied {
                    background: #fee2e2;
                    color: #b91c1c;
                }

                .popup-maintenance {
                    background: #fef3c7;
                    color: #b45309;
                }

                .popup-navigate {
                    width: 100%;
                    margin-top: 18px;
                }

                @keyframes popupIn {
                    from {
                        opacity: 0;
                        transform: translateY(15px) scale(0.96);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                }

                footer {
                    text-align: center;
                    padding: 30px;
                    color: #64748b;
                    font-size: 13px;
                }

                /* RESPONSIVE */
                @media(max-width: 900px) {

                    .stats-grid {
                        grid-template-columns: repeat(2, 1fr);
                    }

                    .route-form {
                        grid-template-columns: 1fr;
                    }

                    .map-wrapper {
                        height: 450px;
                    }
                }

                @media(max-width: 600px) {

                    .stats-grid {
                        grid-template-columns: 1fr;
                    }

                    .topbar {
                        padding: 15px 20px;
                    }

                    .main-content {
                        padding: 20px;
                    }

                    .campus-hero h1 {
                        font-size: 27px;
                    }

                    .map-wrapper {
                        height: 420px;
                    }

                    .building {
                        width: 105px;
                        padding: 8px;
                    }

                    .building-name {
                        font-size: 10px;
                    }

                    .search-box {
                        flex-direction: column;
                    }
                }
            </style>
            ```

        </head>

        <body>

            <div class="dashboard">

                ```
                <!-- TOP BAR -->
                <div class="topbar">

                    <div class="brand">

                        <h2>
                            🧭 Smart Campus
                        </h2>

                        <span>
                            Campus Navigation System
                        </span>

                    </div>

                    <a class="logout-btn" href="logout">
                        Logout
                    </a>

                </div>


                <div class="main-content">

                    <!-- HERO -->
                    <div class="campus-hero">

                        <h1>
                            Explore Your Campus 🚀
                        </h1>

                        <p>
                            Search locations, check availability
                            and find the shortest route between
                            campus buildings.
                        </p>

                    </div>


                    <!-- STATS -->
                    <div class="stats-grid">

                        <div class="stat-card">
                            <h3>7</h3>
                            <p>Campus Locations</p>
                        </div>

                        <div class="stat-card">
                            <h3>8+</h3>
                            <p>Navigation Routes</p>
                        </div>

                        <div class="stat-card">
                            <h3>24/7</h3>
                            <p>Navigation Access</p>
                        </div>

                        <div class="stat-card">
                            <h3>⚡</h3>
                            <p>Dijkstra Shortest Path</p>
                        </div>

                    </div>


                    <!-- MAP -->
                    <div class="map-section">

                        <h2>
                            🗺️ Interactive Campus Map
                        </h2>

                        <p style="color:#64748b;font-size:13px;">
                            Click any building to view detailed information.
                        </p>


                        <div class="map-wrapper">

                            <div class="campus-road road-horizontal"></div>

                            <div class="campus-road road-vertical"></div>


                            <!-- ROUTE SVG -->
                            <svg id="routeSvg" viewBox="0 0 1000 520" preserveAspectRatio="none">

                                <polyline id="routeLine" class="route-line" points="">
                                </polyline>

                            </svg>


                            <!-- MOVING MARKER -->
                            <div id="routeAnimationMarker" class="route-marker">

                                🚶

                            </div>


                            <!-- BUILDING 1 -->
                            <div class="building" id="building1" onclick="showBuildingDetails('CSE Classroom 1')">

                                <div class="building-icon">
                                    🏫
                                </div>

                                <div class="building-name">
                                    CSE Classroom 1
                                </div>

                            </div>


                            <!-- BUILDING 2 -->
                            <div class="building" id="building2" onclick="showBuildingDetails('CSE Computer Lab')">

                                <div class="building-icon">
                                    💻
                                </div>

                                <div class="building-name">
                                    CSE Computer Lab
                                </div>

                            </div>


                            <!-- BUILDING 3 -->
                            <div class="building" id="building3" onclick="showBuildingDetails('Central Library')">

                                <div class="building-icon">
                                    📚
                                </div>

                                <div class="building-name">
                                    Central Library
                                </div>

                            </div>


                            <!-- BUILDING 4 -->
                            <div class="building" id="building4" onclick="showBuildingDetails('Seminar Hall 1')">

                                <div class="building-icon">
                                    🎤
                                </div>

                                <div class="building-name">
                                    Seminar Hall 1
                                </div>

                            </div>


                            <!-- BUILDING 5 -->
                            <div class="building" id="building5" onclick="showBuildingDetails('Principal Office')">

                                <div class="building-icon">
                                    🏢
                                </div>

                                <div class="building-name">
                                    Principal Office
                                </div>

                            </div>


                            <!-- BUILDING 6 -->
                            <div class="building" id="building6" onclick="showBuildingDetails('Faculty Room')">

                                <div class="building-icon">
                                    👨‍🏫
                                </div>

                                <div class="building-name">
                                    Faculty Room
                                </div>

                            </div>

                        </div>


                        <div id="animationControl" class="animation-control">

                            🚶 Live navigation animation is running...

                        </div>

                    </div>


                    <!-- SEARCH -->
                    <div class="search-section">

                        <h2>
                            🔎 Find a Campus Location
                        </h2>

                        <div class="search-box">

                            <input type="text" id="searchInput" placeholder="Example: Principal, Library, Lab...">

                            <button onclick="searchLocation()">
                                Search
                            </button>

                        </div>

                        <div id="searchResult"></div>

                    </div>


                    <!-- ROUTE -->
                    <div class="route-section">

                        <h2>
                            🧭 Find Shortest Route
                        </h2>

                        <div class="route-form">

                            <div class="route-field">

                                <label>
                                    Starting Location
                                </label>

                                <select id="fromLocation">

                                    <option value="">
                                        Select starting location
                                    </option>

                                    <option>CSE Classroom 1</option>
                                    <option>CSE Computer Lab</option>
                                    <option>Central Library</option>
                                    <option>Seminar Hall 1</option>
                                    <option>Principal Office</option>
                                    <option>Faculty Room</option>

                                </select>

                            </div>


                            <div class="route-field">

                                <label>
                                    Destination
                                </label>

                                <select id="toLocation">

                                    <option value="">
                                        Select destination
                                    </option>

                                    <option>CSE Classroom 1</option>
                                    <option>CSE Computer Lab</option>
                                    <option>Central Library</option>
                                    <option>Seminar Hall 1</option>
                                    <option>Principal Office</option>
                                    <option>Faculty Room</option>

                                </select>

                            </div>


                            <button class="route-btn" onclick="findRoute()">

                                🧭 Find Route

                            </button>

                        </div>


                        <div id="routeResult"></div>

                    </div>


                    <!-- LOCATION CARDS -->
                    <h2 class="locations-title">
                        📍 Campus Locations
                    </h2>


                    <div class="location-grid">

                        <% ArrayList<String[]> locations =
                            (ArrayList<String[]>)
                                request.getAttribute("locations");

                                if (locations != null) {

                                for (String[] location : locations) {

                                String statusClass =
                                location[4]
                                .toLowerCase()
                                .replace(" ", "");
                                %>

                                <div class="location-card">

                                    <h3>
                                        📍 <%= location[0] %>
                                    </h3>

                                    <p>
                                        <strong>Floor:</strong>
                                        <%= location[1] %>
                                    </p>

                                    <p>
                                        <strong>Type:</strong>
                                        <%= location[2] %>
                                    </p>

                                    <p>
                                        <%= location[3] %>
                                    </p>

                                    <span class="status <%= statusClass %>">
                                        <%= location[4] %>
                                    </span>

                                </div>

                                <% } } %>

                    </div>

                </div>


                <!-- BUILDING DETAILS POPUP -->
                <div id="detailsOverlay" class="details-overlay" onclick="closeDetails(event)">

                    <div class="details-popup" onclick="event.stopPropagation()">

                        <button class="close-popup" onclick="closeDetails()">

                            ×

                        </button>

                        <div id="detailsContent" class="popup-content">

                            <p>
                                Loading...
                            </p>

                        </div>

                    </div>

                </div>


                <footer>
                    Smart Campus Navigation System
                    • Java Servlet
                    • JSP
                    • JDBC
                    • MySQL
                    • Dijkstra
                </footer>
                ```

            </div>

            <script>

                /* =========================================
                   BUILDING POSITIONS
                   ========================================= */

                const positions = {

                    "CSE Classroom 1":
                        [145, 105],

                    "CSE Computer Lab":
                        [145, 365],

                    "Central Library":
                        [855, 105],

                    "Seminar Hall 1":
                        [855, 365],

                    "Principal Office":
                        [490, 65],

                    "Faculty Room":
                        [490, 405]

                };


                /* =========================================
                   ANIMATION TIMER
                   ========================================= */

                let animationTimer = null;


                /* =========================================
                   SHOW BUILDING DETAILS
                   ========================================= */

                function showBuildingDetails(name) {

                    highlightBuilding(name);

                    const overlay =
                        document.getElementById(
                            "detailsOverlay"
                        );

                    const content =
                        document.getElementById(
                            "detailsContent"
                        );

                    overlay.style.display = "flex";

                    content.innerHTML =
                        "<p>Loading building details...</p>";

                    const xhr =
                        new XMLHttpRequest();

                    xhr.open(
                        "GET",
                        "locationDetails?name="
                        + encodeURIComponent(name),
                        true
                    );

                    xhr.onreadystatechange =
                        function () {

                            if (
                                xhr.readyState === 4 &&
                                xhr.status === 200
                            ) {

                                const parser =
                                    new DOMParser();

                                const doc =
                                    parser.parseFromString(
                                        xhr.responseText,
                                        "text/html"
                                    );

                                const details =
                                    doc.querySelector(
                                        ".location-details"
                                    );

                                if (!details) {

                                    content.innerHTML =
                                        xhr.responseText;

                                    return;
                                }

                                const paragraphs =
                                    details.querySelectorAll("p");

                                let floor = "";
                                let type = "";
                                let description = "";
                                let availability = "";

                                paragraphs.forEach(
                                    function (p) {

                                        const text =
                                            p.textContent.trim();

                                        if (
                                            text.startsWith("Floor:")
                                        ) {

                                            floor =
                                                text
                                                    .replace(
                                                        "Floor:",
                                                        ""
                                                    )
                                                    .trim();
                                        }

                                        if (
                                            text.startsWith("Type:")
                                        ) {

                                            type =
                                                text
                                                    .replace(
                                                        "Type:",
                                                        ""
                                                    )
                                                    .trim();
                                        }

                                        if (
                                            text.startsWith(
                                                "Description:"
                                            )
                                        ) {

                                            description =
                                                text
                                                    .replace(
                                                        "Description:",
                                                        ""
                                                    )
                                                    .trim();
                                        }

                                        if (
                                            text.startsWith(
                                                "Availability:"
                                            )
                                        ) {

                                            availability =
                                                text
                                                    .replace(
                                                        "Availability:",
                                                        ""
                                                    )
                                                    .trim();
                                        }

                                    }
                                );


                                let statusClass =
                                    "popup-available";

                                if (
                                    availability.toLowerCase()
                                    === "occupied"
                                ) {

                                    statusClass =
                                        "popup-occupied";
                                }

                                if (
                                    availability.toLowerCase()
                                    === "maintenance"
                                ) {

                                    statusClass =
                                        "popup-maintenance";
                                }


                                content.innerHTML =

                                    "<h2>📍 "
                                    + name
                                    + "</h2>"

                                    + "<p>"
                                    + "<strong>Floor:</strong> "
                                    + floor
                                    + "</p>"

                                    + "<p>"
                                    + "<strong>Type:</strong> "
                                    + type
                                    + "</p>"

                                    + "<p>"
                                    + "<strong>Description:</strong><br>"
                                    + description
                                    + "</p>"

                                    + "<p>"
                                    + "<strong>Availability:</strong><br>"
                                    + "<span class='popup-status "
                                    + statusClass
                                    + "'>"
                                    + availability
                                    + "</span>"
                                    + "</p>"

                                    + "<button "
                                    + "class='popup-navigate' "
                                    + "onclick=\"navigateToLocation('"
                                    + name.replace(/'/g, "\\'")
                                    + "')\">"
                                    + "🧭 Navigate Here"
                                    + "</button>";

                            }

                            else if (
                                xhr.readyState === 4
                            ) {

                                content.innerHTML =
                                    "<p>Unable to load "
                                    + "building details.</p>";
                            }

                        };

                    xhr.send();

                }


                /* =========================================
                   CLOSE POPUP
                   ========================================= */

                function closeDetails(event) {

                    if (
                        event &&
                        event.target !==
                        document.getElementById(
                            "detailsOverlay"
                        )
                    ) {

                        return;
                    }

                    document
                        .getElementById(
                            "detailsOverlay"
                        )
                        .style.display = "none";

                }


                /* =========================================
                   NAVIGATE TO LOCATION
                   ========================================= */

                function navigateToLocation(name) {

                    document
                        .getElementById(
                            "toLocation"
                        )
                        .value = name;

                    closeDetails();

                    document
                        .querySelector(
                            ".route-section"
                        )
                        .scrollIntoView({
                            behavior: "smooth"
                        });

                }


                /* =========================================
                   HIGHLIGHT BUILDING
                   ========================================= */

                function highlightBuilding(name) {

                    document
                        .querySelectorAll(".building")
                        .forEach(
                            function (building) {

                                building.classList.remove(
                                    "active"
                                );

                            }
                        );


                    const mapping = {

                        "CSE Classroom 1":
                            "building1",

                        "CSE Computer Lab":
                            "building2",

                        "Central Library":
                            "building3",

                        "Seminar Hall 1":
                            "building4",

                        "Principal Office":
                            "building5",

                        "Faculty Room":
                            "building6"

                    };


                    if (mapping[name]) {

                        document
                            .getElementById(
                                mapping[name]
                            )
                            .classList.add(
                                "active"
                            );
                    }

                }


                /* =========================================
                   SEARCH LOCATION
                   ========================================= */

                function searchLocation() {

                    const keyword =
                        document
                            .getElementById(
                                "searchInput"
                            )
                            .value
                            .trim();

                    const result =
                        document.getElementById(
                            "searchResult"
                        );


                    if (keyword === "") {

                        result.innerHTML =
                            "<p>Please enter a location.</p>";

                        return;
                    }


                    const xhr =
                        new XMLHttpRequest();

                    xhr.open(
                        "GET",
                        "searchLocation?search="
                        + encodeURIComponent(keyword),
                        true
                    );


                    xhr.onreadystatechange =
                        function () {

                            if (
                                xhr.readyState === 4 &&
                                xhr.status === 200
                            ) {

                                result.innerHTML =
                                    "<div class='route-result'>"
                                    + xhr.responseText
                                    + "</div>";

                            }

                        };


                    xhr.send();

                }


                /* =========================================
                   FIND ROUTE
                   ========================================= */

                function findRoute() {

                    const from =
                        document
                            .getElementById(
                                "fromLocation"
                            )
                            .value;

                    const to =
                        document
                            .getElementById(
                                "toLocation"
                            )
                            .value;

                    const result =
                        document
                            .getElementById(
                                "routeResult"
                            );


                    if (
                        from === "" ||
                        to === ""
                    ) {

                        result.innerHTML =
                            "<div class='route-result'>"
                            + "<p>Please select both locations.</p>"
                            + "</div>";

                        clearRoute();

                        return;
                    }


                    if (from === to) {

                        result.innerHTML =
                            "<div class='route-result'>"
                            + "<p>"
                            + "Starting location and destination "
                            + "cannot be the same."
                            + "</p>"
                            + "</div>";

                        clearRoute();

                        return;
                    }


                    highlightBuilding(from);


                    const xhr =
                        new XMLHttpRequest();


                    xhr.open(
                        "GET",
                        "route?from="
                        + encodeURIComponent(from)
                        + "&to="
                        + encodeURIComponent(to),
                        true
                    );


                    result.innerHTML =
                        "<div class='route-result'>"
                        + "<p>"
                        + "🧭 Calculating shortest route..."
                        + "</p>"
                        + "</div>";


                    xhr.onreadystatechange =
                        function () {

                            if (
                                xhr.readyState === 4 &&
                                xhr.status === 200
                            ) {

                                result.innerHTML =
                                    xhr.responseText;

                                drawActualRoute();

                                setTimeout(
                                    function () {
                                        animateRoute();
                                    },
                                    300
                                );

                            }

                        };


                    xhr.send();

                }


                /* =========================================
                   DRAW ACTUAL DIJKSTRA ROUTE
                   ========================================= */

                function drawActualRoute() {

                    const pathData =
                        document.getElementById(
                            "routePathData"
                        );


                    if (!pathData) {

                        clearRoute();

                        return;
                    }


                    const pathString =
                        pathData.dataset.path;


                    if (
                        !pathString ||
                        pathString.trim() === ""
                    ) {

                        clearRoute();

                        return;
                    }


                    const routeLocations =
                        pathString.split("|");


                    const points = [];


                    routeLocations.forEach(
                        function (location) {

                            const position =
                                positions[location];


                            if (position) {

                                points.push(
                                    position[0]
                                    + ","
                                    + position[1]
                                );

                            }

                        }
                    );


                    if (points.length < 2) {

                        clearRoute();

                        return;
                    }


                    document
                        .getElementById(
                            "routeLine"
                        )
                        .setAttribute(
                            "points",
                            points.join(" ")
                        );


                    drawRoutePoints(
                        routeLocations
                    );

                }


                /* =========================================
                   DRAW ROUTE POINTS
                   ========================================= */

                function drawRoutePoints(
                    routeLocations
                ) {

                    const svg =
                        document.getElementById(
                            "routeSvg"
                        );


                    document
                        .querySelectorAll(
                            ".route-point"
                        )
                        .forEach(
                            function (point) {

                                point.remove();

                            }
                        );


                    routeLocations.forEach(
                        function (
                            location,
                            index
                        ) {

                            const position =
                                positions[location];


                            if (!position) {
                                return;
                            }


                            const circle =
                                document.createElementNS(
                                    "http://www.w3.org/2000/svg",
                                    "circle"
                                );


                            circle.setAttribute(
                                "cx",
                                position[0]
                            );


                            circle.setAttribute(
                                "cy",
                                position[1]
                            );


                            circle.setAttribute(
                                "r",
                                (
                                    index === 0 ||
                                    index ===
                                    routeLocations.length - 1
                                )
                                    ? "10"
                                    : "7"
                            );


                            circle.setAttribute(
                                "class",
                                "route-point"
                            );


                            svg.appendChild(circle);

                        }
                    );

                }


                /* =========================================
                   ROUTE ANIMATION
                   ========================================= */

                function animateRoute() {

                    const pathData =
                        document.getElementById(
                            "routePathData"
                        );


                    if (!pathData) {
                        return;
                    }


                    const pathString =
                        pathData.dataset.path;


                    if (
                        !pathString ||
                        pathString.trim() === ""
                    ) {
                        return;
                    }


                    const routeLocations =
                        pathString.split("|");


                    if (routeLocations.length < 2) {
                        return;
                    }


                    const marker =
                        document.getElementById(
                            "routeAnimationMarker"
                        );


                    const control =
                        document.getElementById(
                            "animationControl"
                        );


                    if (!marker) {
                        return;
                    }


                    if (animationTimer) {

                        clearTimeout(
                            animationTimer
                        );

                    }


                    marker.style.display =
                        "flex";

                    control.style.display =
                        "block";


                    let index = 0;


                    function moveMarker() {

                        if (
                            index >=
                            routeLocations.length
                        ) {

                            control.innerHTML =
                                "✅ Navigation completed!";

                            setTimeout(
                                function () {

                                    marker.style.display =
                                        "none";

                                    control.style.display =
                                        "none";

                                },
                                2500
                            );

                            return;
                        }


                        const location =
                            routeLocations[index];


                        const position =
                            positions[location];


                        if (!position) {

                            index++;

                            moveMarker();

                            return;
                        }


                        marker.style.left =
                            position[0] + "px";

                        marker.style.top =
                            position[1] + "px";


                        control.innerHTML =
                            "🚶 Navigating to: "
                            + location;


                        index++;


                        animationTimer =
                            setTimeout(
                                moveMarker,
                                1200
                            );

                    }


                    /* Start marker from first location */

                    const firstPosition =
                        positions[
                        routeLocations[0]
                        ];


                    if (firstPosition) {

                        marker.style.left =
                            firstPosition[0] + "px";

                        marker.style.top =
                            firstPosition[1] + "px";

                    }


                    moveMarker();

                }


                /* =========================================
                   CLEAR ROUTE
                   ========================================= */

                function clearRoute() {

                    if (animationTimer) {

                        clearTimeout(
                            animationTimer
                        );

                        animationTimer = null;

                    }


                    const marker =
                        document.getElementById(
                            "routeAnimationMarker"
                        );


                    const control =
                        document.getElementById(
                            "animationControl"
                        );


                    if (marker) {

                        marker.style.display =
                            "none";

                    }


                    if (control) {

                        control.style.display =
                            "none";

                    }


                    document
                        .getElementById(
                            "routeLine"
                        )
                        .setAttribute(
                            "points",
                            ""
                        );


                    document
                        .querySelectorAll(
                            ".route-point"
                        )
                        .forEach(
                            function (point) {

                                point.remove();

                            }
                        );

                }


                /* =========================================
                   ENTER KEY SEARCH
                   ========================================= */

                document
                    .getElementById(
                        "searchInput"
                    )
                    .addEventListener(
                        "keydown",
                        function (event) {

                            if (
                                event.key === "Enter"
                            ) {

                                searchLocation();

                            }

                        }
                    );


                /* =========================================
                   ESC KEY CLOSE POPUP
                   ========================================= */

                document
                    .addEventListener(
                        "keydown",
                        function (event) {

                            if (
                                event.key === "Escape"
                            ) {

                                closeDetails();

                            }

                        }
                    );

            </script>

        </body>

        </html>

package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RouteDAO;

public class RouteServlet extends HttpServlet {

        static class Edge {
                String to;
                int distance;
                String direction;

                Edge(String to, int distance, String direction) {
                        this.to = to;
                        this.distance = distance;
                        this.direction = direction;
                }
        }

        static class Node implements Comparable<Node> {
                String location;
                int distance;

                Node(String location, int distance) {
                        this.location = location;
                        this.distance = distance;
                }

                @Override
                public int compareTo(Node other) {
                        return Integer.compare(this.distance, other.distance);
                }
        }

        @Override
        protected void doGet(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                response.setContentType("text/html;charset=UTF-8");

                String from = request.getParameter("from");
                String to = request.getParameter("to");

                if (from == null || to == null ||
                                from.trim().isEmpty() ||
                                to.trim().isEmpty()) {

                        response.getWriter().println(
                                        "<p>Please select both locations.</p>");

                        return;
                }

                if (from.equals(to)) {

                        response.getWriter().println(
                                        "<p>Starting location and destination cannot be the same.</p>");

                        return;
                }

                try {

                        RouteDAO routeDAO = new RouteDAO();

                        ArrayList<String[]> routes = routeDAO.getAllRoutes();

                        Map<String, ArrayList<Edge>> graph = new HashMap<>();

                        for (String[] route : routes) {

                                String start = route[0];
                                String destination = route[1];

                                int distance = Integer.parseInt(route[2]);

                                String direction = route[3];

                                graph.putIfAbsent(
                                                start,
                                                new ArrayList<Edge>());

                                graph.putIfAbsent(
                                                destination,
                                                new ArrayList<Edge>());

                                graph.get(start).add(
                                                new Edge(
                                                                destination,
                                                                distance,
                                                                direction));

                                graph.get(destination).add(
                                                new Edge(
                                                                start,
                                                                distance,
                                                                "Walk towards " + start));
                        }

                        if (!graph.containsKey(from) ||
                                        !graph.containsKey(to)) {

                                response.getWriter().println(
                                                "<p>Location not found.</p>");

                                return;
                        }

                        Map<String, Integer> distances = new HashMap<>();

                        Map<String, String> previous = new HashMap<>();

                        Map<String, String> directions = new HashMap<>();

                        Set<String> visited = new HashSet<>();

                        for (String location : graph.keySet()) {

                                distances.put(
                                                location,
                                                Integer.MAX_VALUE);
                        }

                        distances.put(from, 0);

                        PriorityQueue<Node> queue = new PriorityQueue<>();

                        queue.add(
                                        new Node(from, 0));

                        while (!queue.isEmpty()) {

                                Node current = queue.poll();

                                if (visited.contains(current.location)) {
                                        continue;
                                }

                                visited.add(current.location);

                                if (current.location.equals(to)) {
                                        break;
                                }

                                for (Edge edge : graph.get(current.location)) {

                                        int newDistance = distances.get(current.location)
                                                        + edge.distance;

                                        if (newDistance < distances.get(edge.to)) {

                                                distances.put(
                                                                edge.to,
                                                                newDistance);

                                                previous.put(
                                                                edge.to,
                                                                current.location);

                                                directions.put(
                                                                edge.to,
                                                                edge.direction);

                                                queue.add(
                                                                new Node(
                                                                                edge.to,
                                                                                newDistance));
                                        }
                                }
                        }

                        if (!previous.containsKey(to)) {

                                response.getWriter().println(
                                                "<p>No route found.</p>");

                                return;
                        }

                        ArrayList<String> path = new ArrayList<>();

                        String current = to;

                        while (current != null) {

                                path.add(current);

                                if (current.equals(from)) {
                                        break;
                                }

                                current = previous.get(current);
                        }

                        Collections.reverse(path);

                        int totalDistance = distances.get(to);

                        int estimatedMinutes = Math.max(
                                        1,
                                        (int) Math.ceil(
                                                        totalDistance / 50.0));

                        response.getWriter().println(
                                        "<div class='route-result'>");

                        response.getWriter().println(
                                        "<h3>🧭 Shortest Route Found</h3>");

                        response.getWriter().println(
                                        "<p><strong>🟢 From:</strong> "
                                                        + from + "</p>");

                        response.getWriter().println(
                                        "<p><strong>🔴 To:</strong> "
                                                        + to + "</p>");

                        response.getWriter().println(
                                        "<p><strong>📏 Distance:</strong> "
                                                        + totalDistance
                                                        + " meters</p>");

                        response.getWriter().println(
                                        "<p><strong>⏱️ Estimated Walking Time:</strong> "
                                                        + estimatedMinutes
                                                        + " minute(s)</p>");

                        response.getWriter().println(
                                        "<p><strong>📍 Locations in Route:</strong> "
                                                        + path.size()
                                                        + "</p>");

                        response.getWriter().println(
                                        "<h4>🚶 Step-by-Step Directions</h4>");

                        response.getWriter().println(
                                        "<ol>");

                        for (int i = 1; i < path.size(); i++) {

                                String location = path.get(i);

                                String direction = directions.get(location);

                                response.getWriter().println(
                                                "<li>"
                                                                + direction
                                                                + " → <strong>"
                                                                + location
                                                                + "</strong>"
                                                                + "</li>");
                        }

                        response.getWriter().println(
                                        "</ol>");

                        /*
                         * Hidden route data for JavaScript.
                         * This allows the frontend map to draw
                         * the actual Dijkstra path.
                         */

                        response.getWriter().println(
                                        "<div id='routePathData' " +
                                                        "data-path='"
                                                        + escapeHtml(String.join("|", path))
                                                        + "'></div>");

                        response.getWriter().println(
                                        "</div>");

                } catch (Exception e) {

                        e.printStackTrace();

                        response.getWriter().println(
                                        "<p>Error calculating route.</p>");
                }
        }

        private String escapeHtml(String value) {

                return value
                                .replace("&", "&amp;")
                                .replace("\"", "&quot;")
                                .replace("<", "&lt;")
                                .replace(">", "&gt;");
        }
}

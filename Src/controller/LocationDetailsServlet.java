package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LocationDAO;

public class LocationDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "text/html;charset=UTF-8");

        String name = request.getParameter("name");

        if (name == null ||
                name.trim().isEmpty()) {

            response.getWriter().println(
                    "<p>Location name is required.</p>");

            return;
        }

        try {

            LocationDAO locationDAO = new LocationDAO();

            String[] location = locationDAO.searchLocation(
                    name.trim());

            if (location != null) {

                response.getWriter().println(
                        "<div class='location-details'>");

                response.getWriter().println(
                        "<h2>📍 "
                                + location[0]
                                + "</h2>");

                response.getWriter().println(
                        "<p><strong>Floor:</strong> "
                                + location[1]
                                + "</p>");

                response.getWriter().println(
                        "<p><strong>Type:</strong> "
                                + location[2]
                                + "</p>");

                response.getWriter().println(
                        "<p><strong>Description:</strong> "
                                + location[3]
                                + "</p>");

                response.getWriter().println(
                        "<p><strong>Availability:</strong> "
                                + location[4]
                                + "</p>");

                response.getWriter().println(
                        "</div>");

            } else {

                response.getWriter().println(
                        "<p>Location not found.</p>");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<p>Error loading location details.</p>");
        }
    }
}
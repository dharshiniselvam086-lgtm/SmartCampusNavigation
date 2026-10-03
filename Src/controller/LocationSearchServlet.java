package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LocationDAO;

public class LocationSearchServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        String keyword = request.getParameter("search");

        if (keyword == null ||
                keyword.trim().isEmpty()) {

            response.getWriter().println(
                    "Please enter a location.");

            return;
        }

        try {

            LocationDAO locationDAO = new LocationDAO();

            String[] location = locationDAO.searchLocation(
                    keyword.trim());

            if (location != null) {

                response.getWriter().println(
                        "Location: " + location[0]);

                response.getWriter().println(
                        " | Floor: " + location[1]);

                response.getWriter().println(
                        " | Type: " + location[2]);

                response.getWriter().println(
                        " | Status: " + location[4]);

                response.getWriter().println(
                        " | " + location[3]);

            } else {

                response.getWriter().println(
                        "Location not found.");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while searching location.");
        }
    }
}
package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LocationDAO;

public class CampusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            LocationDAO locationDAO = new LocationDAO();

            ArrayList<String[]> locations = locationDAO.getAllLocations();

            request.setAttribute(
                    "locations",
                    locations);

            RequestDispatcher dispatcher = request.getRequestDispatcher(
                    "/campus.jsp");

            dispatcher.forward(
                    request,
                    response);

        } catch (Exception e) {

            throw new ServletException(
                    "Error while loading campus locations",
                    e);
        }
    }
}
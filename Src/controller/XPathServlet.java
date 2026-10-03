package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;

public class XPathServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try {

            String filePath = getServletContext().getRealPath("/xml/campus.xml");

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

            DocumentBuilder builder = factory.newDocumentBuilder();

            Document document = builder.parse(filePath);

            XPathFactory xPathFactory = XPathFactory.newInstance();

            XPath xpath = xPathFactory.newXPath();

            String expression = "//location[name='Central Library']/description";

            Node result = (Node) xpath.evaluate(
                    expression,
                    document,
                    XPathConstants.NODE);

            if (result != null) {

                response.getWriter().println(
                        "XPath Search Result:");

                response.getWriter().println(
                        result.getTextContent());

            } else {

                response.getWriter().println(
                        "Location not found.");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while executing XPath query.");
        }
    }
}
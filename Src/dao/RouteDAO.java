package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RouteDAO {

    public ArrayList<String[]> getAllRoutes() {

        ArrayList<String[]> routes = new ArrayList<>();

        String sql = "SELECT from_location, to_location, distance, direction " +
                "FROM campus_routes";

        try {

            Connection connection = DatabaseConnection.getConnection();

            PreparedStatement statement = connection.prepareStatement(sql);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                String[] route = new String[4];

                route[0] = resultSet.getString("from_location");

                route[1] = resultSet.getString("to_location");

                route[2] = String.valueOf(
                        resultSet.getInt("distance"));

                route[3] = resultSet.getString("direction");

                routes.add(route);
            }

            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return routes;
    }
}
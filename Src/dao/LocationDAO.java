package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class LocationDAO {

    public ArrayList<String[]> getAllLocations() {

        ArrayList<String[]> locations = new ArrayList<>();

        String sql = "SELECT name, floor, type, description, availability " +
                "FROM locations";

        try {

            Connection connection = DatabaseConnection.getConnection();

            PreparedStatement statement = connection.prepareStatement(sql);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                String[] location = new String[5];

                location[0] = resultSet.getString("name");

                location[1] = String.valueOf(
                        resultSet.getInt("floor"));

                location[2] = resultSet.getString("type");

                location[3] = resultSet.getString("description");

                location[4] = resultSet.getString("availability");

                locations.add(location);
            }

            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return locations;
    }

    public String[] searchLocation(String keyword) {

        String sql = "SELECT name, floor, type, description, availability " +
                "FROM locations " +
                "WHERE name LIKE ? " +
                "OR type LIKE ? " +
                "OR description LIKE ? " +
                "LIMIT 1";

        try {

            Connection connection = DatabaseConnection.getConnection();

            PreparedStatement statement = connection.prepareStatement(sql);

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {

                String[] location = new String[5];

                location[0] = resultSet.getString("name");

                location[1] = String.valueOf(
                        resultSet.getInt("floor"));

                location[2] = resultSet.getString("type");

                location[3] = resultSet.getString("description");

                location[4] = resultSet.getString("availability");

                resultSet.close();
                statement.close();
                connection.close();

                return location;
            }

            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
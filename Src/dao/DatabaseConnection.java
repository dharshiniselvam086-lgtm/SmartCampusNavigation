package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {

    public static Connection getConnection() {

        Connection connection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            String url = "jdbc:mysql://"
                    + host
                    + ":"
                    + port
                    + "/"
                    + database
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            connection = DriverManager.getConnection(
                    url,
                    user,
                    password);

            System.out.println(
                    "Database connected successfully!");

        } catch (Exception e) {

            e.printStackTrace();
        }

        return connection;
    }
}
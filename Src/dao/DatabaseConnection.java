package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.net.URI;

public class DatabaseConnection {

    public static Connection getConnection() {

        Connection connection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String publicUrl = System.getenv("MYSQL_PUBLIC_URL");

            URI uri = URI.create(publicUrl);

            String host = uri.getHost();

            int port = uri.getPort();

            String database = uri.getPath().substring(1);

            String user = System.getenv("MYSQLUSER");

            String password = System.getenv("MYSQLPASSWORD");

            String jdbcUrl = "jdbc:mysql://"
                    + host
                    + ":"
                    + port
                    + "/"
                    + database
                    + "?useSSL=true&serverTimezone=UTC";

            connection = DriverManager.getConnection(
                    jdbcUrl,
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
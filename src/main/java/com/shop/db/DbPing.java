// src/main/java/com/shop/db/DbPing.java
package com.shop.db;
import java.sql.*;
public class DbPing {
    public static void main(String[] args) throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        try (Connection c = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=shopdb;encrypt=false",
                "sa", "your_password")) {
            System.out.println("OK: " + !c.isClosed());
        }
    }
}

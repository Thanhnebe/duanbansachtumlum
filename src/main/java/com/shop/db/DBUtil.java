package com.shop.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    // URL kết nối SQL Server
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=livingword;encrypt=false";
    private static final String USER = "sa";              // user SQL Server
    private static final String PASS = "123456";   // mật khẩu

    public static Connection getConnection() throws Exception {
        // Nạp driver SQL Server
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Trả về đối tượng Connection
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

package com.belong.db;

import org.apache.commons.dbcp.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by belong on 2017/4/12.
 */
public class OracleConn {
    private static Connection conn;
    private static InputStream is;
    private static DataSource ds;
    private static Properties pro;
    static {
        is = OracleConn.class.getClassLoader().getResourceAsStream("db/dbcp.ini");
        pro = new Properties();
        try {
            pro.load(is);
            ds = BasicDataSourceFactory.createDataSource(pro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(getConnection());
    }
    public static Connection getConnection(){
        try {
            conn = ds.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}

package com.belong.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class DBCP {
	private static Connection conn;
	private static InputStream is;
	private static Properties pro;
	private static DataSource ds;
	static {
		try {
			is = DBCP.class.getClassLoader().getResourceAsStream("dbcp.ini");
			pro = new Properties();
			pro.load(is);
			ds = BasicDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		System.out.println(DBCP.getConnection());
	}
	public static Connection getConnection(){
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}

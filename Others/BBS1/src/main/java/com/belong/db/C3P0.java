package com.belong.db;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0 {
	private static Connection conn;
	private static ComboPooledDataSource ds;
	static {
		ds = new ComboPooledDataSource("mysql");//调用c3p0中的配置文件		
	}
	public static Connection getConnection(){
		try {
			conn = ds.getConnection();//链接数据库
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}

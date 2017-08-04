package com.belong.db;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0 {
	private static Connection conn;
	private static ComboPooledDataSource cds;
	static {
		//1.通过配置文件得到数据源
		cds = new ComboPooledDataSource("mysql");
	}
	public static void main(String[] args) {
		System.out.println(C3P0.getConnection());
	}
	public static Connection getConnection(){
		try {
			conn = cds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}

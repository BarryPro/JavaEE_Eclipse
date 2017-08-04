package com.belong.db;

import java.sql.Connection;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0 {
	private static Connection conn;
	private static ComboPooledDataSource cds;//联合池数据源
	static {
		cds = new ComboPooledDataSource("mysql");
	}
	public static void main(String[] args) {
		System.out.println(C3P0.getConnection());
	}
	public static Connection getConnection(){
		try {
			conn = cds.getConnection();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}
}

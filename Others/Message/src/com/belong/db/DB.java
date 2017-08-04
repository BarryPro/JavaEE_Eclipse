package com.belong.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	private static Connection conn;
	public static Connection getConnection(){
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://192.168.1.111/message?useUnicode=true&characterEncoding=utf-8",
					"root",
					"root");
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
		return conn;
	}
	public static void closeConnection(){
		try {
			if(conn!=null){
				conn.close();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
}

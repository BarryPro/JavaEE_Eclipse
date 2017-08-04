package com.belong.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	private static Connection conn;
	public static Connection getConnection(){//得到连接
		try {
			Class.forName("org.gjt.mm.mysql.Driver");//通过反射得到jdbc的驱动
			conn = DriverManager.getConnection("jdbc:mysql://192.168.1.111/register?useUnicode=true&characterEncoding=utf-8",
					"root","root");//链接数据库
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
		return conn;
	}
	public static void closeConnection(){//关闭数据库
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

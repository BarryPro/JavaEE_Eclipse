package com.belong.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	private static Connection conn;
	public static Connection getConnection(){//�õ�����
		try {
			Class.forName("org.gjt.mm.mysql.Driver");//ͨ������õ�jdbc������
			conn = DriverManager.getConnection("jdbc:mysql://192.168.1.111/register?useUnicode=true&characterEncoding=utf-8",
					"root","root");//�������ݿ�
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
		return conn;
	}
	public static void closeConnection(){//�ر����ݿ�
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

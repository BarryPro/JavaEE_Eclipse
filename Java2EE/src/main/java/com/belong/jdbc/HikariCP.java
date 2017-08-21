package com.belong.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

/**
 * @Description: <p>HikariCP连接池的使用</p>
 * @Author : belong
 * @Date : 2017年8月19日
 */
public class HikariCP {
	private static Connection conn;
	private static HikariDataSource ds;
	static {
		//采用的是绝对路径找配置文件
		HikariConfig config = new HikariConfig("/db/hikaricp.ini");
		ds = new HikariDataSource(config);
	}

	public static void main(String[] args) {
		System.out.println(HikariCP.getConnection());
	}

	public static Connection getConnection() {
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}

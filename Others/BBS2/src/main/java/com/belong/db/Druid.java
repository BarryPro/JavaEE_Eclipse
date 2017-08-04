package com.belong.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;

public class Druid {
	private static Connection conn;
	private static InputStream is;
	private static Properties pro;
	private static DataSource ds;
	static {
		//1.反射通过德鲁伊来连接的
		is = Druid.class.getClassLoader().getResourceAsStream("druid.ini");
		pro = new Properties();
		try {
			pro.load(is);
			ds = DruidDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//单元测试
	public static void main(String[] args) {
		System.out.println(Druid.getConnection());
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

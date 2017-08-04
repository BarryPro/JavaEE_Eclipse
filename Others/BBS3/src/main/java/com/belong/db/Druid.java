package com.belong.db;

import java.io.InputStream;
import java.sql.Connection;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;

public class Druid {
	private static Connection conn;
	private static DataSource ds;
	private static InputStream is;
	private static Properties pro;
	static {
		try {
			is = Druid.class.getClassLoader().getResourceAsStream("druid.ini");
			pro = new Properties();
			pro.load(is);
			ds = DruidDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		System.out.println(Druid.getConnection());
	}
	public static Connection getConnection(){
		try {
			conn = ds.getConnection();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}
}

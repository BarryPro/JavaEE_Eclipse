package com.jdbc;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;
/**
 * @Description: <p>Druid连接池的使用</p>
 * @Author : belong
 * @Date : 2017年8月19日
 */
public class Druid {
	private static Connection conn;	
	private static DataSource ds;
	static{		
		Properties pro=new Properties();		
		InputStream is=Druid.class.getClassLoader().getResourceAsStream("druid.ini");
		try {
			pro.load(is);
			ds=DruidDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}
	public static void main(String[] args) {
		System.out.println(Druid.getConnection());
	}
	public static Connection getConnection(){
		try {
			 conn =ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}

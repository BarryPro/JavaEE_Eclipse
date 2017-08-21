package com.belong.jdbc;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;
/**
 * @Description: <p>DBCP连接池的使用</p>
 * @Author : belong
 * @Date : 2017年8月19日
 */
public class DBCP {
	private static Connection conn;//数据库的链接类
	private static Properties pro;//数据流（键直对）
	private static DataSource ds;//数据资源类（以键直对为资源）
	static {
		pro = new Properties();//声明定义一个键直对流
		//找到配置文件的内容给输入流
		InputStream is = DBCP.class.getClassLoader().getResourceAsStream("dbcp.ini");
		try {
			pro.load(is);//把输入流加入到键直对流当中
			ds = BasicDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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

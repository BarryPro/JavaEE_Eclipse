package com.belong.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;
/*
 * 连接池进行连接时不用关闭（自动关闭）
 */
public class DBCP {
	private static InputStream is;
	private static Properties pro;
	private static Connection conn;
	private static DataSource ds;//连接池通过数据源来进行连接
	static {
		//1.用反射把配置文件加载到输入流方到内存中
		is = DBCP.class.getClassLoader().getResourceAsStream("DBCP.ini");
		//2.用键直对流把输入流的内容取出来
		pro = new Properties();
		try {
			pro.load(is);
			//3.把键直对送入数据源工厂
			ds = BasicDataSourceFactory.createDataSource(pro);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//单元测试（是否链接成功）
	public static void main(String[] args) {
		System.out.println(DBCP.getConnection());
	}
	public static Connection getConnection(){
		try {
			//链接数据库
			conn = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}

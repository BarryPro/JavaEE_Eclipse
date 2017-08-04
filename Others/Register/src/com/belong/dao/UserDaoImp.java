package com.belong.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.belong.db.DB;
import com.belong.vo.User;

public class UserDaoImp implements IUserDao{
	private Connection conn;
	public UserDaoImp(){
		conn = DB.getConnection();//链接数据库
	}
	@Override
	public boolean login(User user) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null; //准备语句（使用sql语句的）
		boolean flag = false;//局部变量必须初始化
		String sql = "select * from user where name=? and password=?";//其中的？表示的是sql语句的参数
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUsername());//有形参来的
			pstmt.setString(2, user.getPassword());
			flag = pstmt.executeQuery().next();//执行sql语句(如果有结果集返回true 否则false)
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//DB.closeConnection();
		}
		return flag;
	}

}

package com.belong.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.belong.db.DB;
import com.belong.vo.User;

public class UserDaoRegisterImp implements IUserDao {
	private Connection conn;
	public UserDaoRegisterImp(){
		conn = DB.getConnection();
	}
	@Override
	public boolean login(User user) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement pstmt = null;
		String sql = "insert into user(name,password) values(?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			flag = pstmt.executeUpdate()>0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
				e2.getMessage();
			}
			DB.closeConnection();
		}
		return flag;
	}

}

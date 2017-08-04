package com.belong.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.belong.db.DB;
import com.belong.vo.User;

public class UserDaoImp implements IUserDao{
	private Connection conn;
	public UserDaoImp(){
		conn = DB.getConnection();//�������ݿ�
	}
	@Override
	public boolean login(User user) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null; //׼����䣨ʹ��sql���ģ�
		boolean flag = false;//�ֲ����������ʼ��
		String sql = "select * from user where name=? and password=?";//���еģ���ʾ����sql���Ĳ���
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUsername());//���β�����
			pstmt.setString(2, user.getPassword());
			flag = pstmt.executeQuery().next();//ִ��sql���(����н��������true ����false)
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

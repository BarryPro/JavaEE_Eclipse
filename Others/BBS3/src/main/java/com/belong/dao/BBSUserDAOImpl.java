package com.belong.dao;

import java.io.FileInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.belong.db.DBCP;
import com.belong.vo.BBSUser;

public class BBSUserDAOImpl implements IBBSUserDAO {
	private static Connection conn;
	public BBSUserDAOImpl(){
		conn = DBCP.getConnection();
	}
	@Override
	public BBSUser login(BBSUser user) {
		// TODO Auto-generated method stub
		BBSUser user1 = new BBSUser();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from user where username = ? and password = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();
			if(rs.next()){
				user1.setId(rs.getInt("id"));
				user1.setUsername(rs.getString("username"));
				user1.setPassword(rs.getString("password"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps!=null){
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return user1;
	}
	@Override
	public boolean register(BBSUser user) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "insert into user(username,password,pic) values(?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			FileInputStream fis = new FileInputStream(user.getPath());
			ps.setBinaryStream(3, fis,fis.available());
			flag = ps.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if(ps!=null){
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return flag;
	}
	@Override
	public byte[] getPic(int id) {
		// TODO Auto-generated method stub
		String sql = "select pic from user where id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		byte[] buffer = null;;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if(rs.next()){
				Blob b = rs.getBlob("pic");
				buffer = b.getBytes(1,(int)b.length());//从头转化				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps!=null){
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return buffer;
	}
	@Override
	public boolean editPagenum(int id,int pagenum) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement ps = null;
		String sql = "update user set pagenum = ? where id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pagenum);
			ps.setInt(2, id);
			flag = ps.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return flag;
	}

}

package com.belong.dao;

import java.io.FileInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.belong.db.Druid;
import com.belong.vo.BBSUser;

public class BBSUserDAOImpl implements IBBSUserDAO {
	private static Connection conn;
	public BBSUserDAOImpl(){
		conn = Druid.getConnection();//链接数据库
	}
	@Override
	public BBSUser login(BBSUser user) {
		// TODO Auto-generated method stub
		PreparedStatement ps = null;//准备语句
		ResultSet rs = null;
		BBSUser user1 = new BBSUser();//保证查询传出来的是数据库里存在的用户
		String sql = "select * from bbsuser where username = ? and password = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();//查询一次看数据库里是否有对应的用户
			while(rs.next()){
				user1.setUsername(user.getUsername());
				user1.setPassword(user.getPassword());
				user1.setId(rs.getInt("id"));
			}
		} catch (Exception e) {
			// TODO: handle exception
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
		String sql = "insert into bbsuser (username,password,pic) values(?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			FileInputStream fis = new FileInputStream(user.getPath());//把输入文件的路径给文件输入流
			ps.setBinaryStream(3, fis, fis.available());//文件的绝对大小
			flag = ps.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
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
		byte[] buffer = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select pic from bbsuser where id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if(rs.next()){//就一笔数据（因为是通过id查询的）
				Blob b = rs.getBlob("pic");
				buffer = b.getBytes(1, (int) b.length());//把图片类型变成字节型来存储
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
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
	public boolean editPagenum(int pagenum, int userid) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "update bbsuser set pagenum = ? where id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pagenum);
			ps.setInt(2, userid);
			flag = ps.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
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

}

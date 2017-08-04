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
	private Connection conn;
	public BBSUserDAOImpl(){		
		conn=Druid.getConnection();
	}
	
	@Override
	public BBSUser login(BBSUser user) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from bbsuser where username=? and password=?";
		BBSUser user1=null;
		try {
			pstmt=conn.prepareStatement(sql);			
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());			
			rs=pstmt.executeQuery();
			if( rs.next()){
				user1=new BBSUser();
				user1.setUsername(user.getUsername());
				user1.setId(rs.getInt("id"));
			}			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}		
		return user1;
	}

	@Override
	public boolean register(BBSUser user) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt=null;
		boolean flag=false;
		try {
			pstmt=conn.prepareStatement("insert into bbsuser(username,password,pic) "
					+ "values(?,?,?)");			
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());			
			FileInputStream fis=new FileInputStream(user.getPath());
			pstmt.setBinaryStream(3, fis, fis.available());
			flag=pstmt.executeUpdate()>0;			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{			
			if(pstmt!=null){
				try {
					pstmt.close();
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
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		byte[] buffer=null;
		try {			
			String sql="select pic from bbsuser where id=?";			
			pstmt=conn.prepareStatement(sql);			
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				Blob b=rs.getBlob("pic");				
				buffer=b.getBytes(1,(int)b.length());//变成字节				
			}			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		}
		return buffer;		
	}

	@Override
	public boolean editPageNum(int pagenum, int userid) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement pstmt = null;
		try {
			String sql = "update bbsuser set pagenum = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pagenum);
			pstmt.setInt(2, userid);
			flag = pstmt.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
		return flag;
	}
}

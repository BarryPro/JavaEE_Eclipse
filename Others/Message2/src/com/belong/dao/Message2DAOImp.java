package com.belong.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.belong.db.DB;
import com.belong.vo.Message2;

public class Message2DAOImp implements IMessage2DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	public Message2DAOImp(){
		conn = DB.getConnection();//Á´½ÓÊý¾Ý¿â
	}
	@Override
	public boolean addMessage(Message2 message) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "insert into board(name,email,title,content,date) values(?,?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, message.getName());
			pstmt.setString(2, message.getEmail());
			pstmt.setString(3, message.getTitle());
			pstmt.setString(4, message.getContent());
			flag = pstmt.executeUpdate()>0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return flag;
	}
	@Override
	public List<Message2> queryMessage() {
		// TODO Auto-generated method stub
		ResultSet rs = null;
		List<Message2> list = new ArrayList<Message2>();
		String sql = "select * from board where id order by id desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Message2 message = new Message2();
				message.setId(rs.getInt("id"));
				message.setName(rs.getString("name"));
				message.setTitle(rs.getString("title"));
				message.setEmail(rs.getString("email"));
				message.setContent(rs.getString("content"));				
				message.setDate(rs.getString("date"));
				list.add(message);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return list;
	}
	@Override
	public boolean delMessage(Message2 message) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "delete from board where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, message.getId());
			flag = pstmt.executeUpdate()>0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try{
				if(pstmt!=null){
					pstmt.close();
				}
			}catch(Exception e){
				e.getMessage();
			}					
		}
		return flag;
	}

}

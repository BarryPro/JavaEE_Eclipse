package com.belong.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.belong.db.DB;
import com.belong.vo.Music;

public class MusicDAOImp implements IMusicDAO {
	private Connection conn; 
	public MusicDAOImp(){
		conn = DB.getConnection();
	}
	@Override
	public boolean addMusic(Music music) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		boolean flag = false;
		String sql = "insert into song(name,singer,special,date) values(?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, music.getName());
			pstmt.setString(2, music.getSinger());
			pstmt.setString(3, music.getSpecial());
			flag = pstmt.executeUpdate()>0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
	public boolean delMusic(Music music) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		boolean flag = false;
		String sql = "delete from song where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, music.getId());
			flag = pstmt.executeUpdate()>0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
	public List<Music> queryMusic() {
		// TODO Auto-generated method stub
		List<Music> list = new ArrayList<Music>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from song where id order by id desc";
		try {
			pstmt = conn.prepareStatement(sql);			
			rs = pstmt.executeQuery();
			while(rs.next()){
				Music music = new Music();
				music.setId(rs.getInt("id"));
				music.setName(rs.getString("name"));
				music.setSinger(rs.getString("singer"));
				music.setSpecial(rs.getString("special"));
				music.setDate(rs.getString("date"));
				list.add(music);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		return list;
	}

}

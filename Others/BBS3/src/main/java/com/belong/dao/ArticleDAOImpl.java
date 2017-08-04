package com.belong.dao;

import java.io.StringReader;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.belong.db.Druid;
import com.belong.vo.Article;
import com.belong.vo.BBSUser;
import com.belong.vo.PageBean;


public class ArticleDAOImpl implements IArticleDAO {
	private Connection conn;
	public ArticleDAOImpl(){
		conn = Druid.getConnection();
	}
	@Override
	public PageBean queryArticleByPage(int curpage, int userid) {
		// TODO Auto-generated method stub
		PageBean pb = new PageBean();
		CallableStatement cs = null;
		ResultSet rs = null;
		String sql = "call paging(?,?,?,?,?)";
		try {
			cs =  conn.prepareCall(sql);
			cs.setInt(1, curpage);
			cs.setInt(2, userid);
			cs.registerOutParameter(3, java.sql.Types.INTEGER);
			cs.registerOutParameter(4, java.sql.Types.INTEGER);
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			ArrayList<Article> list = new ArrayList<Article>();
			boolean flag = cs.execute();
			while(flag){
				pb.setCurPage(curpage);
				pb.setRowPerPage(cs.getInt(3));
				pb.setMaxPage(cs.getInt(4));
				pb.setMaxRow(cs.getInt(5));
				rs = cs.getResultSet();
				while(rs.next()){
					Article a = new Article();
					BBSUser user = new BBSUser();
					a.setId(rs.getInt("a.id"));
					a.setRootid(rs.getInt("a.rootid"));
					a.setTitle(rs.getString("a.title"));
					a.setContent(rs.getString("a.content"));
					user.setId(rs.getInt("u.id"));
					a.setUser(user);
					list.add(a);
				}
				pb.setData(list);
				flag = cs.getMoreResults();
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
			if(cs!=null){
				try {
					cs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return pb;
	}
	@Override
	public boolean delArticle(int id) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement ps = null;		
		try {
			if(id==0){//删除主帖
				String sql = "delete from article where id = ? or rootid = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);//主帖id
				ps.setInt(2, id);//从贴id
			} else {//删除从贴
				String sql = "delete from article where id = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);
			}
			flag = ps.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	@Override
	public boolean insertArticle(Article article) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement ps = null;
		String sql = "insert into article(rootid,title,content,userid,datetime) value(?,?,?,?,now())";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, article.getRootid());
			ps.setString(2, article.getTitle());
			StringReader sr = new StringReader(article.getContent());
			ps.setClob(3, sr, article.getContent().length());
			ps.setInt(4, article.getUser().getId());
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
	public ArrayList<Article> queryReplay(int rootid) {
		// TODO Auto-generated method stub
		ArrayList<Article> list = new ArrayList<Article>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from article a inner join user u on(a.userid=u.id) where a.rootid = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rootid);
			rs = ps.executeQuery();
			while(rs.next()){
				Article a =  new Article();
				a.setRootid(rs.getInt("a.rootid"));
				a.setId(rs.getInt("a.id"));
				a.setTitle(rs.getString("a.title"));
				a.setContent(rs.getString("a.content"));
				BBSUser user = new BBSUser();
				user.setId(rs.getInt("u.id"));
				list.add(a);
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
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	@Override
	public String queryTitleById(int rootid) {
		// TODO Auto-generated method stub
		String title = "";
		String sql = "select title from article where id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rootid);
			rs = ps.executeQuery();
			if(rs.next()){
				title = rs.getString("title");
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
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return title;
	}
}



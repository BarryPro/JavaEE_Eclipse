package com.belong.dao;

import java.io.StringReader;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.belong.db.C3P0;
import com.belong.vo.Article;
import com.belong.vo.BBSUser;
import com.belong.vo.PageBean;

public class ArticleDAOImpl implements IArticleDAO {
	private Connection conn=null;
	public ArticleDAOImpl(){
		conn=C3P0.getConnection();		
	}
	public static void main(String[] args) {
		ArticleDAOImpl dao=new ArticleDAOImpl();
		dao.queryArticleByPage(1, 999);
	}
	@Override
	public PageBean queryArticleByPage(int curpage,int userid) {
		// TODO Auto-generated method stub
		CallableStatement cs=null;
		ResultSet rs=null;
		PageBean pb=new PageBean();
		try {
			String sql="call q3(?,?,?,?,?)";
			cs=conn.prepareCall(sql);
			cs.setInt(1, userid);
			cs.setInt(2, curpage);
			cs.registerOutParameter(3, java.sql.Types.INTEGER);
			cs.registerOutParameter(4, java.sql.Types.INTEGER);
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			boolean flag=cs.execute();
			ArrayList<Article> list=new ArrayList<Article>();
			while(flag){
				pb.setCurPage(curpage);
				pb.setRowsPerPage(cs.getInt(3));
				pb.setMaxPage(cs.getInt(4));
				pb.setMaxRowCount(cs.getInt(5));				
				rs=cs.getResultSet();
				while(rs.next()){					
					Article a=new Article();
					BBSUser user=new BBSUser();
					a.setId(rs.getInt("a.id"));
					a.setTitle(rs.getString("a.title"));
					a.setContent(rs.getString("a.content"));
					a.setRootid(rs.getInt("a.rootid"));
					a.setDatetime(rs.getString("a.datetime"));					
					user.setId(rs.getInt("b.id"));					
					a.setUser(user);					
					list.add(a);
				}
				pb.setData(list);				
				flag=cs.getMoreResults();
			}			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			
			if(cs!=null){
				try {
					cs.close();
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
		return pb;
	}
	@Override
	public boolean delArticle(int id) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt=null;
		boolean flag=false;
		try {
			pstmt=conn.prepareStatement("delete from article where id=? or rootid=?");			
			pstmt.setInt(1, id);			
			pstmt.setInt(2, id);			
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
	public boolean insertArticle(Article a) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement pstmt = null; 
		try {
			String sql = "insert into article(rootid,title,content,userid,datetime) values(?,?,?,?,now())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, a.getRootid());
			pstmt.setString(2, a.getTitle());
			StringReader reader = new StringReader(a.getContent());//把长文本文件以字符流的形式读到内存中
			//写clob
			pstmt.setCharacterStream(3, reader, a.getContent().length());
			pstmt.setInt(4, a.getUser().getId());
			flag = pstmt.executeUpdate()>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
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
}

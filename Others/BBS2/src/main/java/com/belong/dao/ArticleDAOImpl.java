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
	private Connection conn;//链接数据库
	public ArticleDAOImpl(){
		conn = Druid.getConnection();
	}
	@Override
	public PageBean queryArticleByPage(int curpage, int userid) {
		// TODO Auto-generated method stub
		PageBean pb = new PageBean();
		CallableStatement cs = null;//负责调用存储过程
		String sql = "call q3(?,?,?,?,?)";
		ResultSet rs = null;
		try {
			cs = conn.prepareCall(sql);
			//前两个参数是输入
			cs.setInt(1, userid);
			cs.setInt(2, curpage);
			//后三个是输出(用注册的)
			cs.registerOutParameter(3, java.sql.Types.INTEGER);
			cs.registerOutParameter(4, java.sql.Types.INTEGER);
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			boolean flag = cs.execute();//执行完之后out的结果就在cs中
			ArrayList<Article> list = new ArrayList<Article>();//存放文章信息
			while(flag){//循环把cs中的结果赋到pagebean的对象上
				pb.setCurPage(curpage);
				pb.setNumPerPage(cs.getInt(3));//得到输出结果
				pb.setMaxRowCount(cs.getInt(4));
				pb.setMaxPage(cs.getInt(5));
				rs = cs.getResultSet();//用于接收存储过程中的插旬结果
				while(rs.next()){
					Article a = new Article();//声明一个存储返回的article结果
					BBSUser user = new BBSUser();//article里有user对象
					a.setId(rs.getInt("a.id"));
					a.setRootid(rs.getInt("a.rootid"));
					a.setTitle(rs.getString("a.title"));
					a.setContent(rs.getString("a.content"));
					a.setDatetime(rs.getString("a.datetime"));
					user.setId(rs.getInt("b.id"));
					a.setUser(user);
					list.add(a);//把article塞进表单中
				}
				pb.setData(list);//把表单赋到pagebean中的参数中				
				flag = cs.getMoreResults();//用于结束判断
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
		PreparedStatement ps = null;
		boolean flag = false;
		String sql = "";
		
		try {
			if(id==0){//删除主帖
				sql = "delete from article where id = ? or rootid = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);//找到主贴
				ps.setInt(2, id);//找到从贴
				flag = ps.executeUpdate()>0;
			} else {//删除从贴
				sql = "delete from article where id = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);//找到从贴
				flag = ps.executeUpdate()>0;
			}			
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
	public boolean insertArticle(Article article) {
		// TODO Auto-generated method stub
		boolean flag = false;
		PreparedStatement ps = null;
		String sql = "insert into article (rootid,title,content,userid,datetime) "+
		"values(?,?,?,?,now())";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, article.getRootid());
			ps.setString(2, article.getTitle());
			//读取长文本信息
			StringReader reader = new StringReader(article.getContent());
			ps.setClob(3, reader, article.getContent().length());//加上文本的长度
			ps.setInt(4, article.getUser().getId());
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
	public ArrayList<Article> queryReply(int rootid) {
		// TODO Auto-generated method stub
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from article a inner join bbsuser b on(a.userid=b.id) "+
				"where rootid=?";
		ArrayList<Article> list = new ArrayList<Article>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rootid);
			rs = ps.executeQuery();
			while(rs.next()){
				Article a = new Article();
				BBSUser user = new BBSUser();
				a.setId(rs.getInt("a.id"));
				a.setRootid(rs.getInt("a.rootid"));
				a.setTitle(rs.getString("a.title"));
				a.setContent(rs.getString("a.content"));
				user.setId(rs.getInt("b.id"));
				a.setUser(user);
				list.add(a);
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
		return list;
	}
	@Override
	public String queryTitleById(int rootid) {
		// TODO Auto-generated method stub
		String title = "";
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select title from article where id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rootid);
			rs = ps.executeQuery();
			if(rs.next()){
				title = rs.getString("title");
			}
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
		return title;
	}

}

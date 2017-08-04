package com.belong.dao;

import java.util.ArrayList;

import com.belong.vo.Article;
import com.belong.vo.PageBean;

public interface IArticleDAO {
	public PageBean queryArticleByPage(int curpage,int userid);
	public boolean delArticle(int id);
	public boolean insertArticle(Article article);
	public ArrayList<Article> queryReply(int rootid);//通过rootid来获得回帖的内容返回值是fastjson类型
	public String queryTitleById(int rootid);//来找到主帖的标题
}

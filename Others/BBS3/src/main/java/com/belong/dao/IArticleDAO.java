package com.belong.dao;

import java.util.ArrayList;

import com.belong.vo.Article;
import com.belong.vo.PageBean;

public interface IArticleDAO {
	public PageBean queryArticleByPage(int curpage,int userid);//获得分页
	public boolean delArticle(int id);
	public boolean insertArticle(Article article);
	public ArrayList<Article> queryReplay(int rootid);
	public String queryTitleById(int rootid);
}

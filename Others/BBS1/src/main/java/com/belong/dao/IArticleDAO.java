package com.belong.dao;

import com.belong.vo.Article;
import com.belong.vo.PageBean;

public interface IArticleDAO {
	public PageBean queryArticleByPage(int curpage,int userid);
	public boolean delArticle(int id);
	public boolean insertArticle(Article a);
}

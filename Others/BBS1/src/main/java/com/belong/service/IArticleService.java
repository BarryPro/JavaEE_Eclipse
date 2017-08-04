package com.belong.service;

import com.belong.vo.Article;
import com.belong.vo.PageBean;

public interface IArticleService {
	public PageBean queryArticleByPage(int curPage,int userid);
	public boolean delArticle(int id);
	public boolean insertArticle(Article a);
}

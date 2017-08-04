package com.belong.service;

import com.belong.dao.ArticleDAOImpl;
import com.belong.dao.IArticleDAO;
import com.belong.vo.Article;
import com.belong.vo.PageBean;

public class ArticleServiceImpl implements IArticleService {
	private IArticleDAO dao=new ArticleDAOImpl();
	@Override
	public PageBean queryArticleByPage(int curpage, int userid) {
		// TODO Auto-generated method stub
		return dao.queryArticleByPage(curpage, userid);
	}
	@Override
	public boolean delArticle(int id) {
		// TODO Auto-generated method stub
		return dao.delArticle(id);
	}
	@Override
	public boolean insertArticle(Article a) {
		// TODO Auto-generated method stub
		return dao.insertArticle(a);
	}

}

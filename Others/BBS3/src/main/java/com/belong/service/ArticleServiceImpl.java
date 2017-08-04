package com.belong.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.belong.dao.ArticleDAOImpl;
import com.belong.dao.IArticleDAO;
import com.belong.vo.Article;
import com.belong.vo.PageBean;

public class ArticleServiceImpl implements IArticleService {
	private IArticleDAO dao = new ArticleDAOImpl();
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
	public boolean insertArticle(Article article) {
		// TODO Auto-generated method stub
		return dao.insertArticle(article);
	}
	@Override
	public String queryReplay(int rootid) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("title", this.queryTitleById(rootid));
		map.put("list", dao.queryReplay(rootid));
		String json = JSON.toJSONString(map);
		return json;
	}
	@Override
	public String queryTitleById(int rootid) {
		// TODO Auto-generated method stub
		return dao.queryTitleById(rootid);
	}

}

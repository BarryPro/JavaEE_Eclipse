package com.belong.service;

import java.util.ArrayList;

import com.belong.vo.Article;
import com.belong.vo.PageBean;

public interface IArticleService {
	public PageBean queryArticleByPage(int curpage,int userid);
	public boolean delArticle(int id);
	public boolean insertArticle(Article article);
	public String queryReplay(int rootid);
	public String queryTitleById(int rootid);
}

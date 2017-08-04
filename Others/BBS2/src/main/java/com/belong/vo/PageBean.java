package com.belong.vo;

import java.util.ArrayList;

public class PageBean {
	private int curPage;//当前页(用于计算出当前页所含的贴数)
	private int maxPage;//最大页（分的页数）
	private int maxRowCount;//最大行（总贴数）
	private int numPerPage;//每页的帖子的数量
	private ArrayList<Article> data;//发帖信息
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getMaxRowCount() {
		return maxRowCount;
	}
	public void setMaxRowCount(int maxRowCount) {
		this.maxRowCount = maxRowCount;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public ArrayList<Article> getData() {
		return data;
	}
	public void setData(ArrayList<Article> data) {
		this.data = data;
	}
}

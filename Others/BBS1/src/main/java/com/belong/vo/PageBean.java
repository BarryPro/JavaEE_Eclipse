package com.belong.vo;

import java.io.Serializable;
import java.util.ArrayList;
/*
 * 分页类负责分页
 */
public class PageBean implements Serializable{
	private int curPage;//当前页
	private int maxPage;//最大页数
	private int maxRowCount;//最大行数
	private int rowsPerPage;//每页的行数
	private ArrayList<Article> data;//储存文章类的内容
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
	public int getRowsPerPage() {
		return rowsPerPage;
	}
	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}
	public ArrayList<Article> getData() {
		return data;
	}
	public void setData(ArrayList<Article> data) {
		this.data = data;
	}
}

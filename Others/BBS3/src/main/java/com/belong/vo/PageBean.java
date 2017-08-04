package com.belong.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class PageBean implements Serializable {
	private int curPage;
	private int rowPerPage;
	private int maxPage;
	private int maxRow;//主帖的总个数
	private ArrayList<Article> data;
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getMaxRow() {
		return maxRow;
	}
	public void setMaxRow(int maxRow) {
		this.maxRow = maxRow;
	}
	public ArrayList<Article> getData() {
		return data;
	}
	public void setData(ArrayList<Article> data) {
		this.data = data;
	}
}

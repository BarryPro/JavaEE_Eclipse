package com.sitech.acctmgr.atom.domains.bill;

import com.sitech.acctmgr.net.Bill;
import com.sitech.acctmgr.net.bill.BillResponseHeader;
import com.sitech.acctmgr.net.bill.BookBody;

import java.util.List;

public class UnBillData {
	
	private BillResponseHeader header;
	private List<Bill> billList;
	private List<BookBody> bookList;
	
	public BillResponseHeader getHeader() {
		return header;
	}
	
	public List<Bill> getBillList(){
		return billList;
	}
	public List<BookBody> getBookList(){
		return bookList;
	}
	
	public UnBillData(BillResponseHeader h, List<Bill> bill, List<BookBody> book){
		header = h;
		billList = bill;
		bookList = book;
	}
	
	
}

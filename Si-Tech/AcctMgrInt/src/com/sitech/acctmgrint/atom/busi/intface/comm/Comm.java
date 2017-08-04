package com.sitech.acctmgrint.atom.busi.intface.comm;

public class Comm {

	
	public String utfToGbk(String in_utf) {
		String out_gbk = "";
		byte[] b_para = null;
		try {
			b_para = in_utf.getBytes("GBK");
			out_gbk = new String(b_para, "GBK");
		} catch (Exception e) {
			System.err.println("utfToGbk failed.in_utf="+in_utf);
		}
		return out_gbk;
	}
	
	public String gbkToUtf(String in_gbk) {
		String out_utf = "";
		byte[] b_para = null;
		try {
			b_para = in_gbk.getBytes("UTF-8");
			out_utf = new String(b_para, "UTF-8");
		} catch (Exception e) {
			System.err.println("gbkToUtf failed.in_utf="+in_gbk);
		}
		return out_utf;
	}
	
}

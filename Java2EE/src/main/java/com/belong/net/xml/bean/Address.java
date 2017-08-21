package com.belong.net.xml.bean;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class Address {
	private String no;
	private String addr;

	/**
	 * @return the no
	 */
	public String getNo() {
		return no;
	}

	/**
	 * @param no
	 *            the no to set
	 */
	public void setNo(String no) {
		this.no = no;
	}

	/**
	 * @return the addr
	 */
	public String getAddr() {
		return addr;
	}

	/**
	 * @param addr
	 *            the addr to set
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}

	@Override
	public String toString() {
		return "编号:" + this.no + "，地址：" + this.addr;
	}
}

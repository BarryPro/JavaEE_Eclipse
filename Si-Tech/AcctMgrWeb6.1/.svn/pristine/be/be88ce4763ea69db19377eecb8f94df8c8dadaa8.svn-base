package com.sitech.acctmgr.atom.domains.pay;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title: 支票数据实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class ChequeEntity implements Serializable {

	@JSONField(name="BANK_CODE")
	private String	bankCode;
	
	@JSONField(name="CHECK_NO")
	private String	checkNo;
	
	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	/**
	 * @param bankCode
	 * @param checkNo
	 */
	public ChequeEntity(String bankCode, String checkNo) {
		super();
		this.bankCode = bankCode;
		this.checkNo = checkNo;
	}
	
	/**
	 * 
	 */
	public ChequeEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ChequeEntity [bankCode=" + bankCode + ", checkNo=" + checkNo
				+ "]";
	}

	/**
	 * @return the bankCode
	 */
	public String getBankCode() {
		return bankCode;
	}

	/**
	 * @param bankCode the bankCode to set
	 */
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	/**
	 * @return the checkNo
	 */
	public String getCheckNo() {
		return checkNo;
	}

	/**
	 * @param checkNo the checkNo to set
	 */
	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}
	
	public static void main(String[] args) {
		
		ChequeEntity cheque = new ChequeEntity();
		cheque.setBankCode("农业银行");
		cheque.setCheckNo("123456");
		
		Map<String, Object> testMap = cheque.toMap();
		
		System.out.println("测试转换Map： " + testMap);
	}
	
}



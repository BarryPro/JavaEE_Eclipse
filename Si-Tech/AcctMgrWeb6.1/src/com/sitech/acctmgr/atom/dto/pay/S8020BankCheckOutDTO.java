package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

 
/**
* @Description: 一点支付缴费：银行&支票查询 出参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020BankCheckOutDTO extends CommonOutDTO{
 
	private static final long serialVersionUID = 8821218684302825793L;
	
	@JSONField(name="CHECK_PREPAY")
	@ParamDesc(path="CHECK_PREPAY",cons=ConsType.QUES,type="long",len="14",desc="支票余额",memo="略")
	protected long  checkPrepay;
	
	@JSONField(name="BANK_LEN")
	@ParamDesc(path="BANK_LEN",cons=ConsType.QUES,type="int",len="14",desc="银行数量",memo="略")
	protected int  bankLen;
	
	@JSONField(name="LIST_BANK")
	@ParamDesc(path="LIST_BANK",cons=ConsType.STAR,type="compx",len="1",desc="银行列表",memo="略")
	protected List<BankEntity> bankList;

	public S8020BankCheckOutDTO() {
	}

	public S8020BankCheckOutDTO(String sJson) {
		MBean mBean = new MBean(sJson);
		this.checkPrepay = mBean.getBodyLong("OUT_DATA.CHECK_PREPAY");
		this.bankLen = mBean.getBodyInt("OUT_DATA.BANK_LEN");
		this.bankList =  (List<BankEntity>) mBean.getList(getPathByProperName("bankList"));
	}
	
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("checkPrepay"), checkPrepay);
		result.setRoot(getPathByProperName("bankLen"), bankLen);
		result.setRoot(getPathByProperName("bankList"), bankList);
		return result;
	}

	/**
	 * @return the checkPrepay
	 */
	public long getCheckPrepay() {
		return checkPrepay;
	}

	/**
	 * @param checkPrepay the checkPrepay to set
	 */
	public void setCheckPrepay(long checkPrepay) {
		this.checkPrepay = checkPrepay;
	}

	/**
	 * @return the bankLen
	 */
	public int getBankLen() {
		return bankLen;
	}

	/**
	 * @param bankLen the bankLen to set
	 */
	public void setBankLen(int bankLen) {
		this.bankLen = bankLen;
	}

	/**
	 * @return the bankList
	 */
	public List<BankEntity> getBankList() {
		return bankList;
	}

	/**
	 * @param bankList the bankList to set
	 */
	public void setBankList(List<BankEntity> bankList) {
		this.bankList = bankList;
	}
 
}

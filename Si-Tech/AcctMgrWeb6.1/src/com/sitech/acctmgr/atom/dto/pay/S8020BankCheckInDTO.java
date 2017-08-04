package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Title:   []
* @Description: 一点支付缴费 银行&支票查询 入参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
*  20150312 lijxd   dto改造：参数打印
 */
public class S8020BankCheckInDTO extends CommonInDTO{

 
	/**
	 * 
	 */
	private static final long serialVersionUID = 7981376213864014063L;
	
	//protected String sLoginNo;

	@ParamDesc(path="BUSI_INFO.CHECK_FLAG",cons=ConsType.CT001,type="String",len="1",desc="银行支票标志",memo="Y:支票查询;N:银行查询")
	protected String checkFlag;
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.QUES,type="String",len="12",desc="银行代码",memo="略")
	protected String bankCode;
	@ParamDesc(path="BUSI_INFO.BANK_NAME",cons=ConsType.QUES,type="String",len="60",desc="银行名称",memo="略")
	protected String bankName;
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.QUES,type="String",len="20",desc="支票代码",memo="略")
	protected String checkNo;


	 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setCheckFlag(arg0.getStr(getPathByProperName("checkFlag")));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("checkNo")))){
			setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("bankCode")))){
			setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("bankName")))){
			setBankName(arg0.getStr(getPathByProperName("bankName")));
		}
		
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
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}


	/**
	 * @param bankName the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
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


	/**
	 * @return the checkFlag
	 */
	public String getCheckFlag() {
		return checkFlag;
	}


	/**
	 * @param checkFlag the checkFlag to set
	 */
	public void setCheckFlag(String checkFlag) {
		this.checkFlag = checkFlag;
	}

 

	 
}


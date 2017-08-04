package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  陈死账确认入参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author linzc
 * @version 1.0
 */
public class S8006CfmInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7969966432390407792L;
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="long",len="40",desc="用户标识",memo="略")
	private long	idNo;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;    
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.QUES,type="String",len="40",desc="缴费金额",memo="略")
	private long payMoney;    
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.QUES,type="String",len="40",desc="付费类型",memo="略")
	private String payType;
	@ParamDesc(path="BUSI_INFO.DELAY_RATE",cons=ConsType.QUES,type="double",len="40",desc="滞纳金优惠率",memo="略")
	private double delayRate;
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.QUES,type="String",len="40",desc="银行代码[对支票交费]",memo="略")
	private String bankCode;
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.QUES,type="String",len="40",desc="支票号码[对支票交费]",memo="略")
	private String checkNo;
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="40",desc="缴费备注",memo="略")
	private String payNote;
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.QUES,type="String",len="40",desc="陈账死账标识",memo="略")
	private String backType;
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.QUES,type="String",len="40",desc="缴费渠道",memo="略")
	private String payPath;
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.QUES,type="String",len="40",desc="缴费方式",memo="略")
	private String payMethod;
	@ParamDesc(path="BUSI_INFO.SHOULD_PAY",cons=ConsType.QUES,type="String",len="40",desc="应收金额",memo="略")
	private String shouldPay;
	@ParamDesc(path="BUSI_INFO.BILL_YM_STR",cons=ConsType.QUES,type="String",len="1024",desc="指定回收陈死账月份",memo="月份与月份间用“|”分隔，例如：“201606|201607”")
	private String billYMStr;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setIdNo(Long.parseLong(arg0.getObject(getPathByProperName("idNo")).toString()));
		setPhoneNo(StringUtils.castToString(arg0.getObject(getPathByProperName("phoneNo"))));
		setPayMoney(Long.parseLong(arg0.getObject(getPathByProperName("payMoney")).toString()));
		setPayType(StringUtils.castToString(arg0.getObject(getPathByProperName("payType"))));
		setDelayRate(Double.parseDouble(StringUtils.castToString(arg0.getObject(getPathByProperName("delayRate")))));
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("bankCode")))){
			setBankCode(StringUtils.castToString(arg0.getObject(getPathByProperName("bankCode"))));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("checkNo")))){
			setCheckNo(StringUtils.castToString(arg0.getObject(getPathByProperName("checkNo"))));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("payNote")))){
			setPayNote(StringUtils.castToString(arg0.getObject(getPathByProperName("payNote"))));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("payPath")))){
			setPayPath(StringUtils.castToString(arg0.getObject(getPathByProperName("payPath"))));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("payMethod")))){
			setPayMethod(StringUtils.castToString(arg0.getObject(getPathByProperName("payMethod"))));
		}
		setBackType(StringUtils.castToString(arg0.getObject(getPathByProperName("backType"))));
		setShouldPay(StringUtils.castToString(arg0.getObject(getPathByProperName("shouldPay"))));
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("billYMStr")))){
			setBillYMStr(StringUtils.castToString(arg0.getObject(getPathByProperName("billYMStr"))));
		}
		
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public double getDelayRate() {
		return delayRate;
	}

	public void setDelayRate(double delayRate) {
		this.delayRate = delayRate;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getPayNote() {
		return payNote;
	}

	public void setPayNote(String payNote) {
		this.payNote = payNote;
	}


	public String getBackType() {
		return backType;
	}

	public void setBackType(String backType) {
		this.backType = backType;
	}

	public String getPayPath() {
		return payPath;
	}

	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	/**
	 * @return the shouldPay
	 */
	public String getShouldPay() {
		return shouldPay;
	}

	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(String shouldPay) {
		this.shouldPay = shouldPay;
	}

	/**
	 * @return the billYMStr
	 */
	public String getBillYMStr() {
		return billYMStr;
	}

	/**
	 * @param billYMStr the billYMStr to set
	 */
	public void setBillYMStr(String billYMStr) {
		this.billYMStr = billYMStr;
	}

	
	
}


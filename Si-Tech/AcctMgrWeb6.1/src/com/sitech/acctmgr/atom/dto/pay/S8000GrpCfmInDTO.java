package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8000GrpCfmInDTO extends CommonInDTO{

	private static final long serialVersionUID = 2396471888256611927L;

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long   contractNo;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="缴费金额",memo="略")
	private String payMoney;
	
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",memo="略")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",memo="略")
	private String payMethod;
	
	@ParamDesc(path="BUSI_INFO.DELAY_RATE",cons=ConsType.QUES,type="double",len="5",desc="滞纳金优惠率",memo="略")
	private double delayRate;
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.QUES,type="String",len="12",desc="银行编码",memo="略")
	private String bankCode;
	
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.QUES,type="String",len="20",desc="支票号码",memo="略")
	private String checkNo;
	
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="100",desc="缴费备注",memo="略")
	private String payNote;
	
	@ParamDesc(path="BUSI_INFO.IS_DOWEINV",cons=ConsType.QUES,type="String",len="1",desc="集团预开发票回收标识",memo="预开发票回收： R")
	private String isDoweInv;

	@ParamDesc(path="BUSI_INFO.PRE_LOGIN_ACCEPT",cons=ConsType.QUES,type="String",len="20",desc="集团预开发票，开票流水",memo="略")
	private long preloginAccept;
	
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8000";//设置默认值
		}
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setPayMoney(arg0.getStr(getPathByProperName("payMoney")));
		if(payMoney.equals("")){
			payMoney = "0";
		}
		setPayType(arg0.getStr(getPathByProperName("payType")));
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		if(arg0.getBodyStr("BUSI_INFO.DELAY_RATE") != null && !arg0.getBodyStr("BUSI_INFO.DELAY_RATE").toString().equals("")){
			setDelayRate(Double.parseDouble(arg0.getStr(getPathByProperName("delayRate"))));
		}else{
			delayRate = 0;
		}
		
		bankCode = arg0.getStr(getPathByProperName("bankCode"));
		checkNo = arg0.getStr(getPathByProperName("checkNo"));
		
		setPayNote(arg0.getStr(getPathByProperName("payNote")));
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "集团缴费" + payMoney + "分";//设置缴费默认备注，待完善
		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("isDoweInv")))){
			isDoweInv = arg0.getStr(getPathByProperName("isDoweInv"));
			
		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("preloginAccept")))){
			preloginAccept = Long.parseLong(arg0.getStr(getPathByProperName("preloginAccept")));
		}
		
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
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

	public String getIsDoweInv() {
		return isDoweInv;
	}

	public void setIsDoweInv(String isDoweInv) {
		this.isDoweInv = isDoweInv;
	}

	public long getPreloginAccept() {
		return preloginAccept;
	}

	public void setPreloginAccept(long preloginAccept) {
		this.preloginAccept = preloginAccept;
	}


}

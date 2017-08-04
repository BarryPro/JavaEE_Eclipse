package com.sitech.acctmgr.atom.dto.pay;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.AccountPayedEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Title:   []
* @Description: 一点支付账户缴费确认服务入参DTO
* @Date :2016/6/22
* @Company: SI-TECH
* @author : qiaolin
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020CfmInDTO extends CommonInDTO{
 
	private static final long serialVersionUID = -3686455472641785760L;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long  contractNo ;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="缴费金额",memo="略")
	protected long  payMoney ;
	
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
	protected String payType ;
	
	@ParamDesc(path="BUSI_INFO.DELAY_RATE",cons=ConsType.CT001,type="String",len="12",desc="滞纳金优惠比率",memo="略")
	protected String delayRate ;
	
	@ParamDesc(path="BUSI_INFO.YEAR_MONTH",cons=ConsType.CT001	,type="String",len="6",desc="年月",memo="略")
	protected String yearMonth ;
	 
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.QUES,type="String",len="12",desc="银行代码",memo="略")
	protected String bankCode;
	
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.QUES,type="String",len="20",desc="支票代码",memo="略")
	protected String checkNo;
	
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="1024",desc="备注",memo="略")
	protected String payNote ;
	
	@ParamDesc(path = "BUSI_INFO.IS_DOWEINV", cons = ConsType.QUES, type = "String", len = "1", desc = "先开票后缴费标识", memo = "先开票后缴费： R")
	private String isDoweInv;
	
	@ParamDesc(path="BUSI_INFO.PRE_LOGIN_ACCEPT",cons=ConsType.QUES,type="String",len="20",desc="集团预开发票，开票流水",memo="略")
	private long preloginAccept;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setPayMoney(Long.parseLong(arg0.getObject(getPathByProperName("payMoney")).toString()));
		setPayType(arg0.getStr(getPathByProperName("payType")));
		setDelayRate(arg0.getStr(getPathByProperName("delayRate")));
		setYearMonth(arg0.getStr(getPathByProperName("yearMonth")));

		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("checkNo")))){
			setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("bankCode")))){
			setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payNote")))){
			setPayNote(arg0.getStr(getPathByProperName("payNote")).trim());
		}else {
			String sFee = String.format("%.2f", (double)payMoney/100);
			payNote = loginNo +"支付帐户交费:"+contractNo+"缴纳:"+sFee+"元";
		}
		
		isDoweInv = arg0.getStr(getPathByProperName("isDoweInv"));
		if (StringUtils.isEmptyOrNull(isDoweInv)){
			isDoweInv = "N";
		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("preloginAccept")))){
			preloginAccept = Long.parseLong(arg0.getStr(getPathByProperName("preloginAccept")));
		}

	}

	public long getPreloginAccept() {
		return preloginAccept;
	}

	public void setPreloginAccept(long preloginAccept) {
		this.preloginAccept = preloginAccept;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
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

	public String getDelayRate() {
		return delayRate;
	}

	public void setDelayRate(String delayRate) {
		this.delayRate = delayRate;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
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

}


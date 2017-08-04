package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8080QueryPayInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 879859969191944100L;

	
	@JSONField(name = "BILL_YEAR")
	@ParamDesc(path="BILL_YEAR",cons=ConsType.STAR,type="String",len="40",desc="欠费年",memo="略")
    private String billYear;
	@JSONField(name = "BILL_MONTH")
	@ParamDesc(path="BILL_MONTH",cons=ConsType.STAR,type="String",len="100",desc="欠费月",memo="略")
    private String billMonth;
	@JSONField(name = "PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.STAR,type="long",len="40",desc="缴费金额",memo="略")
    private long payFee;
	@JSONField(name = "DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.STAR,type="long",len="40",desc="缴滞纳金金额",memo="略")
    private long delayFee;
	@JSONField(name = "ALL_FEE")
	@ParamDesc(path="ALL_FEE",cons=ConsType.STAR,type="long",len="40",desc="缴费总金额",memo="略")
    private long allFee;
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("billYear"), billYear);
		result.setRoot(getPathByProperName("billMonth"), billMonth);
		result.setRoot(getPathByProperName("delayFee"), delayFee);
		result.setRoot(getPathByProperName("payFee"), payFee);
		result.setRoot(getPathByProperName("allFee"), allFee);
		
		return result;
	}




	public String getBillYear() {
		return billYear;
	}




	public void setBillYear(String billYear) {
		this.billYear = billYear;
	}




	public String getBillMonth() {
		return billMonth;
	}




	public void setBillMonth(String billMonth) {
		this.billMonth = billMonth;
	}




	public long getPayFee() {
		return payFee;
	}




	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}




	public long getDelayFee() {
		return delayFee;
	}




	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}




	public long getAllFee() {
		return allFee;
	}




	public void setAllFee(long allFee) {
		this.allFee = allFee;
	}
	
	
	
}

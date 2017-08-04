package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 欠费催缴确认服务入参 </p>
* <p>Description:   </p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3236143476513921500L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="40",desc="用户idNo",memo="略")
	protected long idNo;	
	@ParamDesc(path="BUSI_INFO.OWE_YEAR",cons=ConsType.CT001,type="String",len="40",desc="欠费年",memo="略")
	protected String oweYear;
	@ParamDesc(path="BUSI_INFO.OWE_MONTH",cons=ConsType.CT001,type="String",len="40",desc="欠费月",memo="略")
	protected String oweMonth;
	@ParamDesc(path="BUSI_INFO.OWE_FEE_PAY",cons=ConsType.CT001,type="String",len="40",desc="缴欠费金额",memo="略")
	protected long oweFeePay;
	@ParamDesc(path="BUSI_INFO.DELAY_FEE_PAY",cons=ConsType.CT001,type="String",len="40",desc="缴滞纳金额",memo="略")
	protected long delayFee;
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="200",desc="备注",memo="略")
	protected String opNote;
	

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))){
			setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		}
		setOweYear(arg0.getStr(getPathByProperName("oweYear")));
		setOweMonth(arg0.getStr(getPathByProperName("oweMonth")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("oweFeePay")))){
			setOweFeePay(Long.parseLong(arg0.getStr(getPathByProperName("oweFeePay"))));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("delayFee")))){
			setDelayFee(Long.parseLong(arg0.getStr(getPathByProperName("delayFee"))));
		}
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
	}
	
	
	
	
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public long getIdNo() {
		return idNo;
	}
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}
	public String getOweYear() {
		return oweYear;
	}
	public void setOweYear(String oweYear) {
		this.oweYear = oweYear;
	}
	public String getOweMonth() {
		return oweMonth;
	}
	public void setOweMonth(String oweMonth) {
		this.oweMonth = oweMonth;
	}
	public long getOweFeePay() {
		return oweFeePay;
	}
	public void setOweFeePay(long oweFeePay) {
		this.oweFeePay = oweFeePay;
	}
	public long getDelayFee() {
		return delayFee;
	}
	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}
	public String getOpNote() {
		return opNote;
	}
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}

package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 崔欠冲正服务入参 </p>
* <p>Description:   </p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8080BackCfmInDTO extends CommonInDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3104290576191671406L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="40",desc="用户idNo",memo="略")
	protected long idNo;	
	@ParamDesc(path="BUSI_INFO.PAY_LOGIN",cons=ConsType.CT001,type="String",len="40",desc="缴费工号",memo="略")
	protected String payLogin;
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="40",desc="缴费流水",memo="略")
	protected String loginAccept;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="40",desc="备注",memo="略")
	protected String remark;
	@ParamDesc(path="ALL_FEE",cons=ConsType.STAR,type="long",len="40",desc="冲正总金额",memo="略")
    private long allFee;
	

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))){
			setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("allFee")))){
			setAllFee(Long.parseLong(arg0.getStr(getPathByProperName("allFee"))));
		}
		setPayLogin(arg0.getStr(getPathByProperName("payLogin")));
		setLoginAccept(arg0.getStr(getPathByProperName("loginAccept")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
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


	public String getPayLogin() {
		return payLogin;
	}


	public void setPayLogin(String payLogin) {
		this.payLogin = payLogin;
	}


	public String getLoginAccept() {
		return loginAccept;
	}


	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public long getAllFee() {
		return allFee;
	}


	public void setAllFee(long allFee) {
		this.allFee = allFee;
	}
	
}

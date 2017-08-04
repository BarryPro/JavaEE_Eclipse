package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title:取用户欠费信息入参  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076InitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4922380471783998106L;
	
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, desc = "服务号码", len = "20", type = "string", memo = "略")
	protected String phoneNo;
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, desc = "用户ID", len = "20", type = "long", memo = "略")
	protected long idNo;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setIdNo(Long.parseLong(arg0.getObject(getPathByProperName("idNo")).toString()));
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


}

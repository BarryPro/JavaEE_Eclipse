package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 取有相同号码的欠费清单入参  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076QueryUsersInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 921136718309134248L;
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, desc = "服务号码", len = "20", type = "String", memo = "略")
	protected String phoneNo;
	
	@ParamDesc(path = "BUSI_INFO.QUERY_FLAG", cons = ConsType.QUES, desc = "查询标识", len = "2", type = "String", memo = "0：查询欠费，1：查询冲正")
	protected String queryFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setQueryFlag(arg0.getStr(getPathByProperName("queryFlag")));
	}
	
	
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getQueryFlag() {
		return queryFlag;
	}


	public void setQueryFlag(String queryFlag) {
		this.queryFlag = queryFlag;
	}

}

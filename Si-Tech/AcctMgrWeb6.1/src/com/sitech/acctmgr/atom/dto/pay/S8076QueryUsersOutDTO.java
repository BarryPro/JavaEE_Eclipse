package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 取有相同号码的欠费清单出参  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076QueryUsersOutDTO  extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2897842640348345789L;

	
	@JSONField(name="LEN_USEROWEINFO")
	@ParamDesc(path="LEN_USEROWEINFO",cons=ConsType.STAR,type="compx",len="4",desc="陈死账欠费用户列表长度",memo="略")
	protected int lenUserOweInfo;

	@JSONField(name="LIST_USEROWEINFO")
	@ParamDesc(path="LIST_USEROWEINFO",cons=ConsType.STAR,type="compx",len="1",desc="陈死账欠费用户列表",memo="略")
	protected List<UserOweEntity> listUserOweInfo;
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("LEN_USEROWEINFO",lenUserOweInfo);
		result.setBody("LIST_USEROWEINFO",listUserOweInfo);
		return result;
	}
	

	public int getLenUserOweInfo() {
		return lenUserOweInfo;
	}


	public void setLenUserOweInfo(int lenUserOweInfo) {
		this.lenUserOweInfo = lenUserOweInfo;
	}


	public List<UserOweEntity> getListUserOweInfo() {
		return listUserOweInfo;
	}


	public void setListUserOweInfo(List<UserOweEntity> listUserOweInfo) {
		this.listUserOweInfo = listUserOweInfo;
	}
}

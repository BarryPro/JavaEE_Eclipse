package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 第三方缴费签约关系设置签约入参DTO  </p>
 * <p>Description: 		  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8297TerminationZfbInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.PHONE_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="服务密码",memo="略")
	private String phonePassword;
	
	@ParamDesc(path="BUSI_INFO.IN_STATE",cons=ConsType.CT001,type="String",len="5",desc="支付宝解约状态",memo="S:解约成功 F:解约失败")
	private String inState;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	private String opNote;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPhonePassword(arg0.getStr(getPathByProperName("phonePassword")));
		setInState(arg0.getStr(getPathByProperName("inState")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
	}



	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getPhonePassword() {
		return phonePassword;
	}

	public void setPhonePassword(String phonePassword) {
		this.phonePassword = phonePassword;
	}

	public String getInState() {
		return inState;
	}

	public void setInState(String inState) {
		this.inState = inState;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}

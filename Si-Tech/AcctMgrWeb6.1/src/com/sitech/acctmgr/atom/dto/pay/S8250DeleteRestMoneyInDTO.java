package com.sitech.acctmgr.atom.dto.pay;


import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8250DeleteRestMoneyInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 311589798016200150L;

	@ParamDesc(path="BUSI_INFO.REGION_CODE",cons=ConsType.CT001,type="String",len="5",desc="配置地市",memo="略")
	private String regionCode;
	
	@ParamDesc(path="BUSI_INFO.OP_CODE",cons=ConsType.CT001,type="String",len="5",desc="opCode",memo="略")
	private String opCode1;
	
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="14",desc="操作流水",memo="")
	private long loginAccept;
	
	@ParamDesc(path="BUSI_INFO.WORK_NO",cons=ConsType.CT001,type="String",len="14",desc="记录工号",memo="当前数据的工号")
	private String workNo;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setOpCode1(arg0.getStr(getPathByProperName("opCode1")));
		setLoginAccept(Long.parseLong(arg0.getStr(getPathByProperName("loginAccept"))));
		setWorkNo(arg0.getStr(getPathByProperName("workNo")));
	}
	
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
	public String getOpCode1() {
		return opCode1;
	}

	public void setOpCode1(String opCode1) {
		this.opCode1 = opCode1;
	}

	public long getLoginAccept() {
		return loginAccept;
	}
	
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getWorkNo() {
		return workNo;
	}

	public void setWorkNo(String workNo) {
		this.workNo = workNo;
	}

}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 缴费冲正查询入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8006InitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2205592497074724534L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="long",len="40",desc="用户标识",memo="略")
	private long idNo;
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.QUES,type="String",len="1",desc="陈账死账标识",memo="略")
	private String backType;
	
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setIdNo(Long.parseLong(arg0.getObject(getPathByProperName("idNo")).toString()));
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setBackType(arg0.getObject(getPathByProperName("backType")).toString());
	
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


	public String getBackType() {
		return backType;
	}


	public void setBackType(String backType) {
		this.backType = backType;
	}


	
}

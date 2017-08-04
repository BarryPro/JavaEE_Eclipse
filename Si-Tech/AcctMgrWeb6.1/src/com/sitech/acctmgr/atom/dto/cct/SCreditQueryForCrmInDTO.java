package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditQueryForCrmInDTO  extends CommonInDTO{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "String", len = "18", desc = "用户ID", memo = "略")
	String idNo;
	@ParamDesc(path = "BUSI_INFO.OP_TIME", cons = ConsType.QUES, type = "String", len = "18", desc = "离网时间", memo = "略")
	String opTime;

	
	public String getIdNo() {
		return idNo;
	}


	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}


	public String getOpTime() {
		return opTime;
	}


	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))){
			idNo = arg0.getStr(getPathByProperName("idNo"));
			System.out.println("idNo===============" + idNo);
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("opTime")))){
			opTime = arg0.getStr(getPathByProperName("opTime"));
			System.out.println("OpTIme===============" + opTime);

		}
	}
}

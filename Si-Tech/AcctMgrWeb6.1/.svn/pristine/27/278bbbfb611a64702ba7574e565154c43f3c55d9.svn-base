package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STransferInDTO  extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "string", len = "18", desc = "用户ID", memo = "略")
	protected String idNo;
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setIdNo(arg0.getStr(getPathByProperName("idNo")));
	}
	
	
	/**
	 * @return the idNo
	 */
	public String getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}
	

}

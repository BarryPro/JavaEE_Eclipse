package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8155limitQryInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="20",desc="集团编码",memo="略")
	private String unitId;
	@ParamDesc(path="BUSI_INFO.ADMIN_PHONE",cons=ConsType.QUES,type="String",len="20",desc="管理员手机号码",memo="略")
	private String adminPhone;
	@ParamDesc(path="BUSI_INFO.YEAR_MONTH",cons=ConsType.QUES,type="String",len="20",desc="查询年月",memo="略")
	private String yearMonth;
	@ParamDesc(path="BUSI_INFO.OPER_PHONE",cons=ConsType.QUES,type="String",len="20",desc="操作员手机号码",memo="略")
	private String operPhone;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());
		setAdminPhone(arg0.getObject(getPathByProperName("adminPhone")).toString());
		setYearMonth(arg0.getStr(getPathByProperName("yearMonth")));
		setOperPhone(arg0.getObject(getPathByProperName("operPhone")).toString());
	
	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	/**
	 * @return the adminPhone
	 */
	public String getAdminPhone() {
		return adminPhone;
	}

	/**
	 * @param adminPhone the adminPhone to set
	 */
	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}

	/**
	 * @return the yearMonth
	 */
	public String getYearMonth() {
		return yearMonth;
	}

	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	/**
	 * @return the operPhone
	 */
	public String getOperPhone() {
		return operPhone;
	}

	/**
	 * @param operPhone the operPhone to set
	 */
	public void setOperPhone(String operPhone) {
		this.operPhone = operPhone;
	}


}

package com.sitech.acctmgr.atom.dto.pay;

 
import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8208AuditQryInDTO extends CommonInDTO{

 
	/**
	 * 
	 */
	private static final long serialVersionUID = -8835948592203177189L;

	
	@ParamDesc(path = "BUSI_INFO.QRY_FLAG", cons = ConsType.CT001, desc = "查询标识", len = "8", type = "string", memo = "审核查询N，赠送查询Y")
	protected String qryFlag;
	@ParamDesc(path = "BUSI_INFO.INPUT_DATE", cons = ConsType.QUES, desc = "查询日期", len = "8", type = "string", memo = "略")
	protected String inputDate;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.QUES, desc = "查询日期", len = "8", type = "string", memo = "略")
	protected String beginDate;
	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.QUES, desc = "查询日期", len = "8", type = "string", memo = "略")
	protected String endDate;
	
 
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(loginNo) ){
			throw new BusiException(getErrorCode(opCode, "01002"), "工号失效，请重新登录！");
		}
		
		setQryFlag(arg0.getStr(getPathByProperName("qryFlag")));
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("inputDate")))) {
			setInputDate(arg0.getStr(getPathByProperName("inputDate")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginDate")))) {
			setBeginDate(arg0.getStr(getPathByProperName("beginDate")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endDate")))) {
			setEndDate(arg0.getStr(getPathByProperName("endDate")));
		}
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	/**
	 * @return the qryFlag
	 */
	public String getQryFlag() {
		return qryFlag;
	}

	/**
	 * @param qryFlag the qryFlag to set
	 */
	public void setQryFlag(String qryFlag) {
		this.qryFlag = qryFlag;
	}

	/**
	 * @return the beginDate
	 */
	public String getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	
}

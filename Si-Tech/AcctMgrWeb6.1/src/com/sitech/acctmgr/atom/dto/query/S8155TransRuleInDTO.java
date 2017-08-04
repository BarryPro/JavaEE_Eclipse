package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8155TransRuleInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="20",desc="集团编码",memo="略")
	private String unitId;
	@ParamDesc(path="BUSI_INFO.ADMIN_PHONE",cons=ConsType.QUES,type="String",len="20",desc="管理员手机号码",memo="略")
	private String adminPhone;
	@ParamDesc(path="BUSI_INFO.JT_CONTRACT_NO",cons=ConsType.QUES,type="String",len="20",desc="集团产品账号",memo="略")
	private String jtContractNo;
	@ParamDesc(path="BUSI_INFO.PHONE_TEMP",cons=ConsType.QUES,type="String",len="1000",desc="操作员手机串",memo="最多30个,|分割")
	private String phoneTemp;
	@ParamDesc(path="BUSI_INFO.LIMIT_PAY_TEMP",cons=ConsType.QUES,type="String",len="1000",desc="限额串",memo="略")
	private String limitPayTemp;
	@ParamDesc(path="BUSI_INFO.BEGIN_YMD",cons=ConsType.QUES,type="String",len="8",desc="规则生效起始日期",memo="略")
	private String beginYmd;
	@ParamDesc(path="BUSI_INFO.END_YMD",cons=ConsType.QUES,type="String",len="8",desc="规则生效结束日期",memo="略")
	private String endYmd;
	@ParamDesc(path="BUSI_INFO.PHONE_NUM",cons=ConsType.QUES,type="String",len="8",desc="配置操作员手机号码个数",memo="略")
	private String phoneNum;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="8",desc="操作类型",memo="0 新增修改  1 删除")
	private String opType;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());
		setAdminPhone(arg0.getObject(getPathByProperName("adminPhone")).toString());
		setJtContractNo(arg0.getObject(getPathByProperName("jtContractNo")).toString());
		setPhoneTemp(arg0.getObject(getPathByProperName("phoneTemp")).toString());
		setLimitPayTemp(arg0.getObject(getPathByProperName("limitPayTemp")).toString());
		setBeginYmd(arg0.getObject(getPathByProperName("beginYmd")).toString());
		setEndYmd(arg0.getObject(getPathByProperName("endYmd")).toString());
		setPhoneNum(arg0.getObject(getPathByProperName("phoneNum")).toString());
		setOpType(arg0.getObject(getPathByProperName("opType")).toString());
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("phoneTemp")))||
				StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("unitId")))||
				StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("jtContractNo")))
				||Integer.parseInt(phoneNum)>30||Integer.parseInt(phoneNum)==0
				||Integer.parseInt(beginYmd)>Integer.parseInt(endYmd)){
			throw new BusiException(AcctMgrError.getErrorCode("8155","00001"), "服务入参有误,请确认！");
		}
		
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
	 * @return the jtContractNo
	 */
	public String getJtContractNo() {
		return jtContractNo;
	}

	/**
	 * @param jtContractNo the jtContractNo to set
	 */
	public void setJtContractNo(String jtContractNo) {
		this.jtContractNo = jtContractNo;
	}

	/**
	 * @return the phoneTemp
	 */
	public String getPhoneTemp() {
		return phoneTemp;
	}

	/**
	 * @param phoneTemp the phoneTemp to set
	 */
	public void setPhoneTemp(String phoneTemp) {
		this.phoneTemp = phoneTemp;
	}

	/**
	 * @return the beginYmd
	 */
	public String getBeginYmd() {
		return beginYmd;
	}

	/**
	 * @param beginYmd the beginYmd to set
	 */
	public void setBeginYmd(String beginYmd) {
		this.beginYmd = beginYmd;
	}

	/**
	 * @return the endYmd
	 */
	public String getEndYmd() {
		return endYmd;
	}

	/**
	 * @param endYmd the endYmd to set
	 */
	public void setEndYmd(String endYmd) {
		this.endYmd = endYmd;
	}

	/**
	 * @return the phoneNum
	 */
	public String getPhoneNum() {
		return phoneNum;
	}

	/**
	 * @param phoneNum the phoneNum to set
	 */
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}

	/**
	 * @return the limitPayTemp
	 */
	public String getLimitPayTemp() {
		return limitPayTemp;
	}

	/**
	 * @param limitPayTemp the limitPayTemp to set
	 */
	public void setLimitPayTemp(String limitPayTemp) {
		this.limitPayTemp = limitPayTemp;
	}
}

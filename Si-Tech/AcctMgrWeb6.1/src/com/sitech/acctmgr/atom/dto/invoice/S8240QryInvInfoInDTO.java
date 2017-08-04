package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  发票查询服务入参 </p>
 * <p>Description: 发票查询服务入参  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author fanck
 * @version 1.0
 */
public class S8240QryInvInfoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7718999647913468402L;
	
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户号",memo="略")
	protected long contractNo;
	@ParamDesc(path="BUSI_INFO.QRY_TYPE",cons=ConsType.CT001,type="int",len="3",desc="查询方式",memo="0:按用户查询，1:按账户查询，2:按集团虚拟号，不传按账户类型决定")
	protected int qryType;
	@ParamDesc(path="BUSI_INFO.QRY_MON",cons=ConsType.CT001,type="int",len="10",desc="查询月份",memo="略")
	protected int qryMon;			  //查询账期
	@ParamDesc(path="BUSI_INFO.USER_FLAG",cons=ConsType.QUES,type="int",len="2",desc="用户类型",memo="0：在网，1：离网")
	protected int userFlag;
	@ParamDesc(path="BUSI_INFO.BILL_CYCLE",cons=ConsType.QUES,type="int",len="10",desc="账期",memo="略")
	protected int billCycle;
	@ParamDesc(path="BUSI_INFO.ELEC_TYPE",cons=ConsType.QUES,type="int",len="2",desc="电子发票标示",memo="0：普通纸质，1：电子")
	private int elecType;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="long",len="20",desc="虚拟集团编号",memo="略")
	private long unitId;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	
	public String getPhoneNo() {
		return phoneNo;
	}


	public long getUnitId() {
		return unitId;
	}


	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}


	/**
	 * @return the elecType
	 */
	public int getElecType() {
		return elecType;
	}


	/**
	 * @param elecType the elecType to set
	 */
	public void setElecType(int elecType) {
		this.elecType = elecType;
	}


	/**
	 * @return the billCycle
	 */
	public int getBillCycle() {
		return billCycle;
	}


	/**
	 * @param billCycle the billCycle to set
	 */
	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}


	/**
	 * @return the userFlag
	 */
	public int getUserFlag() {
		return userFlag;
	}


	/**
	 * @param userFlag the userFlag to set
	 */
	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	public int getQryType() {
		return qryType;
	}


	public void setQryType(int qryType) {
		this.qryType = qryType;
	}


	public int getQryMon() {
		return qryMon;
	}


	public void setQryMon(int qryMon) {
		this.qryMon = qryMon;
	}


	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		System.out.println("arg0="+arg0.toString());
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))){
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))){
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}
		/*if(contractNo==0&&StringUtils.isEmptyOrNull(phoneNo)){
			throw new BusiException(AcctMgrError.getErrorCode("8000","01002"), "入参帐户和用户不能同时为空！");
		}*/
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("qryType")))){
			qryType = Integer.parseInt(arg0.getStr(getPathByProperName("qryType")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("qryMon")))){
			qryMon = Integer.parseInt(arg0.getStr(getPathByProperName("qryMon")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("userFlag")))){
			userFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("userFlag")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("billCycle")))){
			billCycle = ValueUtils.intValue(arg0.getStr(getPathByProperName("billCycle")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("elecType")))){
			elecType = ValueUtils.intValue(arg0.getStr(getPathByProperName("elecType")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("unitId")))){
			unitId = ValueUtils.longValue(arg0.getStr(getPathByProperName("unitId")));
		}
	}

}

package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.AcctMgrError;
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
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SBalanceQryRestPayInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7095050225061755420L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="20",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="30",desc="营销业务流水",memo="略")
	private String foreignSn = "";
	@ParamDesc(path="BUSI_INFO.FOREIGN_TIME",cons=ConsType.CT001,type="String",len="20",desc="业务办理时间",memo="略")
	private String foreignTime = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		}
		if(phoneNo.equals("") && contractNo == 0) {
			throw new BusiException(AcctMgrError.getErrorCode(opCode,"00001"), "入参帐户和服务号码不能同时为空！"); 
		}
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}

	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

	/**
	 * @return the foreignTime
	 */
	public String getForeignTime() {
		return foreignTime;
	}

	/**
	 * @param foreignTime the foreignTime to set
	 */
	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
	}

}

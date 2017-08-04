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
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8107QueryInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8164686045148214802L;

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="可空")
	protected String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账户号码",memo="可空")
	protected long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.USER_FLAG",cons=ConsType.QUES,type="String",len="1",desc="在离网标识",memo="可空,0:在网 1:离网")
	protected int userFlag = 0;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(contractNo == 0 && phoneNo.equals("")) {
			throw new BusiException(AcctMgrError.getErrorCode(opCode,"00001"), "入参帐户和服务号码不能同时为空！");
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("userFlag")))) {
			userFlag = Integer.valueOf(arg0.getStr(getPathByProperName("userFlag")));
		}
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
	
}

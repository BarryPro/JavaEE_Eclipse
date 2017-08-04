package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退预存款 00 </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8008InitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6148658981411878296L;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long  contractNo;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.IN_IF_ONNET",cons=ConsType.CT001,type="String",len="1",desc="在网标识",memo="1:在网；2:离网")
	protected String inIfOnNet;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="20",desc="退费类型",memo="略")
	protected String opType;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setInIfOnNet(arg0.getStr(getPathByProperName("inIfOnNet")));
		setOpType(arg0.getStr(getPathByProperName("opType")));
		if(StringUtils.isEmptyOrNull(opCode)){
			opCode="8008";
		}
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
	 * @return the inIfOnNet
	 */
	public String getInIfOnNet() {
		return inIfOnNet;
	}

	/**
	 * @param inIfOnNet the inIfOnNet to set
	 */
	public void setInIfOnNet(String inIfOnNet) {
		this.inIfOnNet = inIfOnNet;
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
 

	 
	
	
}

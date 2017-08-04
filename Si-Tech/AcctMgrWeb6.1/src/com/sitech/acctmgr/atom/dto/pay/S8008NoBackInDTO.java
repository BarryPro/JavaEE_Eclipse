package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
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
public class S8008NoBackInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7942875953387663493L;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long  contractNo;
	@ParamDesc(path="BUSI_INFO.IN_IF_ONNET",cons=ConsType.CT001,type="String",len="1",desc="在网标识",memo="1:在网；2:离网")
	protected String inIfOnNet;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="1",desc="退费类型",memo="TYCKDEAD、其他")
	protected String opType;
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setInIfOnNet(arg0.getStr(getPathByProperName("inIfOnNet")));
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
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}


	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}
 
	
	 
	
}

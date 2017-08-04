package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   补收查询入参DTO</p>
 * <p>Description:  对补收查询入参进行解析成MBean，并检验入参的正确性 </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8010InitOutDTO  extends CommonOutDTO{	

	/**
	 * 
	 */
	private static final long serialVersionUID = 2585807883195087409L;
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="40",desc="账户名称",memo="略")
	protected String contractName;
	@JSONField(name="RUN_NAME")
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="String",len="10",desc="运行状态",memo="略")
	protected String runName;
	@JSONField(name="CUST_INFO")
	@ParamDesc(path="CUST_INFO",cons=ConsType.CT001,type="String",len="40",desc="客户信息",memo="略")
	protected String custInfo;
	@JSONField(name="LEN_GIVEFEE_TYPE")
	@ParamDesc(path="LEN_GIVEFEE_TYPE",cons=ConsType.CT001,type="int",len="10",desc="送费类型长度",memo="略")
	protected int lenGiveFeeType;
	@JSONField(name="LIST_GIVEFEE_TYPE")
	@ParamDesc(path="LIST_GIVEFEE_TYPE",cons=ConsType.STAR,type="compx",len="1",desc="送费类型",memo="略")
	protected List<PubCodeDictEntity> listGiveFeeType;




	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("contractName"), contractName);
		result.setRoot(getPathByProperName("runName"), runName);
		result.setRoot(getPathByProperName("custInfo"), custInfo);
		result.setRoot(getPathByProperName("lenGiveFeeType"),lenGiveFeeType);
		result.setRoot(getPathByProperName("listGiveFeeType"),listGiveFeeType);
		return result;
	}


	/**
	 * @return the contractName
	 */
	public String getContractName() {
		return contractName;
	}


	/**
	 * @param contractName the contractName to set
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}


	/**
	 * @return the runName
	 */
	public String getRunName() {
		return runName;
	}


	/**
	 * @param runName the runName to set
	 */
	public void setRunName(String runName) {
		this.runName = runName;
	}


	/**
	 * @return the custInfo
	 */
	public String getCustInfo() {
		return custInfo;
	}


	/**
	 * @param custInfo the custInfo to set
	 */
	public void setCustInfo(String custInfo) {
		this.custInfo = custInfo;
	}
	

	public int getLenGiveFeeType() {
		return lenGiveFeeType;
	}


	public void setLenGiveFeeType(int lenGiveFeeType) {
		this.lenGiveFeeType = lenGiveFeeType;
	}


	public List<PubCodeDictEntity> getListGiveFeeType() {
		return listGiveFeeType;
	}


	public void setListGiveFeeType(List<PubCodeDictEntity> listGiveFeeType) {
		this.listGiveFeeType = listGiveFeeType;
	}

	 
}

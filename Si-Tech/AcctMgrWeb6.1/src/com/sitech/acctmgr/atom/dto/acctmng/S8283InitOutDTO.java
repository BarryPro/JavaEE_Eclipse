package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.ChequeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutUserData;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 缴费查询出参DTO  </p>
 * <p>Description: 缴费查询出参DTO，封装出参情况  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
@SuppressWarnings("serial")
public class S8283InitOutDTO extends CommonOutDTO implements Serializable  {
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
	
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="账户名称",memo="略")
	private String contractName;
	
	@ParamDesc(path="CON_PHONE_LIST",cons=ConsType.CT001,type="compx",len="1",desc="账户提醒短信号码列表",memo="略")
	private List<Map<String, Object>> conPhoneList;
	
	@ParamDesc(path="PHONE_CON_LIST",cons=ConsType.QUES,type="compx",len="1",desc="号码配置了提醒账号列表",memo="略")
	private List<Map<String, Object>> phoneConList;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("contractName"), contractName);
		result.setRoot(getPathByProperName("conPhoneList"), conPhoneList);
		result.setRoot(getPathByProperName("phoneConList"), phoneConList);
		return result;
	}


	public String getPhoneNo() {
		return phoneNo;
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


	public String getContractName() {
		return contractName;
	}


	public void setContractName(String contractName) {
		this.contractName = contractName;
	}


	public List<Map<String, Object>> getConPhoneList() {
		return conPhoneList;
	}


	public void setConPhoneList(List<Map<String, Object>> conPhoneList) {
		this.conPhoneList = conPhoneList;
	}


	public List<Map<String, Object>> getPhoneConList() {
		return phoneConList;
	}


	public void setPhoneConList(List<Map<String, Object>> phoneConList) {
		this.phoneConList = phoneConList;
	}

}

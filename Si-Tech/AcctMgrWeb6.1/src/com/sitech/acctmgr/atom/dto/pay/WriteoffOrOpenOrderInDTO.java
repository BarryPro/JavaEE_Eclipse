package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
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
public class WriteoffOrOpenOrderInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = -4109589606941398082L;

	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="String",len="14",desc="缴费入账流水",memo="略")
	private long paySn;
	
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="5",desc="工号",memo="略")
	private String loginNo2;
	
	@ParamDesc(path="BILL_YM",cons=ConsType.QUES,type="int",len="5",desc="冲销年月",memo="略")
	private int billYm;
	
	@ParamDesc(path="GROUP_ID",cons=ConsType.CT001,type="String",len="10",desc="缴费工号机构归属",memo="略")
	private String groupId2;
	
	@ParamDesc(path="DELAY_FAVOUR_RATE",cons=ConsType.QUES,type="String",len="5",desc="滞纳金优惠率",memo="略")
	private double dDelayRate;
	
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="4",desc="模块编码",memo="略")
	private String opCode2;
	
	@ParamDesc(path="OP_TYPE",cons=ConsType.CT001,type="String",len="2",desc="操作类型 ",memo=" 01[只做开机] 02[只做冲销] 03[冲销开机]")
	private String opType;
	

	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		paySn = arg0.getLong(getPathByProperName("paySn"));
		contractNo = arg0.getLong(getPathByProperName("contractNo"));
		
		if(arg0.getObject(getPathByProperName("phoneNo")) != null && !arg0.getObject(getPathByProperName("phoneNo")).equals("")){
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}

		loginNo2 = arg0.getStr(getPathByProperName("loginNo2"));
		
		if(arg0.getObject(getPathByProperName("billYm")) != null && !arg0.getObject(getPathByProperName("billYm")).equals("")){
			billYm = arg0.getInt(getPathByProperName("billYm"));
		}
		
		groupId2 = arg0.getStr(getPathByProperName("groupId2"));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("dDelayRate")))){
			//dDelayRate = arg0.getDouble(getPathByProperName("dDelayRate"));
			dDelayRate = Double.parseDouble(arg0.getObject(getPathByProperName("dDelayRate")).toString());
		}
		
		opCode2 = arg0.getStr(getPathByProperName("opCode2"));
		opType = arg0.getStr(getPathByProperName("opType"));
	}



	/**
	 * @return the billYm
	 */
	public int getBillYm() {
		return billYm;
	}

	/**
	 * @param billYm the billYm to set
	 */
	public void setBillYm(int billYm) {
		this.billYm = billYm;
	}

	/**
	 * @return the loginNo2
	 */
	public String getLoginNo2() {
		return loginNo2;
	}

	/**
	 * @param loginNo2 the loginNo2 to set
	 */
	public void setLoginNo2(String loginNo2) {
		this.loginNo2 = loginNo2;
	}

	/**
	 * @return the groupId2
	 */
	public String getGroupId2() {
		return groupId2;
	}

	/**
	 * @param groupId2 the groupId2 to set
	 */
	public void setGroupId2(String groupId2) {
		this.groupId2 = groupId2;
	}

	/**
	 * @return the opCode2
	 */
	public String getOpCode2() {
		return opCode2;
	}

	/**
	 * @param opCode2 the opCode2 to set
	 */
	public void setOpCode2(String opCode2) {
		this.opCode2 = opCode2;
	}

	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}

	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
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
	 * @return the dDelayRate
	 */
	public double getdDelayRate() {
		return dDelayRate;
	}

	/**
	 * @param dDelayRate the dDelayRate to set
	 */
	public void setdDelayRate(double dDelayRate) {
		this.dDelayRate = dDelayRate;
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

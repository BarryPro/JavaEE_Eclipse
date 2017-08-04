package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 缴费冲正查询入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author linzc
 * @version 1.0
 */
public class S8007InitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 242390497571551158L;
	
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.CT001,type="long",len="40",desc="缴费流水",memo="略")
	private long paySn;
	@ParamDesc(path="BUSI_INFO.PAY_TIME",cons=ConsType.CT001,type="String",len="20",desc="缴费日期",memo="略")
	private String payTime;
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.CT001,type="String",len="2",desc="陈死账类型",memo="1:陈账,4:死账")
	private String backType;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="帐户号码",memo="略")
	private long contractNo;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户ID",memo="略")
	private long idNo;
	@ParamDesc(path="BUSI_INFO.CUST_ID",cons=ConsType.CT001,type="long",len="40",desc="客户ID",memo="略")
	private long custId;
	
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPayTime(arg0.getObject(getPathByProperName("payTime")).toString());
		setPaySn(Long.parseLong(arg0.getObject(getPathByProperName("paySn")).toString()));
		setBackType(StringUtils.castToString(arg0.getObject(getPathByProperName("backType"))));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setIdNo(Long.parseLong(arg0.getObject(getPathByProperName("idNo")).toString()));
		setCustId(Long.parseLong(arg0.getObject(getPathByProperName("custId")).toString()));
		
	}


	public long getPaySn() {
		return paySn;
	}


	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}


	public String getBackType() {
		return backType;
	}


	public void setBackType(String backType) {
		this.backType = backType;
	}


	/**
	 * @return the payTime
	 */
	public String getPayTime() {
		return payTime;
	}


	/**
	 * @param payTime the payTime to set
	 */
	public void setPayTime(String payTime) {
		this.payTime = payTime;
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
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}


	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}


	/**
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}


	/**
	 * @param custId the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}

}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
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
public class S8007GetPaySnInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4039965100501857775L;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="40",desc="账户号码",memo="略")
	private long contractNo;
	@ParamDesc(path="BUSI_INFO.PAY_MONTH",cons=ConsType.CT001,type="int",len="6",desc="缴费日期",memo="略")
	private int payMonth;    
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.CT001,type="String",len="2",desc="业务类型",memo="略")
	private String backType;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setContractNo(ValueUtils.longValue(arg0.getObject(getPathByProperName("contractNo"))));
		setPayMonth(ValueUtils.intValue(arg0.getObject(getPathByProperName("payMonth"))));
		setBackType(arg0.getObject(getPathByProperName("backType")).toString());
		
		
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
	 * @return the payMonth
	 */
	public int getPayMonth() {
		return payMonth;
	}

	/**
	 * @param payMonth the payMonth to set
	 */
	public void setPayMonth(int payMonth) {
		this.payMonth = payMonth;
	}

	/**
	 * @return the backType
	 */
	public String getBackType() {
		return backType;
	}

	/**
	 * @param backType the backType to set
	 */
	public void setBackType(String backType) {
		this.backType = backType;
	}

}

package com.sitech.acctmgr.atom.dto.pay;

 
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S2311DetailInDTO extends CommonInDTO{

 
	/**
	 * 
	 */
	private static final long serialVersionUID = -8835948592203177189L;

	@ParamDesc(path = "BUSI_INFO.INPUT_TIME", cons = ConsType.CT001, desc = "查询日期", len = "18", type = "string", memo = "略")
	protected String inputTime;
	
	@ParamDesc(path = "BUSI_INFO.BATCH_SN", cons = ConsType.CT001, desc = "批次流水", len = "8", type = "long", memo = "选中的批次流水")
	protected long batchSn;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setInputTime(arg0.getStr(getPathByProperName("inputTime")));
		setBatchSn(Long.parseLong(arg0.getObject(getPathByProperName("batchSn")).toString()));
	}

	/**
	 * @return the inputTime
	 */
	public String getInputTime() {
		return inputTime;
	}



	/**
	 * @param inputTime the inputTime to set
	 */
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}



	/**
	 * @return the batchSn
	 */
	public long getBatchSn() {
		return batchSn;
	}

	/**
	 * @param batchSn the batchSn to set
	 */
	public void setBatchSn(long batchSn) {
		this.batchSn = batchSn;
	}

}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
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
public class S8295CfmOutDTO extends CommonOutDTO{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = -1563176948325457191L;
	protected long totalFee;
	protected long totalNum;
	protected long batchSn;
	
	  
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("TOTAL_FEE",totalFee);
		result.setBody("TOTAL_NO",totalNum);
		result.setBody("BATCH_SN",batchSn);
		return result;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

 

	public long getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(long totalNum) {
		this.totalNum = totalNum;
	}

 

	public long getBatchSn() {
		return batchSn;
	}

	public void setBatchSn(long batchSn) {
		this.batchSn = batchSn;
	}
}

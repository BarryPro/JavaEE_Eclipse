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
public class S8296DeleteOutDTO extends CommonOutDTO{
  
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 631081615301396929L;
	protected long batchSn;
	
	
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("BATCH_SN",batchSn);
		return result;
	}
 
 

	public long getBatchSn() {
		return batchSn;
	}

	public void setBatchSn(long batchSn) {
		this.batchSn = batchSn;
	}
}

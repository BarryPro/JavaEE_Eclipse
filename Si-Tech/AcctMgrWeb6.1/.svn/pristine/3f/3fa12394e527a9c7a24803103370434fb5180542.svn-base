package com.sitech.acctmgr.atom.dto.adj;

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
public class S8011CfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8811379608001093995L;
	
	protected long lTotalFee;
	protected long iCount;
	protected long lBatchSn;
	protected long iCountErr;
	
	

	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("TOTAL_FEE",lTotalFee);
		result.setBody("TOTAL_NO",iCount);
		result.setBody("BATCH_SN",lBatchSn);
		result.setBody("TOTAL_NO_ERR",iCountErr);
		return result;
	}

	/**
	 * @return the lTotalFee
	 */
	public long getlTotalFee() {
		return lTotalFee;
	}

	/**
	 * @param lTotalFee the lTotalFee to set
	 */
	public void setlTotalFee(long lTotalFee) {
		this.lTotalFee = lTotalFee;
	}

	/**
	 * @return the iCount
	 */
	public long getiCount() {
		return iCount;
	}

	/**
	 * @param iCount the iCount to set
	 */
	public void setiCount(long iCount) {
		this.iCount = iCount;
	}

	/**
	 * @return the lBatchSn
	 */
	public long getlBatchSn() {
		return lBatchSn;
	}

	/**
	 * @param lBatchSn the lBatchSn to set
	 */
	public void setlBatchSn(long lBatchSn) {
		this.lBatchSn = lBatchSn;
	}

	public long getiCountErr() {
		return iCountErr;
	}

	public void setiCountErr(long iCountErr) {
		this.iCountErr = iCountErr;
	}
	
	
}

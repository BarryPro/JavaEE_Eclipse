package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title: 缴费查询出参DTO  </p>
 * <p>Description: 缴费查询出参DTO，封装出参情况  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8014InitOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;
	
	@JSONField(name="TRANS_OUT_INFO")
	@ParamDesc(path="TRANS_OUT_INFO",cons=ConsType.CT001,type="compx",len="1",desc="转账出参实体",memo="略")
	private TransOutEntity transOutInfo;
	@JSONField(name="OWEFEE_LIST")
	@ParamDesc(path="OWEFEE_LIST",cons=ConsType.CT001,type="compx",len="",desc="转账账本列表",memo="略")
	private List<TransFeeEntity> transFeeList ;
	@JSONField(name="LIST_REASONINFO")
	@ParamDesc(path="LIST_REASONINFO",cons=ConsType.STAR,type="compx",len="1",desc="原因业务列表",memo="略")
	protected List<ComplainAdjReasonEntity> listReasonInfo;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("transOutInfo"), transOutInfo);
		result.setRoot(getPathByProperName("transFeeList"), transFeeList);
		result.setRoot(getPathByProperName("listReasonInfo"), listReasonInfo);
		return result;
	}

	
	/**
	 * @return the listReasonInfo
	 */
	public List<ComplainAdjReasonEntity> getListReasonInfo() {
		return listReasonInfo;
	}


	/**
	 * @param listReasonInfo the listReasonInfo to set
	 */
	public void setListReasonInfo(List<ComplainAdjReasonEntity> listReasonInfo) {
		this.listReasonInfo = listReasonInfo;
	}



	/**
	 * @return the transOutInfo
	 */
	public TransOutEntity getTransOutInfo() {
		return transOutInfo;
	}

	/**
	 * @param transOutInfo the transOutInfo to set
	 */
	public void setTransOutInfo(TransOutEntity transOutInfo) {
		this.transOutInfo = transOutInfo;
	}

	/**
	 * @return the transFeeList
	 */
	public List<TransFeeEntity> getTransFeeList() {
		return transFeeList;
	}

	/**
	 * @param transFeeList the transFeeList to set
	 */
	public void setTransFeeList(List<TransFeeEntity> transFeeList) {
		this.transFeeList = transFeeList;
	}

}

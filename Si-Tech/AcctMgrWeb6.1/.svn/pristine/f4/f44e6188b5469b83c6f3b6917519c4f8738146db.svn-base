package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.GiveInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.GiveRecdEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8208DetailOutDTO extends CommonOutDTO{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = -153076550617641724L;

	//消费信息
	@JSONField(name="LIST_GIVESUCC")
	@ParamDesc(path="LIST_GIVESUCC",cons= ConsType.STAR,type="compx",len="1",desc="赠费导入列表",memo="略")
	protected List<GiveInfoEntity> listGiveSucc;

	@JSONField(name="GIVESUCC_SIZE")
	@ParamDesc(path="GIVESUCC_SIZE",cons=ConsType.CT001,type="int",len="14",desc="赠费导入数",memo="略")
	protected int giveSuccSize = 0;
	
	//消费信息
	@JSONField(name="LIST_GIVEERR")
	@ParamDesc(path="LIST_GIVEERR",cons= ConsType.STAR,type="compx",len="1",desc="赠费导入列表",memo="略")
	protected List<GiveInfoEntity> listGiveErr;

	@JSONField(name="GIVEERR_SIZE")
	@ParamDesc(path="GIVEERR_SIZE",cons=ConsType.CT001,type="int",len="14",desc="赠费导入数",memo="略")
	protected int giveErrSize = 0;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("listGiveSucc"), listGiveSucc);
		result.setRoot(getPathByProperName("giveSuccSize"), giveSuccSize);
		result.setRoot(getPathByProperName("listGiveErr"), listGiveErr);
		result.setRoot(getPathByProperName("giveErrSize"), giveErrSize);
		return result;
	}


	/**
	 * @return the listGiveSucc
	 */
	public List<GiveInfoEntity> getListGiveSucc() {
		return listGiveSucc;
	}


	/**
	 * @param listGiveSucc the listGiveSucc to set
	 */
	public void setListGiveSucc(List<GiveInfoEntity> listGiveSucc) {
		this.listGiveSucc = listGiveSucc;
	}


	/**
	 * @return the giveSuccSize
	 */
	public int getGiveSuccSize() {
		return giveSuccSize;
	}


	/**
	 * @param giveSuccSize the giveSuccSize to set
	 */
	public void setGiveSuccSize(int giveSuccSize) {
		this.giveSuccSize = giveSuccSize;
	}


	/**
	 * @return the listGiveErr
	 */
	public List<GiveInfoEntity> getListGiveErr() {
		return listGiveErr;
	}


	/**
	 * @param listGiveErr the listGiveErr to set
	 */
	public void setListGiveErr(List<GiveInfoEntity> listGiveErr) {
		this.listGiveErr = listGiveErr;
	}


	/**
	 * @return the giveErrSize
	 */
	public int getGiveErrSize() {
		return giveErrSize;
	}


	/**
	 * @param giveErrSize the giveErrSize to set
	 */
	public void setGiveErrSize(int giveErrSize) {
		this.giveErrSize = giveErrSize;
	}

	 
}

package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.BalanceNBEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title: 退预存款  </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8008NoBackOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6784735031154193269L;
	
	@JSONField(name="OUTMSG")
	@ParamDesc(path="OUTMSG",cons=ConsType.CT001,type="compx",len="1",desc="不可退预存列表",memo="略")
	List<BalanceNBEntity> outList;
	@JSONField(name="NBK_SIZE")
	@ParamDesc(path="NBK_SIZE",cons=ConsType.CT001,type="long",len="1",desc="不可退预存原因行数",memo="略")
	long nbkSize;
	
	

	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("outList"), outList);
		result.setRoot(getPathByProperName("nbkSize"), nbkSize);
		return result;
	}



	/**
	 * @return the outList
	 */
	public List<BalanceNBEntity> getOutList() {
		return outList;
	}



	/**
	 * @param outList the outList to set
	 */
	public void setOutList(List<BalanceNBEntity> outList) {
		this.outList = outList;
	}


	/**
	 * @return the nbksize
	 */
	public long getNbksize() {
		return nbkSize;
	}

	
	/**
	 * @param nbksize the nbksize to set
	 */
	public void setNbksize(long nbksize) {
		this.nbkSize = nbksize;
	}
	
	

 
 
}

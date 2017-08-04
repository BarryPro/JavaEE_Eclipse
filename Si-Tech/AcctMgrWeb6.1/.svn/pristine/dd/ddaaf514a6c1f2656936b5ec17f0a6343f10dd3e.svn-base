package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.BatchPayRecdEntity;
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
public class S8208AuditQryOutDTO extends CommonOutDTO{
 
	//消费信息
	@JSONField(name="LIST_GIVE")
	@ParamDesc(path="LIST_GIVE",cons= ConsType.STAR,type="compx",len="1",desc="赠费导入列表",memo="略")
	protected List<BatchPayRecdEntity> sendList;

	@JSONField(name="GIVE_SIZE")
	@ParamDesc(path="GIBE_SIZE",cons=ConsType.CT001,type="int",len="14",desc="赠费导入数",memo="略")
	protected int giveSize = 0;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("sendList"), sendList);
		result.setRoot(getPathByProperName("giveSize"), giveSize);
		return result;
	}


	/**
	 * @return the sendList
	 */
	public List<BatchPayRecdEntity> getSendList() {
		return sendList;
	}

	/**
	 * @param sendList the sendList to set
	 */
	public void setSendList(List<BatchPayRecdEntity> sendList) {
		this.sendList = sendList;
	}

	public int getGiveSize() {
		return giveSize;
	}

	public void setGiveSize(int giveSize) {
		this.giveSize = giveSize;
	}
	
}

package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
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
public class S8208AuditOutDTO extends CommonOutDTO{
 
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 955886320979491549L;

	@JSONField(name="BATCH_SN")
	@ParamDesc(path="BATCH_SN",cons=ConsType.CT001,type="int",len="14",desc="赠费导入数",memo="略")
	protected long batchSn = 0;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("batchSn"), batchSn);
		return result;
	}

	public long getBatchSn() {
		return batchSn;
	}

	public void setBatchSn(long batchSn) {
		this.batchSn = batchSn;
	}
}

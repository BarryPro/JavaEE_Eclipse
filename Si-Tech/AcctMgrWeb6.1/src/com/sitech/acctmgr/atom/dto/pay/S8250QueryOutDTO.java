package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.balance.MkYxzfactEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
/**
*
* <p>Title: </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class S8250QueryOutDTO extends CommonOutDTO {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 4479641505840311386L;
	
	@ParamDesc(path="MkYxzfactDetail_List",cons=ConsType.QUES,type="compx",len="1",desc="配置列表",memo="略")
	private List<MkYxzfactEntity> outList = null;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("outList"), outList);
		
		return result;
	}

	public List<MkYxzfactEntity> getOutList() {
		return outList;
	}

	public void setOutList(List<MkYxzfactEntity> outList) {
		this.outList = outList;
	}
	
}

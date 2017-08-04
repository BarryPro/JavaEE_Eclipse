package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvoInfoEntity;
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
 * @author 
 * @version 1.0
 */
public class S8056qryRelatedInvoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2449186974844586927L;
	@JSONField(name="PRT_INFO")
	@ParamDesc(path="PRT_INFO",cons=ConsType.PLUS,type="compx",len="1",desc="发票信息列表",memo="略")
	private List<InvoInfoEntity> invList;
	@JSONField(name="COUNT")
	@ParamDesc(path="COUNT",cons=ConsType.CT001,type="int",len="1",desc="发票信息列表数量",memo="略")
	private int count;
	
	
	/**
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(int count) {
		this.count = count;
	}

	/**
	 * @return the invList
	 */
	public List<InvoInfoEntity> getInvList() {
		return invList;
	}

	/**
	 * @param invList the invList to set
	 */
	public void setInvList(List<InvoInfoEntity> invList) {
		this.invList = invList;
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invList"),this.invList);
		result.setRoot(getPathByProperName("count"),this.count);
		return result;
	}
	
}

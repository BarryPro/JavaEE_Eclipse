package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvoInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
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
public class S8240QryInvInfoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2441810494667060535L;
	@JSONField(name="INVFEE_IFNO")
	@ParamDesc(path="INVFEE_IFNO",cons=ConsType.PLUS,type="compx",len="1",desc="发票信息列表",memo="略")
	protected List<InvoInfoEntity> invInfoList = new ArrayList<InvoInfoEntity>();
	@JSONField(name="BILL_COUNT")
	@ParamDesc(path="BILL_COUNT",cons=ConsType.CT001,type="int",len="5",desc="发票张数",memo="略")
	protected int billCnt=0;
	
	public List<InvoInfoEntity> getInvInfoList() {
		return invInfoList;
	}

	public void setInvInfoList(List<InvoInfoEntity> invInfoList) {
		this.invInfoList = invInfoList;
	}

	public int getBillCnt() {
		return billCnt;
	}

	public void setBillCnt(int billCnt) {
		this.billCnt = billCnt;
	}

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("billCnt"),this.billCnt);
		result.setBody(getPathByProperName("invInfoList"),this.invInfoList);
		return result;
	}
	
	
}

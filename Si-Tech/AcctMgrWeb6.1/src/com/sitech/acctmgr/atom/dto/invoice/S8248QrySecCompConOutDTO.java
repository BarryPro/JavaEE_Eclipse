package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.TaxAcctInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class S8248QrySecCompConOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6792770271022913L;

	@JSONField(name = "ACCT_LIST")
	@ParamDesc(path = "ACCT_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "二级账户列表", memo = "略")
	private List<TaxAcctInfo> relConList;

	@JSONField(name = "ACCT_NUM")
	@ParamDesc(path = "ACCT_NUM", cons = ConsType.CT001, type = "int", len = "3", desc = "二级账户数目", memo = "略")
	private int count;

	/**
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * @param count
	 *            the count to set
	 */
	public void setCount(int count) {
		this.count = count;
	}

	/**
	 * @return the relConList
	 */
	public List<TaxAcctInfo> getRelConList() {
		return relConList;
	}

	/**
	 * @param relConList
	 *            the relConList to set
	 */
	public void setRelConList(List<TaxAcctInfo> relConList) {
		this.relConList = relConList;
	}

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("relConList"), relConList);
		result.setRoot(getPathByProperName("count"), count);
		return result;
	}

}

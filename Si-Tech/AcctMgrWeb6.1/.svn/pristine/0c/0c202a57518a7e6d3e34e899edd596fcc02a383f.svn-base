package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.RemindOpenEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SRemindOpenInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3457873395909507443L;
	@JSONField(name="RULE_LIST")
	@ParamDesc(path="RULE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="支付类型列表",memo="略")
	private List<RemindOpenEntity> ruleList = new ArrayList<RemindOpenEntity>();
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("ruleList"), ruleList);

		return result;
	}



	/**
	 * @return the ruleList
	 */
	public List<RemindOpenEntity> getRuleList() {
		return ruleList;
	}



	/**
	 * @param ruleList the ruleList to set
	 */
	public void setRuleList(List<RemindOpenEntity> ruleList) {
		this.ruleList = ruleList;
	}
}

package com.sitech.acctmgr.atom.domains.adj;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/

public class AdjBackMoneyInitEntity {
	@JSONField(name="BILL_TYPE_NAME")
	@ParamDesc(path="BILL_TYPE_NAME",cons=ConsType.QUES,type="String",len="14",desc="计费名字",memo="略")
	protected String billTypeName;
	@JSONField(name="BILL_TYPE_ID")
	@ParamDesc(path="BILL_TYPE_ID",cons=ConsType.QUES,type="String",len="10",desc="计费值",memo="略")
	protected String billTypeId;
	@JSONField(name="SUB_TYPE_NAME")
	@ParamDesc(path="SUB_TYPE_NAME",cons=ConsType.QUES,type="String",len="14",desc="核减名字",memo="略")
	protected String subTypeName;
	@JSONField(name="SUB_TYPE_ID")
	@ParamDesc(path="SUB_TYPE_ID",cons=ConsType.QUES,type="String",len="10",desc="核减值",memo="略")
	protected String subTypeId;
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> toMap(){
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}
	
	
	public String getBillTypeName() {
		return billTypeName;
	}

	public void setBillTypeName(String billTypeName) {
		this.billTypeName = billTypeName;
	}

	public String getBillTypeId() {
		return billTypeId;
	}

	public void setBillTypeId(String billTypeId) {
		this.billTypeId = billTypeId;
	}

	public String getSubTypeName() {
		return subTypeName;
	}

	public void setSubTypeName(String subTypeName) {
		this.subTypeName = subTypeName;
	}

	public String getSubTypeId() {
		return subTypeId;
	}

	public void setSubTypeId(String subTypeId) {
		this.subTypeId = subTypeId;
	}

	@Override
	public String toString() {
		return "AdjBackMoneyInitEntity [billTypeName=" + billTypeName 
				+ ", billTypeId=" + billTypeId + ", subTypeName=" + subTypeName + ", subTypeId=" + subTypeId + "]";
		

		
	}
	
}

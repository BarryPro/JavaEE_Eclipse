package com.sitech.acctmgr.atom.domains.detail;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.WriteOffItemEntity;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
/**
 * 
 * @author 详单查询记录展示实体
 *
 */
public class DetailQryRecord {
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons= ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons= ConsType.CT001,type="String",len="20",desc="工号",memo="略")
	private String loginNo;
	
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons= ConsType.CT001,type="String",len="20",desc="操作时间",memo="略")
	private String opTime;
	
	@JSONField(name = "OP_NOTE")
	@ParamDesc(path="REMARK",cons= ConsType.CT001,type="String",len="100",desc="操作日志",memo="略")
	private String remark;
	
	@JSONField(name = "AUTH_NAME")
	@ParamDesc(path="AUTH_NAME",cons= ConsType.CT001,type="String",len="32",desc="",memo="略")
	private String authName;
	
	@JSONField(name = "QUERY_TIME")
	@ParamDesc(path="QUERY_TIME",cons= ConsType.CT001,type="String",len="32",desc="查询时间",memo="略")
	private String queryTime;
	
	@JSONField(name = "RECORD_LIST")
	private List<DetailQryRecord> qryRecdList;

	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public String getOpTime() {
		return opTime;
	}
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getQueryTime() {
		return queryTime;
	}
	public void setQueryTime(String queryTime) {
		this.queryTime = queryTime;
	}
	public List<DetailQryRecord> getQryRecdList() {
		return qryRecdList;
	}
	public void setQryRecdList(List<DetailQryRecord> qryRecdList) {
		this.qryRecdList = qryRecdList;
	}
	
}

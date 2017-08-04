package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBroadInvoiceQryPayInfoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2872339532412775475L;
	
	@JSONField(name="RUN_NAME")
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="String",len="20",desc="运行状态",memo="略")
	protected String runName;
	@JSONField(name="CUST_NAME")
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="20",desc="客户名称",memo="略")
	protected String custName;
	@JSONField(name="ADDRESS")
	@ParamDesc(path="ADDRESS",cons=ConsType.CT001,type="String",len="100",desc="客户地址",memo="略")
	protected String address;
	@JSONField(name="ACCT_LIST")
	@ParamDesc(path="ACCT_LIST",cons=ConsType.CT001,type="compx",len="1",desc="账户信息列表",memo="略")
	protected List<AccountListEntity> acctList ;
	@JSONField(name="ACCTLIST_NUM")
	@ParamDesc(path="ACCTLIST_NUM",cons=ConsType.CT001,type="int",len="3",desc="账户数目",memo="略")
	protected int cnt ;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo;
	@JSONField(name="BEGIN_MON")
	@ParamDesc(path="BEGIN_MON",cons=ConsType.CT001,type="int",len="20",desc="服务号码",memo="略")
	protected int beginMon;
	@JSONField(name="END_MON")
	@ParamDesc(path="END_MON",cons=ConsType.CT001,type="int",len="20",desc="服务号码",memo="略")
	protected int endMon;
	
	
	
	public String getPhoneNo() {
		return phoneNo;
	}



	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public int getBeginMon() {
		return beginMon;
	}



	public void setBeginMon(int beginMon) {
		this.beginMon = beginMon;
	}



	public int getEndMon() {
		return endMon;
	}



	public void setEndMon(int endMon) {
		this.endMon = endMon;
	}



	public int getCnt() {
		return cnt;
	}



	public void setCnt(int cnt) {
		this.cnt = cnt;
	}



	public List<AccountListEntity> getAcctList() {
		return acctList;
	}



	public void setAcctList(List<AccountListEntity> acctList) {
		this.acctList = acctList;
	}



	public String getRunName() {
		return runName;
	}



	public void setRunName(String runName) {
		this.runName = runName;
	}



	public String getCustName() {
		return custName;
	}



	public void setCustName(String custName) {
		this.custName = custName;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("runName"), runName);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("address"), address);
		result.setRoot(getPathByProperName("acctList"), acctList);
		result.setRoot(getPathByProperName("cnt"), this.cnt);
		result.setRoot(getPathByProperName("phoneNo"), this.phoneNo);
		result.setRoot(getPathByProperName("beginMon"), beginMon);
		result.setRoot(getPathByProperName("endMon"), endMon);
		return result;
	}
}

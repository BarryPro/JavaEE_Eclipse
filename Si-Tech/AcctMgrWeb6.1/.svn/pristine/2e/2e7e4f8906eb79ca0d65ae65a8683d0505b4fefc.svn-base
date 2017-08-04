package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBroadInvoiceQryPayInfoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3042377227449599377L;
	
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.BEGIN_MON",cons=ConsType.CT001,type="int",len="10",desc="查询开始账期",memo="略")
	protected int beginMon;
	@ParamDesc(path="BUSI_INFO.END_MON",cons=ConsType.CT001,type="int",len="10",desc="查询结束账期",memo="略")
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
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		System.out.println("arg0="+arg0.toString());
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))){
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(StringUtils.isEmptyOrNull(phoneNo)){
			throw new BusiException(AcctMgrError.getErrorCode("8000","01002"), "入参帐户和用户不能同时为空！");
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginMon")))){
			beginMon = Integer.parseInt((arg0.getStr(getPathByProperName("beginMon"))));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endMon")))){
			endMon = Integer.parseInt((arg0.getStr(getPathByProperName("endMon"))));
		}
	}
	
}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SpecialTransYearCancelInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3956657754579431898L;

	@ParamDesc(path="BUSI_INFO.ORIGIN_ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="原始订单行号,要做包年取消的订单行号",memo="略")
	private String orgForeignSn;
	
	@ParamDesc(path="BUSI_INFO.CREATE_TIME",cons=ConsType.QUES,type="String",len="14",desc="原始操作时间",memo="格式：YYYYMMDDHH24MISS")
	private String orgForeignTime;
	
	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="订单行号",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.QUES,type="String",len="14",desc="操作时间",memo="格式：YYYYMMDDHH24MISS")
	private String opTime;
	
	@ParamDesc(path="BUSI_INFO.IN_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="转入号码",memo="略")
	private String inPhoneNo;
	
	@ParamDesc(path="BUSI_INFO.IN_CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="转入账号",memo="略")
	private long inContractNo;
	
	@ParamDesc(path="BUSI_INFO.OUT_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="转出号码",memo="略")
	private String outPhoneNo;
	
	@ParamDesc(path="BUSI_INFO.OUT_CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="转出账号",memo="略")
	private long outContractNo;
	
	@ParamDesc(path="BUSI_INFO.IN_PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="专款类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.PENAL_SUM_FLAG",cons=ConsType.QUES,type="String",len="1",desc="是否收取违约金标识",memo="N：不收取  Y：收取")
	private String billFlag;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="40",desc="备注信息",memo="略")
	private String opNote;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setOrgForeignSn(arg0.getStr(getPathByProperName("orgForeignSn")));
		setOrgForeignTime(arg0.getStr(getPathByProperName("orgForeignTime")));
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		this.opTime = arg0.getStr(getPathByProperName("opTime"));
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setInContractNo(Long.parseLong(arg0.getObject(getPathByProperName("inContractNo")).toString()));
		setOutPhoneNo(arg0.getStr(getPathByProperName("outPhoneNo")));
		setOutContractNo(Long.parseLong(arg0.getObject(getPathByProperName("outContractNo")).toString()));
		this.payType = arg0.getStr(getPathByProperName("payType"));
		this.billFlag = arg0.getStr(getPathByProperName("billFlag"));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
	}


	public String getPayType() {
		return payType;
	}


	public void setPayType(String payType) {
		this.payType = payType;
	}


	public String getOrgForeignSn() {
		return orgForeignSn;
	}


	public void setOrgForeignSn(String orgForeignSn) {
		this.orgForeignSn = orgForeignSn;
	}


	public String getOrgForeignTime() {
		return orgForeignTime;
	}


	public void setOrgForeignTime(String orgForeignTime) {
		this.orgForeignTime = orgForeignTime;
	}


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	public String getOpTime() {
		return opTime;
	}


	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}


	public String getInPhoneNo() {
		return inPhoneNo;
	}


	public void setInPhoneNo(String inPhoneNo) {
		this.inPhoneNo = inPhoneNo;
	}


	public long getInContractNo() {
		return inContractNo;
	}


	public void setInContractNo(long inContractNo) {
		this.inContractNo = inContractNo;
	}


	public String getOutPhoneNo() {
		return outPhoneNo;
	}


	public void setOutPhoneNo(String outPhoneNo) {
		this.outPhoneNo = outPhoneNo;
	}


	public long getOutContractNo() {
		return outContractNo;
	}


	public void setOutContractNo(long outContractNo) {
		this.outContractNo = outContractNo;
	}


	public String getBillFlag() {
		return billFlag;
	}


	public void setBillFlag(String billFlag) {
		this.billFlag = billFlag;
	}


	public String getOpNote() {
		return opNote;
	}


	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}

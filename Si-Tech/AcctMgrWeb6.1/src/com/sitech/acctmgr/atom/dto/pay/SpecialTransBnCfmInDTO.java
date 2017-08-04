package com.sitech.acctmgr.atom.dto.pay;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SpecialTransBnCfmInDTO extends CommonInDTO{

	private static final long serialVersionUID = -5228903212051791144L;

	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="20",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="外部时间",memo="略")
	private String foreignTime;
	
	@ParamDesc(path="BUSI_INFO.IN_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="转入号码",memo="略")
	private String inPhoneNo;
	
	@ParamDesc(path="BUSI_INFO.IN_CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="转入账号",memo="略")
	private long inContractNo;
	
	@ParamDesc(path="BUSI_INFO.OUT_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="转出号码",memo="略")
	private String outPhoneNo;
	
	@ParamDesc(path="BUSI_INFO.OUT_CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="转出账号",memo="略")
	private long outContractNo;
	
	@ParamDesc(path="BUSI_INFO.EFFECT_MONTH",cons=ConsType.QUES,type="long",len="4",desc="有效期",memo="略")
	private int effectMonth;
	
	@ParamDesc(path="BUSI_INFO.IN_PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="专款类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.YEAR_FEE",cons=ConsType.CT001,type="String",len="14",desc="包年费用",memo="单位：分")
	private long yearFee;
	
	@ParamDesc(path="BUSI_INFO.MONTH_FLAG",cons=ConsType.CT001,type="String",len="1",desc="是否控制专款每月最多消费金额",memo="1控制，0不控制")
	private String monthFlag;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="40",desc="备注信息",memo="略")
	private String opNote;
	
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="14",desc="专款开始日期",memo="YYYYMMDDHH24MISS")
	private String beginDate;
	
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="14",desc="操作类型",
			memo="1、老系统调用bs_s1255Cfm这个业务工单，且op_code不等于1201时  新系统传：BN")
	private String opType;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		this.foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setInContractNo(Long.parseLong(arg0.getObject(getPathByProperName("inContractNo")).toString()));
		setOutPhoneNo(arg0.getStr(getPathByProperName("outPhoneNo")));
		setOutContractNo(Long.parseLong(arg0.getObject(getPathByProperName("outContractNo")).toString()));
		setEffectMonth(Integer.parseInt(arg0.getObject(getPathByProperName("effectMonth")).toString()));
		setPayType(arg0.getStr(getPathByProperName("payType")));
		this.yearFee = Long.parseLong(arg0.getStr(getPathByProperName("yearFee")));
		
		this.monthFlag = arg0.getStr(getPathByProperName("monthFlag"));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		setBeginDate(arg0.getStr(getPathByProperName("beginDate")));
		setOpType(arg0.getStr(getPathByProperName("opType")));
		if (!"BN".equals(opType)){
			throw new BusiException(getErrorCode("0000", "00001"), "操作类型错误，请修改操作类型");
		}
	}


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	public String getForeignTime() {
		return foreignTime;
	}


	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
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

	public int getEffectMonth() {
		return effectMonth;
	}

	public void setEffectMonth(int effectMonth) {
		this.effectMonth = effectMonth;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public long getYearFee() {
		return yearFee;
	}

	public void setYearFee(long yearFee) {
		this.yearFee = yearFee;
	}


	public String getMonthFlag() {
		return monthFlag;
	}

	public void setMonthFlag(String monthFlag) {
		this.monthFlag = monthFlag;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getOpType() {
		return opType;
	}

	public void setOpType(String opType) {
		this.opType = opType;
	}


}

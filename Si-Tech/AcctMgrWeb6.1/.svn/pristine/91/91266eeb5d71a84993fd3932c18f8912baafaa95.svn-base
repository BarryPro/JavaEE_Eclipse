package com.sitech.acctmgr.atom.dto.pay;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SpecialTransCfmInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3422652232361134740L;

	
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
	
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="专款类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.MONTH_FEE",cons=ConsType.CT001,type="String",len="14",desc="每月转入金额",memo="单位：分")
	private String monthFee;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="40",desc="备注信息",memo="略")
	private String opNote;
	
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="14",desc="专款开始日期",memo="YYYYMMDDHH24MISS")
	private String beginDate;
	
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="14",desc="操作类型",
			memo="1、老系统调用s_fmlcreate 接口  OP_CODE为m358且账本类型传入  新系统传：JT ")
	private String opType;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="20",desc="外部流水",memo="略")
	private String foreignSn;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setInContractNo(Long.parseLong(arg0.getObject(getPathByProperName("inContractNo")).toString()));
		setOutPhoneNo(arg0.getStr(getPathByProperName("outPhoneNo")));
		setOutContractNo(Long.parseLong(arg0.getObject(getPathByProperName("outContractNo")).toString()));
		setEffectMonth(Integer.parseInt(arg0.getObject(getPathByProperName("effectMonth")).toString()));
		setPayType(arg0.getStr(getPathByProperName("payType")));
		setMonthFee(arg0.getStr(getPathByProperName("monthFee")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		setBeginDate(arg0.getStr(getPathByProperName("beginDate")));
		setOpType(arg0.getStr(getPathByProperName("opType")));
		if (!"JT".equals(opType)){
			throw new BusiException(getErrorCode("0000", "00001"), "操作类型错误，请修改操作类型");
		}
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		
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


	public String getMonthFee() {
		return monthFee;
	}


	public void setMonthFee(String monthFee) {
		this.monthFee = monthFee;
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


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

}

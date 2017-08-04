package com.sitech.acctmgr.atom.dto.pay;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SpecialTransKdTsCfmInDTO extends CommonInDTO{

	private static final long serialVersionUID = -5228903212051791144L;

	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="20",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="外部时间",memo="略")
	private String foreignTime;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="宽带号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.IN_PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="原专款类型",memo="略")
	private String inPayType;
	
	@ParamDesc(path="BUSI_INFO.IN_PAY_TYPE_NEW",cons=ConsType.CT001,type="String",len="5",desc="新专款类型",memo="略")
	private String inPayTypeNew;
	
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="14",desc="专款开始日期",memo="YYYYMMDDHH24MISS")
	private String beginDate;
	
	@ParamDesc(path="BUSI_INFO.EFFECT_MONTH",cons=ConsType.QUES,type="long",len="4",desc="有效期",memo="略")
	private int effectMonth;
	
	@ParamDesc(path="BUSI_INFO.YEAR_FEE",cons=ConsType.CT001,type="String",len="14",desc="包年费用",memo="单位：分")
	private long yearFee;
	
	@ParamDesc(path="BUSI_INFO.PRC_ID",cons=ConsType.CT001,type="String",len="10",desc="资费",memo="")
	private String prcId;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="40",desc="备注信息",memo="略")
	private String opNote;
	

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		this.foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		this.phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		this.inPayType = arg0.getStr(getPathByProperName("inPayType"));
		this.inPayTypeNew = arg0.getStr(getPathByProperName("inPayTypeNew"));
		this.beginDate = arg0.getStr(getPathByProperName("beginDate"));
		this.effectMonth = Integer.parseInt(arg0.getObject(getPathByProperName("effectMonth")).toString());
		this.yearFee = Long.parseLong(arg0.getStr(getPathByProperName("yearFee")));
		this.prcId = arg0.getStr(getPathByProperName("prcId"));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
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


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getInPayType() {
		return inPayType;
	}


	public void setInPayType(String inPayType) {
		this.inPayType = inPayType;
	}


	public String getInPayTypeNew() {
		return inPayTypeNew;
	}


	public void setInPayTypeNew(String inPayTypeNew) {
		this.inPayTypeNew = inPayTypeNew;
	}


	public String getBeginDate() {
		return beginDate;
	}


	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}


	public int getEffectMonth() {
		return effectMonth;
	}


	public void setEffectMonth(int effectMonth) {
		this.effectMonth = effectMonth;
	}


	public long getYearFee() {
		return yearFee;
	}


	public void setYearFee(long yearFee) {
		this.yearFee = yearFee;
	}


	public String getPrcId() {
		return prcId;
	}


	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}


	public String getOpNote() {
		return opNote;
	}


	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}

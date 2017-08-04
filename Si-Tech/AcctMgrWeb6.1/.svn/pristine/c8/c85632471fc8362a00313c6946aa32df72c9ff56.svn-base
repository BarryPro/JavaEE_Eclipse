package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  缴费冲正确认入参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8056ForeignInDTO extends CommonInDTO{

	private static final long serialVersionUID = -6244438000347788966L;

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@JSONField(name="PAY_DATE")
	@ParamDesc(path="BUSI_INFO.PAY_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String payDate;
	
	@JSONField(name="FOREIGN_SN")
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="long",len="14",desc="要冲正的外部流水",memo="略")
	protected String foreignSn;
	
	@JSONField(name="PAY_PATH")
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",
		memo="02:网上营业厅,06:IVR,04:短信营业厅,11:营业前台,05:自助终端,18:一级BOSS,19:银行,21:智能终端CRM,28:三卡合一")
	protected String payPath;
	
	@JSONField(name="PAY_METHOD")
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",
		memo="0:现金,W:POS机,8:赠费,c:充值卡")
	protected String payMethod;
	
	@JSONField(name="SMS_FLAG")
	@ParamDesc(path="BUSI_INFO.SMS_FLAG",cons=ConsType.CT001,type="String",len="1",desc="是否发送短信标识",memo="默认为0：不发短信，其他：发短信")
	protected String smsFlag;
	
	@JSONField(name="PAY_NOTE")
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="100",desc="缴费备注",memo="略")
	protected String payNote;    //备注（可空）
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8056";//设置默认值
		}
		
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		payDate = arg0.getStr(getPathByProperName("payDate"));
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		payPath = arg0.getStr(getPathByProperName("payPath"));
		payMethod = arg0.getStr(getPathByProperName("payMethod"));
		smsFlag = arg0.getStr(getPathByProperName("smsFlag"));
		if(StringUtils.isEmptyOrNull(smsFlag)){
			smsFlag = "0";
		}
		
		payNote = arg0.getStr(getPathByProperName("payNote"));
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "外部流水缴费冲正";//设置默认备注，待完善
		}
	}


	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}


	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	/**
	 * @return the payDate
	 */
	public String getPayDate() {
		return payDate;
	}


	/**
	 * @param payDate the payDate to set
	 */
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}


	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}


	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	/**
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}


	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}


	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}


	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	/**
	 * @return the payNote
	 */
	public String getPayNote() {
		return payNote;
	}


	/**
	 * @param payNote the payNote to set
	 */
	public void setPayNote(String payNote) {
		this.payNote = payNote;
	}
	
	
}


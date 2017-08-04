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
public class S8056CfmInDTO extends CommonInDTO{

	private static final long serialVersionUID = -6244438000347788966L;

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@JSONField(name="PAY_DATE")
	@ParamDesc(path="BUSI_INFO.PAY_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String payDate;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	protected long	paySn;
	
	@JSONField(name="SMS_FLAG")
	@ParamDesc(path="BUSI_INFO.SMS_FLAG",cons=ConsType.CT001,type="String",len="1",desc="是否发送短信标识",memo="默认为0：不发短信，其他：发短信")
	protected String smsFlag;    //默认为0：不发短信，其他：发短信
	
	@JSONField(name="PAY_NOTE")
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="100",desc="缴费备注",memo="略")
	protected String payNote;    //备注（可空）
	
	@JSONField(name="PAY_PATH")
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="渠道",
	memo="02:网上营业厅,06:IVR,04:短信营业厅,11:营业前台,05:自助终端,18:一级BOSS,19:银行,21:智能终端CRM,28:三卡合一")
	protected String payPath;
	
	@JSONField(name="PAY_METHOD")
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",
	memo="0:现金,W:POS机,8:赠费,c:充值卡")
	protected String payMethod;
	
	@JSONField(name="PAY_OPCODE")
	@ParamDesc(path="BUSI_INFO.PAY_OPCODE",cons=ConsType.QUES,type="String",len="100",desc="缴费时OP_CODE",memo="略")
	protected String payOpCode;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8056";//设置默认值
		}
		
		phoneNo = arg0.getBodyStr("BUSI_INFO.PHONE_NO").trim();
		payDate = arg0.getBodyStr("BUSI_INFO.PAY_DATE");
		paySn = Long.parseLong(arg0.getBodyObject(("BUSI_INFO.PAY_SN")).toString());
		smsFlag = arg0.getBodyStr("BUSI_INFO.SMS_FLAG");
		if (StringUtils.isEmptyOrNull(smsFlag)){
			smsFlag = "0";
		}
		payNote = arg0.getBodyStr("BUSI_INFO.PAY_NOTE");
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "缴费冲正";//设置默认备注，待完善
		}
		payPath = arg0.getBodyStr("BUSI_INFO.PAY_PATH");
		payMethod = arg0.getBodyStr("BUSI_INFO.PAY_METHOD");
		payOpCode = arg0.getStr(getPathByProperName("payOpCode"));
	}
	
	

	/**
	 * @return the payOpCode
	 */
	public String getPayOpCode() {
		return payOpCode;
	}

	/**
	 * @param payOpCode the payOpCode to set
	 */
	public void setPayOpCode(String payOpCode) {
		this.payOpCode = payOpCode;
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
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}
	
	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}
	/**
	 * @return the smsFlag
	 */
	public String getSmsFlag() {
		return smsFlag;
	}
	/**
	 * @param smsFlag the smsFlag to set
	 */
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
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
	
}


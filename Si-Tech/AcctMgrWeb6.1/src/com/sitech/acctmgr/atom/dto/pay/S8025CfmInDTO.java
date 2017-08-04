package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8025CfmInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="发起充值手机号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.PHONENO_PAY",cons=ConsType.CT001,type="String",len="40",desc="被充值手机号码",memo="略")
	protected String phoneNoPay;
	
	@ParamDesc(path="BUSI_INFO.CARD_NO",cons=ConsType.CT001,type="String",len="40",desc="充值卡号",memo="略")
	protected String cardNo;
	
	@ParamDesc(path="BUSI_INFO.CARD_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="充值卡密码",memo="略")
	protected String cardPassword;
	
	@ParamDesc(path="BUSI_INFO.CHANNEL_ID",cons=ConsType.CT001,type="String",len="10",desc="渠道标识",
			memo="02:网上营业厅,06:IVR,04:短信营业厅,11:营业前台")
	protected String channelId;
	
	@ParamDesc(path="BUSI_INFO.CARD_TYPE",cons=ConsType.CT001,type="String",len="1",desc="充值卡是否已刮",memo="0、已刮；1未刮")
	protected String cardType;
	
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="50",desc="备注",memo="略")
	protected String remark;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPhoneNoPay(arg0.getStr(getPathByProperName("phoneNoPay")));
		setCardNo(arg0.getStr(getPathByProperName("cardNo")));
		setCardType(arg0.getStr(getPathByProperName("cardType")));
		setCardPassword(arg0.getStr(getPathByProperName("cardPassword")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		if(StringUtils.isEmptyOrNull(this.cardPassword)){
			
			throw new BusiException(AcctMgrError.getErrorCode("8025", "00016"), "充值卡密码不能为空");
		}
		if(StringUtils.isEmptyOrNull(this.remark)){
			remark = "特殊充值";
		}
		setChannelId(arg0.getStr(getPathByProperName("channelId")));
		/*智能网定义的渠道标识 10：短信营业厅, 11：网上营业厅 12：实体营业厅 13：WAP营业厅 14：自助终端，15：10086热线，*/
		if(this.channelId.equals("06")){
			channelId = "15";
		}else if(this.channelId.equals("02")){
			channelId = "11";
		}else if(this.channelId.equals("04")){
			channelId = "10";
		}else{
			
			throw new BusiException(AcctMgrError.getErrorCode("8025", "00015"), "传入渠道标识有误");
		}
	}


	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}


	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getPhoneNoPay() {
		return phoneNoPay;
	}


	public void setPhoneNoPay(String phoneNoPay) {
		this.phoneNoPay = phoneNoPay;
	}


	public String getCardNo() {
		return cardNo;
	}


	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}


	public String getCardPassword() {
		return cardPassword;
	}


	public void setCardPassword(String cardPassword) {
		this.cardPassword = cardPassword;
	}


	public String getChannelId() {
		return channelId;
	}


	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}


	/**
	 * @return the cardType
	 */
	public String getCardType() {
		return cardType;
	}


	/**
	 * @param cardType the cardType to set
	 */
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	
}

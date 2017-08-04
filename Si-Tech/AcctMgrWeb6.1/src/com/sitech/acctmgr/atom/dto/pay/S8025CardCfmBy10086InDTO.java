package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title: 银行卡签约客户主动交费入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8025CardCfmBy10086InDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="发起充值手机号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.PHONENO_PAY",cons=ConsType.CT001,type="String",len="40",desc="被充值手机号码",memo="略")
	protected String phoneNoPay;
	
	@ParamDesc(path="BUSI_INFO.CARD_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="充值卡密码",memo="略")
	protected String cardPassword;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="40",desc="交易流水号",memo="略")
	protected String foreignSn;
	
	@ParamDesc(path="BUSI_INFO.CHANNEL_ID",cons=ConsType.CT001,type="String",len="10",desc="渠道标识",
			memo="06:IVR,11:营业前台")
	protected String channelId;
	
	@ParamDesc(path="BUSI_INFO.KEY_ID",cons=ConsType.CT001,type="String",len="10",desc="按键轨迹",memo="略")
	protected String keyId;
	
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.QUES,type="String",len="10",desc="备注",memo="略")
	protected String remark;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPhoneNoPay(arg0.getStr(getPathByProperName("phoneNoPay")));
		setCardPassword(arg0.getStr(getPathByProperName("cardPassword")));
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		setChannelId(arg0.getStr(getPathByProperName("channelId")));
		setKeyId(arg0.getStr(getPathByProperName("keyId")));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("remark")))){
			this.remark = arg0.getStr(getPathByProperName("remark"));
		}else{
			if(this.channelId.equals("06")){
				remark = "10086热线充值卡充值";
			}else{
				remark = "充值卡发起充值请求";
			}
		}
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getKeyId() {
		return keyId;
	}

	public void setKeyId(String keyId) {
		this.keyId = keyId;
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


	public String getCardPassword() {
		return cardPassword;
	}


	public void setCardPassword(String cardPassword) {
		this.cardPassword = cardPassword;
	}


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	public String getChannelId() {
		return channelId;
	}


	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

}

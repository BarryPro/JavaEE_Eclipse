package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
* @Description: 手机钱包支付扣费 入参DTO
* @Date :2016年10月24日
* @Company: SI-TECH
* @author : liuyc_billing
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class SMicroPayCfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3063786815254078923L;
	
	@ParamDesc(path="BUSI_INFO.LOGIN_PASSWORD",cons=ConsType.CT001,type="String",len="20",desc="工号密码",memo="略")
	private String vPassWord;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String inPhoneNo;
	@ParamDesc(path="BUSI_INFO.TRADE_CODE",cons=ConsType.CT001,type="String",len="40",desc="交易代码",memo="略")
	private String vTradCode;
	@ParamDesc(path="BUSI_INFO.IN_PREPAY_FEE",cons=ConsType.CT001,type="double",len="40",desc="消费金额",memo="略")
	private long inPrePayFee;
	@ParamDesc(path="BUSI_INFO.IN_TRANS_ID",cons=ConsType.CT001,type="String",len="40",desc="交易流水",memo="略")
	private String inTransId;
	@ParamDesc(path="BUSI_INFO.IN_TRANS_DATE",cons=ConsType.CT001,type="String",len="40",desc="交易日期",memo="略")
	private String inTransDate;
	@ParamDesc(path="BUSI_INFO.IN_COMPANY_ID",cons=ConsType.CT001,type="String",len="40",desc="商户号",memo="略")
	private String inCompanyId;
	@ParamDesc(path="BUSI_INFO.IN_COMPANY_NAME",cons=ConsType.CT001,type="String",len="40",desc="商户名称",memo="略")
	private String inCompanyName;
	@ParamDesc(path="BUSI_INFO.IN_GOODS_ID",cons=ConsType.CT001,type="String",len="40",desc="商品号",memo="略")
	private String inGoodsId;
	@ParamDesc(path="BUSI_INFO.IN_GOODS_NAME",cons=ConsType.CT001,type="String",len="40",desc="商品名称",memo="略")
	private String inGoodsName;
	@ParamDesc(path="BUSI_INFO.SERVICE_TYPE",cons=ConsType.CT001,type="String",len="2",desc="",memo="服务类型：小额支付为0，流量优惠为1")
	private String serviceType;

	@Override
	public void decode(MBean arg0){
		super.decode(arg0);
		setvPassWord(arg0.getStr(getPathByProperName("vPassWord")));
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setvTradCode(arg0.getStr(getPathByProperName("vTradCode")));
//		setInPrePayFee(arg0.getLong(getPathByProperName("inPrePayFee")));
		setInPrePayFee(Long.parseLong(arg0.getObject(getPathByProperName("inPrePayFee")).toString()));
		setInTransId(arg0.getStr(getPathByProperName("inTransId")));
		setInTransDate(arg0.getStr(getPathByProperName("inTransDate")));
		setInCompanyId(arg0.getStr(getPathByProperName("inCompanyId")));
		setInCompanyName(arg0.getStr(getPathByProperName("inCompanyName")));
		setInGoodsId(arg0.getStr(getPathByProperName("inGoodsId")));
		setInGoodsName(arg0.getStr(getPathByProperName("inGoodsName")));
		setServiceType(arg0.getStr(getPathByProperName("serviceType")));
		if(StringUtils.isEmptyOrNull(serviceType)){
			serviceType="0";
		}
		/*设置默认opcode*/
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "C240";
		}
	}
	
	
	

	public String getvPassWord() {
		return vPassWord;
	}

	public void setvPassWord(String vPassWord) {
		this.vPassWord = vPassWord;
	}

	public String getInPhoneNo() {
		return inPhoneNo;
	}

	public void setInPhoneNo(String inPhoneNo) {
		this.inPhoneNo = inPhoneNo;
	}

	public String getvTradCode() {
		return vTradCode;
	}

	public void setvTradCode(String vTradCode) {
		this.vTradCode = vTradCode;
	}

	public long getInPrePayFee() {
		return inPrePayFee;
	}

	public void setInPrePayFee(long inPrePayFee) {
		this.inPrePayFee = inPrePayFee;
	}

	public String getInTransId() {
		return inTransId;
	}

	public void setInTransId(String inTransId) {
		this.inTransId = inTransId;
	}

	public String getInTransDate() {
		return inTransDate;
	}

	public void setInTransDate(String inTransDate) {
		this.inTransDate = inTransDate;
	}

	public String getInCompanyId() {
		return inCompanyId;
	}

	public void setInCompanyId(String inCompanyId) {
		this.inCompanyId = inCompanyId;
	}

	public String getInCompanyName() {
		return inCompanyName;
	}

	public void setInCompanyName(String inCompanyName) {
		this.inCompanyName = inCompanyName;
	}

	public String getInGoodsId() {
		return inGoodsId;
	}

	public void setInGoodsId(String inGoodsId) {
		this.inGoodsId = inGoodsId;
	}

	public String getInGoodsName() {
		return inGoodsName;
	}

	public void setInGoodsName(String inGoodsName) {
		this.inGoodsName = inGoodsName;
	}




	public String getServiceType() {
		return serviceType;
	}




	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

}

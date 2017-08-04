package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8069alipayCfmInDTO extends CommonInDTO {
	
	@JSONField(name="BUSI_INFO.PHONENO")
	@ParamDesc(path="BUSI_INFO.PHONENO",cons=ConsType.CT001,type="String",len="40",desc="签约用户手机号码",memo="老系统入参第一个参数")
	protected String phoneNo;
	
	@JSONField(name="BUSI_INFO.PASSWD")
	@ParamDesc(path="BUSI_INFO.PASSWD",cons=ConsType.CT001,type="String",len="40",desc="签约用户手机号码密码",memo="略")
	protected String passWD;
	
	@JSONField(name="BUSI_INFO.PHONENO_PAY")
	@ParamDesc(path="BUSI_INFO.PHONENO_PAY",cons=ConsType.CT001,type="String",len="40",desc="前用户手机号码",memo="老系统入参第三个参数")
	protected String phoneNoPay;
	
	@JSONField(name="BUSI_INFO.LOGIN_NO")
	@ParamDesc(path="BUSI_INFO.LOGIN_NO",cons=ConsType.CT001,type="String",len="12",desc="操作员工号",memo="略")
	protected String loginNo;
	
	@JSONField(name="BUSI_INFO.LOGIN_PASSWD")
	@ParamDesc(path="BUSI_INFO.LOGIN_PASSWD",cons=ConsType.CT001,type="String",len="40",desc="操作员工号密码",memo="略")
	protected String loginPassWD;
	
	@JSONField(name="BUSI_INFO.PAY_MONEY") 
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="long",len="40",desc="总付款金额",memo="略")
	protected long payMoney;
	
	@JSONField(name="BUSI_INFO.QUANTITY")
	@ParamDesc(path="BUSI_INFO.QUANTITY",cons=ConsType.CT001,type="String",len="10",desc="商品数量",memo="略")
	protected String quantity;
	
	@JSONField(name="BUSI_INFO.PAY_OTHER_INFO")
	@ParamDesc(path="BUSI_INFO.PAY_OTHER_INFO",cons=ConsType.CT001,type="String",len="120",desc="支付时需要的其它信息",memo="略")
	protected String payOtherInfo;
	
	@JSONField(name="BUSI_INFO.MEMO")
	@ParamDesc(path="BUSI_INFO.MEMO",cons=ConsType.CT001,type="String",len="120",desc="付款备注",memo="略")
	protected String memo;
	
	@JSONField(name="BUSI_INFO.EXTEND_ONE")
	@ParamDesc(path="BUSI_INFO.EXTEND_ONE",cons=ConsType.CT001,type="String",len="40",desc="扩展字段1",memo="略")
	protected String extendOne;
	
	@JSONField(name="BUSI_INFO.EXTEND_TWO")
	@ParamDesc(path="BUSI_INFO.EXTEND_TWO",cons=ConsType.CT001,type="String",len="40",desc="扩展字段2",memo="略")
	protected String extendTwo;
	
	@JSONField(name="BUSI_INFO.BUSI_TYPE")
	@ParamDesc(path="BUSI_INFO.BUSI_TYPE",cons=ConsType.CT001,type="String",len="10",desc="业务类型",memo="略")
	protected String busiType;
	
	@JSONField(name="BUSI_INFO.BUSI_PARAMETER")
	@ParamDesc(path="BUSI_INFO.BUSI_PARAMETER",cons=ConsType.CT001,type="String",len="40",desc="业务参数",memo="略")
	protected String busiParameter;
	
	@JSONField(name="BUSI_INFO.GOODS_INFO")
	@ParamDesc(path="BUSI_INFO.GOODS_INFO",cons=ConsType.CT001,type="String",len="40",desc="商品信息",memo="略")
	protected String goodsInfo;
	
	@JSONField(name="BUSI_INFO.DISCOUNT_RATE")
	@ParamDesc(path="BUSI_INFO.DISCOUNT_RATE",cons=ConsType.CT001,type="String",len="10",desc="优惠率",memo="略")
	protected String discountRate;
	
	@JSONField(name="BUSI_INFO.DISCOUNT_PAYMONEY")
	@ParamDesc(path="BUSI_INFO.DISCOUNT_PAYMONEY",cons=ConsType.CT001,type="long",len="40",desc="折扣后的金额",memo="略")
	protected long discountPayMoney;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPassWD(arg0.getStr(getPathByProperName("passWD")));
		setPhoneNoPay(arg0.getStr(getPathByProperName("phoneNoPay")));
		setLoginNo(arg0.getStr(getPathByProperName("loginNo")));
		setLoginPassWD(arg0.getStr(getPathByProperName("loginPassWD")));
		setPayMoney(Long.parseLong(arg0.getStr(getPathByProperName("payMoney"))));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("quantity")))){
			setQuantity(arg0.getStr(getPathByProperName("quantity")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payOtherInfo")))){
			setPayOtherInfo(arg0.getStr(getPathByProperName("payOtherInfo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("memo")))){
			setMemo(arg0.getStr(getPathByProperName("memo")));
		}
		setExtendOne(arg0.getStr(getPathByProperName("extendOne")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("extendTwo")))){
			setExtendTwo(arg0.getStr(getPathByProperName("extendTwo")));
		}
		setBusiType(arg0.getStr(getPathByProperName("busiType")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("busiParameter")))){
			setBusiParameter(arg0.getStr(getPathByProperName("busiParameter")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("goodsInfo")))){
			setGoodsInfo(arg0.getStr(getPathByProperName("goodsInfo")));
		}
		setDiscountRate(arg0.getStr(getPathByProperName("discountRate")));
		setDiscountPayMoney(Long.parseLong(arg0.getStr(getPathByProperName("discountPayMoney"))));
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
	 * @return the passWD
	 */
	public String getPassWD() {
		return passWD;
	}

	/**
	 * @param passWD the passWD to set
	 */
	public void setPassWD(String passWD) {
		this.passWD = passWD;
	}

	/**
	 * @return the phoneNoPay
	 */
	public String getPhoneNoPay() {
		return phoneNoPay;
	}

	/**
	 * @param phoneNoPay the phoneNoPay to set
	 */
	public void setPhoneNoPay(String phoneNoPay) {
		this.phoneNoPay = phoneNoPay;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the loginPassWD
	 */
	public String getLoginPassWD() {
		return loginPassWD;
	}

	/**
	 * @param loginPassWD the loginPassWD to set
	 */
	public void setLoginPassWD(String loginPassWD) {
		this.loginPassWD = loginPassWD;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the quantity
	 */
	public String getQuantity() {
		return quantity;
	}

	/**
	 * @param quantity the quantity to set
	 */
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	/**
	 * @return the payOtherInfo
	 */
	public String getPayOtherInfo() {
		return payOtherInfo;
	}

	/**
	 * @param payOtherInfo the payOtherInfo to set
	 */
	public void setPayOtherInfo(String payOtherInfo) {
		this.payOtherInfo = payOtherInfo;
	}

	/**
	 * @return the memo
	 */
	public String getMemo() {
		return memo;
	}

	/**
	 * @param memo the memo to set
	 */
	public void setMemo(String memo) {
		this.memo = memo;
	}

	/**
	 * @return the extendOne
	 */
	public String getExtendOne() {
		return extendOne;
	}

	/**
	 * @param extendOne the extendOne to set
	 */
	public void setExtendOne(String extendOne) {
		this.extendOne = extendOne;
	}

	/**
	 * @return the extendTwo
	 */
	public String getExtendTwo() {
		return extendTwo;
	}

	/**
	 * @param extendTwo the extendTwo to set
	 */
	public void setExtendTwo(String extendTwo) {
		this.extendTwo = extendTwo;
	}

	/**
	 * @return the busiType
	 */
	public String getBusiType() {
		return busiType;
	}

	/**
	 * @param busiType the busiType to set
	 */
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	/**
	 * @return the busiParameter
	 */
	public String getBusiParameter() {
		return busiParameter;
	}

	/**
	 * @param busiParameter the busiParameter to set
	 */
	public void setBusiParameter(String busiParameter) {
		this.busiParameter = busiParameter;
	}

	/**
	 * @return the goodsInfo
	 */
	public String getGoodsInfo() {
		return goodsInfo;
	}

	/**
	 * @param goodsInfo the goodsInfo to set
	 */
	public void setGoodsInfo(String goodsInfo) {
		this.goodsInfo = goodsInfo;
	}

	/**
	 * @return the discountRate
	 */
	public String getDiscountRate() {
		return discountRate;
	}

	/**
	 * @param discountRate the discountRate to set
	 */
	public void setDiscountRate(String discountRate) {
		this.discountRate = discountRate;
	}

	/**
	 * @return the discountPayMoney
	 */
	public long getDiscountPayMoney() {
		return discountPayMoney;
	}

	/**
	 * @param discountPayMoney the discountPayMoney to set
	 */
	public void setDiscountPayMoney(long discountPayMoney) {
		this.discountPayMoney = discountPayMoney;
	}
	
}

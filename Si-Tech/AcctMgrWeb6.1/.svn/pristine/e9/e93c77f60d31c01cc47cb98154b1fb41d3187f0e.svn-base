package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 退预存款
 * </p>
 * <p>
 * Description: 将String入参解析成MBean格式
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author LIJXD
 * @version 1.0
 */
public class SOrderPayInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6530513105591434857L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "14", desc = "服务号码", memo = "略")
	protected String phoneNo;
	@ParamDesc(path = "BUSI_INFO.PAY_MONEY", cons = ConsType.CT001, type = "String", len = "12", desc = "金额", memo = "略")
	protected String payMoney;
	@ParamDesc(path = "BUSI_INFO.BUSI_PARAMETER", cons = ConsType.QUES, type = "String", len = "31", desc = "扫描枪数据", memo = "略")
	protected String busiParameter;
	@ParamDesc(path = "BUSI_INFO.CLIENT_IP", cons = ConsType.QUES, type = "String", len = "31", desc = "ADDRESS", memo = "略")
	protected String clientIp;
	@ParamDesc(path = "BUSI_INFO.TRADE_ID", cons = ConsType.QUES, type = "String", len = "31", desc = "支付单ID", memo = "略")
	protected String tradeId;
	@ParamDesc(path = "BUSI_INFO.ORDER_ID", cons = ConsType.QUES, type = "String", len = "31", desc = "订单ID", memo = "略")
	protected String orderId;
	@ParamDesc(path = "BUSI_INFO.ORDER_DESC", cons = ConsType.QUES, type = "String", len = "31", desc = "订单描述", memo = "略")
	protected String orderDesc;
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPayMoney(arg0.getStr(getPathByProperName("payMoney")));
		setBusiParameter(arg0.getStr(getPathByProperName("busiParameter")));
		setClientIp(arg0.getStr(getPathByProperName("clientIp")));
		setTradeId(arg0.getStr(getPathByProperName("tradeId")));
		setOrderId(arg0.getStr(getPathByProperName("orderId")));
		setOrderDesc(arg0.getStr(getPathByProperName("orderDesc")));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @return the payMoney
	 */
	public String getPayMoney() {
		return payMoney;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @param payMoney
	 *            the payMoney to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the busiParameter
	 */
	public String getBusiParameter() {
		return busiParameter;
	}

	/**
	 * @return the clientIp
	 */
	public String getClientIp() {
		return clientIp;
	}

	/**
	 * @return the tradeId
	 */
	public String getTradeId() {
		return tradeId;
	}

	/**
	 * @return the orderId
	 */
	public String getOrderId() {
		return orderId;
	}

	/**
	 * @return the orderDesc
	 */
	public String getOrderDesc() {
		return orderDesc;
	}

	/**
	 * @param busiParameter the busiParameter to set
	 */
	public void setBusiParameter(String busiParameter) {
		this.busiParameter = busiParameter;
	}

	/**
	 * @param clientIp the clientIp to set
	 */
	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

	/**
	 * @param tradeId the tradeId to set
	 */
	public void setTradeId(String tradeId) {
		this.tradeId = tradeId;
	}

	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	/**
	 * @param orderDesc the orderDesc to set
	 */
	public void setOrderDesc(String orderDesc) {
		this.orderDesc = orderDesc;
	}

}

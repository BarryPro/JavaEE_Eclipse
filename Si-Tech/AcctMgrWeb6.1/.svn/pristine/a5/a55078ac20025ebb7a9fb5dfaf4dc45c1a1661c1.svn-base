package com.sitech.acctmgr.atom.dto.pay;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PayBackOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title: 陈死账回收查询出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author linzc
 * @version 1.0
 */
public class S8007InitOutDTO extends CommonOutDTO{

	/**
	 *
	 */
	private static final long serialVersionUID = 1557131573679998243L;

	@JSONField(name="ALL_PAY")
	@ParamDesc(path="ALL_PAY",cons=ConsType.CT001,type="long",len="18",desc="全部付款金额",memo="略")
	protected	long	allPay;
	@JSONField(name="CUST_NAME")
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="40",desc="客户名称",memo="略")
	protected	String	custName;
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="18",desc="用户ID",memo="略")
	protected	long	idNo;
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="40",desc="操作时间",memo="略")
	protected	String	opTime;
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="18",desc="付费流水",memo="略")
	protected	long	paySn;
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected	long	contractNo;
	@JSONField(name="ID_NUMBER")
	@ParamDesc(path="ID_NUMBER",cons=ConsType.CT001,type="int",len="1",desc="付费用户数",memo="略")
	protected   int  idNumber;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="电话号码",memo="略")
	private String phoneNo;
	@JSONField(name="PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="缴费金额",memo="略")
	private long payMoney;
	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="新增预存",memo="略")
	private long prepayFee;
	@JSONField(name="PAYED_OWE")
	@ParamDesc(path="PAYED_OWE",cons=ConsType.CT001,type="long",len="14",desc="冲销欠费",memo="略")
	private long payedOwe;
	@JSONField(name="DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="冲销滞纳金",memo="略")
	private long delayFee;
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="40",desc="电话号码",memo="略")
	private String loginNo;

	public MBean encode() {
		MBean result = new MBean();

		result.setRoot(getPathByProperName("allPay"), allPay);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("idNo"), idNo);
		result.setRoot(getPathByProperName("opTime"), opTime);
		result.setRoot(getPathByProperName("paySn"), paySn);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("idNumber"), idNumber);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("payedOwe"), payedOwe);
		result.setRoot(getPathByProperName("loginNo"), loginNo);
		result.setRoot(getPathByProperName("delayFee"), delayFee);

		return result;
	}



	/**
	 * @return the allPay
	 */
	public long getAllPay() {
		return allPay;
	}



	/**
	 * @param allPay the allPay to set
	 */
	public void setAllPay(long allPay) {
		this.allPay = allPay;
	}



	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}



	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}



	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}



	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}



	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}



	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
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
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}



	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}



	/**
	 * @return the idNumber
	 */
	public int getIdNumber() {
		return idNumber;
	}



	/**
	 * @param idNumber the idNumber to set
	 */
	public void setIdNumber(int idNumber) {
		this.idNumber = idNumber;
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
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}



	/**
	 * @param prepayFee the prepayFee to set
	 */
	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}



	/**
	 * @return the payedOwe
	 */
	public long getPayedOwe() {
		return payedOwe;
	}



	/**
	 * @param payedOwe the payedOwe to set
	 */
	public void setPayedOwe(long payedOwe) {
		this.payedOwe = payedOwe;
	}



	/**
	 * @return the delayFee
	 */
	public long getDelayFee() {
		return delayFee;
	}



	/**
	 * @param delayFee the delayFee to set
	 */
	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getLoginNo() {
		return loginNo;
	}


	/**
	 * 
	 * @param loginNo
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}




}

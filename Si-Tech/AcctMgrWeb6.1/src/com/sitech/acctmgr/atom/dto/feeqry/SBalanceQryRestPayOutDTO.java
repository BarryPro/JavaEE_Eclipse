package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.atom.domains.balance.BatchPayEntity;
import com.sitech.acctmgr.atom.domains.balance.RestPayEntity;
import com.sitech.acctmgr.atom.domains.balance.RestUnPayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SBalanceQryRestPayOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -930620547135229620L;
	
	@ParamDesc(path="RESTPAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="未返费列表",memo="略")
	private List<RestPayEntity> restPayList = new ArrayList<RestPayEntity>();
	@ParamDesc(path="RESTUNPAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="不满足条件未返费列表",memo="略")
	private List<RestUnPayEntity> restUnPayList = new ArrayList<RestUnPayEntity>();
	@ParamDesc(path="BATCHPAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="已返费列表",memo="略")
	private List<BatchPayEntity> BatchPayList = new ArrayList<BatchPayEntity>();
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="未返费预存",memo="略")
	private long prepayFee = 0;
	@ParamDesc(path="ORD_PREPAY",cons=ConsType.CT001,type="long",len="20",desc="未返费普通预存",memo="略")
	private long ordPrepay = 0;
	@ParamDesc(path="PRE_PREPAY",cons=ConsType.CT001,type="long",len="20",desc="未返费赠费预存",memo="略")
	private long prePrepay = 0;
	@ParamDesc(path="PREUNPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="不满足条件未返费预存",memo="略")
	private long preUnpayFee = 0;
	@ParamDesc(path="ORD_PRUNEPAY",cons=ConsType.CT001,type="long",len="20",desc="不满足条件未返费普通预存",memo="略")
	private long ordUnPrepay = 0;
	@ParamDesc(path="PRE_PRUNEPAY",cons=ConsType.CT001,type="long",len="20",desc="不满足条件未返费赠费预存",memo="略")
	private long preUnPrepay = 0;
	@ParamDesc(path="VALIDED_PAY",cons=ConsType.CT001,type="long",len="20",desc="已返费预存",memo="略")
	private long validedPay = 0;
	@ParamDesc(path="ORD_VALIDED",cons=ConsType.CT001,type="long",len="20",desc="已返费普通预存",memo="略")
	private long ordValided = 0;
	@ParamDesc(path="PRE_VALIDED",cons=ConsType.CT001,type="long",len="20",desc="已返费赠费预存",memo="略")
	private long preValided = 0;

	@Override
	public MBean encode() {
		MBean mBean = new MBean();
		mBean.setRoot(getPathByProperName("restPayList"), restPayList);
		mBean.setRoot(getPathByProperName("restUnPayList"), restUnPayList);
		mBean.setRoot(getPathByProperName("prepayFee"), prepayFee);
		mBean.setRoot(getPathByProperName("ordPrepay"), ordPrepay);
		mBean.setRoot(getPathByProperName("prePrepay"), prePrepay);
		mBean.setRoot(getPathByProperName("preUnpayFee"), preUnpayFee);
		mBean.setRoot(getPathByProperName("ordUnPrepay"), ordUnPrepay);
		mBean.setRoot(getPathByProperName("preUnPrepay"), preUnPrepay);
		mBean.setRoot(getPathByProperName("BatchPayList"), BatchPayList);
		mBean.setRoot(getPathByProperName("validedPay"), validedPay);
		mBean.setRoot(getPathByProperName("ordValided"), ordValided);
		mBean.setRoot(getPathByProperName("preValided"), preValided);
		return mBean;
	}

	public long getPreUnpayFee() {
		return preUnpayFee;
	}

	public void setPreUnpayFee(long preUnpayFee) {
		this.preUnpayFee = preUnpayFee;
	}

	public long getOrdUnPrepay() {
		return ordUnPrepay;
	}

	public void setOrdUnPrepay(long ordUnPrepay) {
		this.ordUnPrepay = ordUnPrepay;
	}

	public long getPreUnPrepay() {
		return preUnPrepay;
	}

	public void setPreUnPrepay(long preUnPrepay) {
		this.preUnPrepay = preUnPrepay;
	}

	/**
	 * @return the restPayList
	 */
	public List<RestPayEntity> getRestPayList() {
		return restPayList;
	}

	/**
	 * @return the restUnPayList
	 */
	public List<RestUnPayEntity> getRestUnPayList() {
		return restUnPayList;
	}
	/**
	 * @param restPayList the restPayList to set
	 */
	public void setRestPayList(List<RestPayEntity> restPayList) {
		this.restPayList = restPayList;
	}
	
	/**
	 * @param restPayList the restPayList to set
	 */
	public void setRestUnPayList(List<RestUnPayEntity> restUnPayList) {
		this.restUnPayList = restUnPayList;
	}

	/**
	 * @return the batchPayList
	 */
	public List<BatchPayEntity> getBatchPayList() {
		return BatchPayList;
	}

	/**
	 * @param batchPayList the batchPayList to set
	 */
	public void setBatchPayList(List<BatchPayEntity> batchPayList) {
		BatchPayList = batchPayList;
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
	 * @return the ordPrepay
	 */
	public long getOrdPrepay() {
		return ordPrepay;
	}

	/**
	 * @param ordPrepay the ordPrepay to set
	 */
	public void setOrdPrepay(long ordPrepay) {
		this.ordPrepay = ordPrepay;
	}

	/**
	 * @return the prePrepay
	 */
	public long getPrePrepay() {
		return prePrepay;
	}

	/**
	 * @param prePrepay the prePrepay to set
	 */
	public void setPrePrepay(long prePrepay) {
		this.prePrepay = prePrepay;
	}

	/**
	 * @return the validedPay
	 */
	public long getValidedPay() {
		return validedPay;
	}

	/**
	 * @param validedPay the validedPay to set
	 */
	public void setValidedPay(long validedPay) {
		this.validedPay = validedPay;
	}

	/**
	 * @return the ordValided
	 */
	public long getOrdValided() {
		return ordValided;
	}

	/**
	 * @param ordValided the ordValided to set
	 */
	public void setOrdValided(long ordValided) {
		this.ordValided = ordValided;
	}

	/**
	 * @return the preValided
	 */
	public long getPreValided() {
		return preValided;
	}

	/**
	 * @param preValided the preValided to set
	 */
	public void setPreValided(long preValided) {
		this.preValided = preValided;
	}


}

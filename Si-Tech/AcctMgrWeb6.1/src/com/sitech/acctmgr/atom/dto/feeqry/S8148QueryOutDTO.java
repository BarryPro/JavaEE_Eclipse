package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayEntity;
import com.sitech.acctmgr.atom.domains.balance.EffBalanceEntity;
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
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8148QueryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7636021241104989733L;
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="100",desc="归属地",memo="略")
	private String regionName = "";
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="String",len="50",desc="付款方式",memo="略")
	private String payName = "";
	@ParamDesc(path="UNBILL_FEE",cons=ConsType.CT001,type="long",len="20",desc="内存欠费",memo="略")
	private long unBillFee = 0;
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="20",desc="余额",memo="略")
	private long remainFee = 0;
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费",memo="略")
	private long oweFee = 0;
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="账户预存",memo="略")
	private long prepayFee = 0;
	@ParamDesc(path="PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="已经生效总预存",memo="略")
	private long prepayTotal = 0;
	@ParamDesc(path="EFF_PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="将要生效总预存",memo="略")
	private long effPrepayTotal = 0;
	@ParamDesc(path="EXP_PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="已经失效总预存",memo="略")
	private long expPrepayTotal = 0;
	
	@ParamDesc(path="VALID_LIST",cons=ConsType.STAR,type="compx",len="1",desc="已经生效预存列表",memo="略")
	private List<BalanceDisplayEntity> validList = new ArrayList<BalanceDisplayEntity>();
	@ParamDesc(path="EFFDATE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="将要生效预存列表",memo="略")
	private List<BalanceDisplayEntity> effDateList = new ArrayList<BalanceDisplayEntity>();
	@ParamDesc(path="EXPDATE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="已经失效预存列表",memo="略")
	private List<BalanceDisplayEntity> expDateList = new ArrayList<BalanceDisplayEntity>();
	
	@ParamDesc(path="EFF_LIST",cons=ConsType.STAR,type="compx",len="1",desc="未生效预存包括条件返费",memo="略")
	private List<EffBalanceEntity> effList = new ArrayList<EffBalanceEntity>();
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
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}

	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}

	/**
	 * @return the unBillFee
	 */
	public long getUnBillFee() {
		return unBillFee;
	}

	/**
	 * @param unBillFee the unBillFee to set
	 */
	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
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
	 * @return the prepayTotal
	 */
	public long getPrepayTotal() {
		return prepayTotal;
	}

	/**
	 * @param prepayTotal the prepayTotal to set
	 */
	public void setPrepayTotal(long prepayTotal) {
		this.prepayTotal = prepayTotal;
	}

	/**
	 * @return the effPrepayTotal
	 */
	public long getEffPrepayTotal() {
		return effPrepayTotal;
	}

	/**
	 * @param effPrepayTotal the effPrepayTotal to set
	 */
	public void setEffPrepayTotal(long effPrepayTotal) {
		this.effPrepayTotal = effPrepayTotal;
	}

	/**
	 * @return the expPrepayTotal
	 */
	public long getExpPrepayTotal() {
		return expPrepayTotal;
	}

	/**
	 * @param expPrepayTotal the expPrepayTotal to set
	 */
	public void setExpPrepayTotal(long expPrepayTotal) {
		this.expPrepayTotal = expPrepayTotal;
	}

	/**
	 * @return the validList
	 */
	public List<BalanceDisplayEntity> getValidList() {
		return validList;
	}

	/**
	 * @param validList the validList to set
	 */
	public void setValidList(List<BalanceDisplayEntity> validList) {
		this.validList = validList;
	}

	/**
	 * @return the effDateList
	 */
	public List<BalanceDisplayEntity> getEffDateList() {
		return effDateList;
	}

	/**
	 * @param effDateList the effDateList to set
	 */
	public void setEffDateList(List<BalanceDisplayEntity> effDateList) {
		this.effDateList = effDateList;
	}

	/**
	 * @return the expDateList
	 */
	public List<BalanceDisplayEntity> getExpDateList() {
		return expDateList;
	}

	/**
	 * @param expDateList the expDateList to set
	 */
	public void setExpDateList(List<BalanceDisplayEntity> expDateList) {
		this.expDateList = expDateList;
	}

	public List<EffBalanceEntity> getEffList() {
		return effList;
	}

	public void setEffList(List<EffBalanceEntity> effList) {
		this.effList = effList;
	}

	@Override
	public MBean encode() {
		MBean mBean = new MBean();
		mBean.setRoot(getPathByProperName("phoneNo"), phoneNo);
		mBean.setRoot(getPathByProperName("contractNo"), contractNo);
		mBean.setRoot(getPathByProperName("regionName"), regionName);
		mBean.setRoot(getPathByProperName("payName"), payName);
		mBean.setRoot(getPathByProperName("unBillFee"), unBillFee);
		mBean.setRoot(getPathByProperName("remainFee"), remainFee);
		mBean.setRoot(getPathByProperName("oweFee"), oweFee);
		mBean.setRoot(getPathByProperName("prepayFee"), prepayFee);
		
		mBean.setRoot(getPathByProperName("validList"), validList);
		mBean.setRoot(getPathByProperName("effDateList"), effDateList);
		mBean.setRoot(getPathByProperName("expDateList"), expDateList);
		mBean.setRoot(getPathByProperName("effList"), effList);
		
		return mBean;
	}
	
	
}

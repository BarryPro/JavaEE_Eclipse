package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退预存款  </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8008InitOutDTO extends CommonOutDTO{

	

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6473016216074532394L;
	@JSONField(name="OUT_PREPAY_FEE")
	@ParamDesc(path="OUT_PREPAY_FEE",cons=ConsType.CT001,type="long",len="18",desc="当前预存",memo="分")
	protected long outPrepayFee;
	@JSONField(name="RETURN_MONEY")
	@ParamDesc(path="RETURN_MONEY",cons=ConsType.CT001,type="long",len="18",desc="可退余额",memo="分")
	protected long returnMoney;
	@JSONField(name="UNBILL_TOTAL")
	@ParamDesc(path="UNBILL_TOTAL",cons=ConsType.CT001,type="long",len="18",desc="总欠费",memo="分")
	protected long unbillTotal;
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="long",len="18",desc="客户名称",memo="略")
	protected String conEncrypName;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="40",desc="服务号",memo="分")
	protected String phoneNo;
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="客户账号",memo="略")
	protected long contractNo;
	@JSONField(name="LIST_REASONINFO")
	@ParamDesc(path="LIST_REASONINFO",cons=ConsType.STAR,type="compx",len="1",desc="原因业务列表",memo="略")
	protected List<ComplainAdjReasonEntity> listReasonInfo;

	@JSONField(name="BEGIN_DATE")
	@ParamDesc(path="BEGIN_DATE",cons=ConsType.CT001,type="String",len="18",desc="资费生效日期",memo="略")
	protected String beginDate;
	
	@JSONField(name="END_DATE")
	@ParamDesc(path="END_DATE",cons=ConsType.CT001,type="String",len="18",desc="资费失效日期",memo="略")
	protected String endDate;
	
	@JSONField(name="DATE_SUB")
	@ParamDesc(path="DATE_SUB",cons=ConsType.CT001,type="long",len="18",desc="日期差",memo="略")
	protected long dateSub;
	
	@JSONField(name="ZI_FEI")
	@ParamDesc(path="ZI_FEI",cons=ConsType.CT001,type="long",len="18",desc="资费",memo="略")
	protected long ziFei;
	
	@JSONField(name="IF_GET_MONTH")
	@ParamDesc(path="IF_GET_MONTH",cons=ConsType.CT001,type="String",len="18",desc="是否获取整月",memo="略")
	protected String ifGetMonth;
 
	

	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("outPrepayFee"), outPrepayFee);
		result.setRoot(getPathByProperName("returnMoney"), returnMoney);
		result.setRoot(getPathByProperName("unbillTotal"), unbillTotal);
		result.setRoot(getPathByProperName("conEncrypName"), conEncrypName);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("listReasonInfo"), listReasonInfo);
		result.setRoot(getPathByProperName("beginDate"), beginDate);
		result.setRoot(getPathByProperName("endDate"), endDate);
		result.setRoot(getPathByProperName("ziFei"), ziFei);
		result.setRoot(getPathByProperName("dateSub"), dateSub);
		result.setRoot(getPathByProperName("ifGetMonth"), ifGetMonth);
		return result;
	}
	
	

	public String getBeginDate() {
		return beginDate;
	}



	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}



	public String getEndDate() {
		return endDate;
	}



	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}



	public long getDateSub() {
		return dateSub;
	}



	public void setDateSub(long dateSub) {
		this.dateSub = dateSub;
	}



	public long getZiFei() {
		return ziFei;
	}



	public void setZiFei(long ziFei) {
		this.ziFei = ziFei;
	}



	public String getIfGetMonth() {
		return ifGetMonth;
	}



	public void setIfGetMonth(String ifGetMonth) {
		this.ifGetMonth = ifGetMonth;
	}



	/**
	 * @return the listReasonInfo
	 */
	public List<ComplainAdjReasonEntity> getListReasonInfo() {
		return listReasonInfo;
	}

	/**
	 * @param listReasonInfo the listReasonInfo to set
	 */
	public void setListReasonInfo(List<ComplainAdjReasonEntity> listReasonInfo) {
		this.listReasonInfo = listReasonInfo;
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
	 * @return the contractNo
	 */
	public long getContractNo() {
			return contractNo;
	}
	
	/**
	 * @param returnMoney the contractNo to set
	 */
	public void setContractNo(long contractNo) {
			this.contractNo = contractNo;
	}


	/**
	 * @return the returnMoney
	 */
	public long getReturnMoney() {
		return returnMoney;
	}


	/**
	 * @param returnMoney the returnMoney to set
	 */
	public void setReturnMoney(long returnMoney) {
		this.returnMoney = returnMoney;
	}


	/**
	 * @return the unbillTotal
	 */
	public long getUnbillTotal() {
		return unbillTotal;
	}


	/**
	 * @param unbillTotal the unbillTotal to set
	 */
	public void setUnbillTotal(long unbillTotal) {
		this.unbillTotal = unbillTotal;
	}


	/**
	 * @return the conEncrypName
	 */
	public String getConEncrypName() {
		return conEncrypName;
	}


	/**
	 * @param conEncrypName the conEncrypName to set
	 */
	public void setConEncrypName(String conEncrypName) {
		this.conEncrypName = conEncrypName;
	}

 
	/**
	 * @return the outPrepayFee
	 */
	public long getOutPrepayFee() {
		return outPrepayFee;
	}


	/**
	 * @param outPrepayFee the outPrepayFee to set
	 */
	public void setOutPrepayFee(long outPrepayFee) {
		this.outPrepayFee = outPrepayFee;
	}

	 
	
}

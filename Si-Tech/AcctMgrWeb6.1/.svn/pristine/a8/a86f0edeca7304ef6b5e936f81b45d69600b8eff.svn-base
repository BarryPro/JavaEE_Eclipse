package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 产品资费升级实体
 *
 */
public class ProductOfferUpEntity {

    @JSONField(name = "UP_ID")
    @ParamDesc(path = "UP_ID", cons = ConsType.CT001, type = "String", len = "15", desc = "升级关系ID", memo = "比如短信端口号")
    private String upId;

    @JSONField(name = "PHONE_NO")
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "用户号码", memo = "")
    private String phoneNo;

    @JSONField(name = "OFFER_CANCEL")
    @ParamDesc(path = "OFFER_CANCEL", cons = ConsType.CT001, type = "String", len = "50", desc = "退订的套餐串", memo = "")
    private String offerCancel;

    @JSONField(name = "OFFER_ORDER")
    @ParamDesc(path = "OFFER_ORDER", cons = ConsType.CT001, type = "String", len = "50", desc = "订购的套餐串", memo = "")
    private String offerOrder;

    @JSONField(name = "OP_TIME")
    @ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "String", len = "", desc = "系统时间", memo = "")
    private String opTime;

    @JSONField(name = "TOTAL_DATE")
    @ParamDesc(path = "TOTAL_DATE", cons = ConsType.CT001, type = "int", len = "6", desc = "操作年月", memo = "")
    private int totalDate;
    
    @JSONField(name = "RETURN_FLAG")
    @ParamDesc(path = "RETURN_FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "返费标识", memo = "0代表不返费 1代表返费")
    private String returnFlag;
    
    @JSONField(name = "RETURN_FEE")
    @ParamDesc(path = "RETURN_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "返费金额", memo = "")
    private long returnFee;
    
    @JSONField(name = "DATE_LIMIT")
    @ParamDesc(path = "DATE_LIMIT", cons = ConsType.CT001, type = "String", len = "1", desc = "日期限制", memo = "0代表24小时内有效 1代表本日内有效 2代表本月有效")
    private String dateLimit;

    public String getUpId() {
		return upId;
	}

	public void setUpId(String upId) {
		this.upId = upId;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public String getOfferCancel() {
		return offerCancel;
	}

	public void setOfferCancel(String offerCancel) {
		this.offerCancel = offerCancel;
	}

	public String getOfferOrder() {
		return offerOrder;
	}

	public void setOfferOrder(String offerOrder) {
		this.offerOrder = offerOrder;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	public String getReturnFlag() {
		return returnFlag;
	}

	public void setReturnFlag(String returnFlag) {
		this.returnFlag = returnFlag;
	}

	public long getReturnFee() {
		return returnFee;
	}

	public void setReturnFee(long returnFee) {
		this.returnFee = returnFee;
	}

	public String getDateLimit() {
		return dateLimit;
	}

	public void setDateLimit(String dateLimit) {
		this.dateLimit = dateLimit;
	}

	@Override
    public String toString() {
        return "ProductOfferUpEntity{" +
                "upId='" + upId + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", offerCancel=" + offerCancel +
                ", offerOrder='" + offerOrder + '\'' +
                ", opTime='" + opTime + '\'' +
                ", totalDate='" + totalDate + '\'' +
                ", returnFlag='" + returnFlag + '\'' +
                ", returnFee='" + returnFee + '\'' +
                ", dateLimit='" + dateLimit + '\'' +
                '}';
    }

}

package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 功能：国际漫游产品信息实体
 */
public class InterRoamProdInfoEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO", cons=ConsType.CT001, type="string", len="11", desc="服务号码", memo="")
    private String phoneNo;
    
	@JSONField(name = "PROD_ID")
    @ParamDesc(path="PROD_ID", cons=ConsType.CT001, type="string", len="", desc="产品ID", memo="")
    private String prodId;
    
	@JSONField(name = "PRODINST_ID")
    @ParamDesc(path="PRODINST_ID", cons=ConsType.CT001, type="string", len="", desc="产品订购流水号", memo="")
    private String prodinstId;
    
	@JSONField(name = "OP_TIME")
    @ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "操作时间", memo = "略")
    private String opTime;
	
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getProdinstId() {
		return prodinstId;
	}

	public void setProdinstId(String prodinstId) {
		this.prodinstId = prodinstId;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	@Override
    public String toString() {
        return "InterRoamProdInfoEntity{" +
                "phoneNo=" + phoneNo +
                ", prodId=" + prodId +
                ", prodinstId=" + prodinstId +
                ", opTime=" + opTime +
                '}';
    }
}

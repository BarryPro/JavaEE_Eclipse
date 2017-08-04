package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * @Description: 帐户托收单信息
 * @author: wangyla
 * @version:
 * @createTime: 2015-3-16 下午7:59:43
 */

public class CollBillDetInfoEntity implements Serializable {
    private static final long serialVersionUID = 5419589385141372461L;

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "托收帐户号码", type = "long", memo = "略")
    private long contractNo;
    
    @JSONField(name = "QUERY_YM")
    @ParamDesc(path = "QUERY_YM", cons = ConsType.CT001, len = "6", desc = "查询年月", type = "int", memo = "略")
    private int queryYm;
    
    @JSONField(name = "FEE")
    @ParamDesc(path = "FEE", cons = ConsType.CT001, len = "14", desc = "托收金额", type = "long", memo = "略")
    private long fee;
    
    @JSONField(name = "PHONE_NO")
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", desc = "用户服务号码", type = "string", memo = "略")
    private String phoneNo;
    
	public long getContractNo() {
		return contractNo;
	}
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}
	public int getQueryYm() {
		return queryYm;
	}
	public void setQueryYm(int queryYm) {
		this.queryYm = queryYm;
	}
	public long getFee() {
		return fee;
	}
	public void setFee(long fee) {
		this.fee = fee;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
    
}

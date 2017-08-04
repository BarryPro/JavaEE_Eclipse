package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 补托收文件实体
 * 
 */
public class CollConDealRecdEntity {
	
    @JSONField(name = "LOGIN_SEQ")
    @ParamDesc(path = "LOGIN_SEQ", cons = ConsType.CT001, len = "5", desc = "工号序列", type = "int", memo = "略")
    private int loginSeq;

    @JSONField(name = "DETAIL_SEQ")
    @ParamDesc(path = "DETAIL_SEQ", cons = ConsType.CT001, len = "8", desc = "详细序列", type = "int", memo = "略")
    private int detailSeq;

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "用户账号", type = "long", memo = "略")
    private long contractNo;

    @JSONField(name = "OP_DATE")
    @ParamDesc(path = "OP_DATE", cons = ConsType.CT001, len = "8", desc = "操作时间", type = "int", memo = "略")
    private int opDate;
    
	@JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, len = "6", desc = "托收单生成帐务月", type = "int", memo = "略")
    private int yearMonth;
    
    @JSONField(name = "LOGIN_NO")
    @ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, len = "20", desc = "操作工号", type = "String", memo = "略")
    private String loginNo;
    
    @JSONField(name = "DEAL_FLAG")
    @ParamDesc(path = "DEAL_FLAG", cons = ConsType.CT001, len = "1", desc = "处理标识", type = "String", memo = "略")
    private String dealFlag;

	public int getLoginSeq() {
		return loginSeq;
	}

	public void setLoginSeq(int loginSeq) {
		this.loginSeq = loginSeq;
	}

	public int getDetailSeq() {
		return detailSeq;
	}

	public void setDetailSeq(int detailSeq) {
		this.detailSeq = detailSeq;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getOpDate() {
		return opDate;
	}

	public void setOpDate(int opDate) {
		this.opDate = opDate;
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}


}

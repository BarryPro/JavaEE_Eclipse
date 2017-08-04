package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class UserPrcEntity {

	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.QUES, type = "long", len = "3", desc = "用户ID", memo = "略")
    private Long idNo;

	@JSONField(name = "PROD_PRCID")
	@ParamDesc(path = "PROD_PRCID", cons = ConsType.QUES, type = "string", len = "3", desc = "资费", memo = "略")
    private String prodPrcid;
	
	@JSONField(name = "PROD_PRC_NAME")
	@ParamDesc(path = "PROD_PRC_NAME", cons = ConsType.QUES, type = "string", len = "3", desc = "资费名称", memo = "略")
    private String prodPrcName;

	@JSONField(name = "PRC_TYPE")
	@ParamDesc(path = "PRC_TYPE", cons = ConsType.QUES, type = "string", len = "3", desc = "资费类型", memo = "略")
	private String prcType;

	@JSONField(name = "PRC_CLASS")
	@ParamDesc(path = "PRC_CLASS", cons = ConsType.QUES, type = "string", len = "3", desc = "", memo = "略")
	private String prcClass;

	@JSONField(name = "EFF_DATE")
	@ParamDesc(path = "EFF_DATE", cons = ConsType.QUES, type = "string", len = "3", desc = "生效时间", memo = "略")
	private String effDate;

	@JSONField(name = "EXP_DATE")
	@ParamDesc(path = "EXP_DATE", cons = ConsType.QUES, type = "string", len = "3", desc = "失效时间", memo = "略")
	private String expDate;

	@JSONField(name = "STATE_DATE")
	@ParamDesc(path = "STATE_DATE", cons = ConsType.QUES, type = "string", len = "3", desc = "", memo = "略")
	private String stateDate;
	
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "string", len = "3", desc = "工号", memo = "略")
	private String loginNo;
	
	@JSONField(name = "EXP_FLAG")
	@ParamDesc(path = "EXP_FLAG", cons = ConsType.QUES, type = "string", len = "3", desc = "", memo = "略")
	private String expFlag;

	/* 半月标识 */
	@JSONField(name = "HALF_FLAG")
	@ParamDesc(path = "HALF_FLAG", cons = ConsType.QUES, type = "string", len = "3", desc = "", memo = "略")
	private String halfFlag;
	
	@JSONField(name = "GOODS_PRC_DESC")
	@ParamDesc(path = "GOODS_PRC_DESC", cons = ConsType.QUES, type = "string", len = "3", desc = "资费描述", memo = "略")
	private String prcDesc;

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.QUES, type = "string", len = "3", desc = "流水", memo = "略")
	private String loginAccept;

	@JSONField(name = "GOODS_MAIN_FLAG")
	@ParamDesc(path = "GOODS_MAIN_FLAG", cons = ConsType.QUES, type = "string", len = "3", desc = "主资费标志", memo = "0：主资费，1：附加资费")
	private String goodsMainFlag;

	public String getGoodsMainFlag() {
		return goodsMainFlag;
	}

	public void setGoodsMainFlag(String goodsMainFlag) {
		this.goodsMainFlag = goodsMainFlag;
	}

	public String getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}

	public Long getIdNo() {
		return idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public String getProdPrcid() {
		return prodPrcid;
	}

	public void setProdPrcid(String prodPrcid) {
		this.prodPrcid = prodPrcid;
	}

	public String getProdPrcName() {
		return prodPrcName;
	}

	public void setProdPrcName(String prodPrcName) {
		this.prodPrcName = prodPrcName;
	}

	public String getPrcType() {
		return prcType;
	}

	public void setPrcType(String prcType) {
		this.prcType = prcType;
	}

	public String getPrcClass() {
		return prcClass;
	}

	public void setPrcClass(String prcClass) {
		this.prcClass = prcClass;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getStateDate() {
		return stateDate;
	}

	public void setStateDate(String stateDate) {
		this.stateDate = stateDate;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getExpFlag() {
		return expFlag;
	}

	public void setExpFlag(String expFlag) {
		this.expFlag = expFlag;
	}

	public String getHalfFlag() {
		return halfFlag;
	}

	public void setHalfFlag(String halfFlag) {
		this.halfFlag = halfFlag;
	}
	

	public String getPrcDesc() {
		return prcDesc;
	}

	public void setPrcDesc(String prcDesc) {
		this.prcDesc = prcDesc;
	}

	@Override
	public String toString() {
		return "UserPrcEntity{" +
				"idNo=" + idNo +
				", prodPrcid='" + prodPrcid + '\'' +
				", prodPrcName='" + prodPrcName + '\'' +
				", prcType='" + prcType + '\'' +
				", prcClass='" + prcClass + '\'' +
				", effDate='" + effDate + '\'' +
				", expDate='" + expDate + '\'' +
				", stateDate='" + stateDate + '\'' +
				", loginNo='" + loginNo + '\'' +
				", expFlag='" + expFlag + '\'' +
				", halfFlag='" + halfFlag + '\'' +
				", prcDesc='" + prcDesc + '\'' +
				'}';
	}
}

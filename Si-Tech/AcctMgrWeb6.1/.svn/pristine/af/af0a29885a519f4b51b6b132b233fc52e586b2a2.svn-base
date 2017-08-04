package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 *
 * <p>Title: 第三方签约关系 对象</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class UserSignInfoEntity implements Serializable{

	@JSONField(name = "ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="Long",len="20",desc="用户id",memo="略")
	private Long idNo;
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@JSONField(name = "BUSI_TYPE")
	@ParamDesc(path="BUSI_TYPE",cons=ConsType.CT001,type="String",len="4",desc="业务类型",memo="1001:手机支付自动缴话费签约关系.  1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系")
	private String busiType;

	@JSONField(name = "SIGN_SN")
	@ParamDesc(path="SIGN_SN",cons=ConsType.CT001,type="String",len="60",desc="签约流水",memo="平台传入")
	private String signSn;
	
	@JSONField(name = "SIGN_TIME")
	@ParamDesc(path="SIGN_TIME",cons=ConsType.CT001,type="String",len="14",desc="签约时间",memo="平台传入")
	private String signTime;
	
	@JSONField(name = "SIGN_FLAG")
	@ParamDesc(path="SIGN_FLAG",cons=ConsType.CT001,type="String",len="60",desc="签约生效标志",memo="0 签约 1 解约")
	private String signFlag;
	
	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="14",desc="内部操作流水",memo="")
	private long loginAccept;
	
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="工号",memo="略")
	private String loginNo;
	
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="14",desc="操作时间",memo="略")
	private String opTime;
	
	@JSONField(name = "OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="4",desc="",memo="略")
	private String opCode;
	
	@JSONField(name = "REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="String",len="300",desc="",memo="略")
	private String remark;

	@JSONField(name = "FIELD_LIST")
	@ParamDesc(path="FIELD_LIST",cons=ConsType.QUES,type="compx",len="1",desc="签约属性",memo="略")
	private	List<FieldEntity> signFieldList;
	
	
	public UserSignInfoEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserSignInfoEntity(UserSignInfoEntity in){
		this.idNo = in.getIdNo();
		this.phoneNo= in.getPhoneNo();
		this.busiType = in.getBusiType();
		this.signSn = in.getSignSn();
		this.signTime = in.getSignTime();
		this.signFlag = in.getSignFlag();
		this.loginAccept = in.getLoginAccept();
		this.loginNo = in.getLoginNo();
		this.opTime = in.getOpTime();
		this.opCode = in.getOpCode();
		this.remark = in.getRemark();
		this.signFieldList = in.getSignFieldList();
	}
	
	public String toString() {
		return "UserSignInfoEntity [idNo=" + idNo + ", phoneNo=" + phoneNo + ", busiType=" + busiType + ", signSn=" + signSn
				+ ", signTime=" + signTime + ", signFlag=" + signFlag + ", loginAccept=" + loginAccept + ", loginNo=" + loginNo
				+ ", opTime=" + opTime + ", opCode=" + opCode + ", remark=" + remark + ", signFieldList=" + signFieldList + "]";
	}

	public Long getIdNo() {
		return idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBusiType() {
		return busiType;
	}

	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	public String getSignSn() {
		return signSn;
	}

	public void setSignSn(String signSn) {
		this.signSn = signSn;
	}

	public String getSignTime() {
		return signTime;
	}

	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}

	public String getSignFlag() {
		return signFlag;
	}

	public void setSignFlag(String signFlag) {
		this.signFlag = signFlag;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<FieldEntity> getSignFieldList() {
		return signFieldList;
	}

	public void setSignFieldList(List<FieldEntity> signFieldList) {
		this.signFieldList = signFieldList;
	}
}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
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
public class S8008CfmInDTO extends CommonInDTO{

  
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 3004862419373347241L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="退费金额",memo="略")
	protected long  payMoney;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	protected long  contractNo;
	@ParamDesc(path="BUSI_INFO.IF_ONNET",cons=ConsType.QUES,type="String",len="1",desc="在网标识",memo="1:在网；2:离网；3:CRM销户退预存款;4:宽带退预存")
	protected String inIfOnNet;
	@ParamDesc(path="BUSI_INFO.NOTE",cons=ConsType.QUES,type="String",len="1024",desc="备注",memo="备注")
	protected String note="";
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.QUES,type="String",len="5",desc="缴费渠道",memo="11营业")
	protected String payPath="";
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.QUES,type="String",len="5",desc="缴费方式",memo="0现金")
	protected String payMethod;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.QUES,type="String",len="40",desc="外部流水",memo="手机扣款传入")
	protected String foreignSn;
	@ParamDesc(path="BUSI_INFO.FOREIGN_TIME",cons=ConsType.QUES,type="String",len="20",desc="外部时间"
			,memo="手机扣款传入- YYYYMMDD HH24:MI:SS格式")
	protected String foreignTime;
	
	@ParamDesc(path="BUSI_INFO.AGENT_PHONE",cons=ConsType.QUES,type="String",len="40",desc="代理商号码",memo="联动空中充值退费传入")
	protected String agentPhone;

	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.QUES,type="String",len="5",desc="退费账本",memo="营销传入")
	protected String payType;
	
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="20",desc="退费类型",memo="略")
	protected String opType;
	
	@ParamDesc(path="BUSI_INFO.REASON",cons=ConsType.QUES,type="String",len="20",desc="转账原因",memo="略")
	private String reason;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPayMoney(Long.parseLong(arg0.getObject(getPathByProperName("payMoney")).toString()));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("contractNo")))){
			setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("inIfOnNet")))){
			setInIfOnNet(arg0.getStr(getPathByProperName("inIfOnNet")));
		}else {
			//联动空中充值在网
			inIfOnNet="1";
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("note")))){
			setNote(arg0.getStr(getPathByProperName("note")));
		}else {
			note="退预存款";
			String sPayMoney = String.format("%.2f", (double)payMoney/100);
			note ="["+ phoneNo+"]["+opType+"]退预存款["+sPayMoney+"]元";
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payPath")))){
			setPayPath(arg0.getStr(getPathByProperName("payPath")));
		}else {
			setPayPath("11");
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payMethod")))){
			setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		}else {
			//营业11
			setPayMethod("0");
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("foreignSn")))){
			setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("foreignTime")))){
			setForeignTime(arg0.getStr(getPathByProperName("foreignTime")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("agentPhone")))){
			setAgentPhone(arg0.getStr(getPathByProperName("agentPhone")));
		}
        if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payType")))){
            setPayType(arg0.getStr(getPathByProperName("payType")));
        }
        if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reason")))){
        setReason(arg0.getStr(getPathByProperName("reason")));
        }
	}
	
	

	/**
	 * @return the fieldValue
	 */
	public String getReason() {
		return reason;
	}



	/**
	 * @param fieldValue the fieldValue to set
	 */
	public void setReason(String reason) {
		this.reason = reason;
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
	 * @return the inIfOnNet
	 */
	public String getInIfOnNet() {
		return inIfOnNet;
	}


	/**
	 * @param inIfOnNet the inIfOnNet to set
	 */
	public void setInIfOnNet(String inIfOnNet) {
		this.inIfOnNet = inIfOnNet;
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
	 * @return the note
	 */
	public String getNote() {
		return note;
	}


	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}


	/**
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}


	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}


	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}


	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}


	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	/**
	 * @return the foreignTime
	 */
	public String getForeignTime() {
		return foreignTime;
	}


	/**
	 * @param foreignTime the foreignTime to set
	 */
	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
	}


	/**
	 * @return the agentPhone
	 */
	public String getAgentPhone() {
		return agentPhone;
	}


	/**
	 * @param agentPhone the agentPhone to set
	 */
	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }


	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}


	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}
    
    
}

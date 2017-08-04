package com.sitech.acctmgr.atom.domains.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title: 调账扩展实体  </p>
* <p>Description:  账单基本信息以外的调账信息  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class AdjExtendEntity {
	  
	@JSONField(name="ADJ_FLAG")
	@ParamDesc(path="ADJ_FLAG",cons=ConsType.QUES,type="String",len="4",desc="调账类型",memo="略")
	protected	String adjFlag;	
	
	@JSONField(name="OP_SN")
	@ParamDesc(path="OP_SN",cons=ConsType.QUES,type="long",len="14",desc="调账流水",memo="略")
	protected	long opSn;
	
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.QUES,type="String",len="4",desc="操作代码",memo="略")
	protected	String opCode;
	
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.QUES,type="String",len="20",desc="操作工号",memo="略")
	protected	String loginNo;
	
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	protected	String remark;
	
	@JSONField(name="OFF_FLAG")
	@ParamDesc(path="OFF_FLAG",cons=ConsType.QUES,type="String",len="1",desc="账单类型",memo="0：账单减免 1：账单减免恢复 2：账单挂账 3：账单挂账且减免 4：账单挂账恢复")
	protected	String offFlag;
	
	@JSONField(name="ADJ_REASON")
	@ParamDesc(path="ADJ_REASON",cons=ConsType.QUES,type="String",len="200",desc="退费原因",memo="略")
	protected	String adjReason;
	
	@JSONField(name="ADJ_TYPE")
	@ParamDesc(path="ADJ_TYPE",cons=ConsType.QUES,type="String",len="4",desc="退费类型",memo="略")
	protected	String adjType;
	
	@JSONField(name="ERR_SERIAL")
	@ParamDesc(path="ERR_SERIAL",cons=ConsType.QUES,type="String",len="25",desc="投诉电子单号",memo="略")	
	protected String errSerial;
	
	@JSONField(name="BACK_FEE")
	@ParamDesc(path="BACK_FEE",cons=ConsType.QUES,type="long",len="14",desc="退费金额",memo="略")	
	protected long backFee;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.QUES,type="String",len="18",desc="操作时间",memo="略")	
	protected String opTime;
	
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.QUES,type="String",len="18",desc="操作时间",memo="略")	
	protected String status;
	
	@JSONField(name="REFUND_BEGIN_DT")
	@ParamDesc(path="REFUND_BEGIN_DT",cons=ConsType.QUES,type="String",len="18",desc="退费开始时间",memo="略")	
	protected String beginTime;
	
	@JSONField(name="REFUND_END_DT")
	@ParamDesc(path="REFUND_END_DT",cons=ConsType.QUES,type="String",len="18",desc="退费结束时间",memo="略")	
	protected String endTime;
	
	@JSONField(name="OPER_CODE")
	@ParamDesc(path="OPER_CODE",cons=ConsType.QUES,type="String",len="20",desc="业务代码",memo="略")	
	protected String operCode;
	
	@JSONField(name="OPER_NAME")
	@ParamDesc(path="OPER_NAME",cons=ConsType.QUES,type="String",len="80",desc="业务名称",memo="略")	
	protected String operName;
	
	
	@JSONField(name="DEAL_TYPE")
	@ParamDesc(path="DEAL_TYPE",cons=ConsType.QUES,type="String",len="20",desc="送费类型",memo="略")	
	protected String dealType;
	
	@JSONField(name="BALANCE_TYPE")
	@ParamDesc(path="BALANCE_TYPE",cons=ConsType.QUES,type="String",len="40",desc="送费明细",memo="略")	
	protected String balanceType;

	@JSONField(name="USER_IDNO")
	@ParamDesc(path="USER_IDNO",cons=ConsType.QUES,type="long",len="40",desc="用户ID",memo="略")	
	protected long userIdNo;
	
	@JSONField(name="BILL_ID")
	@ParamDesc(path="BILL_ID",cons=ConsType.QUES,type="long",len="40",desc="账单ID",memo="略")	
	protected long billId;
	
	protected boolean spFlag;  //true:sp退费  false：非sp退费
	
    @Override
    public String toString() {
        return "AdjExtendEntity{" +
                "adjFlag='" + adjFlag + '\'' +
                ", opSn='" + opSn + '\'' +
                ", opCode='" + opCode + '\'' +
                ", loginNo='" + loginNo + '\'' +
                ", remark='" + remark + '\'' +
                ", offFlag='" + offFlag + '\'' +
                ", adjReason='" + adjReason + '\'' +
                ", adjType='" + adjType + '\'' +
                ", errSerial='" + errSerial + '\'' +
                ", backFee='" + backFee + '\'' +
                ", spFlag='" + spFlag + '\'' +
                ", status='" + status + '\'' +
                ", balanceType='" + balanceType + '\'' +
                ", dealType='" + dealType + '\'' +
                ", opTime='" + opTime + '\'' +
                '}';
    }
    
    

	/**
	 * @return the adjFlag
	 */
	public String getAdjFlag() {
		return adjFlag;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}


	
	/**
	 * @param adjFlag the adjFlag to set
	 */
	public void setAdjFlag(String adjFlag) {
		this.adjFlag = adjFlag;
	}



	/**
	 * @return the opSn
	 */
	public long getOpSn() {
		return opSn;
	}

	/**
	 * @param opSn the opSn to set
	 */
	public void setOpSn(long opSn) {
		this.opSn = opSn;
	}

	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}

	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the offFlag
	 */
	public String getOffFlag() {
		return offFlag;
	}

	/**
	 * @param offFlag the offFlag to set
	 */
	public void setOffFlag(String offFlag) {
		this.offFlag = offFlag;
	}



	/**
	 * @return the adjReason
	 */
	public String getAdjReason() {
		return adjReason;
	}



	/**
	 * @param adjReason the adjReason to set
	 */
	public void setAdjReason(String adjReason) {
		this.adjReason = adjReason;
	}



	/**
	 * @return the adjType
	 */
	public String getAdjType() {
		return adjType;
	}



	/**
	 * @param adjType the adjType to set
	 */
	public void setAdjType(String adjType) {
		this.adjType = adjType;
	}



	/**
	 * @return the errSerial
	 */
	public String getErrSerial() {
		return errSerial;
	}



	/**
	 * @param errSerial the errSerial to set
	 */
	public void setErrSerial(String errSerial) {
		this.errSerial = errSerial;
	}



	/**
	 * @return the backFee
	 */
	public long getBackFee() {
		return backFee;
	}



	/**
	 * @param backFee the backFee to set
	 */
	public void setBackFee(long backFee) {
		this.backFee = backFee;
	}



	/**
	 * @return the spFlag
	 */
	public boolean isSpFlag() {
		return spFlag;
	}



	/**
	 * @param spFlag the spFlag to set
	 */
	public void setSpFlag(boolean spFlag) {
		this.spFlag = spFlag;
	}



	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}



	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}



	/**
	 * @return the userIdNo
	 */
	public long getUserIdNo() {
		return userIdNo;
	}



	/**
	 * @param userIdNo the userIdNo to set
	 */
	public void setUserIdNo(long userIdNo) {
		this.userIdNo = userIdNo;
	}
	

	public String getBeginTime() {
		return beginTime;
	}



	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}



	public String getEndTime() {
		return endTime;
	}



	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	
	
	public String getOperCode() {
		return operCode;
	}



	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}



	public String getOperName() {
		return operName;
	}



	public void setOperName(String operName) {
		this.operName = operName;
	}

	

	public String getDealType() {
		return dealType;
	}



	public void setDealType(String dealType) {
		this.dealType = dealType;
	}



	public String getBalanceType() {
		return balanceType;
	}



	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}



	public long getBillId() {
		return billId;
	}



	public void setBillId(long billId) {
		this.billId = billId;
	}




}

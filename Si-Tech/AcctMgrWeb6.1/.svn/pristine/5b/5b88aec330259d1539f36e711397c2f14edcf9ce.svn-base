package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class InvoInfoEntity implements Serializable {

	/**
	 * 
	 */
	public InvoInfoEntity() {
		// TODO Auto-generated constructor stub
	}
	
	//单月账期
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.QUES,type="int",len="10",desc="账期月",memo="略")
	private int billCyle;
	
	@JSONField(name="BILLCYCLE_STR")
	@ParamDesc(path="BILLCYCLE_STR",cons=ConsType.QUES,type="String",len="20",desc="账期月",memo="略")
	private String billCycleStr;
	
	//发票类型名称
	@JSONField(name="INVTYPE_NAME")
	@ParamDesc(path="INVTYPE_NAME",cons=ConsType.QUES,type="String",len="100",desc="发票类型",memo="略")
	private String invTypeName;
	
	//发票代码
	@JSONField(name="INV_CODE")
	@ParamDesc(path="INV_CODE",cons=ConsType.CT001,type="String",len="20",desc="发票代码",memo="略")
	private String invCode;
	
	//发票号码
	@JSONField(name="INV_NO")
	@ParamDesc(path="INV_NO",cons=ConsType.CT001,type="String",len="20",desc="发票号码",memo="略")
	private String invNo;
	
	//打印工号
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="工号",memo="略")
	private String loginNo;
	
	//打印模块
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="10",desc="打印模块",memo="略")
	private String opCode;
	
	//打印时间
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="Strint",len="20",desc="打印时间",memo="略")
	private String printTime;
	
	//打印金额
	@JSONField(name="PRINT_FEE")
	@ParamDesc(path="PRINT_FEE",cons=ConsType.CT001,type="long",len="10",desc="打印金额",memo="略")
	private long printFee;
	
	//打印流水
	@JSONField(name="PRINT_SN")
	@ParamDesc(path="PRINT_SN",cons=ConsType.CT001,type="long",len="21",desc="打印流水",memo="略")
	private long printSn;
	
	@JSONField(name="ORDER_SN")
	@ParamDesc(path="ORDER_SN",cons=ConsType.QUES,type="long",len="20",desc="打印订单流水",memo="略")
	private long orderSn;
	
	//发票状态
	@JSONField(name="STATE_NAME")
	@ParamDesc(path="STATE_NAME",cons=ConsType.QUES,type="String",len="100",desc="发票状态",memo="略")
	private String invStatusName;
	
	//账户号
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.QUES,type="long",len="20",desc="账号",memo="略")
	private long contractNo;
	
	//服务号码
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo;
	
	//补打次数
	@JSONField(name="PRINT_SEQ")
	@ParamDesc(path="PRINT_SEQ",cons=ConsType.QUES,type="int",len="3",desc="打印次数",memo="略")
	private int printSeq;
	
	@JSONField(name="PRINT_XML")
	@ParamDesc(path="PRINT_XML",cons=ConsType.QUES,type="String",len="1",desc="打印xml报文",memo="略")
	private String xmlStr;
	
	@JSONField(name="PRINT_ARRAY")
	@ParamDesc(path="PRINT_ARRAY",cons=ConsType.QUES,type="int",len="2",desc="发票序号",memo="略")
	private int printArray;
	
	@JSONField(name="INV_TYPE")
	@ParamDesc(path="INV_TYPE",cons=ConsType.QUES,type="String",len="10",desc="发票类型",memo="略")
	private String invType;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.QUES,type="long",len="20",desc="缴费流水",memo="略")
	private long paySn;
	
	@JSONField(name="ONLINE_FLAG")
	@ParamDesc(path="ONLINE_FLAG",cons=ConsType.QUES,type="int",len="2",desc="割接前标志",memo="0：割接后数据，1：割接前数据")
	private int onlineFlag;
	@JSONField(name="PRINT_SN_STR")
	@ParamDesc(path="PRINT_SN_STR",cons=ConsType.QUES,type="String",len="21",desc="打印流水",memo="略")
	private String printSnStr;
	@JSONField(name="BEGIN_YMD")
	@ParamDesc(path="BEGIN_YMD",cons=ConsType.QUES,type="int",len="10",desc="发票开始日期",memo="略")
	private int beginYMD;
	@JSONField(name="END_YMD")
	@ParamDesc(path="END_YMD",cons=ConsType.QUES,type="int",len="10",desc="发票结束日期",memo="略")
	private int endYMD;
	
	@JSONField(name="STATE")
	@ParamDesc(path="STATE",cons=ConsType.QUES,type="String",len="2",desc="发票状态",memo="0：电子发票正在申请，1：正常，2：作废")
	private String state;
	
	
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
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
	 * @return the beginYMD
	 */
	public int getBeginYMD() {
		return beginYMD;
	}

	/**
	 * @param beginYMD the beginYMD to set
	 */
	public void setBeginYMD(int beginYMD) {
		this.beginYMD = beginYMD;
	}

	/**
	 * @return the endYMD
	 */
	public int getEndYMD() {
		return endYMD;
	}

	/**
	 * @param endYMD the endYMD to set
	 */
	public void setEndYMD(int endYMD) {
		this.endYMD = endYMD;
	}

	/**
	 * @return the printSnStr
	 */
	public String getPrintSnStr() {
		return printSnStr;
	}

	/**
	 * @param printSnStr the printSnStr to set
	 */
	public void setPrintSnStr(String printSnStr) {
		this.printSnStr = printSnStr;
	}

	/**
	 * @return the onlineFlag
	 */
	public int getOnlineFlag() {
		return onlineFlag;
	}

	/**
	 * @param onlineFlag the onlineFlag to set
	 */
	public void setOnlineFlag(int onlineFlag) {
		this.onlineFlag = onlineFlag;
	}

	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}

	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	/**
	 * @return the invType
	 */
	public String getInvType() {
		return invType;
	}

	/**
	 * @param invType the invType to set
	 */
	public void setInvType(String invType) {
		this.invType = invType;
	}

	/**
	 * @return the printArray
	 */
	public int getPrintArray() {
		return printArray;
	}

	/**
	 * @param printArray the printArray to set
	 */
	public void setPrintArray(int printArray) {
		this.printArray = printArray;
	}

	/**
	 * @return the xmlStr
	 */
	public String getXmlStr() {
		return xmlStr;
	}

	/**
	 * @param xmlStr the xmlStr to set
	 */
	public void setXmlStr(String xmlStr) {
		this.xmlStr = xmlStr;
	}

	/**
	 * @return the printSeq
	 */
	public int getPrintSeq() {
		return printSeq;
	}

	/**
	 * @param printSeq the printSeq to set
	 */
	public void setPrintSeq(int printSeq) {
		this.printSeq = printSeq;
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
	 * @return the billCycleStr
	 */
	public String getBillCycleStr() {
		return billCycleStr;
	}

	/**
	 * @param billCycleStr the billCycleStr to set
	 */
	public void setBillCycleStr(String billCycleStr) {
		this.billCycleStr = billCycleStr;
	}

	/**
	 * @return the orderSn
	 */
	public long getOrderSn() {
		return orderSn;
	}

	/**
	 * @param orderSn the orderSn to set
	 */
	public void setOrderSn(long orderSn) {
		this.orderSn = orderSn;
	}
	

	/**
	 * @return the billCyle
	 */
	public int getBillCyle() {
		return billCyle;
	}

	/**
	 * @param billCyle the billCyle to set
	 */
	public void setBillCyle(int billCyle) {
		this.billCyle = billCyle;
	}

	public String getInvTypeName() {
		return invTypeName;
	}

	public void setInvTypeName(String invTypeName) {
		this.invTypeName = invTypeName;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getPrintTime() {
		return printTime;
	}

	public void setPrintTime(String printTime) {
		this.printTime = printTime;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public String getInvStatusName() {
		return invStatusName;
	}

	public void setInvStatusName(String invStatusName) {
		this.invStatusName = invStatusName;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "InvoInfoEntity [billCyle=" + billCyle + ", billCycleStr="
				+ billCycleStr + ", invTypeName=" + invTypeName + ", invCode="
				+ invCode + ", invNo=" + invNo + ", loginNo=" + loginNo
				+ ", opCode=" + opCode + ", printTime=" + printTime
				+ ", printFee=" + printFee + ", printSn=" + printSn
				+ ", orderSn=" + orderSn + ", invStatusName=" + invStatusName
				+ ", contractNo=" + contractNo + ", printSeq=" + printSeq
				+ ", xmlStr=" + xmlStr + ", printArray=" + printArray
				+ ", invType=" + invType + ", paySn=" + paySn + ", onlineFlag="
				+ onlineFlag + ", printSnStr=" + printSnStr + "]";
	}

	
	
}

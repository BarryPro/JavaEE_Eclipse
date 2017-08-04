package com.sitech.acctmgr.atom.domains.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class ComplainAdjQryBatchEntity {

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected	String phoneNo;
	
	@JSONField(name="ERR_SERIAL")
	@ParamDesc(path="ERR_SERIAL",cons=ConsType.QUES,type="String",len="20",desc="工单流水",memo="略")
	protected	String errSerial;

	@JSONField(name="ADJ_REASON_THREE")
	@ParamDesc(path="ADJ_REASON_THREE",cons=ConsType.QUES,type="String",len="100",desc="退费三级原因",memo="略")
	protected	String adjReasonThree;
		
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.QUES,type="String",len="100",desc="地市名称",memo="略")
	protected	String regionName;

	@JSONField(name="ADJ_TYPE_NAME")
	@ParamDesc(path="ADJ_TYPE_NAME",cons=ConsType.QUES,type="String",len="20",desc="退费类型名称",memo="双倍 单倍")
	protected	String adjTypeName;
		
	@JSONField(name="COM_FEE")
	@ParamDesc(path="COM_FEE",cons=ConsType.QUES,type="long",len="14",desc="补偿金额",memo="略")	
	protected long comFee;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.QUES,type="String",len="20",desc="操作时间",memo="略")	
	protected String opTime;
	
	@JSONField(name="OPR_LOGIN_NO")
	@ParamDesc(path="OPR_LOGIN_NO",cons=ConsType.QUES,type="String",len="20",desc="操作工号",memo="略")	
	protected String oprLoginNo;

	@JSONField(name="SP_CODE")
	@ParamDesc(path="SP_CODE",cons=ConsType.QUES,type="String",len="20",desc="spCode",memo="略")	
	protected String spCode;
	
	@JSONField(name="SP_NAME")
	@ParamDesc(path="SP_NAME",cons=ConsType.QUES,type="String",len="40",desc="sp名称",memo="略")	
	protected String spName;
	
	@JSONField(name="OPER_CODE")
	@ParamDesc(path="OPER_CODE",cons=ConsType.QUES,type="String",len="20",desc="sp业务代码",memo="略")	
	protected String operCode;
	
	@JSONField(name="OPER_NAME")
	@ParamDesc(path="OPER_NAME",cons=ConsType.QUES,type="String",len="40",desc="sp业务名称",memo="略")	
	protected String operName;
	
	@JSONField(name="USER_TIME")
	@ParamDesc(path="USER_TIME",cons=ConsType.QUES,type="String",len="20",desc="业务使用时间",memo="略")	
	protected String userTime;
	
	@JSONField(name="BILL_TYPE")
	@ParamDesc(path="BILL_TYPE",cons=ConsType.QUES,type="String",len="10",desc="计费类型",memo="略")	
	protected String billType;
	
	@JSONField(name="PRICE")
	@ParamDesc(path="PRICE",cons=ConsType.QUES,type="String",len="20",desc="单价",memo="略")	
	protected String price;
	
	@JSONField(name="COUNT")
	@ParamDesc(path="COUNT",cons=ConsType.QUES,type="String",len="20",desc="数量",memo="略")	
	protected String count;
	
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
	 * @return the errSerial
	 */
	public String getErrSerial() {
		return errSerial;
	}

	
	
	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @param errSerial the errSerial to set
	 */
	public void setErrSerial(String errSerial) {
		this.errSerial = errSerial;
	}

	/**
	 * @return the adjReasonThree
	 */
	public String getAdjReasonThree() {
		return adjReasonThree;
	}

	/**
	 * @param adjReasonThree the adjReasonThree to set
	 */
	public void setAdjReasonThree(String adjReasonThree) {
		this.adjReasonThree = adjReasonThree;
	}

	/**
	 * @return the adjTypeName
	 */
	public String getAdjTypeName() {
		return adjTypeName;
	}

	/**
	 * @param adjTypeName the adjTypeName to set
	 */
	public void setAdjTypeName(String adjTypeName) {
		this.adjTypeName = adjTypeName;
	}

	/**
	 * @return the comFee
	 */
	public long getComFee() {
		return comFee;
	}

	/**
	 * @param comFee the comFee to set
	 */
	public void setComFee(long comFee) {
		this.comFee = comFee;
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
	 * @return the oprLoginNo
	 */
	public String getOprLoginNo() {
		return oprLoginNo;
	}

	/**
	 * @param oprLoginNo the oprLoginNo to set
	 */
	public void setOprLoginNo(String oprLoginNo) {
		this.oprLoginNo = oprLoginNo;
	}

	/**
	 * @return the spCode
	 */
	public String getSpCode() {
		return spCode;
	}

	/**
	 * @param spCode the spCode to set
	 */
	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

	/**
	 * @return the spName
	 */
	public String getSpName() {
		return spName;
	}

	/**
	 * @param spName the spName to set
	 */
	public void setSpName(String spName) {
		this.spName = spName;
	}

	/**
	 * @return the operCode
	 */
	public String getOperCode() {
		return operCode;
	}

	/**
	 * @param operCode the operCode to set
	 */
	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}

	/**
	 * @return the operName
	 */
	public String getOperName() {
		return operName;
	}

	/**
	 * @param operName the operName to set
	 */
	public void setOperName(String operName) {
		this.operName = operName;
	}

	/**
	 * @return the userTime
	 */
	public String getUserTime() {
		return userTime;
	}

	/**
	 * @param userTime the userTime to set
	 */
	public void setUserTime(String userTime) {
		this.userTime = userTime;
	}

	/**
	 * @return the billType
	 */
	public String getBillType() {
		return billType;
	}

	/**
	 * @param billType the billType to set
	 */
	public void setBillType(String billType) {
		this.billType = billType;
	}

	/**
	 * @return the price
	 */
	public String getPrice() {
		return price;
	}

	/**
	 * @param price the price to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the count
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(String count) {
		this.count = count;
	}


	
}

package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BadBillEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 陈死账查询出参DTO
 * </p>
 * <p>
 * Description: 陈死账查询出参DTO，封装出参情况
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author xiongjy
 * @version 1.0
 */
public class S8109OutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="TYPE_NAME",cons=ConsType.CT001,type="String",len="40",desc="客户性质",memo="略")
	protected String custTypeName;
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="18",desc="欠费",memo="略")
	protected long oweFee;
	@ParamDesc(path="OWE_MONTH",cons=ConsType.CT001,type="int",len="6",desc="欠费月数",memo="略")
	protected int oweMonth;
	@ParamDesc(path="PAYED_FEE",cons=ConsType.CT001,type="long",len="18",desc="已缴费",memo="略")
	protected long payedFee;
	@ParamDesc(path="BILL_LIST",cons=ConsType.QUES,type="compx",len="1",desc="账单列表",memo="略")
	private List<BillDetailEntity> outList = null;
	
	/*基本信息*/
	@ParamDesc(path="GROUP_NAME",cons=ConsType.CT001,type="String",len="100",desc="归属地",memo="略")
	protected String groupName;
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户姓名",memo="略")
	protected String custName;
	@ParamDesc(path="CUST_LEVEL",cons=ConsType.CT001,type="String",len="40",desc="客户级别",memo="略")
	protected String custLevel;
	@ParamDesc(path="TYPE_CODE",cons=ConsType.CT001,type="String",len="40",desc="客户类型",memo="略")
	protected String typeCode;
	@ParamDesc(path="CUST_ADDRESS",cons=ConsType.CT001,type="String",len="200",desc="客户地址",memo="略")
	protected String custAddress;
	@ParamDesc(path="ID_TYPE",cons=ConsType.CT001,type="String",len="40",desc="证件类型",memo="略")
	protected String idType;
	@ParamDesc(path="ID_ICCID",cons=ConsType.CT001,type="String",len="40",desc="证件号码",memo="略")
	protected String idIccid;
	@ParamDesc(path="ID_ADDRESS",cons=ConsType.CT001,type="String",len="100",desc="证件地址",memo="略")
	protected String idAddress;
	@ParamDesc(path="ID_VALIDDATE",cons=ConsType.CT001,type="String",len="20",desc="证件有效期",memo="略")
	protected String idValidDate;
	@ParamDesc(path="CONTACT_NAME",cons=ConsType.CT001,type="String",len="20",desc="联系人",memo="略")
	protected String contactName;
	@ParamDesc(path="CONTACT_PHONE",cons=ConsType.CT001,type="String",len="20",desc="联系人电话",memo="略")
	protected String contactPhone;
	@ParamDesc(path="CONTACT_ADDRESS",cons=ConsType.CT001,type="String",len="100",desc="联系人地址",memo="略")
	protected String contactAddress;
	@ParamDesc(path="SEX_CODE",cons=ConsType.CT001,type="String",len="10",desc="性别",memo="略")
	protected String sexCode;
	@ParamDesc(path="PROFESSION_ID",cons=ConsType.CT001,type="String",len="20",desc="职业类型",memo="略")
	protected String professionId;
	@ParamDesc(path="CUST_LOVE",cons=ConsType.CT001,type="String",len="20",desc="爱好",memo="略")
	protected String custLove;
	@ParamDesc(path="CUST_HABIT",cons=ConsType.CT001,type="String",len="100",desc="客户习惯",memo="略")
	protected String custHabit;
	@ParamDesc(path="WORK_CODE",cons=ConsType.CT001,type="String",len="100",desc="学历",memo="略")
	protected String workCode;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("custTypeName"), custTypeName);
		result.setRoot(getPathByProperName("oweFee"), oweFee);
		result.setRoot(getPathByProperName("oweMonth"), oweMonth);
		result.setRoot(getPathByProperName("payedFee"), payedFee);
		result.setRoot(getPathByProperName("outList"), outList);
		
		
		result.setRoot(getPathByProperName("groupName"), groupName);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("custLevel"), custLevel);
		result.setRoot(getPathByProperName("typeCode"), typeCode);
		result.setRoot(getPathByProperName("custAddress"), custAddress);
		result.setRoot(getPathByProperName("idType"), idType);
		result.setRoot(getPathByProperName("idIccid"), idIccid);
		result.setRoot(getPathByProperName("idAddress"), idAddress);
		result.setRoot(getPathByProperName("idValidDate"), idValidDate);
		result.setRoot(getPathByProperName("contactName"), contactName);
		result.setRoot(getPathByProperName("contactPhone"), contactPhone);
		result.setRoot(getPathByProperName("contactAddress"), contactAddress);
		result.setRoot(getPathByProperName("sexCode"), sexCode);
		result.setRoot(getPathByProperName("professionId"), professionId);
		result.setRoot(getPathByProperName("custLove"), custLove);
		result.setRoot(getPathByProperName("custHabit"), custHabit);
		result.setRoot(getPathByProperName("workCode"), workCode);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the outList
	 */

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the custTypeName
	 */
	public String getCustTypeName() {
		return custTypeName;
	}

	/**
	 * @param custTypeName
	 *            the custTypeName to set
	 */
	public void setCustTypeName(String custTypeName) {
		this.custTypeName = custTypeName;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee
	 *            the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the oweMonth
	 */
	public int getOweMonth() {
		return oweMonth;
	}

	/**
	 * @param oweMonth
	 *            the oweMonth to set
	 */
	public void setOweMonth(int oweMonth) {
		this.oweMonth = oweMonth;
	}

	/**
	 * @return the payedFee
	 */
	public long getPayedFee() {
		return payedFee;
	}

	/**
	 * @param payedFee
	 *            the payedFee to set
	 */
	public void setPayedFee(long payedFee) {
		this.payedFee = payedFee;
	}

	/**
	 * @return the outList
	 */
	public List<BillDetailEntity> getOutList() {
		return outList;
	}

	/**
	 * @param outList the outList to set
	 */
	public void setOutList(List<BillDetailEntity> outList) {
		this.outList = outList;
	}

	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}

	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}

	/**
	 * @return the custLevel
	 */
	public String getCustLevel() {
		return custLevel;
	}

	/**
	 * @param custLevel the custLevel to set
	 */
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}

	/**
	 * @return the typeCode
	 */
	public String getTypeCode() {
		return typeCode;
	}

	/**
	 * @param typeCode the typeCode to set
	 */
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	/**
	 * @return the custAddress
	 */
	public String getCustAddress() {
		return custAddress;
	}

	/**
	 * @param custAddress the custAddress to set
	 */
	public void setCustAddress(String custAddress) {
		this.custAddress = custAddress;
	}

	/**
	 * @return the idType
	 */
	public String getIdType() {
		return idType;
	}

	/**
	 * @param idType the idType to set
	 */
	public void setIdType(String idType) {
		this.idType = idType;
	}

	/**
	 * @return the idIccid
	 */
	public String getIdIccid() {
		return idIccid;
	}

	/**
	 * @param idIccid the idIccid to set
	 */
	public void setIdIccid(String idIccid) {
		this.idIccid = idIccid;
	}

	/**
	 * @return the idAddress
	 */
	public String getIdAddress() {
		return idAddress;
	}

	/**
	 * @param idAddress the idAddress to set
	 */
	public void setIdAddress(String idAddress) {
		this.idAddress = idAddress;
	}

	/**
	 * @return the idValidDate
	 */
	public String getIdValidDate() {
		return idValidDate;
	}

	/**
	 * @param idValidDate the idValidDate to set
	 */
	public void setIdValidDate(String idValidDate) {
		this.idValidDate = idValidDate;
	}

	/**
	 * @return the contactName
	 */
	public String getContactName() {
		return contactName;
	}

	/**
	 * @param contactName the contactName to set
	 */
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	/**
	 * @return the contactPhone
	 */
	public String getContactPhone() {
		return contactPhone;
	}

	/**
	 * @param contactPhone the contactPhone to set
	 */
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * @return the contactAddress
	 */
	public String getContactAddress() {
		return contactAddress;
	}

	/**
	 * @param contactAddress the contactAddress to set
	 */
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	/**
	 * @return the sexCode
	 */
	public String getSexCode() {
		return sexCode;
	}

	/**
	 * @param sexCode the sexCode to set
	 */
	public void setSexCode(String sexCode) {
		this.sexCode = sexCode;
	}

	/**
	 * @return the professionId
	 */
	public String getProfessionId() {
		return professionId;
	}

	/**
	 * @param professionId the professionId to set
	 */
	public void setProfessionId(String professionId) {
		this.professionId = professionId;
	}

	/**
	 * @return the custLove
	 */
	public String getCustLove() {
		return custLove;
	}

	/**
	 * @param custLove the custLove to set
	 */
	public void setCustLove(String custLove) {
		this.custLove = custLove;
	}

	/**
	 * @return the custHabit
	 */
	public String getCustHabit() {
		return custHabit;
	}

	/**
	 * @param custHabit the custHabit to set
	 */
	public void setCustHabit(String custHabit) {
		this.custHabit = custHabit;
	}

	/**
	 * @return the workCode
	 */
	public String getWorkCode() {
		return workCode;
	}

	/**
	 * @param workCode the workCode to set
	 */
	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}

}

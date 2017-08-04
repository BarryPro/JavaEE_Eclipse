package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title:取用户欠费信息出参  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076InitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9107306597787501460L;
	
	
	@JSONField(name = "REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.STAR,type="String",len="40",desc="地市名称",memo="略")
    private String regionName;
	@JSONField(name = "DISTRICT_NAME")
	@ParamDesc(path="DISTRICT_NAME",cons=ConsType.STAR,type="String",len="100",desc="地区",memo="略")
    private String districtName;
	@JSONField(name = "ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.STAR,type="long",len="40",desc="用户ID",memo="略")
    private long idNo;
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.STAR,type="String",len="40",desc="服务号码",memo="略")
    private String phoneNo;
	@JSONField(name = "USE_TIME")
	@ParamDesc(path="USE_TIME",cons=ConsType.STAR,type="String",len="40",desc="开户时间",memo="略")
    private String useTime;
	@JSONField(name = "OWNER_NAME")
	@ParamDesc(path="OWNER_NAME",cons=ConsType.STAR,type="String",len="40",desc="用户名称",memo="略")
    private String ownerName;
	@JSONField(name = "OWNER_UNIT")
	@ParamDesc(path="OWNER_UNIT",cons=ConsType.STAR,type="String",len="100",desc="用户单位",memo="略")
    private String ownerUnit;
	@JSONField(name = "OWNER_IDNO")
	@ParamDesc(path="OWNER_IDNO",cons=ConsType.STAR,type="String",len="40",desc="用户ID",memo="略")
    private String ownerIdNo;
	@JSONField(name = "OWNER_PHONE")
	@ParamDesc(path="OWNER_PHONE",cons=ConsType.STAR,type="String",len="40",desc="用户号码",memo="略")
    private String ownerPhone;
	@JSONField(name = "OWNER_ADDRESS")
	@ParamDesc(path="OWNER_ADDRESS",cons=ConsType.STAR,type="String",len="200",desc="用户地址",memo="略")
    private String ownerAddress;
	@JSONField(name = "OWNER_ZIP")
	@ParamDesc(path="OWNER_ZIP",cons=ConsType.STAR,type="String",len="40",desc="邮编",memo="略")
    private String ownerZip;
	@JSONField(name = "CONTACT_PERSON")
	@ParamDesc(path="CONTACT_PERSON",cons=ConsType.STAR,type="String",len="40",desc="联系人",memo="略")
    private String contactPerson;
	@JSONField(name = "CONTACT_PHONE")
	@ParamDesc(path="CONTACT_PHONE",cons=ConsType.STAR,type="String",len="40",desc="联系人号码",memo="略")
    private String contactPhone;
	@JSONField(name = "CONTACT_IDNO")
	@ParamDesc(path="CONTACT_IDNO",cons=ConsType.STAR,type="String",len="40",desc="联系人证件号",memo="略")
    private String contactIdNo;
	@JSONField(name = "DELETE_TIME")
	@ParamDesc(path="DELETE_TIME",cons=ConsType.STAR,type="String",len="20",desc="拆机时间",memo="略")
	private String deleteTime;
	@JSONField(name = "UPDATE_TIME")
	@ParamDesc(path="UPDATE_TIME",cons=ConsType.STAR,type="String",len="20",desc="更新时间",memo="略")
    private String updateTime;
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.STAR,type="String",len="20",desc="工号",memo="略")
    private String loginNo;
	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.STAR,type="String",len="40",desc="操作流水",memo="略")
    private String loginAccept;
	@JSONField(name = "BAK_CHAR")
	@ParamDesc(path="BAK_CHAR",cons=ConsType.STAR,type="String",len="40",desc="备注",memo="略")
    private String bakChar;
	
	@JSONField(name = "OWE_SUM")
	@ParamDesc(path="OWE_SUM",cons=ConsType.STAR,type="long",len="40",desc="欠费总金额",memo="略")
    private long oweSum;
	
	@JSONField(name = "DELAY_SUM")
	@ParamDesc(path="DELAY_SUM",cons=ConsType.STAR,type="long",len="40",desc="滞纳金总金额",memo="略")
    private long delaySum;
	
	@JSONField(name="LEN_OWEINFO")
	@ParamDesc(path="LEN_OWEINFO",cons=ConsType.CT001,type="int",len="10",desc="欠费信息长度",memo="略")
	protected int lenOweInfo;
	
	@JSONField(name="LIST_OWEINFO")
	@ParamDesc(path="LIST_OWEINFO",cons=ConsType.STAR,type="compx",len="1",desc="欠费信息列表",memo="略")
	protected List<UserOweEntity> listOweInfo;
	
	
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("regionName"), regionName);
		result.setRoot(getPathByProperName("bakChar"), bakChar);
		result.setRoot(getPathByProperName("updateTime"), updateTime);
		result.setRoot(getPathByProperName("deleteTime"), deleteTime);
		result.setRoot(getPathByProperName("contactIdNo"), contactIdNo);
		result.setRoot(getPathByProperName("contactPhone"), contactPhone);
		result.setRoot(getPathByProperName("contactPerson"), contactPerson);
		result.setRoot(getPathByProperName("ownerZip"), ownerZip);
		result.setRoot(getPathByProperName("ownerAddress"), ownerAddress);
		result.setRoot(getPathByProperName("ownerPhone"), ownerPhone);
		result.setRoot(getPathByProperName("ownerIdNo"), ownerIdNo);
		result.setRoot(getPathByProperName("ownerUnit"), ownerUnit);
		result.setRoot(getPathByProperName("ownerName"), ownerName);
		result.setRoot(getPathByProperName("useTime"), useTime);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("idNo"), idNo);
		result.setRoot(getPathByProperName("oweSum"), oweSum);
		result.setRoot(getPathByProperName("delaySum"), delaySum);
		result.setRoot(getPathByProperName("districtName"), districtName);
		result.setRoot(getPathByProperName("lenOweInfo"), lenOweInfo);
		result.setRoot(getPathByProperName("listOweInfo"), listOweInfo);
	

		return result;
	}


	public String getRegionName() {
		return regionName;
	}


	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}


	public String getDistrictName() {
		return districtName;
	}


	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}


	public long getIdNo() {
		return idNo;
	}


	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getUseTime() {
		return useTime;
	}


	public void setUseTime(String useTime) {
		this.useTime = useTime;
	}


	public String getOwnerName() {
		return ownerName;
	}


	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}


	public String getOwnerUnit() {
		return ownerUnit;
	}


	public void setOwnerUnit(String ownerUnit) {
		this.ownerUnit = ownerUnit;
	}


	public String getOwnerIdNo() {
		return ownerIdNo;
	}


	public void setOwnerIdNo(String ownerIdNo) {
		this.ownerIdNo = ownerIdNo;
	}


	public String getOwnerPhone() {
		return ownerPhone;
	}


	public void setOwnerPhone(String ownerPhone) {
		this.ownerPhone = ownerPhone;
	}


	public String getOwnerAddress() {
		return ownerAddress;
	}


	public void setOwnerAddress(String ownerAddress) {
		this.ownerAddress = ownerAddress;
	}


	public String getOwnerZip() {
		return ownerZip;
	}


	public void setOwnerZip(String ownerZip) {
		this.ownerZip = ownerZip;
	}


	public String getContactPerson() {
		return contactPerson;
	}


	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}


	public String getContactPhone() {
		return contactPhone;
	}


	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}


	public String getContactIdNo() {
		return contactIdNo;
	}


	public void setContactIdNo(String contactIdNo) {
		this.contactIdNo = contactIdNo;
	}


	public String getDeleteTime() {
		return deleteTime;
	}


	public void setDeleteTime(String deleteTime) {
		this.deleteTime = deleteTime;
	}



	public String getUpdateTime() {
		return updateTime;
	}


	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}


	public String getLoginNo() {
		return loginNo;
	}


	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}


	public String getLoginAccept() {
		return loginAccept;
	}


	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}


	public String getBakChar() {
		return bakChar;
	}


	public void setBakChar(String bakChar) {
		this.bakChar = bakChar;
	}


	public int getLenOweInfo() {
		return lenOweInfo;
	}


	public void setLenOweInfo(int lenOweInfo) {
		this.lenOweInfo = lenOweInfo;
	}


	public List<UserOweEntity> getListOweInfo() {
		return listOweInfo;
	}


	public void setListOweInfo(List<UserOweEntity> listOweInfo) {
		this.listOweInfo = listOweInfo;
	}


	public long getOweSum() {
		return oweSum;
	}


	public void setOweSum(long oweSum) {
		this.oweSum = oweSum;
	}


	public long getDelaySum() {
		return delaySum;
	}


	public void setDelaySum(long delaySum) {
		this.delaySum = delaySum;
	}




}

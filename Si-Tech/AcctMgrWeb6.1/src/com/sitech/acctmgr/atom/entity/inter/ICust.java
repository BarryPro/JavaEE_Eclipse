package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.cust.CtCustContactEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.PersonalCustEntity;
import com.sitech.acctmgr.atom.domains.cust.TaxPayerInfo;

import java.util.List;

/**
 * 
 * <p>
 * Title: 客户类
 * </p>
 * <p>
 * Description: 查询客户基本信息
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhangbine
 * @version 1.0
 * 
 */
public interface ICust {

	/**
	 * 
	 * 名称：查询客户基本信息
	 * 
	 * @param CUST_ID
	 *            客户标识(可选)
	 * @param ID_ICCID
	 *            证件号码(可选)
	 * @return Map： </br> CUST_ID </br> CUST_NAME </br> ID_ADDRESS </br> ID_ICCID </br> CUST_CD </br> CUST_LAST_NAME </br> CUST_ADDRESS </br> GROUP_ID </br> CUST_LEVEL </br> CUST_LEVEL_NAME </br> ID_TYPE </br> ID_TYPE_NAME </br> TYPE_CODE </br> CUST_TYPE_NAME </br> BLUR_CUSTNAME </br>
	 * @author zhangbine
	 */
	CustInfoEntity getCustInfo(Long custId, String idIccid);

	/**
	 * 
	 * 名称：查询集团客户基本信息
	 * 
	 * @param inCustId
	 *            集团客户标识
	 * @return Map： </br> CUST_ID </br> GROUP_TYPE </br> UNIT_ID </br>
	 * @author zhangbine
	 */
	GrpCustInfoEntity getGrpCustInfo(Long custId, Long unitId);

	List<GrpCustEntity> getGrpCustList(Long custId, Long unitId, String idIccid);

	/**
	 * 功能：获取集团客户的客户经理
	 * 
	 * @param custId
	 * @return
	 */
	String getGrpContactStaff(Long custId);

	/**
	 * 功能：查询增值税纳税人的信息
	 * 
	 * @param custId
	 * @param taxPayerId
	 * @return
	 */
	TaxPayerInfo getTaxPayerInfo(long custId, String taxPayerId);
	
	/**
	 * 功能：查下客户相关联系信息
	 * 
	 * @param custId
	 * @return
	 */
	CtCustContactEntity getContactEnt(long custId);
	
	/**
	 * 客户附加信息
	 */
	PersonalCustEntity getPersonalCust(long custId);
}

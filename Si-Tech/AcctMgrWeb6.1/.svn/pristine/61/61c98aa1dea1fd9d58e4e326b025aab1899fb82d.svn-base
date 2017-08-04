package com.sitech.acctmgr.atom.entity;

import static org.apache.commons.collections.MapUtils.getLongValue;
import static org.apache.commons.collections.MapUtils.getString;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.alibaba.fastjson.JSON;
import com.opensymphony.oscache.util.StringUtil;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.ImeiFileMsgInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.user.ExpireOprEntity;
import com.sitech.acctmgr.atom.domains.user.FamilyEntity;
import com.sitech.acctmgr.atom.domains.user.GroupUserInfo;
import com.sitech.acctmgr.atom.domains.user.ServAddNumEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserExpireEntity;
import com.sitech.acctmgr.atom.domains.user.UserGroupMbrEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserRelEntity;
import com.sitech.acctmgr.atom.domains.user.UserdetaildeadEntity;
import com.sitech.acctmgr.atom.domains.user.UsersvcAttrEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.CodecUtil;

/**
 * <p>
 * Title: 用户类
 * </p>
 * <p>
 * Description: 取用户信息的相关方法
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
 */
@SuppressWarnings({"unchecked"})
public class User extends BaseBusi implements IUser {

    private IAccount account;
    private IControl control;
    private ICust cust;

    @Override
    public UserInfoEntity getUserInfo(String phoneNo) {

        UserInfoEntity uie = getUserEntity(null, phoneNo, null, true);

        UserDetailEntity ude = getUserdetailEntity(uie.getIdNo());

        UserBrandEntity ube = getUserBrandRel(uie.getIdNo());

        uie.setRunCode(ude.getRunCode());
        uie.setRunName(ude.getRunName());
        uie.setUserPasswd(ude.getUserPasswd());
        uie.setUserGradeCode(ude.getUserGradeCode());
        uie.setCardType(ude.getCardType());
        uie.setBrandId(ube.getBrandId());
        uie.setBrandName(ube.getBrandName());

        return uie;
    }

    @Override
    public UserInfoEntity getUserEntityByIdNo(Long idNo, Boolean isThrow) {
        return this.getUserEntity(idNo, null, null, isThrow);
    }

    @Override
    public UserInfoEntity getUserEntityByPhoneNo(String phoneNo, Boolean isThrow) {
        return this.getUserEntity(null, phoneNo, null, isThrow);
    }

    @Override
    public UserInfoEntity getUserEntityByConNo(Long conNo, Boolean isThrow) {
        return this.getUserEntity(null, null, conNo, isThrow);
    }

    @Override
    public UserInfoEntity getUserEntity(Long idNo, String phoneNo, Long contractNo, Boolean isThrow) {

        if ((idNo == null || idNo < 0) && StringUtils.isEmpty(phoneNo) && (contractNo == null || contractNo < 0)) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00079"), "查询用户信息ID、服务号码、账户不能同时为空！");
        }

        Map<String, Object> inMap = new HashMap<String, Object>();
        if (idNo != null && idNo > 0) {
            safeAddToMap(inMap, "ID_NO", idNo);
        }
        if (contractNo != null && contractNo > 0) {
            safeAddToMap(inMap, "CONTRACT_NO", contractNo);
        }
        if (StringUtils.isNotEmpty(phoneNo)) {
            safeAddToMap(inMap, "PHONE_NO", phoneNo);
        }

        UserInfoEntity uie = (UserInfoEntity) baseDao.queryForObject("ur_user_info.qUserInfo", inMap);

        if (isThrow) {
            if (uie == null) {
                log.debug("USERINFO NON-EXISTENT! inParam:[ " + JSON.toJSONString(inMap) + " ]");
				throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "查询用户信息错误！inParam:[ " + JSON.toJSONString(inMap) + " ]");
            }
        }

        if (uie != null) {
            String accessType = uie.getAccessType();
            if ("001".equals(accessType) || "002".equals(accessType)) {
                uie.setIs4G(true);
            } else {
                uie.setIs4G(false);
            }
        }


        return uie;
    }

    public UserInfoEntity getUserEntityAllDb(Long idNo, String phoneNo, Long contractNo, Boolean isThrow) {

        if ((idNo == null || idNo < 0) && StringUtils.isEmpty(phoneNo)) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00042"), "查询用户信息ID与服务号码不能同时为空！");
        }

        Map<String, Object> inMap = new HashMap<String, Object>();
        if (idNo != null && idNo > 0) {
            safeAddToMap(inMap, "ID_NO", idNo);
        }
        if (contractNo != null && contractNo > 0) {
            safeAddToMap(inMap, "CONTRACT_NO", contractNo);
        }
        if (StringUtils.isNotEmpty(phoneNo)) {
            safeAddToMap(inMap, "PHONE_NO", phoneNo);
        }

        List<UserInfoEntity> uie = (List<UserInfoEntity>) baseDao.queryAllDbList("ur_user_info.qUserInfo", inMap);

        if (isThrow) {
            if (uie.size() == 0) {
                log.debug("USERINFO NON-EXISTENT! inParam:[ " + JSON.toJSONString(uie) + " ]");
				throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "查询用户信息错误！inParam:[ " + JSON.toJSONString(uie) + " ]");
            }
        }

        return uie.get(0);
    }

    @Override
    public List<UserDeadEntity> getUserdeadEntity(String phoneNo, Long idNo, Long contractNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        if (idNo != null && idNo > 0) {
            safeAddToMap(inMap, "ID_NO", idNo);
        }
        if (contractNo != null && contractNo > 0) {
            safeAddToMap(inMap, "CONTRACT_NO", contractNo);
        }
        if (StringUtils.isNotEmpty(phoneNo)) {
            safeAddToMap(inMap, "PHONE_NO", phoneNo);
        }
        List<UserDeadEntity> result = (List<UserDeadEntity>) baseDao.queryForList("ur_userdead_info.qUserdeadInfo", inMap);
        if (result.size() == 0) {
            log.debug("USERDEADINFO NON-EXISTENT! inParam:[ " + inMap.toString() + " ]");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "查询离网用户信息错误！inParam:[ " + inMap.toString() + " ]");
        }
        return result;
    }

    @Override
    public UserDetailEntity getUserdetailEntity(Long inIdNo) {

		long lIdNo = inIdNo; /* 入参用户标识 */

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", lIdNo);
        UserDetailEntity result = (UserDetailEntity) baseDao.queryForObject("cs_userdetail_info.qUserdetailInfo", inMap);

        if (result == null) {
            log.debug("USERDETAILINFO ERROR! inParam:[ " + inMap.toString() + " ]");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00004"), "查询在网用户详细信息错误！inParam:[ " + inMap.toString() + " ]");
        }

        return result;
    }

    @Override
    public List<UserDeadEntity> getUserdeadByCustId(String idIccid) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_ICCID", idIccid);
        List<UserDeadEntity> result = (List<UserDeadEntity>) baseDao.queryForList("ur_userdead_info.qryByCustId", inMap);
		/* if (result.size()==0) { throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "查询离网用户信息错误！inParam:[ " + inMap.toString() + " ]"); } */
        return result;
    }

    @Override
    public UserBrandEntity getUserBrandRel(Long inIdNo) {

		return getUserBrandRel(inIdNo, true);
    }
    @Override
	public UserBrandEntity getUserBrandRel(Long inIdNo, boolean flag) {
		long lIdNo = inIdNo; /* 入参用户标识 */

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", lIdNo);
		UserBrandEntity result = (UserBrandEntity) baseDao.queryForObject("ur_userbrand_rel.qUserbrandInfo", inMap);

		if (result == null && flag) {
			log.debug("USERBRANDINFO ERROR! inParam:[ " + inMap.toString() + " ]");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00004"), "查询用户品牌信息错误！inParam:[ " + inMap.toString() + " ]");
		}

		return result;
	}

	@Override
    public boolean isUserExpire(long inIdNo, int timeFlag) {

        int iCount = 0;
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", inIdNo);
        if (timeFlag == 1) {
            inMap.put("TIME_FLAG", timeFlag);
        }
        Map<String, Object> outMap = (Map<String, Object>) baseDao.queryForObject("bal_userexpire_info.qIsExpireByIdNo", inMap);
        iCount = Integer.parseInt(outMap.get("COUNT").toString());

        if (iCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public UserExpireEntity getUserExpireInfo(Long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        UserExpireEntity result = (UserExpireEntity) baseDao.queryForObject("bal_userexpire_info.qUserexpireInfoByIdNo", inMap);
        return result;
    }

    @Override
    public String getAddServiceNo(Long idNo, String addBbrType) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        String addNo = "";
        if (idNo != null && idNo > 0) {
            safeAddToMap(inMap, "ID_NO", idNo);
        }
        if (StringUtils.isNotEmpty(addBbrType)) {
            safeAddToMap(inMap, "ADD_NBR_TYPE", addBbrType);
        }
        ServAddNumEntity result = (ServAddNumEntity) baseDao.queryForObject("ur_user_info.qAddServiceNo", inMap);
        if (result != null) {
            addNo = result.getAddServiceNo();
        }
        return addNo;
    }

    public String getPhoneNoByAsn(String addServieNo, String addBbrType) {
        ServAddNumEntity result = this.getPhoneNoByAsn(addServieNo, addBbrType, true);
        return result.getPhoneNo();
    }

    @Override
    public ServAddNumEntity getPhoneNoByAsn(String addServieNo, String addBbrType, boolean isThrow) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(addServieNo)) {
            safeAddToMap(inMap, "ADD_SERVICE_NO", addServieNo);
        }
        if (StringUtils.isNotEmpty(addBbrType)) {
            safeAddToMap(inMap, "ADD_NBR_TYPE", addBbrType);
        }
        ServAddNumEntity result = (ServAddNumEntity) baseDao.queryForObject("ur_user_info.qAddServiceNo", inMap);
        if (isThrow && result == null) {
			log.error("接入号码不存在，请重新输入! ");
			throw new BusiException(AcctMgrError.getErrorCode("8008", "00011"), "接入号码不存在，请重新输入!");
        }

        return result;
    }
    
    @Override
    public ServAddNumEntity getPhoneNoByAsn(String addServieNo, String[] addBbrTypes) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(addServieNo)) {
            safeAddToMap(inMap, "ADD_SERVICE_NO", addServieNo);
        }
        if (addBbrTypes.length>0) {
            safeAddToMap(inMap, "ADD_NBR_TYPES", addBbrTypes);
        }
        ServAddNumEntity result = (ServAddNumEntity) baseDao.queryForObject("ur_user_info.qAddServiceNo", inMap);
        if (result == null) {
            log.error("接入号码不存在，请重新输入! ");
            throw new BusiException(AcctMgrError.getErrorCode("8008", "00011"), "接入号码不存在，请重新输入!");
        }

        return result;
    }

    @Override
    public long getFamilyId(long contractNo) {

        Map<String, Object> inMapTmp = null;
        Map<String, Object> outMapTmp = null;

        long vartualId = 0;

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CONTRACT_NO", String.valueOf(contractNo));
        outMapTmp = (Map<String, Object>) baseDao.queryForObject("ur_useradd_info.qFamilyCon", inMapTmp);
        if (outMapTmp == null) {

            vartualId = 0;
        } else {

            vartualId = Long.parseLong(outMapTmp.get("ID_NO").toString());
        }

        return vartualId;
    }

    @Override
    public List<FamilyEntity> getFamilyInfo(long idNo) {

        Map<String, Object> inMapTmp = null;

        List<FamilyEntity> outFamList = new ArrayList<FamilyEntity>();

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ID_NO", idNo);
        inMapTmp.put("GROUP_TYPES", Arrays.asList(CommonConst.FAMILY_GROUP_TYPES.split("\\,")));
        List<UserGroupMbrEntity> mbrList = (List<UserGroupMbrEntity>) baseDao.queryForList("ur_usergroupmbr_info.qGroupInfo", inMapTmp);
        if (0 == mbrList.size()) {
			log.info("该号码没有办理家庭业务ID_NO[" + idNo + "]");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00012"), "该号码没有办理家庭业务ID_NO[" + idNo + "]");
        }
        for (UserGroupMbrEntity mbrEnt : mbrList) {

            long groupId = mbrEnt.getGroupId();
            List<FamilyEntity> outFamilyList = this.getFamilyInfoByGroupId(groupId);

            outFamList.addAll(outFamilyList);
        }

		log.debug("家庭所有成员： " + outFamList.toString());
        return outFamList;
    }

    @Override
    public List<FamilyEntity> getFamilyInfoByGroupId(long groupId) {

        Map<String, Object> inMapTmp = null;
        Map<String, Object> outMapTmp = null;

        List<FamilyEntity> outFamMbrList = new ArrayList<FamilyEntity>();

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_ID", groupId);
        inMapTmp.put("GROUP_TYPES", Arrays.asList(CommonConst.FAMILY_GROUP_TYPES.split("\\,")));
        outMapTmp = (Map<String, Object>) baseDao.queryForObject("ur_usergroupmbr_info.qUserGroupInfo", inMapTmp);
		long lVirtualId = getLongValue(outMapTmp, "ID_NO"); // 群组对应的虚拟用户ID
		String groupType = getString(outMapTmp, "GROUP_TYPE"); // 群组类型

		// 获取家庭公共账户，如果有公共账户，则展示
        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ID_NO", lVirtualId);
        outMapTmp = (Map<String, Object>) baseDao.queryForObject("ur_useradd_info.qFamilyCon", inMapTmp);
        if (MapUtils.isNotEmpty(outMapTmp)) {
            long pubCon = Long.parseLong(outMapTmp.get("CONTRACT_NO").toString());
            ContractInfoEntity cie = account.getConInfo(pubCon);

            FamilyEntity virtualFamEnt = new FamilyEntity();
            virtualFamEnt.setPhoneNo("");
            virtualFamEnt.setContractName(cie.getBlurContractName());
            virtualFamEnt.setContracttypeName(cie.getContractName());
			virtualFamEnt.setMemberTypeFlag("0"); // 家长
            virtualFamEnt.setContractNo(pubCon);

            outFamMbrList.add(virtualFamEnt);
        }

        long codeClass = 2004;
		List<Long> memberRoleIds = this.getFamilyRoleIds(codeClass, "0"); // 关键人角色ID字符串
        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_ID", groupId);
		/* 获取群组下所有成员，含家长和普通成员 */
        List<UserGroupMbrEntity> mbrList = (List<UserGroupMbrEntity>) baseDao.queryForList("ur_usergroupmbr_info.qGroupInfo", inMapTmp);
        for (UserGroupMbrEntity mbrEnt : mbrList) {

			String memberTypeFlag = "1"; // 0 ：关键人 1：成员

            UserInfoEntity uie = this.getUserEntityByIdNo(mbrEnt.getIdNo(), true);

			// 获取账户信息
            ContractInfoEntity conInfo = account.getConInfo(uie.getContractNo());
            String contractTypeName = conInfo.getContractattTypeName();

			// 判断是否关键人
            inner:
            for (long mbrRoleId : memberRoleIds) {
                if (mbrRoleId == mbrEnt.getMemberRoleId()) {
					contractTypeName = "家庭主卡账户";
                    memberTypeFlag = "0";
                    break inner;
                }
            }

            FamilyEntity famMbrEnt = new FamilyEntity();
            famMbrEnt.setPhoneNo(uie.getPhoneNo());
            famMbrEnt.setContractNo(uie.getContractNo());
            famMbrEnt.setContracttypeName(contractTypeName);
            famMbrEnt.setContractName(conInfo.getBlurContractName());
            famMbrEnt.setMemberTypeFlag(memberTypeFlag);

            outFamMbrList.add(famMbrEnt);

        }

        return outFamMbrList;

    }

    public List<FamilyEntity> getFamilyInfoByVirtualId(long idNo) {

        Map<String, Object> inMapTmp = null;
        Map<String, Object> outMapTmp = null;

        List<FamilyEntity> outParam = new ArrayList<FamilyEntity>();

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ID_NO", idNo);
        inMapTmp.put("GROUP_TYPES", Arrays.asList(CommonConst.FAMILY_GROUP_TYPES.split("\\,")));

        outMapTmp = (Map<String, Object>) baseDao.queryForObject("ur_usergroupmbr_info.qUserGroupInfo", inMapTmp);
        long groupId = Long.parseLong(outMapTmp.get("GROUP_ID").toString());

        outParam = this.getFamilyInfoByGroupId(groupId);

        return outParam;
    }

    @Override
    public List<Long> getFamilyRoleIds(Long codeClass, String mbrFlag) {
        List<PubCodeDictEntity> pubValues = control.getPubCodeList(codeClass, null, mbrFlag, null);
        List<Long> mbrIdList = new ArrayList<>();
        for (PubCodeDictEntity pubValue : pubValues) {
            mbrIdList.add(Long.parseLong(pubValue.getCodeId()));
        }

        return mbrIdList;

    }

    @Override
    public UserGroupMbrEntity getFamilyMemberInfo(Long idNo, List<Long> memberRoleIds) {
        return this.getFamilyMemberInfo(idNo, Arrays.asList(CommonConst.FAMILY_GROUP_TYPES.split("\\,")), memberRoleIds);
    }

    @Override
    public UserGroupMbrEntity getFamilyMemberInfo(Long idNo, List<String> groupTypes, List<Long> memberRoleIds) {
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", idNo);
        if (!memberRoleIds.isEmpty()) {
            safeAddToMap(inMap, "MEMBER_ROLE_IDS", memberRoleIds);
        }

		// TODO 家庭群组类型需要确认
        if (!groupTypes.isEmpty()) {
            safeAddToMap(inMap, "GROUP_TYPES", groupTypes);
        } else {
			safeAddToMap(inMap, "GROUP_TYPES", Arrays.asList(CommonConst.FAMILY_GROUP_TYPES.split("\\,"))); // TODO 需要确认家庭亲情网和家庭网的群组类型标识是否一致；不一致时，按入参传入
        }

        UserGroupMbrEntity groupMbrEnt = (UserGroupMbrEntity) baseDao.queryForObject("ur_usergroupmbr_info.qGroupInfo", inMap);

        return groupMbrEnt;
    }

    @Override
    public char isPimaryOrSecondaryCard(String phoneNo) {

        return 'c';
    }

    @Override
    public long getCardId(String phoneNo, String flag) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public boolean isInternetOfThingsPhone(String phoneNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("PHONE_NO", phoneNo);
        inMap.put("ADD_NBR_TYPE", CommonConst.NBR_TYPE_WLW);
        Integer cnt = (Integer) baseDao.queryForObject("ur_servaddnum_info.qCnt", inMap);
        if (cnt > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean isInternetOfThingsPhone(long idNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        inMap.put("ADD_NBR_TYPE", CommonConst.NBR_TYPE_WLW);
        Integer cnt = (Integer) baseDao.queryForObject("ur_servaddnum_info.qCnt", inMap);
        if (cnt > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean isBroadbandPhone(String phoneNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("PHONE_NO", phoneNo);
        inMap.put("ADD_NBR_TYPE", CommonConst.NBR_TYPE_KD);
        Integer cnt = (Integer) baseDao.queryForObject("ur_servaddnum_info.qCnt", inMap);
        if (cnt > 0) {
            return true;
        } else {
            return false;
        }
    }

    public UsersvcAttrEntity getUsersvcAttr(long idNo, String attrIds) {
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ID_NO", idNo);
        inMapTmp.put("ATTR_IDS", attrIds.split("\\,"));
        UsersvcAttrEntity result = (UsersvcAttrEntity) baseDao.queryForObject("ur_usersvcattrtrace_info.qAttrValue", inMapTmp);
        return result;
    }

    public UserdetaildeadEntity getUserdetailDeadEntity(Long inIdNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        safeAddToMap(inMap, "ID_NO", inIdNo);
        UserdetaildeadEntity result = (UserdetaildeadEntity) baseDao.queryForObject("cs_userdetaildead_info.quserdetaildead", inMap);
        if (result == null) {
            log.debug("NOT FIND USERINFO!");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00044"), "取用户明细信息错误！");
        }

        return result;
    }

    @Override
    public Date getUserPassDate(Long idNo, Long contractNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        if (idNo != null && idNo > 0) {
            safeAddToMap(inMap, "ID_NO", idNo);
        }
        if (contractNo != null && contractNo > 0) {
            safeAddToMap(inMap, "CONTRACT_NO", contractNo);
        }
        Date date = (Date) baseDao.queryForObject("cs_userpass_info.selectUserPassDate", inMap);
        return date;
    }

    @Override
    public UserGroupMbrEntity getGroupInfo(String phoneNo, String groupType) {
        UserInfoEntity userInfo = this.getUserEntityByPhoneNo(phoneNo, true);
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", userInfo.getIdNo());
        safeAddToMap(inMap, "GROUP_TYPE", groupType);
		log.debug("查询群组信息的入参为：" + groupType);
        UserGroupMbrEntity groupInfo = (UserGroupMbrEntity) baseDao.queryForObject("ur_usergroupmbr_info.qGroupInfo", inMap);

        return groupInfo;
    }

    private List<UserInfoEntity> getGrpUserInfo(Long unitId, Long custId) {
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        if (unitId != null && unitId > 0) {
            safeAddToMap(inMapTmp, "UNIT_ID", unitId);
        }

        if (custId != null && custId > 0) {
            safeAddToMap(inMapTmp, "CUST_ID", custId);
        }

        List<UserInfoEntity> userList = (List<UserInfoEntity>) baseDao.queryForList("ur_user_info.qryGrpUserInfo", inMapTmp);

        return userList;
    }

    @Override
    public List<UserInfoEntity> getGrpUserInfoByCustId(Long custId) {
        return this.getGrpUserInfo(null, custId);
    }

    @Override
    public List<UserInfoEntity> getGrpUserInfoByUnitId(Long unitId) {
        return this.getGrpUserInfo(unitId, null);
    }

    public List<UserDeadEntity> getGrpUserDeadInfo(Long unitId) {
        // List<UserDeadEntity> outParamList = new ArrayList<UserDeadEntity>();

        Map<String, Object> inMapTmp = null;
        // Map<String, Object> outMapTmp = null;

        inMapTmp = new HashMap<String, Object>();
        safeAddToMap(inMapTmp, "UNIT_ID", unitId);

		log.debug("参数：" + inMapTmp);
        List<UserDeadEntity> conList = (List<UserDeadEntity>) baseDao.queryForList("ur_userdead_info.qryGrpUserDeadInfo", inMapTmp);

        return conList;
    }

    @Override
    public List<UserInfoEntity> getGrpUserInfoByBrand(Long custId, String brandIds) {
        Map<String, Object> inMapTmp = new HashMap<String, Object>();

        safeAddToMap(inMapTmp, "CUST_ID", custId);
        safeAddToMap(inMapTmp, "BRAND_ID_LIST", brandIds.split(","));

        List<UserInfoEntity> userList = (List<UserInfoEntity>) baseDao.queryForList("ur_user_info.qryGrpUserInfo", inMapTmp);

        return userList;
    }

    @Override
    public Map<String, Object> getGroupGoods(long idNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);

        Map<String, Object> outGroup = (Map<String, Object>) baseDao.queryForObject("ur_usergoods_info.qGroupGoodsInfo", inMap);

        if (outGroup == null) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00047"), "未找到集团产品信息！");
        }

        return outGroup;
    }

    public List<ExpireOprEntity> getExpireOprList(long lIdNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", lIdNo);
        List<ExpireOprEntity> expireList = baseDao.queryForList("bal_expirelist_recd.select", inMap);

        return expireList;

    }

    public List<GroupUserInfo> getGrpInfo(String iccId, String custId, String unitId, String contractNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        String iccId2 = "";
        if(!StringUtil.isEmpty(iccId)){
        	iccId2 = control.pubEncryptData(iccId, 0);
        }
        safeAddToMap(inMap, "ID_ICCID", iccId2);
        safeAddToMap(inMap, "CUST_ID", custId);
        safeAddToMap(inMap, "UNIT_ID", unitId);
        safeAddToMap(inMap, "CONTRACT_NO", contractNo);

        List<GroupUserInfo> conList = (List<GroupUserInfo>) baseDao.queryForList("ur_user_info.qryGrpInfo", inMap);
        
        List<GroupUserInfo> conList1 = new ArrayList<GroupUserInfo>();
        
        for(GroupUserInfo conEnt:conList){
        	String iccId1 = "";
        	
			iccId1 = control.pubEncryptData(conEnt.getIccId(),1);
			
        	conEnt.setIccId(iccId1);
        	conList1.add(conEnt);
        }

        return conList1;
    }

    public Map<String, Object> getUrGrpInfo(long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        Map<String, Object> outMap = new HashMap<String, Object>();

        safeAddToMap(inMap, "ID_NO", idNo);

        Map<String, Object> conMap = (Map<String, Object>) baseDao.queryForObject("ur_usergroupmbr_info.qryUrGrpInfo", inMap);

        outMap.put("GROUP_NAME", conMap.get("GROUP_NAME"));
        outMap.put("GROUP_ID", conMap.get("GROUP_ID"));
        outMap.put("GROUP_CODE", conMap.get("GROUP_CODE"));

        return outMap;
    }

    @Override
    public List<VirtualGrpEntity> getVirtualGrpList(long unitId, String phoneNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        if (unitId > 0) {
            inMap.put("UNIT_ID", unitId);
        }
        if (StringUtils.isNotEmpty(phoneNo)) {
            inMap.put("PHONE_NO", phoneNo);
        }

        List<VirtualGrpEntity> virtualGrpList = baseDao.queryForList("bal_grpuser_rel.qry", inMap);
        return virtualGrpList;
    }

    @Override
    public List<UserGroupMbrEntity> getUserGroupList(Long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        List<UserGroupMbrEntity> groupList = (List<UserGroupMbrEntity>) baseDao.queryForList("ur_usergroupmbr_info.qGroupInfo", inMap);
        return groupList;
    }

    @Override
    public int cntUserRel(long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("MASTER_ID", idNo);
        inMap.put("RELATION_CODE", CommonConst.HZFXZFHGX);

        return (Integer) baseDao.queryForObject("cs_userrel_info.qryCnt", inMap);

    }

    public boolean isSlaveCard(long idNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("SLAVE_ID", idNo);
        inMap.put("RELATION_CODE", CommonConst.HZFXZFHGX);

        Integer result = (Integer) baseDao.queryForObject("cs_userrel_info.qryCnt", inMap);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isGroupSlaveCard(long idNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("SLAVE_ID", idNo);
        inMap.put("OP_CODES", new String[]{"1341", "1367"});
        inMap.put("RELATION_CODE", CommonConst.HZFXZFHGX);
        Integer result = (Integer) baseDao.queryForObject("cs_userrel_info.qryCnt", inMap);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isFalSlaveCard(long idNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("SLAVE_ID", idNo);
        inMap.put("OP_CODE", "");
        inMap.put("RELATION_CODE", CommonConst.HZFXZFHGX);
        Integer result = (Integer) baseDao.queryForObject("cs_userrel_info.qryCnt", inMap);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isRealName(long idNo, String isOnNet) {

        long custId = 0;
        if (isOnNet.equals("1")) {
            UserInfoEntity userEntity = this.getUserEntityByIdNo(idNo, true);
            custId = userEntity.getCustId();
        } else {
            List<UserDeadEntity> userDeadEnt = this.getUserdeadEntity(null, idNo, null);
            custId = userDeadEnt.get(0).getCustId();
        }
        CustInfoEntity custEntity = cust.getCustInfo(custId, null);
        if (custEntity.getTrueFlag().equals("F")) {
            return false;
        } else {
            return true;
        }
    }

    @Override
    public UserRelEntity getMasterId(Long idNo, String opCode) {
        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("SLAVE_ID", idNo);
        inMap.put("OP_CODE", opCode);
        inMap.put("RELATION_CODE", "60");
        UserRelEntity ure = (UserRelEntity) baseDao.queryForObject("cs_userrel_info.qry", inMap);
        return ure;
    }

    @Override
    public List<UserRelEntity> getSlaveId(Long idNo, String opCode) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("MASTER_ID", idNo);
        inMap.put("OP_CODE", opCode);
        inMap.put("RELATION_CODE", "60");
        List<UserRelEntity> resultList = (List<UserRelEntity>) baseDao.queryForList("cs_userrel_info.qry", inMap);
        return resultList;
    }

    @Override
    public boolean isEasyOwnSigned(Long idNo) {
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", idNo);
        safeAddToMap(inMap, "FIELD_CODE", "100025");
        int cnt = (Integer) baseDao.queryForObject("cs_useradd_info.qCnt", inMap);

        return cnt > 0 ? true : false;
    }

    @Override
    public boolean isTrafficFlux(long idNo, String attrId, String attrValue) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        inMap.put("ATTR_ID", attrId);
        inMap.put("ATTR_VALUE", attrValue);
        int cnt = (Integer) baseDao.queryForObject("ur_usersvcattrtrace_info.qCnt", inMap);
        if (cnt > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public List<ImeiFileMsgInfoEntity> getImeiFileMsgInfo(String phoneNo, String startMonth, String endMonth) {
        Map<String, Object> inMap = new HashMap<>();
        inMap.put("PHONE_NO", phoneNo);
        inMap.put("START_MONTH", startMonth);
        inMap.put("END_MONTH", endMonth);
        List<ImeiFileMsgInfoEntity> imeiFileMsgInfo = (List<ImeiFileMsgInfoEntity>) baseDao
                .queryForList("bal_imeifilemsg_info.query", inMap);

        if (imeiFileMsgInfo == null) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00048"), "未找到拆包刷码信息！");
        }

        return imeiFileMsgInfo;
    }

    public Map<String, Object> getDateSub(long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        Map<String, Object> outMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        Map<String, Object> dateSub = (Map<String, Object>) baseDao.queryForObject("ur_dynaccount_info.getDateSub", inMap);
        return dateSub;
    }

    public boolean IsBilltotcodeUser(long groupContract, long contractNo) {
        boolean IsBilltotcodeUser;
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("GROUP_CONTRACT", groupContract);
        inMap.put("CONTRACT_NO", contractNo);
        long count = (long) baseDao.queryForObject("SBILLTOTCODE_USER.qSbilltotcodeInfo", inMap);
        if (count > 0) {
            IsBilltotcodeUser = true;
        } else {
            IsBilltotcodeUser = false;
        }

        return IsBilltotcodeUser;
    }

    @Override
    public ServAddNumEntity getAddNumInfo(String phoneNo, String addServiceNo, String addNbrType) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        if (StringUtils.isNotEmptyOrNull(phoneNo)) {
            inMap.put("PHONE_NO", phoneNo);
        }
        if (StringUtils.isNotEmptyOrNull(addServiceNo)) {
            inMap.put("ADD_SERVICE_NO", addServiceNo);
        }
        if (StringUtils.isNotEmptyOrNull(addNbrType)) {
            inMap.put("ADD_NBR_TYPE", addNbrType);
        }
        ServAddNumEntity addNumEnt = (ServAddNumEntity) baseDao.queryForObject("ur_servaddnum_info.qaddNumInfo", inMap);
        return addNumEnt;
    }

    @Override
    public boolean IsNetBinding(String phoneNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("NET_NO", phoneNo);
        int count = (int) baseDao.queryForObject("mk_netbinding_info.qCnt", inMap);
        if (count > 0) {
            return true;
        } else {
            return false;
        }

    }

    @Override
    public boolean IsNetMember(Long idNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        List<Map<String, Object>> MemberRoleIdList = (List<Map<String, Object>>) baseDao.queryForList("ur_usergroupmbr_info.qMemberRoleId", inMap);
        List<Long> list = Arrays.asList(PayBusiConst.JTKDCY_MEMRD);
		log.debug("家庭宽带成员memberroleId:" + list.toString());
        if (MemberRoleIdList.size() == 0) {
            return false;
        } else {
            for (Map<String, Object> userGroup : MemberRoleIdList) {
				// 家庭宽带成员号码，不允许缴费
                if (list.contains(Long.parseLong(userGroup.get("MEMBER_ROLE_ID").toString()))) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
	public boolean IsNetPerson(Long idNo) {
       return IsNetFamily(idNo,CommonConst.XYZFSJKDBDFF);
	}
    
    @Override
  	public boolean IsNetMate(Long idNo) {
         return IsNetFamily(idNo, CommonConst.LLBLK);
  	}
    
    @Override
    public boolean IsNetFamily(Long idNo,String relationCode) {
     	 Map<String, Object> inMap = new HashMap<String, Object>();
         inMap.put("SLAVE_ID", idNo);
         inMap.put("RELATION_CODE", relationCode);
        Integer result = (Integer) baseDao.queryForObject("cs_userrel_info.qryCnt", inMap);
        return result > 0 ? true : false;
    }

    @Override
    public List<Long> getFamlilyIds(long payIdNo) {
        List<Long> idList = new ArrayList<>();
        long[] mainRoleIds = {21098,21100,21105,21108};
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", payIdNo);
        safeAddToMap(inMap, "MEMBER_ROLE_IDS", mainRoleIds);
        UserGroupMbrEntity famInfo = (UserGroupMbrEntity) baseDao.queryForObject("ur_usergroupmbr_info.qGroupInfo", inMap);
        if (famInfo != null) {
            long groupId = famInfo.getGroupId();
            long famId = famInfo.getGroupIdNo();
            idList.add(famId);

            long[] memRoleIds = {21097,21101,21109,21106};
            inMap = new HashMap<>();
            safeAddToMap(inMap, "GROUP_ID", groupId);
            safeAddToMap(inMap, "MEMBER_ROLE_IDS", memRoleIds);
            List<UserGroupMbrEntity> memList = (List<UserGroupMbrEntity>) baseDao.queryForList("ur_usergroupmbr_info.qGroupInfo", inMap);
            for (UserGroupMbrEntity mbrInfo : memList) {
                idList.add(mbrInfo.getIdNo());
            }
        } else {
			log.debug("用户[" + payIdNo + "]为普通用户，并不是家庭付费人");
        }


        return idList;
    }
    
    @Override
    public long getFamlilyMainId(long secIdNo) {
    	
    	long[] memRoleIds = {21097,21101,21109,21106};
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", secIdNo);
        safeAddToMap(inMap, "MEMBER_ROLE_IDS", memRoleIds);
        UserGroupMbrEntity famInfo = (UserGroupMbrEntity) baseDao.queryForObject("ur_usergroupmbr_info.qGroupInfo", inMap);
        long groupId = famInfo.getGroupId();
        
        long[] mainRoleIds = {21098,21100,21105,21108};
        inMap = new HashMap<>();
        safeAddToMap(inMap, "GROUP_ID", groupId);
        safeAddToMap(inMap, "MEMBER_ROLE_IDS", mainRoleIds);
        UserGroupMbrEntity famInfoMain = (UserGroupMbrEntity) baseDao.queryForObject("ur_usergroupmbr_info.qGroupInfo", inMap);
        long MainId = famInfoMain.getIdNo();
        return MainId;
    }
    
    @Override
    public long getCntFamlily(long idNo,long[] memRoleIds) {
    	Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", idNo);
        safeAddToMap(inMap, "MEMBER_ROLE_IDS", memRoleIds);
        long cnt = (long) baseDao.queryForObject("ur_usergroupmbr_info.qCnt", inMap);
        
        return cnt;
    }
    
    public UserRelEntity getMateId(long mainId,long slaveId) {  	
        Map<String, Object> inMap = new HashMap<String, Object>();
        
        if(mainId>0) {
        	inMap.put("MASTER_ID", mainId);
        }
        if(slaveId>0) {
        	inMap.put("SLAVE_ID", slaveId);
        }
        inMap.put("RELATION_CODE", "62");
        UserRelEntity ure = (UserRelEntity) baseDao.queryForObject("cs_userrel_info.qry", inMap);
		return ure;
    	
    }

    public ICust getCust() {
        return cust;
    }

    public void setCust(ICust cust) {
        this.cust = cust;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }


}

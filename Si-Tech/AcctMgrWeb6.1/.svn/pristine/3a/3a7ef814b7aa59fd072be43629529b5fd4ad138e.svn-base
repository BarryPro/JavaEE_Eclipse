package com.sitech.acctmgr.atom.entity;

import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.cust.PostBankEntity;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.exception.BusiException;
import org.apache.commons.lang.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * <p>Title:   基础的操作信息</p>
 * <p>Description:   基础的操作信息</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @version 1.0
 */
public class Base extends BaseBusi implements IBase {
    private IGroup group;

    /* (non-Javadoc)
     * @see com.sitech.acctmgr.atom.entity.IBase#pGetFunctionDict(java.util.Map)
     */
    @Override
    public String getFunctionName(String opCode) {
        Map<String, Object> inParamMap = new HashMap<String, Object>();
        inParamMap.put("FUNCTION_CODE", opCode);
        Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("bs_function_dict.qFunctionDictByFunCode", inParamMap);

        if (result == null) {
            log.info("bs_function_dict.qFunctionDictByFunCode is null! FUNCTION_CODE = " + inParamMap.get("FUNCTION_CODE"));
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00023"), "查询bs_function_dict出错！");
        }

        return result.get("FUNCTION_NAME").toString();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<BankEntity> getBankInfo(String groupId, String provinceId, String blurBankCode, String blurBankName) {

        int currentLevel = group.getCurrentLevel(groupId, provinceId);
        List<BankEntity> bankList = null;

        Map<String, Object> inMap = new HashMap<>();
        if (currentLevel <= 2) {
            //TODO 确认地市及省代码时，是否展示地市下全区县下的银行列表
            safeAddToMap(inMap, "GROUP_ID", groupId);
            bankList = baseDao.queryForList("bs_bank_dict.qryByGroupId", inMap);
        }else {
            safeAddToMap(inMap, "GROUP_ID", groupId);
            safeAddToMap(inMap, "PROVINCE_ID", provinceId);
            if (StringUtils.isNotEmpty(blurBankCode)) {
                safeAddToMap(inMap, "BLUR_BANK_CODE", blurBankCode);
            }
            if (StringUtils.isNotEmpty(blurBankName)) {
                safeAddToMap(inMap, "BLUR_BANK_NAME", blurBankName);
            }

            bankList = baseDao.queryForList("bs_bank_dict.qBankInfo", inMap);
        }

        if (bankList.size() == 0) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00017"), "该区县未配置银行信息");
        }

        return bankList;
    }

    @Override
    public BankEntity getBankInfo(String groupId, String provinceId, String bankCode) {
        int currentLevel = group.getCurrentLevel(groupId, provinceId);

        BankEntity bankEnt = null;
        Map<String, Object> inMap = new HashMap<>();
        if (currentLevel <= 2) {
            safeAddToMap(inMap, "GROUP_ID", groupId);
            safeAddToMap(inMap, "BANK_CODE", bankCode);
            bankEnt = (BankEntity) baseDao.queryForObject("bs_bank_dict.qryByGroupId", inMap);
        }else {
            safeAddToMap(inMap, "GROUP_ID", groupId);
            safeAddToMap(inMap, "PROVINCE_ID", provinceId);
            if (StringUtils.isNotEmpty(bankCode)) {
                safeAddToMap(inMap, "BANK_CODE", bankCode);
            }

            bankEnt = (BankEntity) baseDao.queryForObject("bs_bank_dict.qBankInfo", inMap);
        }

        return bankEnt;
    }

    @Override
    public List<PostBankEntity> getPostBankInfo(String regionCode, String postBankCode){
        Map<String, Object> inMap = new HashMap<>();
        if (StringUtils.isNotEmpty(postBankCode)) {
            safeAddToMap(inMap, "POST_BANK_CODE", postBankCode);
        }

        safeAddToMap(inMap, "REGION_CODE", regionCode);

        List<PostBankEntity> bankList = (List<PostBankEntity>) baseDao.queryForList("ct_postbank_dict.qPostBankInfo", inMap);

        if (bankList.size() == 0) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00018"), "归属地市未配置局方托收银行信息");
        }

        return bankList;
    }
    
    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }
}

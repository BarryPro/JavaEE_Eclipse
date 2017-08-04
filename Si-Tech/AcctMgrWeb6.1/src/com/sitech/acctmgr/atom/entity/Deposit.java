package com.sitech.acctmgr.atom.entity;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.deposit.DepositInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IDeposit;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2016/6/13.
 */
public class Deposit extends BaseBusi implements IDeposit {
    private IAccount account;

    @Override
    public List<DepositInfoEntity> getDepositInfo(String phoneNo, Long contractNo, String status) {
        if (StringUtils.isEmpty(phoneNo) && (contractNo == null || contractNo == 0)) {
            throw new BusiException(AcctMgrError.getErrorCode("0000","0000"),"押金查询服务号码和账户号码不能同时为空");
        }
        Map<String , Object> inMap = new HashMap<String , Object>();
        if (StringUtils.isNotEmpty(phoneNo)) {
            safeAddToMap(inMap,"PHONE_NO",phoneNo);
        }
        if (contractNo != null && contractNo > 0) {
            safeAddToMap(inMap,"CONTRACT_NO",contractNo);
        }
        if (StringUtils.isNotEmpty(status)){
            safeAddToMap(inMap,"STATUS",status);
        }

        List<DepositInfoEntity> outList = baseDao.queryForList("bal_depositfee_info.qryByPhoneOrCon",inMap);
        for (DepositInfoEntity depositInfo : outList) {
            String contractName = "";
            try {
                ContractInfoEntity conInfo = account.getConInfo(depositInfo.getContractNo());
                contractName = conInfo.getBlurContractName();
            } catch (Exception e) {
                contractName = "未知";
            }

            depositInfo.setContractName(contractName);

        }

        return outList;

    }


    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }
}

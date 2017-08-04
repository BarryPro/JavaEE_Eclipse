package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.deposit.DepositInfoEntity;

import java.util.List;

/**
 * Created by wangyla on 2016/6/13.
 */
public interface IDeposit {
    /**
     * 功能：查询押金信息列表
     * @param phoneNo 服务号码
     * @param contractNo 帐户号码
     * @param status 押金状态
     * @return
     */
    List<DepositInfoEntity> getDepositInfo(String phoneNo, Long contractNo, String status);
}

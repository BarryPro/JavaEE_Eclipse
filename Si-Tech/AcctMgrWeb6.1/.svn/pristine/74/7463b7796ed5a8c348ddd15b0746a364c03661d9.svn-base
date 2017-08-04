package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/23.
 */
public interface IConUserRel {
    /**
     * 功能：在网用户查询帐务关系
     * @param inParam
     * @return
     */
    OutDTO queryOnLine(InDTO inParam);

    /**
     * 功能：离线用户查询帐务关系
     * @param inParam .PHONE_NO  服务号码
     * 
     * @return List<AccountListEntity>
     * AccountListEntity.ID_NO  用户号码
     * AccountListEntity.CUST_ID  客户ID
     * AccountListEntity.CONTRACT_NO 默认账户号码
     * AccountListEntity.BLUR_CUST_NAME 模糊化客户名称
     * AccountListEntity.CUST_NAME  解密后客户名称
     * 
     */
    OutDTO queryOffLine(InDTO inParam);

    /**
     * 功能：在网用户帐务关系查询，并且返回每个帐户的余额
     * @param inParam
     * @return
     */
    OutDTO queryOnLineIncBalance(InDTO inParam);

    /**
     * 功能：查询用户所有在网和离网的帐务关系
     * @param inParam
     * @return
     */
    OutDTO queryAll(InDTO inParam);
}

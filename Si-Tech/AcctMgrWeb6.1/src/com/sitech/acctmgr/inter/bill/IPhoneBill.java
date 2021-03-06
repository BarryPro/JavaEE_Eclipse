package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/12/23.
 */
public interface IPhoneBill {

    /**
     * 功能：查询用户帐单
     * 对应老接口：sPhoneQueryBill
     * @param inParam
     * @return 用户按月份展示代付帐户下的帐单及明细
     */
    OutDTO query(InDTO inParam);

    /**
     * 功能：按月查询用户帐单
     * 对应老接口：sPhoneOweTotal 当月话费总额查询
     * @param inParam
     * @return
     */
    OutDTO query2(InDTO inParam);
}

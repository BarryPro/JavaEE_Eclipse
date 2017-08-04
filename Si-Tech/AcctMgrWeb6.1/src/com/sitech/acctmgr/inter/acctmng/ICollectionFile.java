package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/7.
 */
public interface ICollectionFile {

    /**
     * 功能：托收文件生成，
     * 对应旧接口：s9904Cfm 电子托收单打印
     * @param inParam
     * @return
     */
    OutDTO create(InDTO inParam);

    /**
     * 功能：托收文件重新生成，只针对托收帐户列表
     * 对应旧接口：s4426Cfm 补充生成电子托收
     * @param inParam
     * @return
     */
    OutDTO reCreate(InDTO inParam);

    /**
     * 功能：补充电子托收信息校验
     * @param inParam
     * @return
     */
    OutDTO check(InDTO inParam);

    /**
     * 功能：托收回执单入库
     * @param inParam
     * @return
     */
    OutDTO insertTable(InDTO inParam);
}

package com.sitech.acctmgr.atom.busi.volume.inter;

import java.util.Map;

/**
 * Created by wangyla on 2017/3/28.
 */
public interface IVolume {
    void saveBuyOpr(Map<String, Object> inMap);

    void saveBuyOprHis(String orderId);

    void saveSaleInfo(Map<String, Object> inMap);

    void saveSaleInfoHis(String orderId);

    void deleteBuyOprByOrderId(String orderId);

    void deleteSaleInfoByOrderId(String orderId);
}

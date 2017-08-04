package com.sitech.acctmgr.atom.busi.volume;

import com.sitech.acctmgr.atom.busi.volume.inter.IVolume;
import com.sitech.acctmgr.common.BaseBusi;

import java.util.Map;

/**
 * Created by wangyla on 2017/3/28.
 */
public class Volume extends BaseBusi implements IVolume {

    @Override
    public void saveBuyOpr(Map<String, Object> inMap) {
        baseDao.insert("volumeopr.saveBuyOpr", inMap);
    }

    @Override
    public void saveBuyOprHis(String orderId) {
        baseDao.insert("volumeopr.saveBuyOprHis", orderId);
    }

    @Override
    public void saveSaleInfo(Map<String, Object> inMap) {
        baseDao.insert("volumeopr.saveSaleInfo", inMap);
    }

    @Override
    public void saveSaleInfoHis(String orderId) {
        baseDao.insert("volumeopr.saveSaleInfoHis", orderId);
    }

    @Override
    public void deleteBuyOprByOrderId(String orderId) {
        baseDao.delete("volumeopr.deleteBuyOpr", orderId);
    }

    @Override
    public void deleteSaleInfoByOrderId(String orderId) {
        baseDao.delete("volumeopr.deleteSaleInfo", orderId);
    }
}

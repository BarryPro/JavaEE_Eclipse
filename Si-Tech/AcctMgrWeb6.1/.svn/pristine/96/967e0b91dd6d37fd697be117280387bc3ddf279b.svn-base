package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.bill.BillFeeEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.free.SDxFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SDxFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IDxFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2017/1/20.
 */
@ParamTypes({
        @ParamType(c = SDxFreeQueryInDTO.class, m = "query", oc = SDxFreeQueryOutDTO.class)
})
public class SDxFree extends AcctMgrBaseService implements IDxFree {

    private IUser user;
    private IFreeDisplayer freeDisplayer;
    private IBill bill;

    @Override
    public OutDTO query(InDTO inParam) {
        SDxFreeQueryInDTO inDto = (SDxFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        String phoneNo = inDto.getPhoneNo();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        long conNo = userInfo.getContractNo();

        //TODO 取内存欠费信息，query_type = 0
        //S1：获取用户未出帐话费
        BillFeeEntity unBillEnt = bill.getUnBillOweFee(idNo, conNo);
        long shoudFee = unBillEnt.getShouldPay();
        long realFee = unBillEnt.getRealFee();

        //S2: 获取底线优惠使用情况
        Map<String, Long> dxFeeMaps = this.getDxFees(conNo, idNo);
        long dxTotal/*优惠总金额*/ = dxFeeMaps.get("DX_TOTAL");
        long dxUsed /*优惠已使用金额*/ = dxFeeMaps.get("DX_USED");
        long dxLeft/*优惠剩余金额*/ = dxFeeMaps.get("DX_REMAIN");

        /*S3：获取套餐内语音、短信优惠使用情况*/
        List<FreeMinBill> freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, DateUtils.getCurYm(), "0");
        Map<String, Long> freeMap = freeDisplayer.getFreeTotalMap(freeDetailList);

        /*出参实体实例化*/
        SDxFreeQueryOutDTO outDto = new SDxFreeQueryOutDTO();
        /*未出帐费用*/
        outDto.setShouldFee(shoudFee);
        outDto.setRealFee(realFee);

        /*底线消费帐单费用*/
        outDto.setDxTotal(dxTotal);
        outDto.setDxUsed(dxUsed);
        outDto.setDxRemain(dxLeft);

        /*当月优惠使用情况*/
        outDto.setVoiceTotal(freeMap.get("VOICE_TOTAL"));
        outDto.setVoiceUsed(freeMap.get("VOICE_USED"));
        outDto.setVoiceRemain(freeMap.get("VOICE_REMAIN"));
        outDto.setSmsTotal(freeMap.get("SMS_TOTAL"));
        outDto.setSmsUsed(freeMap.get("SMS_USED"));
        outDto.setSmsRemain(freeMap.get("SMS_REMAIN"));

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    private Map<String, Long> getDxFees(long conNo, long idNo) {
        long dxLeft = 0;
        long dxTotal = 0;
        long dxUsed = 0;
        //TODO 从未出帐明细帐单中获取底线消费
        Map<String, Long> dxMapTmp = bill.getUnbillDxInfo(conNo, idNo);

        dxLeft = dxMapTmp.get("DX_LEFT");
        dxTotal = dxMapTmp.get("DX_PAY_MONEY");

        if (dxLeft >= dxTotal) {
            dxLeft = dxTotal;
        }

        dxUsed = dxTotal - dxLeft;

        Map<String, Long> dxFeesMap = new HashMap<>();
        safeAddToMap(dxFeesMap, "DX_TOTAL", dxTotal); //底线优惠总金额
        safeAddToMap(dxFeesMap, "DX_USED", dxUsed); //底线优惠已使用量
        safeAddToMap(dxFeesMap, "DX_REMAIN", dxLeft); //底线优惠剩余金额

        return dxFeesMap;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }
}

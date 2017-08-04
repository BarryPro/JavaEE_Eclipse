package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDispDetailEntity;
import com.sitech.acctmgr.atom.domains.bill.FeeCodeBillEntity;
import com.sitech.acctmgr.atom.domains.bill.ItemGroupBillEntity;
import com.sitech.acctmgr.atom.domains.bill.PhoneBillEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillQuery2InDTO;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillQuery2OutDTO;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.bill.IPhoneBill;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.*;

import static org.apache.commons.collections.MapUtils.getDouble;
import static org.apache.commons.collections.MapUtils.getInteger;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2016/12/23.
 */
@ParamTypes({
        @ParamType(c = SPhoneBillQueryInDTO.class, m = "query", oc = SPhoneBillQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_bill_IPhoneBillSvc_query"),
        @ParamType(c = SPhoneBillQuery2InDTO.class, m = "query2", oc = SPhoneBillQuery2OutDTO.class, srvName = "com_sitech_acctmgr_inter_bill_IPhoneBillSvc_query2")
})
public class SPhoneBill extends AcctMgrBaseService implements IPhoneBill {
    private IUser user;
    private IAccount account;
    private IBill bill;
    private IDelay delay;
    private ICust cust;
    private IRecord record;

    @Override
    public OutDTO query(InDTO inParam) {
        SPhoneBillQueryInDTO inDTO = (SPhoneBillQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int begYm = inDTO.getBeginMonth();
        int endYm = inDTO.getEndMonth();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();

        List<PhoneBillEntity> phoneBillList = new ArrayList<>();
        for (int ym = begYm; ym <= endYm; ym = DateUtils.addMonth(ym, 1)) {
            List<ContractEntity> conList = account.getConList(idNo, ym); //获取指定帐期生效的账务关系，只为了查询帐单更准确
            for (ContractEntity conEnt : conList) {
                long conTmp = conEnt.getCon();
                PhoneBillEntity phoneBillEnt = this.getPhoneBillInfo(idNo, conTmp, ym);
                phoneBillEnt.setPhoneNo(phoneNo);
                phoneBillList.add(phoneBillEnt);
            }
        }


        SPhoneBillQueryOutDTO outDTO = new SPhoneBillQueryOutDTO();
        outDTO.setBillList(phoneBillList);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    private PhoneBillEntity getPhoneBillInfo(long idNo, long contractNo, int queryYm) {

        List<BillDispDetailEntity> billDetailList = bill.getAllBillList(idNo, contractNo, queryYm);

        long totalShould = 0;
        long totalFavour = 0;
        long totalPrepay = 0;
        long totalLater = 0;
        long totalOweFee = 0;
        long totalDelayFee = 0;

        for (BillDispDetailEntity billEnt : billDetailList) {
            totalShould += billEnt.getShouldPay();
            totalFavour += billEnt.getFavourFee();
            totalPrepay += billEnt.getPayedPrepay();
            totalLater += billEnt.getPayedLater();
            totalOweFee += billEnt.getOweFee();
        }

        if (totalOweFee > 0) {
            int billBegin = billDetailList.get(0).getBillBegin();

            Map<String, Object> inMap = new HashMap<>();
            safeAddToMap(inMap, "CONTRACT_NO", contractNo);
            Map<String, Object> delayInfo = delay.getDelayRate(inMap);
            int delayBegin = getInteger(delayInfo, "DELAY_BEGIN");
            double delayRate = getDouble(delayInfo, "DELAY_RATE");

            inMap = new HashMap<>();
            safeAddToMap(inMap, "BILL_BEGIN", billBegin);
            safeAddToMap(inMap, "OWE_FEE", totalOweFee);
            safeAddToMap(inMap, "DELAY_BEGIN", delayBegin);
            safeAddToMap(inMap, "DELAY_RATE", delayRate);
            safeAddToMap(inMap, "BILL_CYCLE", queryYm);
            safeAddToMap(inMap, "TOTAL_DATE", DateUtils.getCurDay());
            totalDelayFee = delay.getDelayFee(inMap);

        }

        PhoneBillEntity outPhoneBillEnt = new PhoneBillEntity();
        outPhoneBillEnt.setYearMonth(queryYm);
        outPhoneBillEnt.setContractNo(contractNo);
        outPhoneBillEnt.setPayedLater(totalLater);
        outPhoneBillEnt.setPayedPrepay(totalPrepay);
        outPhoneBillEnt.setShouldPay(totalShould);
        outPhoneBillEnt.setFavourFee(totalFavour);
        outPhoneBillEnt.setOweFee(totalOweFee);
        outPhoneBillEnt.setStatusName(totalOweFee > 0 ? "未缴" : "已缴");
        outPhoneBillEnt.setDelayFee(totalDelayFee);
        outPhoneBillEnt.setDetailList(billDetailList);

        return outPhoneBillEnt;
    }

    @Override
    public OutDTO query2(InDTO inParam) {
        SPhoneBillQuery2InDTO inDTO = (SPhoneBillQuery2InDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int queryYm = inDTO.getYearMonth();

        UserInfoEntity userInfo = user.getUserInfo(phoneNo);
        long idNo = userInfo.getIdNo();
        long conNo = userInfo.getContractNo();
        long custId = userInfo.getCustId();

        CustInfoEntity custInfo = cust.getCustInfo(custId, null);
        String custName = custInfo.getCustName();

        List<FeeCodeBillEntity> billList = this.getFeeCodeBillList(idNo, conNo, queryYm);

        long totalShould = 0;
        long totalFavour = 0;
        long totalDelay = 0;
        long totalOwe = 0;

        int billBegin = queryYm * 100 + 1;
        int billEnt = queryYm * 100 + DateUtils.getLastDayOfMonth(queryYm);
        for (FeeCodeBillEntity fbEnt : billList) {
            totalShould += fbEnt.getShouldPay();
            totalFavour += fbEnt.getFavourFee();
            totalDelay += fbEnt.getDelayFee();
            totalOwe += fbEnt.getOweFee();
        }

        ActQueryOprEntity oprEntity = new ActQueryOprEntity();
        oprEntity.setQueryType("0");
        oprEntity.setOpCode("8138");
        oprEntity.setContactId("");
        oprEntity.setIdNo(idNo);
        oprEntity.setPhoneNo(phoneNo);
        oprEntity.setBrandId(userInfo.getBrandId());
        oprEntity.setLoginNo(inDTO.getLoginNo());
        oprEntity.setLoginGroup(inDTO.getGroupId());
        oprEntity.setProvinceId(inDTO.getProvinceId());
        oprEntity.setRemark("当月话费总额查询");
        record.saveQueryOpr(oprEntity, false);

        SPhoneBillQuery2OutDTO outDTO = new SPhoneBillQuery2OutDTO();
        outDTO.setCustName(custName);
        outDTO.setStatusName(totalOwe > 0 ? "未缴" : "已缴");
        outDTO.setShouldPay(totalShould);
        outDTO.setFavourFee(totalFavour);
        outDTO.setOweFee(totalOwe);
        outDTO.setDelayFee(totalDelay);
        outDTO.setBillBegin(billBegin);
        outDTO.setBillEnd(billEnt);
        outDTO.setDetailList(billList);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    private List<FeeCodeBillEntity> getFeeCodeBillList(long idNo, long contractNo, int queryYm) {

        Map<String, FeeCodeBillEntity> indexMap = new LinkedHashMap<>(); /*存放一级帐目项费用汇总*/

        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "CONTRACT_NO", contractNo);
        Map<String, Object> delayInfo = delay.getDelayRate(inMap);
        int delayBegin = getInteger(delayInfo, "DELAY_BEGIN");
        double delayRate = getDouble(delayInfo, "DELAY_RATE");

        bill.saveMidAllBillFee(contractNo, idNo, queryYm);
        List<ItemGroupBillEntity> billList = bill.getAllBillListDetByItemGroup(contractNo, idNo, queryYm, "B00"); //按帐目项一级查询明细

        long delayFee = 0;
        for (ItemGroupBillEntity billEnt : billList) {
            String acctItemGroup = billEnt.getAcctItemGroup();
            delayFee = 0;

            if (billEnt.getOweFee() > 0) {
                inMap = new HashMap<>();
                safeAddToMap(inMap, "BILL_BEGIN", billEnt.getBillBegin());
                safeAddToMap(inMap, "OWE_FEE", billEnt.getOweFee());
                safeAddToMap(inMap, "DELAY_BEGIN", delayBegin);
                safeAddToMap(inMap, "DELAY_RATE", delayRate);
                safeAddToMap(inMap, "BILL_CYCLE", queryYm);
                safeAddToMap(inMap, "TOTAL_DATE", DateUtils.getCurDay());
                delayFee = delay.getDelayFee(inMap);
            }

            if (indexMap.containsKey(acctItemGroup)) { //相同一级帐目下的不同帐目项
                FeeCodeBillEntity oldEnt = indexMap.get(acctItemGroup);
                oldEnt.setShouldPay(oldEnt.getShouldPay() + billEnt.getShouldPay());
                oldEnt.setFavourFee(oldEnt.getFavourFee() + billEnt.getFavourFee());
                oldEnt.setDelayFee(oldEnt.getDelayFee() + delayFee);
                oldEnt.setOweFee(oldEnt.getOweFee() + billEnt.getOweFee());

            } else {
                FeeCodeBillEntity fbEnt = new FeeCodeBillEntity();
                fbEnt.setFeeCode(acctItemGroup);
                fbEnt.setFeeCodeName(billEnt.getItemGroupName());
                fbEnt.setShouldPay(billEnt.getShouldPay());
                fbEnt.setFavourFee(billEnt.getFavourFee());
                fbEnt.setDelayFee(delayFee);
                fbEnt.setOweFee(billEnt.getOweFee());
                indexMap.put(acctItemGroup, fbEnt);
            }

        }

        List<FeeCodeBillEntity> outList = new ArrayList<>();
        for (String key : indexMap.keySet()) {
            outList.add(indexMap.get(key));
        }

        return outList;

    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }

    public IDelay getDelay() {
        return delay;
    }

    public void setDelay(IDelay delay) {
        this.delay = delay;
    }

    public ICust getCust() {
        return cust;
    }

    public void setCust(ICust cust) {
        this.cust = cust;
    }

    public IRecord getRecord() {
        return record;
    }

    public void setRecord(IRecord record) {
        this.record = record;
    }
}

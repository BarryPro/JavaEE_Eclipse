package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.account.GrpConEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDispDetailEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.GrpBillDispEntity;
import com.sitech.acctmgr.atom.domains.bill.GrpBillKfEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.bill.SGrpBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SGrpBillQueryOutDTO;
import com.sitech.acctmgr.atom.dto.bill.SGrpBillSixQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SGrpBillSixQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.bill.IGrpBill;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2016/11/23.
 */
@ParamTypes({
        @ParamType(c = SGrpBillQueryInDTO.class, m = "query", oc = SGrpBillQueryOutDTO.class),
        @ParamType(c = SGrpBillSixQueryInDTO.class, m = "sixQuery", oc = SGrpBillSixQueryOutDTO.class)
})
public class SGrpBill extends AcctMgrBaseService implements IGrpBill {

    private IUser user;
    private IProd prod;
    private IBill bill;
    private ICust cust;
    private ILogin login;
    private IAccount account;
    private IBalance balance;

    @Override
    public OutDTO query(InDTO inParam) {
        SGrpBillQueryInDTO inDTO = (SGrpBillQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        long unitId = inDTO.getUnitId();
        int yearMonth = inDTO.getYearMonth();

        GrpCustInfoEntity grpCustInfo = cust.getGrpCustInfo(null, unitId);
        long grpCustId = grpCustInfo.getCustId();

        CustInfoEntity custInfo = cust.getCustInfo(grpCustId, null);

        List<UserInfoEntity> grpUserList = user.getGrpUserInfoByUnitId(unitId);
        List<GrpBillDispEntity> grpBillList = new ArrayList<>();
        long totalReal = 0; //集团下产品总费用
        for (UserInfoEntity grpUser : grpUserList) {
            UserPrcEntity grpPrcInfo = prod.getUserPrcidInfo(grpUser.getIdNo(), false);
            if (grpPrcInfo == null) { //未取到主订价的产品不予处理
                continue;
            }

            long grpConTmp = grpUser.getContractNo(); //集团产品的帐户信息

            List<BillDispDetailEntity> billList = bill.getGrpAllBillList(grpConTmp, yearMonth);
            if (billList.isEmpty()) { //过滤没有费用的产品
                continue;
            }
            Map<String, Long> totalFeeMap = this.getSumFee(billList);
            totalReal += totalFeeMap.get("TOTAL_REAL");

            GrpBillDispEntity grpBillDispEnt = new GrpBillDispEntity();
            grpBillDispEnt.setPrcName(grpPrcInfo.getProdPrcName()); //产品的主定价名称
            grpBillDispEnt.setGrpContractNo(grpConTmp);
            grpBillDispEnt.setShouldPay(totalFeeMap.get("TOTAL_SHOULD"));
            grpBillDispEnt.setFavourFee(totalFeeMap.get("TOTAL_FAVOUR"));
            grpBillDispEnt.setRealFee(totalFeeMap.get("TOTAL_REAL"));
            grpBillDispEnt.setDetailList(billList);

            grpBillList.add(grpBillDispEnt);

        }

        String curYmd = String.format("%d", DateUtils.getCurDay());
        String printDate = new StringBuilder()
                .append(curYmd.substring(0, 4)).append("年")
                .append(curYmd.substring(4, 6)).append("月")
                .append(curYmd.substring(6, 8)).append("日").toString();

        int lastDay = DateUtils.getLastDayOfMonth(yearMonth);
        String beginYmd = String.format("%6d01", yearMonth);
        String endYmd = String.format("%6d%2d", yearMonth, lastDay);
        String billRange = new StringBuilder()
                .append(beginYmd.substring(0, 4)).append("年")
                .append(beginYmd.substring(4, 6)).append("月")
                .append(beginYmd.substring(6, 8)).append("日")
                .append("至")
                .append(endYmd.substring(0, 4)).append("年")
                .append(endYmd.substring(4, 6)).append("月")
                .append(endYmd.substring(6, 8)).append("日").toString();

        String staffLogin /*客户经理工号*/ = cust.getGrpContactStaff(grpCustId);
        LoginEntity staffLoginInfo = login.getLoginInfo(staffLogin, inDTO.getProvinceId());

        SGrpBillQueryOutDTO outDTO = new SGrpBillQueryOutDTO();
        outDTO.setCustName(custInfo.getBlurCustName());
        outDTO.setUnitId(unitId);
        outDTO.setBillRange(billRange);
        outDTO.setPrintDate(printDate);
        outDTO.setManagerName(staffLoginInfo.getLoginName());
        outDTO.setManagerPhone(staffLoginInfo.getContactPhone());
        outDTO.setTotalReal(totalReal);
        outDTO.setBillList(grpBillList);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    private Map<String, Long> getSumFee(List<BillDispDetailEntity> billList) {
        long totalShould = 0;
        long totalFavour = 0;
        long totalReal = 0;

        for (BillDispDetailEntity billEnt : billList) {
            totalShould += billEnt.getShouldPay();
            totalFavour += billEnt.getFavourFee();
            totalReal += billEnt.getRealFee();
        }

        Map<String, Long> feeMap = new HashMap<>();
        safeAddToMap(feeMap, "TOTAL_SHOULD", totalShould);
        safeAddToMap(feeMap, "TOTAL_FAVOUR", totalFavour);
        safeAddToMap(feeMap, "TOTAL_REAL", totalReal);
        return feeMap;
    }

    @Override
    public OutDTO sixQuery(InDTO inParam) {
        SGrpBillSixQueryInDTO inDTO = (SGrpBillSixQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        long contractNo = inDTO.getContractNo();
        //非集团用户允许查询
        if (!account.isGrpCon(contractNo)) {
            throw new BusiException(AcctMgrError.getErrorCode("8103", "20005"), "非集团帐户，不能查询集团帐单");
        }

        UserInfoEntity grpUserInfo = user.getUserEntityByConNo(contractNo, true);
        long custId = grpUserInfo.getCustId();
        CustInfoEntity grpCustInfo = cust.getCustInfo(custId, null);
        String custName = grpCustInfo.getCustName();

        long prepayFee = balance.getAcctBookSum(contractNo, null); /*取所有帐本的预存*/
        Map<String, Long> unPayMap = bill.getSumUnpayInfo(contractNo, null, null); //查询帐户所有未缴费用
        long unPayFee = unPayMap.get("OWE_FEE");

        //获取集团帐户的客户ID和用户ID

        List<BillEntity> allList = new ArrayList<>();
        Map<String, GrpBillKfEntity> indexMap = new HashMap<>();
        int curYm = DateUtils.getCurYm();
        for (int i = 1; i <= 6; i++) { //只查询近6个月的集团帐单
            int queryYm = DateUtils.addMonth(curYm, -i);

            List<BillEntity> payedList = bill.getPayedOweGroupById(contractNo, queryYm);
            List<BillEntity> unPayList = bill.getUnPayOweGroupById(contractNo, queryYm);

            allList.addAll(payedList);
            allList.addAll(unPayList);
        }

        for (BillEntity billEnt : allList) {
            String key = billEnt.getIdNo() + "^" + billEnt.getBillCycle();
            if (indexMap.containsKey(key)) {
                GrpBillKfEntity oldGrpBillEnt = indexMap.get(key);
                GrpBillKfEntity newGrpBillEnt = new GrpBillKfEntity(); /*农服集团帐单只使用ShouldPay和FavourFee*/
                newGrpBillEnt.setShouldPay(oldGrpBillEnt.getShouldPay() + billEnt.getShouldPay());
                newGrpBillEnt.setFavourFee(oldGrpBillEnt.getFavourFee() + billEnt.getFavourFee());
            } else {
                GrpBillKfEntity grpBillEnt = new GrpBillKfEntity();
                grpBillEnt.setContractNo(contractNo);
                grpBillEnt.setIdNo(billEnt.getIdNo());
                grpBillEnt.setShouldPay(billEnt.getShouldPay());
                grpBillEnt.setFavourFee(billEnt.getFavourFee());
                grpBillEnt.setPrepayFee(prepayFee);
                grpBillEnt.setOweFee(unPayFee); /*帐户总物理库欠费*/
                grpBillEnt.setBillBegin(billEnt.getBillBegin());
                grpBillEnt.setBillEnd(billEnt.getBillEnd());
                grpBillEnt.setBillCycle(billEnt.getBillCycle());
                grpBillEnt.setCustId(custId);
                grpBillEnt.setCustName(custName);

                UserPrcEntity userPrcEnt = prod.getUserPrcidInfo(billEnt.getIdNo());
                grpBillEnt.setPrcName(userPrcEnt.getProdPrcName());
                grpBillEnt.setPrcId(userPrcEnt.getProdPrcid());
                UserInfoEntity userInfo = user.getUserEntityByIdNo(billEnt.getIdNo(), true);
                grpBillEnt.setPhoneNo(userInfo.getPhoneNo());

                indexMap.put(key, grpBillEnt);
            }

        }

        List<GrpBillKfEntity> billList = new ArrayList<>();
        for (String key : indexMap.keySet()) {
            billList.add(indexMap.get(key));
        }

        SGrpBillSixQueryOutDTO outDTO = new SGrpBillSixQueryOutDTO();
        outDTO.setBillList(billList);

        return outDTO;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }

    public ICust getCust() {
        return cust;
    }

    public void setCust(ICust cust) {
        this.cust = cust;
    }

    public ILogin getLogin() {
        return login;
    }

    public void setLogin(ILogin login) {
        this.login = login;
    }

    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public IBalance getBalance() {
        return balance;
    }

    public void setBalance(IBalance balance) {
        this.balance = balance;
    }
}

package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDisp1LevelEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.S8164QryBillInDTO;
import com.sitech.acctmgr.atom.dto.bill.S8164QryOutBillInfo;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.bill.I8164;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.apache.commons.lang.StringUtils;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.*;

/**
 * Created by wangyla on 2016/6/29.
 */

@ParamTypes({
        @ParamType(c = S8164QryBillInDTO.class, m = "queryBill", oc = S8164QryOutBillInfo.class)
})
public class S8164 extends AcctMgrBaseService implements I8164 {

    private IUser user;
    private IAccount account;
    private IBillDisplayer billDisplayer;
    private ICust cust;
    private IRecord record;
    private ILogin login;

    public OutDTO queryBill(InDTO inParam) {
        S8164QryBillInDTO inDto = (S8164QryBillInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        String phoneNo = inDto.getPhoneNo();
        String queryYM = String.format("%6d", inDto.getYearMonth());
        //String queryType = inDto.getQueryType();
        long contractNo = inDto.getContractNo();

        if (StringUtils.isEmpty(phoneNo) && contractNo <= 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8164", "20001"), "用户和帐户不能同时为空");
        }


        /*
         * 1、物联网查询，非物联网用户不允许查询；
         * 2、神州行未签约用户不能进行查询；sEasyOwn
         * 需要通过物联网号对应的服务号码进行查询；
         */
        String mobilePhoneNo = phoneNo;

        /*if (StringUtils.isNotEmpty(queryType) && !queryType.equalsIgnoreCase("pt") && StringUtils.isNotEmpty(phoneNo)) {
            String nbrType = "";
            if (queryType.equalsIgnoreCase("wlw")) {
                nbrType = CommonConst.NBR_TYPE_WLW;
            } else if (queryType.equalsIgnoreCase("kd")) {
                nbrType = CommonConst.NBR_TYPE_KD; //宽带接入号类型
            }
            mobilePhoneNo = user.getPhoneNoByAsn(phoneNo, nbrType);
        }*/

        Map<String, Object> baseInfo = this.getBaseInfo(mobilePhoneNo, contractNo, inDto.getYearMonth());
        String openDate = getString(baseInfo, "OPEN_DATE");

        if (DateUtils.compare(queryYM, openDate, DateUtils.DATE_FORMAT_YYYYMM) < 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8164", "00003"), "不允许查询开户前的数据");
        }

        long idNo = 0;
        if (baseInfo.containsKey("ID_NO")) {
            idNo = getLongValue(baseInfo, "ID_NO"); //得确认
        }

        //调用组件 getSevenBill3Level 来获取用户的三级帐单列表
        List<BillDisp1LevelEntity> billDisp1List = billDisplayer.getBill3sLevelList(idNo, contractNo, inDto.getYearMonth());
        Map<String, Long> feeMap = this.getTotalFees(billDisp1List);

        this.saveQueryOprLog(phoneNo, (idNo <= 0 ? contractNo : idNo), inDto.getLoginNo(), inDto.getYearMonth(), getString(baseInfo, "BRAND_ID"), inDto.getProvinceId());

        Collections.sort(billDisp1List, new BillDisp1LevelEntity());

        S8164QryOutBillInfo outDto = new S8164QryOutBillInfo();
        outDto.setDetailList(billDisp1List);
        outDto.setPhoneNo(mobilePhoneNo);
        outDto.setBrandName(getString(baseInfo, "BRAND_NAME"));
        outDto.setCustName(getString(baseInfo, "CUST_NAME"));
        outDto.setContractNo(getLongValue(baseInfo, "CONTRACT_NO"));
        outDto.setBillRange(getString(baseInfo, "BILL_RANGE"));
        outDto.setShouldPay(feeMap.get("SHOULD_PAY"));
        outDto.setFavourFee(feeMap.get("FAVOUR_FEE"));
        outDto.setRealFee(feeMap.get("REAL_FEE"));

        log.debug("outDto=" + outDto.toJson());
        return outDto;

    }

    private Map<String, Object> getBaseInfo(String phoneNo, Long contractNo, int queryYM) {

        Map<String, Object> outMap = new HashMap<>(); /*存放返回值*/
        long custId = 0;
        String brandName = "--";
        String openDate = "";
        if (StringUtils.isNotEmpty(phoneNo)) {
            UserInfoEntity userInfo = user.getUserEntity(null, phoneNo, null, true);
            long idNo = userInfo.getIdNo();
            custId = userInfo.getCustId();
            openDate = userInfo.getOpenTime();
            contractNo = userInfo.getContractNo();

            UserBrandEntity brandInfo = user.getUserBrandRel(idNo);
            brandName = brandInfo.getBrandName();

            safeAddToMap(outMap, "BRAND_ID", brandInfo.getBrandId());
            safeAddToMap(outMap, "ID_NO", idNo);
        } else {
            ContractEntity conInfo = account.getUserList(contractNo).get(0);
            custId = conInfo.getCustId();
            openDate = conInfo.getEffDate();
        }

        CustInfoEntity custInfo = cust.getCustInfo(custId, null);

        int lastDay = DateUtils.getLastDayOfMonth(queryYM);
        String beginDate = String.format("%4d年%02d月01日", queryYM / 100, queryYM % 100);
        String endDate = String.format("%4d年%02d月%02d日", queryYM / 100, queryYM % 100, lastDay);
        StringBuilder sb = new StringBuilder();
        sb.append(beginDate).append("-").append(endDate);

        safeAddToMap(outMap, "BRAND_NAME", brandName);
        safeAddToMap(outMap, "CUST_NAME", custInfo.getBlurCustName());
        safeAddToMap(outMap, "BILL_RANGE", sb.toString());
        safeAddToMap(outMap, "OPEN_DATE", openDate);
        safeAddToMap(outMap, "CONTRACT_NO", contractNo);


        return outMap;
    }

    private Map<String, Long> getTotalFees(List<BillDisp1LevelEntity> billDisp1List) {
        long shouldPay = 0;
        long favourFee = 0;
        long realFee = 0;
        for (BillDisp1LevelEntity billDispEnt : billDisp1List) {
            shouldPay += billDispEnt.getShouldPay();
            favourFee += billDispEnt.getFavourFee();
            realFee += billDispEnt.getRealFee();
        }

        Map<String, Long> outMap = new HashMap<>();
        safeAddToMap(outMap, "SHOULD_PAY", shouldPay);
        safeAddToMap(outMap, "FAVOUR_FEE", favourFee);
        safeAddToMap(outMap, "REAL_FEE", realFee);

        return outMap;
    }

    private void saveQueryOprLog(String phoneNo, long idNo, String loginNo, int yearMonth, String brandID, String proviceId) {
        LoginEntity result = login.getLoginInfo(loginNo, proviceId);

        StringBuilder buffer = new StringBuilder();
        buffer.append(loginNo);
        buffer.append("打印用户");
        buffer.append(phoneNo + "[");
        buffer.append(yearMonth);
        buffer.append("]帐单");

        ActQueryOprEntity oprEntity = new ActQueryOprEntity();
        oprEntity.setLoginGroup(result.getGroupId());
        oprEntity.setQueryType("0");
        oprEntity.setOpCode("8164");
        oprEntity.setContactId("");
        oprEntity.setIdNo(idNo);
        oprEntity.setPhoneNo(phoneNo);
        oprEntity.setBrandId(brandID);
        oprEntity.setLoginNo(loginNo);
        oprEntity.setProvinceId(proviceId);
        oprEntity.setRemark(buffer.toString());
        record.saveQueryOpr(oprEntity, false);
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

    public IBillDisplayer getBillDisplayer() {
        return billDisplayer;
    }

    public void setBillDisplayer(IBillDisplayer billDisplayer) {
        this.billDisplayer = billDisplayer;
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

    public ILogin getLogin() {
        return login;
    }

    public void setLogin(ILogin login) {
        this.login = login;
    }
}

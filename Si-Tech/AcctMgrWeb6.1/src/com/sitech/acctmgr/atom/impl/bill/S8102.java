package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.bill.SevenBillDispEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.bill.S8102QryBillDetailInDTO;
import com.sitech.acctmgr.atom.dto.bill.S8102QryBillDetailOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.bill.I8102;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.StringUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2016/6/22.
 */
@ParamTypes({
        @ParamType(c = S8102QryBillDetailInDTO.class, m = "queryBillDetail", oc = S8102QryBillDetailOutDTO.class)
})
public class S8102 extends AcctMgrBaseService implements I8102 {
    private static final String SPECIL_SERVICE_FEE_CODE = "0B";
    private static final String MESSAGE_FEE_CODE = "0N";
    private IUser user;
    private IBillDisplayer billDisplayer;
    private IProd prod;
    private IRecord record;

    @Override
    public OutDTO queryBillDetail(InDTO inParam) {
        S8102QryBillDetailInDTO inDto = (S8102QryBillDetailInDTO) inParam;
        log.debug("inDTO=" + inDto.getMbean());

        String phoneNo = inDto.getPhoneNo();
        long contractNo = inDto.getContractNo();
        UserInfoEntity userInfoEnt = user.getUserInfo(phoneNo);
        long idNo = userInfoEnt.getIdNo();
        if (contractNo == 0) {
            contractNo = userInfoEnt.getContractNo();
        }
        String queryType = inDto.getBillQueryType();
        String queryTypeName = "所有帐单";

        String feeCode = "";
        if (StringUtils.isEmpty(queryType) || !queryType.equalsIgnoreCase("all")) {
            if (queryType.equalsIgnoreCase("tf")) { //只查询特服费用
                feeCode = SPECIL_SERVICE_FEE_CODE;
                queryTypeName = "特服费";
            } else if (queryType.equalsIgnoreCase("xxf")) {//只查询信息费
                feeCode = MESSAGE_FEE_CODE;
                queryTypeName = "信息费";
            }
        } else {
            queryType = "all";
        }

        UserPrcEntity userPrcInfo = prod.getUserPrcidInfo(idNo, false);
        String prcName = (userPrcInfo == null) ? "未知" : userPrcInfo.getProdPrcName();
        /*
        * 按七大类将费用查询出来，
        * 并且每个大类下存放该大类的二级明细信息
        */
        int yearMonth = inDto.getYearMonth();
        long shouldPayTotal = 0;
        long favourFeeTotal = 0;
        long payedPrepayTotal = 0;
        long payedLaterTotal = 0;
        long oweFeeTotal = 0;
        List<SevenBillDispEntity> sevenBillList = new ArrayList<>();
        if (yearMonth/100 > 2014) {
            sevenBillList = billDisplayer.getSevenBill(idNo, contractNo, yearMonth, feeCode);
            for (SevenBillDispEntity billEnt : sevenBillList) {
                shouldPayTotal += billEnt.getShouldPay();
                favourFeeTotal += billEnt.getFavourFee();
                payedLaterTotal += billEnt.getPayedPrepay();
                payedLaterTotal += billEnt.getPayedLater();
                oweFeeTotal += billEnt.getOweFee();
            }
        }

        ActQueryOprEntity actQryOprEntity = new ActQueryOprEntity();
        actQryOprEntity.setBrandId(userInfoEnt.getBrandId());
        actQryOprEntity.setIdNo(idNo);
        actQryOprEntity.setContactId(String.format("%d", contractNo));
        actQryOprEntity.setLoginGroup(inDto.getGroupId());
        actQryOprEntity.setLoginNo(inDto.getLoginNo());
        actQryOprEntity.setOpCode("8102");
        actQryOprEntity.setPhoneNo(phoneNo);
        actQryOprEntity.setQueryType(queryType.toLowerCase());
        actQryOprEntity.setRemark(new StringBuilder()
                .append("查询用户").append(queryTypeName).append("费用").toString());
        actQryOprEntity.setProvinceId(inDto.getProvinceId());
        actQryOprEntity.setHeader(inDto.getHeader());
        record.saveQueryOpr(actQryOprEntity, true);

        S8102QryBillDetailOutDTO outDto = new S8102QryBillDetailOutDTO();
        outDto.setPhoneNo(phoneNo);
        outDto.setContractNo(contractNo);
        outDto.setYearMonth(yearMonth);
        outDto.setQueryType(queryTypeName);
        outDto.setMainPrcName(prcName);
        outDto.setTotalShould(shouldPayTotal);
        outDto.setTotalFavFee(favourFeeTotal);
        outDto.setTotalRealFee(shouldPayTotal - favourFeeTotal);
        outDto.setTotalOweFee(oweFeeTotal);
        outDto.setBillInfoList(sevenBillList);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IBillDisplayer getBillDisplayer() {
        return billDisplayer;
    }

    public void setBillDisplayer(IBillDisplayer billDisplayer) {
        this.billDisplayer = billDisplayer;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }

    public IRecord getRecord() {
        return record;
    }

    public void setRecord(IRecord record) {
        this.record = record;
    }
}

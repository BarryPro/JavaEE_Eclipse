package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.SFamBillUnbillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SFamBillUnbillQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.bill.IFamBill;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.List;

/**
 * Created by wangyla on 2017/2/10.
 */
@ParamTypes({
        @ParamType(c = SFamBillUnbillQueryInDTO.class, m = "unbillQuery", oc = SFamBillUnbillQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_bill_IFamBillSvc_unbillQuery")
})
public class SFamBill extends AcctMgrBaseService implements IFamBill {

    private IUser user;
    private IBillAccount billAccount;
    private IAccount account;
    private IBill bill;

    @Override
    public OutDTO unbillQuery(InDTO inParam) {
        SFamBillUnbillQueryInDTO inDTO = (SFamBillUnbillQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        long contractNo = userInfo.getContractNo();

        /*判断付费人是底线还是融合*/
        String dxFlag = billAccount.getGroupDxFlag(idNo);

        long payUnbillFee = 0; /*付费人未出帐话费*/
        long netUnbillFee = 0; /*家庭宽带未出帐话费*/
        long famUnbillFee = 0; /*家庭用户未出帐话费*/

        if (!phoneNo.startsWith("202")) { /*虚拟号码不查询内存帐单*/
            List<ContractEntity> userList = account.getUserList(contractNo);
            for (ContractEntity conEnt : userList) {
                long idNoTmp = conEnt.getId();
                UnbillEntity unbillInfo = bill.getUnbillFee(contractNo, idNoTmp, CommonConst.UNBILL_TYPE_BILL_TOT); //需要查询综合帐单
                if (idNo == idNoTmp) {
                    payUnbillFee = unbillInfo.getUnBillFee(); /*付费用户（家长），不产生帐单*/
                } else {
                    UserInfoEntity userInfoTmp = user.getUserEntityByIdNo(idNoTmp, false);
                    if (userInfoTmp == null) {
                        continue;
                    }

                    String phoneNoTmp = userInfoTmp.getPhoneNo();
                    if (phoneNoTmp.startsWith("209")) {
                        netUnbillFee = unbillInfo.getUnBillFee(); /*宽带用户*/
                    } else if (phoneNoTmp.startsWith("207")) {
                        famUnbillFee = unbillInfo.getUnBillFee(); /*共享用户*/
                    }
                }

            }

        } else {
            log.debug("查询号码为虚拟集团号码,不做查询处理！");
        }

        SFamBillUnbillQueryOutDTO outDTO = new SFamBillUnbillQueryOutDTO();
        outDTO.setDxFlag(dxFlag);
        outDTO.setPayUnbillFee(netUnbillFee + famUnbillFee);
        outDTO.setFamUnbillFee(famUnbillFee);
        outDTO.setNetUnbillFee(netUnbillFee);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IBillAccount getBillAccount() {
        return billAccount;
    }

    public void setBillAccount(IBillAccount billAccount) {
        this.billAccount = billAccount;
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
}

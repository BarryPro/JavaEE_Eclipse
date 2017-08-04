package com.sitech.acctmgr.atom.impl.feeqry;

import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SFeeQryIsPayAndExpenseInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SFeeQryIsPayAndExpenseOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.IFeeQry;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
 * Created by qiaolin
 */
@ParamTypes({
        @ParamType(c = SFeeQryIsPayAndExpenseInDTO.class, m = "isPayAndExpense", oc = SFeeQryIsPayAndExpenseOutDTO.class)
})
public class SFeeQry extends AcctMgrBaseService implements IFeeQry {
    private IUser user;
    private IRecord record;
    private IBill bill;

    public OutDTO isPayAndExpense(InDTO inParam) {

        //入参DTO
        SFeeQryIsPayAndExpenseInDTO inDto = (SFeeQryIsPayAndExpenseInDTO) inParam;
        String sOpenTime = inDto.getOpenTime();
        String sOpenSn = inDto.getOpenSn();
        String sOpenOpCode = inDto.getOpenOpCode();
        String sOpCode = inDto.getOpCode();

        //取当前时间
        int iCurYm = DateUtils.getCurYm();
        int iCurDate = DateUtils.getCurDay();

        if (Integer.parseInt(sOpenTime) > iCurDate) {
            throw new BusiException(AcctMgrError.getErrorCode(sOpCode, "00001"), "开户时间不能大于当前时间!");
        }

        //开户年月
        int iOpenYm = 0;
        iOpenYm = Integer.parseInt(sOpenTime) / 100;

        //取用户默认账户
        UserInfoEntity userEntity = user.getUserEntityByPhoneNo(inDto.getPhoneNo(), true);

        long lRealPay = 0;
        long lPayFee = 0;
        for (int iOneYm = iOpenYm; iOneYm <= iCurYm; iOneYm = DateUtils.addMonth(iOneYm, 1)) {
            //取用户消费金额
            lRealPay += bill.getRealFee(userEntity.getIdNo(), userEntity.getContractNo(), iOneYm);

            //取开户后缴费金额
            lPayFee += record.getSumPayFee(userEntity.getContractNo(), iOneYm, sOpenOpCode, sOpenSn);
        }

        //判断是否消费过
        int iIsExpense = 0;
        if (lRealPay > 0) {
            iIsExpense = 1;
        }
        //判断是否缴费
        int iIsPay = 0;
        if (lPayFee != 0) {
            iIsPay = 1;
        }

        SFeeQryIsPayAndExpenseOutDTO out = new SFeeQryIsPayAndExpenseOutDTO();
        out.setIsPay(iIsPay);
        out.setIsExpense(iIsExpense);
        out.setRealPay(lRealPay);
        out.setPayFee(lPayFee);

        return out;
    }


    public IRecord getRecord() {
        return record;
    }

    public void setRecord(IRecord record) {
        this.record = record;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }
}

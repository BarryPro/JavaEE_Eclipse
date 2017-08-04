package com.sitech.acctmgr.atom.impl.bill;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillInfoDispEntity;
import com.sitech.acctmgr.atom.domains.bill.BroadBillEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.SBroadBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SBroadBillQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.bill.IBroadBill;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/22.
 */
@ParamTypes({
        @ParamType(c = SBroadBillQueryInDTO.class, m = "query", oc = SBroadBillQueryOutDTO.class)
})
public class SBroadBill extends AcctMgrBaseService implements IBroadBill {
    private IUser user;
    private IBill bill;

    @Override
    public OutDTO query(InDTO inParam) {
    	SBroadBillQueryInDTO inDTO = (SBroadBillQueryInDTO) inParam;
        log.debug("inDTO=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        
        UserInfoEntity userInfoEnt = user.getUserEntityByPhoneNo(phoneNo, true);
        long contractNo = userInfoEnt.getContractNo();
        int curYM = DateUtils.getCurYm();

        //循环 查询近6月
        List<BroadBillEntity> boardBillList = new ArrayList<BroadBillEntity>();
        int billCycle = 0;
        long shouldPay = 0;
        long favourFee = 0;
        long payedPrepay = 0;
        long payedLater = 0;
        long oweFee = 0;
        String status = "";
        String itemName = "";
        long delayFee = 0;
        
        for(int i = 1; i < 7; i++){
        	
    		int queryYM = DateUtils.addMonth(curYM, -i);
    		
    		//获取已冲销滞纳金
    		delayFee = bill.getPayedDelayFee(contractNo, queryYM);
    		
    		//已缴清
    		List<BillInfoDispEntity> broadPayedBillList = bill.getPayedBillList(contractNo, queryYM);
    		for (BillInfoDispEntity billInfoDispEnt : broadPayedBillList) {
    			
    			billCycle = billInfoDispEnt.getBillCycle();
    			shouldPay = billInfoDispEnt.getShouldPay();
    			favourFee = billInfoDispEnt.getFavourFee();
    			payedPrepay = billInfoDispEnt.getPayedPrepay();
    			payedLater = billInfoDispEnt.getPayedLater();
    			oweFee = billInfoDispEnt.getOweFee();
    			status = billInfoDispEnt.getStatus();
    			itemName = billInfoDispEnt.getItemName();
    			
    			BroadBillEntity broadBillEnt = new BroadBillEntity();
    			
    			broadBillEnt.setPayedDelay(delayFee);
    			broadBillEnt.setBillCycle(billCycle);
    			broadBillEnt.setFavourFee(favourFee);
    			broadBillEnt.setItemName(itemName);
    			broadBillEnt.setOweFee(oweFee);
    			broadBillEnt.setPayedLater(payedLater);
    			broadBillEnt.setPayedPrepay(payedPrepay);
    			broadBillEnt.setShouldPay(shouldPay);
    			broadBillEnt.setStatus(status);
    			
    			boardBillList.add(broadBillEnt);
			}
    		
    		//未缴清
    		List<BillInfoDispEntity> broadUnpayBillList = bill.getUnpayBillList(contractNo, queryYM);
    		for (BillInfoDispEntity billInfoDispEnt : broadUnpayBillList) {
    			billCycle = billInfoDispEnt.getBillCycle();
    			shouldPay = billInfoDispEnt.getShouldPay();
    			favourFee = billInfoDispEnt.getFavourFee();
    			payedPrepay = billInfoDispEnt.getPayedPrepay();
    			payedLater = billInfoDispEnt.getPayedLater();
    			oweFee = billInfoDispEnt.getOweFee();
    			status = billInfoDispEnt.getStatus();
    			itemName = billInfoDispEnt.getItemName();
    			
    			BroadBillEntity broadBillEnt = new BroadBillEntity();
    			
    			broadBillEnt.setPayedDelay(delayFee);
    			broadBillEnt.setBillCycle(billCycle);
    			broadBillEnt.setFavourFee(favourFee);
    			broadBillEnt.setItemName(itemName);
    			broadBillEnt.setOweFee(oweFee);
    			broadBillEnt.setPayedLater(payedLater);
    			broadBillEnt.setPayedPrepay(payedPrepay);
    			broadBillEnt.setShouldPay(shouldPay);
    			broadBillEnt.setStatus(status);
    			
    			boardBillList.add(broadBillEnt);
			}
    		
    	}

        SBroadBillQueryOutDTO outDTO = new SBroadBillQueryOutDTO();
        outDTO.setBroadBillList(boardBillList);
        
        log.debug("outDTO=" + outDTO.toJson());
        return outDTO;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

}

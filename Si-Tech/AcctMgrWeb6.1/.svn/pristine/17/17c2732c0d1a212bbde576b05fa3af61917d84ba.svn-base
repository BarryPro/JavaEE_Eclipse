package com.sitech.acctmgr.atom.impl.free;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.bill.Fav1860CfgEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.free.SMonthFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SMonthFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.free.IMonthFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/22.
 */
@ParamTypes({@ParamType(c = SMonthFreeQueryInDTO.class, m = "query", oc = SMonthFreeQueryOutDTO.class)})
public class SMonthFree extends AcctMgrBaseService implements IMonthFree {

	private IUser user;
	private IFreeDisplayer freeDisplayer;
	private IBillAccount billAccount;
	private IGroup group;
	private IProd prod;
	private IBill bill;
	
    @Override
    public OutDTO query(InDTO inParam){
        SMonthFreeQueryInDTO inDTO = (SMonthFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        String userGroupId = userInfo.getGroupId();
        long contractNo = userInfo.getContractNo();
        
        ChngroupRelEntity regionInfo = group.getRegionDistinct(userGroupId, "2", inDTO.getProvinceId());
        String regionCode = regionInfo.getRegionCode();
        
        UserPrcEntity mainPrcInfo = prod.getUserPrcidInfo(idNo, true);
        String prcId = mainPrcInfo.getProdPrcid();
        String halfFlag = mainPrcInfo.getHalfFlag();
        
        Fav1860CfgEntity fav1860CfgEnt = billAccount.getFavInfo(ValueUtils.longValue(regionCode), prcId, "1");
        long favCall = fav1860CfgEnt.getFavCall();
        long favSave2 = fav1860CfgEnt.getFavSave();
        
        long totalFavFee = favCall;
        long monthFee = 0;
        
        if("1".equals(halfFlag)){
        	monthFee = favSave2 / 2;
        } else {
        	monthFee = favSave2;
        }
        
        UnbillEntity unbillInfo = bill.getUnbillFee(contractNo, idNo, CommonConst.UNBILL_TYPE_BILL_TOT);
        long favourFee = unbillInfo.getFavourFee();
        long favourLeftFee = 0;

        List<FreeMinBill> freeList = freeDisplayer.getFreeDetailList(phoneNo, DateUtils.getCurYm(), "0");
        Map<String, Long> freeMap = freeDisplayer.getFreeTotalMap(freeList);
        
        if(totalFavFee == 0){
        	favourFee = 0;
        	favourLeftFee = 0;
        } else {
        	if ((totalFavFee - monthFee - favourFee) > 0)
	       	{
             favourLeftFee = totalFavFee - monthFee- favourFee;
            }
         else
         	{
   		       favourFee = totalFavFee;
   		       favourLeftFee = 0;
            }
        }
        
        if ((favourFee + favourLeftFee) != totalFavFee)
	      {
		       favourFee = totalFavFee - favourLeftFee;
	      }
        
        SMonthFreeQueryOutDTO outDTO = new SMonthFreeQueryOutDTO();
        outDTO.setTotalFee(totalFavFee);
        outDTO.setUsedFee(favourFee);
        outDTO.setRemainFee(favourLeftFee);
        outDTO.setSmsTotal(freeMap.get("SMS_TOTAL"));
        outDTO.setSmsUsed(freeMap.get("SMS_USED"));
        outDTO.setSmsRemain(freeMap.get("SMS_REMAIN"));
        outDTO.setTimeTotal(freeMap.get("VOICE_TOTAL"));
        outDTO.setTimeUsed(freeMap.get("VOICE_USED"));
        outDTO.setTimeRemain(freeMap.get("VOICE_REMAIN"));

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
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

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
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
	
}

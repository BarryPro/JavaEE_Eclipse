package com.sitech.acctmgr.atom.impl.free;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.bill.Fav1860CfgEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.free.SZeroFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SZeroFreeQueryOutDTO;
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
import com.sitech.acctmgr.inter.free.IZeroFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 功能：0月租优惠信息查询
 * Created by wangyla on 2016/7/22.
 */
@ParamTypes({@ParamType(c = SZeroFreeQueryInDTO.class, m = "query", oc = SZeroFreeQueryOutDTO.class)})
public class SZeroFree extends AcctMgrBaseService implements IZeroFree {

	private IUser user;
	private IGroup group;
	private IProd prod;
	private IFreeDisplayer freeDisplayer;
    private IBill bill;
    private IBillAccount billAccount;
	
    @Override
    public OutDTO query(InDTO inParam){
        SZeroFreeQueryInDTO inDTO = (SZeroFreeQueryInDTO) inParam;
        log.debug("inDto=" +inDTO.getMbean());
        
        String phoneNo = inDTO.getPhoneNo();
        
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        long contractNo = userInfo.getContractNo();
        int curYm = DateUtils.getCurYm();
        String userGroupId = userInfo.getGroupId();
        
        ChngroupRelEntity regionInfo = group.getRegionDistinct(userGroupId, "2", inDTO.getProvinceId());
        String regionCode = regionInfo.getRegionCode();
        
        UserPrcEntity mainPrcInfo = prod.getUserPrcidInfo(idNo, true);
        String prcId = mainPrcInfo.getProdPrcid();

        Fav1860CfgEntity fav1860CfgEnt = billAccount.getFavInfo(ValueUtils.longValue(regionCode), prcId, "5");
        long favCall = fav1860CfgEnt.getFavCall();
        long favSave1 = fav1860CfgEnt.getFavSave();
        
        Map<String, Long> dxFeeMaps = this.getDxFees(contractNo, idNo);
        long dxTotal = dxFeeMaps.get("DX_TOTAL");
        long dxUsed = dxFeeMaps.get("DX_USED");
        long dxLeft = dxFeeMaps.get("DX_REMAIN");
        
        
        if(favCall > 0){
            
            List<FreeMinBill> freeList = freeDisplayer.getFreeDetailList(phoneNo, curYm, "0");
            Map<String, Long> freeMap = freeDisplayer.getFreeTotalMap(freeList);
            
            long voiceTotal = freeMap.get("VOICE_TOTAL"); 
            long voiceUsed = freeMap.get("VOICE_USED");
            long voiceRemain = voiceTotal - voiceUsed;
            
        	dxTotal = favCall * favSave1;
        	if(voiceRemain > 0){
        		dxUsed = (favCall - voiceRemain) *favSave1;
        		dxLeft = voiceRemain * favSave1;
        	} else {
        		dxUsed = dxTotal;
        		dxLeft = 0;
        	}
        } else {
        	UnbillEntity unbillInfo = bill.getUnbillFee(contractNo, idNo, CommonConst.UNBILL_TYPE_BILL_TOT);
            long actualFee = unbillInfo.getShouldPay() - unbillInfo.getFavourFee();
        	dxTotal = actualFee;
        	dxUsed = actualFee - dxLeft;
        }
        
        SZeroFreeQueryOutDTO outDTO = new SZeroFreeQueryOutDTO();
        outDTO.setTotalFee(dxTotal);
        outDTO.setBaseConsumeFee(dxUsed);
        outDTO.setBaseRemainFee(dxLeft);
        
        return outDTO;
    }

    private Map<String, Long> getDxFees(long conNo, long idNo) {
        long dxLeft = 0;
        long dxTotal = 0;
        long dxUsed = 0;
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
    
    public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

}

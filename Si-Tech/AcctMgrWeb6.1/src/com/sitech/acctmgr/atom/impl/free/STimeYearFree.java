package com.sitech.acctmgr.atom.impl.free;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.free.STimeYearFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.STimeYearFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.ITimeYearFree;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({@ParamType(c = STimeYearFreeQueryInDTO.class, m = "query", oc = STimeYearFreeQueryOutDTO.class)})
public class STimeYearFree extends AcctMgrBaseService implements ITimeYearFree {

    private IUser user;
    private IFreeDisplayer freeDisplayer;
    private IProd prod;

    @Override
    public OutDTO query(InDTO inParam) {
    	STimeYearFreeQueryInDTO inDTO = (STimeYearFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        double favRate = inDTO.getFavRate();
        String favCall = inDTO.getFavCall();
        String prcId = inDTO.getPrcId();
        
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        
        UserPrcEntity upe = prod.getUserPrcidInfo(idNo);
        if(!prcId.equals(upe.getProdPrcid())){
        	throw new BusiException(AcctMgrError.getErrorCode("0000", "20014"), "查询产品主资费错误！");
        }
        
        String expDate = upe.getExpDate();

        List<FreeMinBill> freeList = freeDisplayer.getFreeDetailList(phoneNo, DateUtils.getCurYm(), "1");
        
        Map<String, Long> freeMap  = freeDisplayer.getFreeTotalMap(freeList);
        
        long timeTotal = freeMap.get("VOICE_TOTAL");
        long timeUsed = freeMap.get("VOICE_USED");
        long timeRemain = freeMap.get("VOICE_REMAIN");
        long totalFee = Long.parseLong(favCall);
        long remainFee = Math.round(timeRemain * favRate * 100);
        
        STimeYearFreeQueryOutDTO outDTO = new STimeYearFreeQueryOutDTO();
        outDTO.setTotalFee(totalFee);
        outDTO.setRemainFee(remainFee);
        outDTO.setUsedFee(totalFee - remainFee);
        outDTO.setExpDate(expDate);

        outDTO.setTimeTotal(timeTotal);
        outDTO.setTimeUsed(timeUsed);
        outDTO.setTimeRemain(timeRemain);

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

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}
}

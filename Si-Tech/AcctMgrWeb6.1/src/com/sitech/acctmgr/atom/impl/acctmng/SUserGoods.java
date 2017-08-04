package com.sitech.acctmgr.atom.impl.acctmng;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.dto.acctmng.SUserGoodsInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SUserGoodsOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.acctmng.IUserGoods;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "dataSyn", c = SUserGoodsInDTO.class, oc = SUserGoodsOutDTO.class)
})
public class SUserGoods extends AcctMgrBaseService implements IUserGoods{

	protected IBillAccount billAccount;
	
	@Override
	public OutDTO dataSyn(InDTO inParam) {
		SUserGoodsInDTO inDTO = (SUserGoodsInDTO)inParam;
		 log.debug("inDTO=" + inDTO.getMbean());

		 long goodsinsId = inDTO.getGoodsinsId();
		 long idNo = inDTO.getIdNo();
		 String prcId = inDTO.getPrcId();
		 String effDate = inDTO.getEffDate();
	     String expDate = inDTO.getExpDate();
	     String opTime = inDTO.getOpTime();
	     
	     Map<String, Object> inMap = new HashMap<String, Object>();
	     
    	 inMap.put("GOODSINS_ID", goodsinsId);
	     inMap.put("ID_NO", idNo);
	     inMap.put("PRC_ID", prcId);
	     inMap.put("EFF_DATE", effDate);
	     inMap.put("EXP_DATE", expDate);
	     inMap.put("OP_TIME", opTime);
	     
    	 billAccount.saveUserGoodsZFYQ(inMap);
	   
	    SUserGoodsOutDTO outDTO = new SUserGoodsOutDTO();
	    log.debug("outDTO=" + outDTO.toJson());
		return outDTO;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}
	
}

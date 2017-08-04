package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.CardQueryEntity;
import com.sitech.acctmgr.atom.domains.pay.PayInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.PosPayEntity;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title: 充值卡缴费查询入参DTO  </p>
 * <p>Description: 缴费确认入参DTO  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8025QueryInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.CARD_LIST",cons=ConsType.PLUS,type="complex",len="1",desc="充值卡号列表",memo="略")
	private	List<CardQueryEntity>	cardList = new ArrayList<CardQueryEntity>();
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		//payList = (List<Map<String, Object>>)arg0.getBodyList("BUSI_INFO.PAY_LIST");
		List<Map<String, Object>> cardListTmp = (List<Map<String, Object>>)arg0.getList(getPathByProperName("cardList"));
		for(Map<String, Object> payTmp : cardListTmp){
    		String jsonStr = JSON.toJSONString(payTmp);
    		this.cardList.add(JSON.parseObject(jsonStr, CardQueryEntity.class));
    		
		}

	}

	public List<CardQueryEntity> getCardList() {
		return cardList;
	}

	public void setCardList(List<CardQueryEntity> cardList) {
		this.cardList = cardList;
	}

}

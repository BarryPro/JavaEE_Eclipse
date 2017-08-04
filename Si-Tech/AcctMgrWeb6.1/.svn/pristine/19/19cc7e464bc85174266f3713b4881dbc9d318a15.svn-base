package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.CardQueryOutEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 缴费确认出参DTO  </p>
 * <p>Description: 缴费确认出参DTO，封装出参结果  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class S8025QueryOutDTO extends CommonOutDTO {

	@JSONField(name="CARDPAY_LIST")
	@ParamDesc(path="CARDPAY_LIST",cons=ConsType.STAR,type="complex",len="1",desc="充值卡缴费列表",memo="略")
	private	List<CardQueryOutEntity> cardPayList = new ArrayList<CardQueryOutEntity>();
	
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("cardPayList"), cardPayList);
		
		return result;
	}

	public List<CardQueryOutEntity> getCardPayList() {
		return cardPayList;
	}

	public void setCardPayList(List<CardQueryOutEntity> cardPayList) {
		this.cardPayList = cardPayList;
	}

}

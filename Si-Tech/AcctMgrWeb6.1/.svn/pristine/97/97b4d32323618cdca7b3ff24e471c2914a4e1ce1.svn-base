package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 充值卡号对象  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class CardQueryEntity implements Serializable{

	@JSONField(name = "CARD_SN")
	@ParamDesc(path="CARD_SN",cons=ConsType.CT001,type="String",len="40",desc="充值卡号",memo="略")
	private String cardSn;

	@Override
	public String toString() {
		return "CardQueryEntity [cardSn=" + cardSn + "]";
	}

	public String getCardSn() {
		return cardSn;
	}

	public void setCardSn(String cardSn) {
		this.cardSn = cardSn;
	}


}

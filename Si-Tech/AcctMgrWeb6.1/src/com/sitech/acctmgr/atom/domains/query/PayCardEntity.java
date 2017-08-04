package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title:  充值卡信息实体 </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public class PayCardEntity {

	@JSONField(serialize =false)
	@ParamDesc(path = "CARD_SN", cons = ConsType.QUES, type = "String", len = "60", desc = "卡类缴费外部流水", memo = "略")
	protected String cardSn;

	@JSONField(serialize =false)
	@ParamDesc(path = "PAY_TYPE", cons = ConsType.QUES, type = "String", len = "5", desc = "账本类型", memo = "略")
	protected String payType;

	@JSONField(serialize =false)
	@ParamDesc(path = "PAY_SN", cons = ConsType.QUES, type = "long", len = "14", desc = "缴费流水", memo = "略")
	protected long paySn;

	@JSONField(serialize =false)
	@ParamDesc(path = "TOTAL_DATE", cons = ConsType.QUES, type = "int", len = "8", desc = "缴费日期", memo = "略")
	protected int totalDate;

	@JSONField(serialize =false)
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "操作工号", memo = "略")
	protected String loginNo;

	@JSONField(serialize =false)
	@ParamDesc(path = "DEAL_MONTH", cons = ConsType.QUES, type = "String", len = "2", desc = "处理日期", memo = "略")
	protected String dealMonth;

	public String getCardSn() {
		return cardSn;
	}

	public void setCardSn(String cardSn) {
		this.cardSn = cardSn;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getDealMonth() {
		return dealMonth;
	}

	public void setDealMonth(String dealMonth) {
		this.dealMonth = dealMonth;
	}

}

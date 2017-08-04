package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 托收电子回执单账户信息实体
 * 
 */
public class CollAcctConEntity {
    @JSONField(name = "REC_SEQ")
    @ParamDesc(path = "REC_SEQ", cons = ConsType.CT001, len = "8", desc = "文件记录序号", type = "String", memo = "略")
    private String recSeq;

    @JSONField(name = "USER_ENTER_ACCOUNT_NO")
    @ParamDesc(path = "USER_ENTER_ACCOUNT_NO", cons = ConsType.CT001, len = "60", desc = "用户协议号码", type = "String", memo = "略")
    private String userEnterAccountNo;

    @JSONField(name = "PAY_MONEY")
    @ParamDesc(path = "PAY_MONEY", cons = ConsType.CT001, len = "15", desc = "用户托收金额", type = "long", memo = "略")
    private long payMoney;

    @JSONField(name = "REC_RETURN_CODE")
    @ParamDesc(path = "REC_RETURN_CODE", cons = ConsType.CT001, len = "2", desc = "记录返回代码", type = "String", memo = "略")
    private String recReturnCode;

    @JSONField(name = "REC_RETURN_MSG")
    @ParamDesc(path = "REC_RETURN_MSG", cons = ConsType.CT001, len = "60", desc = "记录返回代码描述信息", type = "String", memo = "略")
    private String recReturnMsg;

	public String getRecSeq() {
		return recSeq;
	}

	public void setRecSeq(String recSeq) {
		this.recSeq = recSeq;
	}

	public String getUserEnterAccountNo() {
		return userEnterAccountNo;
	}

	public void setUserEnterAccountNo(String userEnterAccountNo) {
		this.userEnterAccountNo = userEnterAccountNo;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public String getRecReturnCode() {
		return recReturnCode;
	}

	public void setRecReturnCode(String recReturnCode) {
		this.recReturnCode = recReturnCode;
	}

	public String getRecReturnMsg() {
		return recReturnMsg;
	}

	public void setRecReturnMsg(String recReturnMsg) {
		this.recReturnMsg = recReturnMsg;
	}
    
}

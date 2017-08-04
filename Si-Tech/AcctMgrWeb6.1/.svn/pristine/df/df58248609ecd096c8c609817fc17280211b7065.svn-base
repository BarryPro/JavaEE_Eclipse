package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Description: 一点支付缴费根据证件获取账户 出参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020AccountOutDTO extends CommonOutDTO{
	
	@JSONField(name="ACCOUNT_LEN")
	@ParamDesc(path="ACCOUNT_LEN",cons=ConsType.CT001,type="int",len="8",desc="账户个数",memo="略")
	protected int accountLen;
	
	@JSONField(name="LIST_ACCOUNT")
	@ParamDesc(path="LIST_ACCOUNT",cons=ConsType.STAR,type="compx",len="8",desc="账户列表",memo="略")
	protected List<AccountListEntity> listAccount;
	
	
	public S8020AccountOutDTO() {
	}

	public S8020AccountOutDTO(String sJson) {
		MBean mBean = new MBean(sJson);
		this.accountLen = mBean.getBodyInt("OUT_DATA.ACCOUNT_LEN");
		//this.listAccount = (List<AccountListEntity>) mBean.getBodyList("OUT_DATA.LIST_ACCOUNT");
		this.listAccount = (List<AccountListEntity>) mBean.getList(getPathByProperName("listAccount"));

	}
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("accountLen"), accountLen);
		result.setRoot(getPathByProperName("listAccount"), listAccount);
		
		return result;
	}
	

	/**
	 * @return the accountLen
	 */
	public int getAccountLen() {
		return accountLen;
	}

	/**
	 * @param accountLen the accountLen to set
	 */
	public void setAccountLen(int accountLen) {
		this.accountLen = accountLen;
	}

	/**
	 * @return the listAccount
	 */
	public List<AccountListEntity> getListAccount() {
		return listAccount;
	}

	/**
	 * @param listAccount the listAccount to set
	 */
	public void setListAccount(List<AccountListEntity> listAccount) {
		this.listAccount = listAccount;
	}

}

package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.cust.PostBankEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @author Administrator
 *
 */
public class SCollectBankGraphyOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="BANK_LIST")
	@ParamDesc(path="BANK_LIST",cons=ConsType.PLUS,type="compx",len="1",desc="银行信息列表",memo="略")
	protected List<PostBankEntity> bankList = null;
	
	@JSONField(name="BANK_AMOUNT")
	@ParamDesc(path="BANK_AMOUNT",cons=ConsType.CT001,type="int",len="10",desc="总页数",memo="略")
	protected int amount;
	
	@JSONField(name="PAGE_NUM")
	@ParamDesc(path="PAGE_NUM",cons=ConsType.CT001,type="int",len="10",desc="总页",memo="略")
	protected int pageNum;

	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public List<PostBankEntity> getBankList() {
		return bankList;
	}

	public void setBankList(List<PostBankEntity> bankList) {
		this.bankList = bankList;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("bankList"), bankList);
		result.setRoot(getPathByProperName("amount"), amount);
		result.setRoot(getPathByProperName("pageNum"), pageNum);
		return result;
		
	}
	
}

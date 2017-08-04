package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.AccountPayedEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;
import java.util.Map;

 
/**
* @Description: 一点支付缴费：查询 出参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020InitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2821450228820055208L;
	
	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="支付账户预存",memo="略")
	protected long  prepayFee;
	
	@JSONField(name="ALL_TOTAL")
	@ParamDesc(path="ALL_TOTAL",cons=ConsType.CT001,type="long",len="14",desc="合计应支付金额",memo="略")
	protected long  allTotal;
	
	@JSONField(name="ALL_DELAYFEE")
	@ParamDesc(path="ALL_DELAYFEE",cons=ConsType.CT001,type="long",len="14",desc="合计应支付滞纳金",memo="略")
	protected long  allDelayfee;
	
	@JSONField(name="CONTRACT_LEN")
	@ParamDesc(path="CONTRACT_LEN",cons=ConsType.CT001,type="int",len="14",desc="被支付个数",memo="略")
	protected int 	 contractLen;
	
	@JSONField(name="LIST_CONTRACT")
	@ParamDesc(path="LIST_CONTRACT",cons=ConsType.STAR,type="compx",len="1",desc="被支付账户列表",memo="略")
	protected List<AccountPayedEntity> listContract;

	
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("allTotal"), allTotal);
		result.setRoot(getPathByProperName("allDelayfee"), allDelayfee);
		result.setRoot(getPathByProperName("contractLen"), contractLen);
		result.setRoot(getPathByProperName("listContract"), listContract);
		
		return result;
	}


	public long getPrepayFee() {
		return prepayFee;
	}


	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}


	public long getAllTotal() {
		return allTotal;
	}


	public void setAllTotal(long allTotal) {
		this.allTotal = allTotal;
	}


	public long getAllDelayfee() {
		return allDelayfee;
	}


	public void setAllDelayfee(long allDelayfee) {
		this.allDelayfee = allDelayfee;
	}


	public int getContractLen() {
		return contractLen;
	}


	public void setContractLen(int contractLen) {
		this.contractLen = contractLen;
	}


	public List<AccountPayedEntity> getListContract() {
		return listContract;
	}


	public void setListContract(List<AccountPayedEntity> listContract) {
		this.listContract = listContract;
	}

	
}

package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.query.AgentOprEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8419InitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo;
	@ParamDesc(path="RESULTLIST",cons=ConsType.STAR,type="compx",len="1",desc="转账列表",memo="略")
	List<AgentOprEntity> resultList;
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="18",desc="充值金额",memo="略")
	private long payMoney;
	@ParamDesc(path="PAY_NUM",cons=ConsType.CT001,type="String",len="18",desc="充值笔数",memo="略")
	private long payNum;
	@ParamDesc(path="BACK_MONEY",cons=ConsType.CT001,type="long",len="18",desc="冲正金额",memo="略")
	private long backMoney;
	@ParamDesc(path="BACK_NUM",cons=ConsType.CT001,type="long",len="18",desc="冲正笔数",memo="略")
	private long backNum;
	@ParamDesc(path="ALL_MONEY",cons=ConsType.CT001,type="long",len="18",desc="实际充值金额",memo="略")
	private long allMoney;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("payNum"), payNum);
		result.setRoot(getPathByProperName("backMoney"), backMoney);
		result.setRoot(getPathByProperName("backNum"), backNum);
		result.setRoot(getPathByProperName("allMoney"), allMoney);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the resultList
	 */
	public List<AgentOprEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<AgentOprEntity> resultList) {
		this.resultList = resultList;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the backMoney
	 */
	public long getBackMoney() {
		return backMoney;
	}

	/**
	 * @param backMoney the backMoney to set
	 */
	public void setBackMoney(long backMoney) {
		this.backMoney = backMoney;
	}

	/**
	 * @return the allMoney
	 */
	public long getAllMoney() {
		return allMoney;
	}

	/**
	 * @param allMoney the allMoney to set
	 */
	public void setAllMoney(long allMoney) {
		this.allMoney = allMoney;
	}

	/**
	 * @return the payNum
	 */
	public long getPayNum() {
		return payNum;
	}

	/**
	 * @param payNum the payNum to set
	 */
	public void setPayNum(long payNum) {
		this.payNum = payNum;
	}

	/**
	 * @return the backNum
	 */
	public long getBackNum() {
		return backNum;
	}

	/**
	 * @param backNum the backNum to set
	 */
	public void setBackNum(long backNum) {
		this.backNum = backNum;
	}

	
}


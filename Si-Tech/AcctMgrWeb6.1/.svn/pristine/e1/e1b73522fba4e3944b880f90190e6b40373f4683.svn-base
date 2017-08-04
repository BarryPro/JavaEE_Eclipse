package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.PhonePayNewEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPhonePayNewOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="PAY_TIMES",cons=ConsType.CT001,type="long",len="15",desc="返费次数",memo="略")
	protected long payTimes = 0;
	@ParamDesc(path="PAY_ALL",cons=ConsType.CT001,type="long",len="15",desc="总缴费金额",memo="单位：分")
	protected long payAll = 0;
	@ParamDesc(path="PAYED_ALL",cons=ConsType.CT001,type="long",len="15",desc="总冲销欠费金额",memo="单位：分略")
	protected long payedAll = 0;
	@ParamDesc(path="DELAY_ALL",cons=ConsType.CT001,type="long",len="15",desc="总冲销滞纳金",memo="单位：分")
	protected long delayAll = 0;
	
	@ParamDesc(path="PAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费列表",memo="略")
	protected List<PhonePayNewEntity> payList = new ArrayList<PhonePayNewEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payAll"), payAll);
		result.setRoot(getPathByProperName("payTimes"), payTimes);
		result.setRoot(getPathByProperName("payedAll"), payedAll);
		result.setRoot(getPathByProperName("delayAll"), delayAll);
		result.setRoot(getPathByProperName("payList"), payList);

		return result;
	}

	/**
	 * @return the payTimes
	 */
	public long getPayTimes() {
		return payTimes;
	}

	/**
	 * @param payTimes the payTimes to set
	 */
	public void setPayTimes(long payTimes) {
		this.payTimes = payTimes;
	}

	/**
	 * @return the payAll
	 */
	public long getPayAll() {
		return payAll;
	}

	/**
	 * @param payAll the payAll to set
	 */
	public void setPayAll(long payAll) {
		this.payAll = payAll;
	}

	/**
	 * @return the payedAll
	 */
	public long getPayedAll() {
		return payedAll;
	}

	/**
	 * @param payedAll the payedAll to set
	 */
	public void setPayedAll(long payedAll) {
		this.payedAll = payedAll;
	}

	/**
	 * @return the delayAll
	 */
	public long getDelayAll() {
		return delayAll;
	}

	/**
	 * @param delayAll the delayAll to set
	 */
	public void setDelayAll(long delayAll) {
		this.delayAll = delayAll;
	}

	/**
	 * @return the payList
	 */
	public List<PhonePayNewEntity> getPayList() {
		return payList;
	}

	/**
	 * @param payList the payList to set
	 */
	public void setPayList(List<PhonePayNewEntity> payList) {
		this.payList = payList;
	}
	
}

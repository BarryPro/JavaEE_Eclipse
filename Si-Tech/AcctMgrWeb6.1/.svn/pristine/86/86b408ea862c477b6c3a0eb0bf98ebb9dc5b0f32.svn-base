package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8056qryRelatedInvoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2402519899609886910L;
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.CT001,type="long",len="20",desc="激费流水",memo="略")
	private long paySn;
	@ParamDesc(path="BUSI_INFO.PAY_YEARMON",cons=ConsType.CT001,type="int",len="10",desc="缴费月份",memo="略")
	private int payYM;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户号",memo="略")
	private long contractNo;
	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}
	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}
	/**
	 * @return the payYM
	 */
	public int getPayYM() {
		return payYM;
	}
	/**
	 * @param payYM the payYM to set
	 */
	public void setPayYM(int payYM) {
		this.payYM = payYM;
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
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		System.out.println("@@"+arg0.toString());
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("paySn")))){
			paySn = ValueUtils.longValue(arg0.getStr(getPathByProperName("paySn")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payYM")))){
			payYM = ValueUtils.intValue(arg0.getStr(getPathByProperName("payYM")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))){
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}
		
	}
}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 缴费冲正查询入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8056InitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3282715822146950731L;
	
	@ParamDesc(path="BUSI_INFO.PAY_DATE",cons=ConsType.CT001,type="long",len="8",desc="缴费日期",memo="略")
	protected String payDate;
	
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	protected long	paySn;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo = 0;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8056";//设置默认值
		}
		
		payDate = arg0.getBodyStr("BUSI_INFO.PAY_DATE");
		paySn = Long.valueOf(arg0.getBodyObject("BUSI_INFO.PAY_SN").toString());
		
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("contractNo")))){
			contractNo = Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString());
		}
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
	 * @return the payDate
	 */
	public String getPayDate() {
		return payDate;
	}
	/**
	 * @param payDate the payDate to set
	 */
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
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

	

}

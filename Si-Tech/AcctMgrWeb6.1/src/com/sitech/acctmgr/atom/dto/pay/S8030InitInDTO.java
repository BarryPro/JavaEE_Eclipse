package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 托收缴费查询入参 DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030InitInDTO extends CommonInDTO{

	private static final long serialVersionUID = -949460014847009244L;
    
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="String",len="18",desc="帐户号码",memo="略")
	protected long contractNo;
	
	@ParamDesc(path="BUSI_INFO.YEAR_MONTH",cons=ConsType.CT001,type="String",len="6",desc="查询年月",memo="略")
	protected String yearMonth;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));
		setYearMonth(arg0.getStr(getPathByProperName("yearMonth")));	
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
	 * @return the yearMonth
	 */
	public String getYearMonth() {
		return yearMonth;
	}

	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

}

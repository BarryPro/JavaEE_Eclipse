package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8420InitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.YEAR_MONTH",cons=ConsType.QUES,type="String",len="6",desc="查询年月",memo="略")
	protected String yearMonth = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账户",memo="略")
	protected long contractNo = 0;
	
	public void decode(MBean arg0){
		super.decode(arg0);	
		setYearMonth(arg0.getObject(getPathByProperName("yearMonth")).toString());
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		
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
}

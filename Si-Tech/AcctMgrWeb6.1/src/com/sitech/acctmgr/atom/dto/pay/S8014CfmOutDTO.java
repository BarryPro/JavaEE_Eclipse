package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 转账确认出参DTO  </p>
 * <p>Description: 转账确认出参DTO，封装出参情况  </p>
 * <p>Copyright: Copyright (c) 2015/1/5</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8014CfmOutDTO extends CommonOutDTO {
 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5090885390443338887L;
	
	@JSONField(name="TOTAL_DATET")
	@ParamDesc(path="TOTAL_DATET",cons=ConsType.CT001,type="string",len="8",desc="转账日期",memo="略")
	private String totalDate;
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="18",desc="转账流水",memo="略")
	private long psySn;

	/*public S8014CfmOutDTO(){
		
	}
	
	public S8014CfmOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.lPsySn = mBean.getBodyLong("OUT_DATA.PAY_SN");
		this.sTotaldate = mBean.getBodyStr("OUT_DATA.TOTAL_DATET");
	}
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("psySn"), psySn);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the totalDate
	 */
	public String getTotalDate() {
		return totalDate;
	}

	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	/**
	 * @return the psySn
	 */
	public long getPsySn() {
		return psySn;
	}

	/**
	 * @param psySn the psySn to set
	 */
	public void setPsySn(long psySn) {
		this.psySn = psySn;
	}
 
 
	
}

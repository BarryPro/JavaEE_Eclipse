package com.sitech.acctmgr.atom.dto.pay;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退预存款  </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8008CfmOutDTO extends CommonOutDTO{

 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7349353274742245810L;

	@JSONField(name="PAY_ACCEPT")
	@ParamDesc(path="PAY_ACCEPT",cons=ConsType.CT001,type="long",len="18",desc="退费流水",memo="略")
	protected long payAccept;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="退费日期",memo="略")
	protected String totalDate;

	@JSONField(name="REMAIN_FEE")
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="14",desc="退款后余额",memo="联动空中充值退费出参")
	protected long remainFee;
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payAccept"), payAccept);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		return result;
	}
	
	

	/**
	 * @return the payAccept
	 */
	public long getPayAccept() {
		return payAccept;
	}


	/**
	 * @param payAccept the payAccept to set
	 */
	public void setPayAccept(long payAccept) {
		this.payAccept = payAccept;
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

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}
}

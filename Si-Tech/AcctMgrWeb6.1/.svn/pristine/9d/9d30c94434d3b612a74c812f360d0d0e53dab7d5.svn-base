package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  陈死账回收回退确认入参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author linzc
 * @version 1.0
 */
public class S8007CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9217907505310244415L;
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="long",len="40",desc="用户号码",memo="略")
	private long idNo;
	@ParamDesc(path="BUSI_INFO.PAY_TIME",cons=ConsType.QUES,type="String",len="40",desc="日期",memo="略")
	private String payTime;    
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.QUES,type="long",len="40",desc="缴费流水",memo="略")
	private long paySn;
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="40",desc="回退备注",memo="略")
	private String payNotes;
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.CT001,type="String",len="2",desc="陈死账类型",memo="1:陈账,4:死账")
	private String backType;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setIdNo(Long.parseLong(arg0.getObject(getPathByProperName("idNo")).toString()));
		setPayTime(StringUtils.castToString(arg0.getObject(getPathByProperName("payTime"))));
		setPaySn(Long.parseLong(arg0.getObject(getPathByProperName("paySn")).toString()));
		setPayNotes(StringUtils.castToString(arg0.getObject(getPathByProperName("payNotes"))));
		setBackType(StringUtils.castToString(arg0.getObject(getPathByProperName("backType"))));
		
	}


	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}


	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}


	/**
	 * @return the payTime
	 */
	public String getPayTime() {
		return payTime;
	}

	/**
	 * @param payTime the payTime to set
	 */
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public String getPayNotes() {
		return payNotes;
	}

	public void setPayNotes(String payNotes) {
		this.payNotes = payNotes;
	}

	/**
	 * @return the backType
	 */
	public String getBackType() {
		return backType;
	}

	/**
	 * @param backType the backType to set
	 */
	public void setBackType(String backType) {
		this.backType = backType;
	}

}


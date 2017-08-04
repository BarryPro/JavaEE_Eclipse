package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.text.ParseException;
import java.text.SimpleDateFormat;

  
/**   
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author:  wangyla
 * @version:
 * @createTime:  2015-5-6 上午10:14:20
 */

public class SEchargeCardInDTO extends CommonInDTO { 
	private static final long serialVersionUID = 1L;

	/*
	@ParamDesc(path = "BUSI_INFO.OPR_SN", cons = ConsType.QUES, desc = "操作流水", len = "24", type = "string", memo = "略")
	protected String oprSn = "";
	
	@ParamDesc(path = "BUSI_INFO.CONTACT_ID", cons = ConsType.QUES, desc = "全网客户接触ID", len = "27", type = "string", memo = "略")
	protected String contactId = "";
	*/
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
	protected String phoneNo = "";

	/*
	@ParamDesc(path = "BUSI_INFO.IDENT_CODE", cons = ConsType.QUES, desc = "用户身份凭证", len = "32", type = "string", memo = "略")
	protected String identCode = "";
	*/
	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, desc = "查询开始时间 YYYYMMDDHH24MISS", len = "14", type = "string", memo = "略")
	protected String beginTime = "";
	
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, desc = "查询结束时间 YYYYMMDDHH24MISS", len = "14", type = "string", memo = "略")
	protected String endTime = "";

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		/*
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("oprSn")))){
			oprSn = arg0.getStr(getPathByProperName("oprSn"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("contactId")))){
			contactId = arg0.getStr(getPathByProperName("contactId"));
		}
		*/
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		/*
		if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("identCode")))){
			identCode = arg0.getStr(getPathByProperName("identCode"));
		}
		*/
		beginTime = arg0.getStr(getPathByProperName("beginTime"));
		endTime = arg0.getStr(getPathByProperName("endTime"));
		
		String transStrBeg = beginTime.substring(0, 8);
		String transStrEnd = endTime.substring(0, 8);
		try {
			beginTime = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyyMMdd").parse(transStrBeg));
			endTime = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyyMMdd").parse(transStrEnd));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}



	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}



	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}



	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	
}

package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.io.Serializable;

/**
 *
 * <p>Title: 缴费查询出参DTO  </p>
 * <p>Description: 缴费查询出参DTO，封装出参情况  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
@SuppressWarnings("serial")
public class SCheckConCheckRemainFeeOutDTO extends CommonOutDTO implements Serializable  {
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="COMMON_REMAIN_FEE",cons=ConsType.CT001,type="long",len="18",desc="普通预存款余额",memo="略")
	private long commonRemainFee;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("commonRemainFee"), commonRemainFee);
		
		return result;
	}


	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getCommonRemainFee() {
		return commonRemainFee;
	}

	public void setCommonRemainFee(long commonRemainFee) {
		this.commonRemainFee = commonRemainFee;
	}

}

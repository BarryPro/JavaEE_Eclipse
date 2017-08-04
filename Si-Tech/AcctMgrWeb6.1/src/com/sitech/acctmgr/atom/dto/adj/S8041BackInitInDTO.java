package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   投诉退费冲正查询入参DTO</p>
 * <p>Description:   对入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8041BackInitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2691393344291212726L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.BACK_SN",cons=ConsType.CT001,type="long",len="14",desc="退费流水",memo="略")
	protected long backSn;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setBackSn(Long.parseLong(arg0.getObject(getPathByProperName("backSn")).toString()));
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8041";
		}
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the backSn
	 */
	public long getBackSn() {
		return backSn;
	}

	/**
	 * @param backSn the backSn to set
	 */
	public void setBackSn(long backSn) {
		this.backSn = backSn;
	}

}

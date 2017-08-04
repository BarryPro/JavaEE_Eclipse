package com.sitech.acctmgr.common.dto;

import com.sitech.acctmgr.common.AcctMgrProperties;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * <p>Title: 公共入参信息DTO  </p>
 * <p>Description: 公共入参信息DTO类，封装了login_no、op_code、group_id等 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class CommonInDTO extends InDTO {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
	
	static HashMap<String, String> provinceMap = new HashMap<>();
	static{
		provinceMap.put("HLJ", "230000");
		provinceMap.put("JL",  "220000");
	}
	
	private static final long serialVersionUID = 4539041731593125543L;
	@ParamDesc(path="OPR_INFO.LOGIN_NO",cons=ConsType.QUES,type="String",len="20",desc="工号",memo="略")
	protected String loginNo;
	@ParamDesc(path="OPR_INFO.GROUP_ID",cons=ConsType.QUES,type="String",len="10",desc="工号归属",memo="略")
	protected String groupId;
	@ParamDesc(path="OPR_INFO.OP_CODE",cons=ConsType.QUES,type="String",len="5",desc="操作代码",memo="略")
	protected String opCode;
	
	@ParamDesc(path="OPR_INFO.PROVINCE_ID",cons=ConsType.CT001,type="String",len="20",desc="省份代码",memo="黑龙江填写：230000")
	protected String provinceId;
	
	protected Map<String,Object> header;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		
		setHeader(arg0.getHeader());
		
		setLoginNo(arg0.getStr(getPathByProperName("loginNo")));
		setGroupId(arg0.getStr(getPathByProperName("groupId")));
		setOpCode(arg0.getStr(getPathByProperName("opCode")));
		setProvinceId(arg0.getStr(getPathByProperName("provinceId")));
		if(provinceId == null || provinceId.equals("")){
			
			String provinceGroup;
			if(header.get("PROVINCE_GROUP") != null && !header.get("PROVINCE_GROUP").equals("")){
				provinceGroup = header.get("PROVINCE_GROUP").toString();
				provinceId = provinceMap.get(provinceGroup);
			}else{
				provinceId = AcctMgrProperties.getConfigByMap("DEFAULT_PROVINCE_ID");
			}
			
			log.debug("qiaolin test: " + provinceId);
		}
	}

	
	
	/**
	 * @return the provinceId
	 */
	public String getProvinceId() {
		return provinceId;
	}

	/**
	 * @param provinceId the provinceId to set
	 */
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	/**
	 * @return the header
	 */
	public Map<String, Object> getHeader() {
		return header;
	}

	/**
	 * @param header the header to set
	 */
	public void setHeader(Map<String, Object> header) {
		this.header = header;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}

	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	
	
}

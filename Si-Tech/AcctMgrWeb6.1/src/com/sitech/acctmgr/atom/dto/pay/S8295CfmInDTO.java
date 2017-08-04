package com.sitech.acctmgr.atom.dto.pay;


import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8295CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4032792093833310318L;


	@ParamDesc(path = "BUSI_INFO.RELPATH", cons = ConsType.CT001, desc = "相对路径", len = "100", type = "string", memo = "略")
	private String relPath;
	
	
	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.CT001, desc = "备注", len = "100", type = "string", memo = "略")
	protected String remark;
	
	
	@ParamDesc(path = "BUSI_INFO.GROUP_CONTRACT_NO", cons = ConsType.CT001, desc = "联系人电话", len = "300", type = "long", memo = "")
	protected long groupContractNo;

	@ParamDesc(path = "BUSI_INFO.GROUP_PRODUCT_NAME", cons = ConsType.CT001, desc = "集团产品名称", len = "120", type = "string", memo = "")
	protected String groupProductName;

 
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		setGroupContractNo(Long.parseLong(arg0.getObject(getPathByProperName("groupContractNo")).toString()));
		setRelPath(arg0.getStr(getPathByProperName("relPath")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		setGroupProductName(arg0.getStr(getPathByProperName("groupProductName")));

		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))) {
			setOpCode("8295");
		}
		
	}


	/**
	 * @return the relPath
	 */
	public String getRelPath() {
		return relPath;
	}


	/**
	 * @param relPath the relPath to set
	 */
	public void setRelPath(String relPath) {
		this.relPath = relPath;
	}


	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}


	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}


	/**
	 * @return the groupContractNo
	 */
	public long getGroupContractNo() {
		return groupContractNo;
	}


	/**
	 * @param groupContractNo the groupContractNo to set
	 */
	public void setGroupContractNo(long groupContractNo) {
		this.groupContractNo = groupContractNo;
	}

	public String getGroupProductName() {
		return groupProductName;
	}

	public void setGroupProductName(String groupProductName) {
		this.groupProductName = groupProductName;
	}
}

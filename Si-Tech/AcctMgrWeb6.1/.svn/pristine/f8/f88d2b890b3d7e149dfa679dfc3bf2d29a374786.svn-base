package com.sitech.acctmgr.atom.dto.adj;

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
public class S8011CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3325301768633529844L;

	@ParamDesc(path = "BUSI_INFO.RELPATH", cons = ConsType.CT001, desc = "相对路径", len = "100", type = "string", memo = "略")
	private String relPath;
	@ParamDesc(path = "BUSI_INFO.ACCT_ITEM_CODE", cons = ConsType.CT001, desc = "账目项", len = "100", type = "string", memo = "略")
	protected String acctItem;
	@ParamDesc(path = "BUSI_INFO.BILL_MONTH", cons = ConsType.CT001, desc = "补收年月", len = "100", type = "string", memo = "略")
	protected int billMonth=0;
	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.CT001, desc = "备注", len = "100", type = "string", memo = "略")
	protected String remark;
//	@ParamDesc(path = "BUSI_INFO.PHONE_LIST", cons = ConsType.STAR, desc = "相对路径", len = "1", type = "compx", memo = "略")
//	protected List<Map> phoneNoList;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setRelPath(arg0.getStr(getPathByProperName("relPath")));
		setAcctItem(arg0.getStr(getPathByProperName("acctItem")));
		setBillMonth(Integer.parseInt(arg0.getObject(getPathByProperName("billMonth")).toString()));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		//sPhoneNoList = arg0.getBodyList("BUSI_INFO.PHONE_LIST",Map.class);
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8011";
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
	 * @return the acctItem
	 */
	public String getAcctItem() {
		return acctItem;
	}

	/**
	 * @param acctItem the acctItem to set
	 */
	public void setAcctItem(String acctItem) {
		this.acctItem = acctItem;
	}

	/**
	 * @return the billMonth
	 */
	public int getBillMonth() {
		return billMonth;
	}

	/**
	 * @param billMonth the billMonth to set
	 */
	public void setBillMonth(int billMonth) {
		this.billMonth = billMonth;
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

}

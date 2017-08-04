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
public class S8296DeleteInDTO extends CommonInDTO{

	private static final long serialVersionUID = 7831341447315438832L;

	@ParamDesc(path = "BUSI_INFO.GROUP_CONTRACT_NO", cons = ConsType.CT001, desc = "集团账户", len = "300", type = "string", memo = "")
	protected long groupContractNo;

 
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		setGroupContractNo(Long.parseLong(arg0.getObject(getPathByProperName("groupContractNo")).toString()));
		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))) {
			setOpCode("8296");
		}
		
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


 

 

}

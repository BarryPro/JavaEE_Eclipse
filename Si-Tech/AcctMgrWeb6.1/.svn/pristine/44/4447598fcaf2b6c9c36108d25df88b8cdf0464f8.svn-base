/**
 * 
 */
package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * <p>Title:   托收管理</p>
 * <p>Description:   托收管理</p>
 * <p>Copyright: Copyright (c) 2015</p>
 * <p>Company: SI-TECH </p>
 * @author wangyla
 * @version 1.0
 */
public interface I8225 {

	/**
	 * 功能：托收用户清单和错单查询
	 * @param inParam
	 * @return
     */
	OutDTO qryCollBill(InDTO inParam);

	/**
	 * 功能：托收用户清单和错单查询，只查询指定服务在托收帐户下的托收费用情况
	 * @param inParam
	 * @return
     */
	OutDTO qryCollBillByPhone(InDTO inParam);

	/**
	 * 功能：按帐户查询托收帐单，以导出Excel的出参格式进行返回
	 * @param inParam
	 * @return
     */
	OutDTO qryCollBillByCon(InDTO inParam);

	/**
	 * 功能：托收代码操作
	 * @param inParam
	 * @return
     */
	OutDTO collCodeOpr(InDTO inParam);

	/**
	 * 功能：托收状态清单/统计
	 * @param inParam
	 * @return
     */
	OutDTO calCollBill(InDTO inParam);
}

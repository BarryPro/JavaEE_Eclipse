package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 费用综合信息查询  </p>
 * <p>Description: 费用综合信息查询 含交费记录 销帐记录 用户基本信息  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public interface I8107 {
	
	OutDTO query(InDTO inParam) throws Exception;
	OutDTO qryPay(InDTO inParam) throws Exception;
	OutDTO qryBill(InDTO inParam) throws Exception;
	OutDTO qryBillDetail(InDTO inParam) throws Exception;
	
}

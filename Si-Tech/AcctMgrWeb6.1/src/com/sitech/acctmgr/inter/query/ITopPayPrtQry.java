package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：总对总发票打印情况查询，对应的老系统接口为：bs_i064Qry
 * 
 * @author liuhl_bj
 *
 */
public interface ITopPayPrtQry {

	OutDTO query(InDTO inParam);

}

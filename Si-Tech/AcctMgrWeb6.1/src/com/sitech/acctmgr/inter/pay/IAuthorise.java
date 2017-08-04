package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created 2015/01/27
 * @author LIJXD
 * @modify  
 * IAuthorise 授权审批接口：调用基基础域 com_sitech_basemng_atom_inter_apply_IApplyPdomSvc_pubAppQry
 */
public interface IAuthorise {
	OutDTO query(final InDTO inParam);
}

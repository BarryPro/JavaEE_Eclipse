package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I8226 {
	/**
	 * 托收单打印或查询 <br>
	 * 根据打印标志print_flag 0：查询 1：打印
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryOrPrint(InDTO inParam);

}

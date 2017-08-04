package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by com on 16/10/18.
 */
public interface IGivenMicroPay {

    //求赠赠予扣费确认
    OutDTO cfm(final InDTO inParam);
}

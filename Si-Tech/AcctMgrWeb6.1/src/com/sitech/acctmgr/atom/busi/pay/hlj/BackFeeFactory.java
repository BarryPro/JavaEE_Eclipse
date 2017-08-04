package com.sitech.acctmgr.atom.busi.pay.hlj;

import com.sitech.acctmgr.atom.busi.pay.backfee.BackFeeDEAD;
import com.sitech.acctmgr.atom.busi.pay.backfee.BackFeeON;
import com.sitech.acctmgr.atom.busi.pay.backfee.BackFeeType;
import com.sitech.acctmgr.atom.busi.pay.backfee.BackFeeXH;
import com.sitech.acctmgr.atom.busi.pay.backfee.BbdBackFeeON;
import com.sitech.acctmgr.atom.impl.pay.S8008;
import com.sitech.acctmgr.common.AcctMgrBaseService;

/**
 * Created by SOAL on 20160407.
 */
public class BackFeeFactory extends AcctMgrBaseService{
    public static BackFeeType createBackFeeFactory(String opType, S8008 back8008){
        BackFeeType backFeeType = null;

        switch(opType){
            case "BackFeeON":
                backFeeType = new BackFeeON(back8008);
                break;
            case "BackFeeDEAD":
                backFeeType = new BackFeeDEAD(back8008);
                break;
            case "BackFeeXH":
                backFeeType = new BackFeeXH(back8008);
                break;
            case "BbdBackFeeON":
                backFeeType = new BbdBackFeeON(back8008);
                break;
            default :
                backFeeType = new BackFeeType(back8008);
        }
        return backFeeType;
    }
}

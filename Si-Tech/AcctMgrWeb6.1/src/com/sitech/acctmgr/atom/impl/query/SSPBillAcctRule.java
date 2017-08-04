package com.sitech.acctmgr.atom.impl.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.SPBillAcctRuleEntity;
import com.sitech.acctmgr.atom.dto.query.SSPBillAcctRuleInDTO;
import com.sitech.acctmgr.atom.dto.query.SSPBillAcctRuleOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.ISPBillAcctRule;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({
        @ParamType(c = SSPBillAcctRuleInDTO.class, oc = SSPBillAcctRuleOutDTO.class, m = "query")})

public class SSPBillAcctRule extends AcctMgrBaseService implements ISPBillAcctRule {

    private IBillAccount billAccount;

    @Override
    public OutDTO query(InDTO inParam) {

    	SSPBillAcctRuleInDTO inDTO = (SSPBillAcctRuleInDTO) inParam;
    	SSPBillAcctRuleOutDTO outDTO = new SSPBillAcctRuleOutDTO();
        log.debug("inDTO=" + inDTO.getMbean());

        String bizType = inDTO.getBizType();
        String inSpCode = inDTO.getSpCode();
        String inOperCode = inDTO.getOperCode();
        
        List<SPBillAcctRuleEntity> spBillRuleList = billAccount.getSPBillRule(bizType);
        boolean checkFlag = true;
        
        for (SPBillAcctRuleEntity spBillRuleEnt : spBillRuleList) {
        	String spCodeRule = spBillRuleEnt.getSpCode();
            String operCodeRule = spBillRuleEnt.getOperCode();
            int acctRule = spBillRuleEnt.getAcctRule();
            
            boolean spCheckFlag = this.ruleCheck(inSpCode, spCodeRule);
            boolean operCheckFlag = this.ruleCheck(inOperCode, operCodeRule);
            
            if(!(spCheckFlag && operCheckFlag)){
            	checkFlag = false;
            	continue;
            } else if(spCheckFlag && operCheckFlag) {
            	checkFlag = true;
            	outDTO.setAcctRule(acctRule);
            	break;
            }
		}
        
        if( !checkFlag ){
        	throw new BusiException(AcctMgrError.getErrorCode("0000", "20015"), "查询sp业务计费类型失败！");
        }
        
        log.debug("outDTO=" + outDTO.toJson());
        return outDTO;
    }

    /**
     * 功能：校验传入的字符串是否匹配规则
     * @param inStr 待校验字符串
     * @param ruleStr  规则字符串
     */
    private boolean ruleCheck(String inStr, String ruleStr){
		boolean checkFlag = true;  //校验标识
		
		if(ruleStr.startsWith("*")){
			return true;
		} else if(ruleStr.startsWith("!")) {
			checkFlag = false;
		} else {
			if(ruleStr.startsWith("^")){
				String prefix = ruleStr.substring(1); //需要匹配的前缀
				if(prefix.equals(inStr.substring(0, prefix.length()))){
					return true;
				} else {
					checkFlag = false;
				}
			} else if(ruleStr.startsWith("#")) {
				String code = ruleStr.substring(1); //需要包含在内的代码
				if(inStr.contains(code)){
					return true;
				} else {
					checkFlag = false;
				}
			} else {
				if(inStr.equals(ruleStr)){
					return true;
				} else {
					checkFlag = false;
				}
			} 
		}
    	return checkFlag;
    }

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

}

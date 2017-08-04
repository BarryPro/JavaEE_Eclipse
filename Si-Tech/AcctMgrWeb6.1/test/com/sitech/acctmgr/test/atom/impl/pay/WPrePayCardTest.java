package com.sitech.acctmgr.test.atom.impl.pay;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.dto.pay.WPrePayCardCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardCfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardLimitInDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardLimitOutDTO;
import com.sitech.acctmgr.inter.pay.IWPrePayCard;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

import org.junit.Before;
import org.junit.Test;


public class WPrePayCardTest  extends BaseTestCase {

	private IWPrePayCard bean;
    /**
     * 名称：
     * @param
     * @return
     * @throws
     */
    @Before
    public void setUp() throws Exception {
    	bean = (IWPrePayCard)getBean("wPrePayCardSvc");
    }
   
    private String getArgStringForCfm() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13944163643");
        busiMap.put("CONTRACT_NO", 230101100000250005L);
        busiMap.put("PAY_FEE", "116");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70s");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
    
    /**
     * 名称：
     * @param
     * @return
     * @throws
     */
    @Test
    public void testInit() {

    	IWPrePayCard wPrePayCard = (IWPrePayCard) getBean("wPrePayCardSvc");

        try {
            MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"A1\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"" +
                    "BODY\":{\"BUSI_INFO\":{\"PHONE_NO\": \"13944163643\",\"CONTRACT_NO\": \"230101100000250005\",\"PAY_FEE\": \"116\"}}}}");

            InDTO in = parseInDTO(inMBean, WPrePayCardLimitInDTO.class);
            WPrePayCardLimitOutDTO out = (WPrePayCardLimitOutDTO)wPrePayCard.limit(in);
            String result = out.toJson();
            System.out.println("result = " + result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
    
   @Test
    public void testCfm() {
    	
    	String inStr = getArgStringForCfm();

        try {	
        	InDTO inDto = parseInDTO(inStr, WPrePayCardCfmInDTO.class);
        	WPrePayCardCfmOutDTO out = (WPrePayCardCfmOutDTO)bean.cfm(inDto);
            String result = out.toJson();
            System.out.println("result = " + result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
	
}

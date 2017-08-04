package com.sitech.acctmgr.test.atom.impl.adj;



import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.dto.adj.SMicroPayBackCfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.SMicroPayBackCfmOutDTO;
import com.sitech.acctmgr.atom.dto.adj.SMicroPayCfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.SMicroPayCfmOutDTO;
import com.sitech.acctmgr.atom.dto.adj.SMicroPayInitInDTO;
import com.sitech.acctmgr.atom.dto.adj.SMicroPayInitOutDTO;
import com.sitech.acctmgr.inter.adj.IMicroPay;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

import org.junit.Before;
import org.junit.Test;


public class SMicroPayTest  extends BaseTestCase {

	private IMicroPay bean;
    /**
     * 名称：
     * @param
     * @return
     * @throws
     */
    @Before
    public void setUp() throws Exception {
    	bean = (IMicroPay)getBean("microPaySvc");
    }
   
    private String getArgStringForCfm() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13804310982");
        busiMap.put("IN_GOODS_ID", "369");
        busiMap.put("IN_COMPANY_ID", "369");
        busiMap.put("IN_TRANS_DATE", "20161025174800");
        busiMap.put("IN_PREPAY_FEE", 100L);
        busiMap.put("IN_TRANS_DATE", "20161026");
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

    	IMicroPay iMicroPay = (IMicroPay) getBean("microPaySvc");

        try {
            MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"A1\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"" +
                    "BODY\":{\"BUSI_INFO\":{\"PHONE_NO\": \"13944161265\"}}}}");

            InDTO in = parseInDTO(inMBean, SMicroPayInitInDTO.class);
            SMicroPayInitOutDTO out = (SMicroPayInitOutDTO)iMicroPay.init(in);
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
        	InDTO inDto = parseInDTO(inStr, SMicroPayCfmInDTO.class);
            SMicroPayCfmOutDTO out = (SMicroPayCfmOutDTO)bean.cfm(inDto);
            String result = out.toJson();
            System.out.println("result = " + result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
    
    @Test
    public void backCfm() {
    	
    	String inStr = getArgStringForCfm();

        try {	
        	InDTO inDto = parseInDTO(inStr, SMicroPayBackCfmInDTO.class);
            SMicroPayBackCfmOutDTO out = (SMicroPayBackCfmOutDTO)bean.backCfm(inDto);
            String result = out.toJson();
            System.out.println("result = " + result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
	
}

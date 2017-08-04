package com.sitech.acctmgr.test.atom.impl.adj;

import com.sitech.acctmgr.atom.dto.adj.SGivenCfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.SGivenCfmOutDTO;

import com.sitech.acctmgr.inter.adj.IGivenMicroPay;

import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

import org.junit.Before;
import org.junit.Test;


/**
 * Created by com on 16/10/20.
 */
public class sGivenMicroPayTest  extends BaseTestCase {

    /**
     * 名称：
     * @param
     * @return
     * @throws
     */
    @Before
    public void setUp() throws Exception {
    }

    /**
     * 名称：
     * @param
     * @return
     * @throws
     */
    @Test
    public void testCfm() {

        IGivenMicroPay iGivenMicroPay = (IGivenMicroPay) getBean("givenMicroPaySvc");

        try {
            MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"A1\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"" +
                    "BODY\":{\"OPR_INFO\":{\"LOGIN_NO\": \"aan70s\",	\"LOGIN_PASSWORD\":\"xxxxxxxx\" ,\"GROUP_ID\": \"13436\"}," +
                    "\"BUSI_INFO\":{\"PHONE_NO\":\"13944161250\",\"GIVE_FEE\":\"2000\",\"PUB_FLAG\": \"0\",\"SERVE_TYPE\": \"2\"" +
                    ",\"FOREIGN_SN\": \"11111\",\"GPRS\": \"10\",\"MARK_PRC\": \"#\",\"MARK_SN\": \"#\"}}}}");

            InDTO in = parseInDTO(inMBean, SGivenCfmInDTO.class);
            SGivenCfmOutDTO out = (SGivenCfmOutDTO)iGivenMicroPay.cfm(in);
            String result = out.toJson();
            System.out.println("result = " + result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}

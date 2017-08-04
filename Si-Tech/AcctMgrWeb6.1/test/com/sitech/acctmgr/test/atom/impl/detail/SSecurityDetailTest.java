package com.sitech.acctmgr.test.atom.impl.detail;

import com.sitech.acctmgr.atom.dto.detail.SSecurityDetailQueryInDTO;
import com.sitech.acctmgr.inter.detail.ISecurityDetail;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2016/11/12.
 */
public class SSecurityDetailTest extends BaseTestCase {
    private ISecurityDetail bean;

    @Before
    public void setUp() throws Exception {
        bean = (ISecurityDetail) getBean("securityDetailSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13514515213");
        busiMap.put("QUERY_TYPE", "25");
        busiMap.put("QUERY_FLAG", "0"); //0:时间段
        busiMap.put("BEGIN_TIME", "20160901");
        busiMap.put("END_TIME", "20160930");
        busiMap.put("YEAR_MONTH", "");

        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8121");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, SSecurityDetailQueryInDTO.class);

        OutDTO outDTO = bean.query(inDTO);

        System.out.println(outDTO.toJson());
    }

}

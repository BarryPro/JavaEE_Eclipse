package com.sitech.acctmgr.test.atom.impl.detail;

import com.sitech.acctmgr.atom.dto.detail.SGrpDetailQueryInDTO;
import com.sitech.acctmgr.inter.detail.IGrpDetail;
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
 * Created by wangyla on 2016/7/12.
 */
public class SGrpDetailTest extends BaseTestCase{
    private IGrpDetail bean;

    @Before
    public void setUp() throws Exception {
        bean = (IGrpDetail) getBean("grpDetailSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForChannelQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("GRP_CUST_ID", "230780003000668803");
        busiMap.put("QUERY_TYPE", "01");
        busiMap.put("QUERY_FLAG", "1");//0:时间段， 1：帐务月
        busiMap.put("BEGIN_TIME", "");
        busiMap.put("END_TIME", "");
        busiMap.put("YEAR_MONTH", "201610");
        busiMap.put("CONFERENCE_ID", "");
        busiMap.put("CALLING_NUMBER", "");
        busiMap.put("IS_PAGE", "");
        busiMap.put("PAGE_NO", "");
        busiMap.put("PAGE_SIZE", "");

        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8119");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForChannelQuery();
        InDTO inDTO = parseInDTO(inStr, SGrpDetailQueryInDTO.class);

        OutDTO outDTO = bean.query(inDTO);

        System.out.println(outDTO.toJson());
    }
}
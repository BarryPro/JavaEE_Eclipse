package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.SGrpFreeIndivQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SGrpFreeShareQueryInDTO;
import com.sitech.acctmgr.inter.free.IGrpFree;
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
 * Created by wangyla on 2016/8/5.
 */
public class SGrpFreeTest extends BaseTestCase{
    private IGrpFree bean;

    @Before
    public void setUp(){
        bean = (IGrpFree) getBean("grpFreeSvc");
    }
    @After
    public void tearDown() throws Exception {
        bean = null;
    }
    private String getArgStringForShareQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "1234");
        busiMap.put("YEAR_MONTH", "201703");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8114");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testShareQuery() throws Exception {

        String inStr = getArgStringForShareQuery();
        InDTO inDto = parseInDTO(inStr , SGrpFreeShareQueryInDTO.class);

        OutDTO outDto = bean.shareQuery(inDto);
        System.out.println(outDto.toJson());

    }

    private String getArgStringForIdivQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15094649610");  //13796014541 此用户为有集团共享流量的哈尔滨用户
        busiMap.put("YEAR_MONTH", "201612");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8114");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testIndivQuery() throws Exception {

        String inStr = getArgStringForIdivQuery();
        InDTO inDto = parseInDTO(inStr , SGrpFreeIndivQueryInDTO.class);

        OutDTO outDto = bean.indivQuery(inDto);
        System.out.println(outDto.toJson());

    }
}
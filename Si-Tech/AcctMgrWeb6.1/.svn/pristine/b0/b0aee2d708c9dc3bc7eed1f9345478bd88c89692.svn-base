package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.SMzoneFreeQueryInDTO;
import com.sitech.acctmgr.inter.free.IMzoneFree;
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
public class SMzoneFreeTest extends BaseTestCase{
    private IMzoneFree bean;

    @Before
    public void setUp(){
        bean = (IMzoneFree) getBean("mzoneFreeSvc");
    }
    @After
    public void tearDown() throws Exception {
        bean = null;
    }
    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15946724432");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        oprMap.put("OP_CODE", "0000");
        oprMap.put("GROUP_ID", "724");
        oprMap.put("PROVINCE_ID", "230000");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
    @Test
    public void testQuery() throws Exception {

        String inStr = getArgStringForQuery();
        InDTO inDto = parseInDTO(inStr , SMzoneFreeQueryInDTO.class);

        OutDTO outDto = bean.query(inDto);
        System.out.println(outDto.toJson());

    }
}
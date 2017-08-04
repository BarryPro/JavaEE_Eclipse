package com.sitech.acctmgr.test.atom.impl.query;

import com.sitech.acctmgr.atom.dto.query.S8291QueryInDTO;
import com.sitech.acctmgr.inter.query.I8291;
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
 * Created by wangyla on 2016/11/11.
 */
public class S8291Test extends BaseTestCase {
    private I8291 bean;

    @Before
    public void setUp() throws Exception {
        bean = (I8291) getBean("8291Svc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15146855609");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String indtoStr = this.getArgStringForQuery();
        InDTO inDTO = parseInDTO(indtoStr, S8291QueryInDTO.class);

        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());
    }
}

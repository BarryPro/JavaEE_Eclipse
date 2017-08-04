package com.sitech.acctmgr.test.atom.impl.detail;

import com.sitech.acctmgr.atom.domains.detail.TargetPhoneEntity;
import com.sitech.acctmgr.atom.dto.detail.SDetailCheckCheckInDTO;
import com.sitech.acctmgr.inter.detail.IDetailCheck;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

/**
 * Created by wangyla on 2016/10/11.
 */
public class SDetailCheckTest extends BaseTestCase{
    private IDetailCheck bean;

    @Before
    public void setUp() throws Exception {
        bean = (IDetailCheck) getBean("detailCheckSvc");
    }

    private String getArgStringForCheck() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "18246348389");
        busiMap.put("BEGIN_TIME", "20161001");
        busiMap.put("END_TIME", "20161030");

        List<TargetPhoneEntity> tpeList = new ArrayList<>();

        TargetPhoneEntity tpe1 = new TargetPhoneEntity();
        tpe1.setQueryType("7005");
        tpe1.setTargetPhone("18345630242");
        tpeList.add(tpe1);

        tpe1 = new TargetPhoneEntity();
        tpe1.setQueryType("7005");
        tpe1.setTargetPhone("18945755987");
        tpeList.add(tpe1);

        tpe1 = new TargetPhoneEntity();
        tpe1.setQueryType("7005");
        tpe1.setTargetPhone("13244633387");
        tpeList.add(tpe1);

        busiMap.put("PHONE_LIST", tpeList);

        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "0000");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testCheck() throws Exception {
        String inStr = this.getArgStringForCheck();
        InDTO inDto = parseInDTO(inStr, SDetailCheckCheckInDTO.class);
        OutDTO outDto = bean.check(inDto);
        System.out.println(outDto.toJson());
    }
}
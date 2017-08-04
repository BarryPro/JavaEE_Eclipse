package com.sitech.acctmgr.test.atom.impl.volume;

import com.sitech.acctmgr.atom.dto.volume.SGrpVolumeDataSynInDTO;
import com.sitech.acctmgr.inter.volume.IGrpVolume;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2017/3/28.
 */
public class SGrpVolumeTest extends BaseTestCase {
    private IGrpVolume bean;

    @Before
    public void setUp() {
        bean = (IGrpVolume) getBean("grpVolumeSvc");
    }

    private String getRequestForSyn() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("ORDER_ID", "18249070556");

        busiMap.put("PS_ID", "0");
        busiMap.put("UNIT_ID_NO", "0");
        busiMap.put("GOODS_ID", "00");

        busiMap.put("BUYS_DATE", "20170328");
        busiMap.put("BUYS_NUMBER", "1");
        busiMap.put("BUYS_SIZE", "1");
        busiMap.put("BUYS_PRICE", "1"); //请求头信息
        busiMap.put("SALE_EFF_DATE", "20170328");
        busiMap.put("SALE_EXP_DATE", "20170528");

        busiMap.put("SALE_DATE", "20170328");
        busiMap.put("SALE_NUMBER", "1");
        busiMap.put("SALE_SIZE", "1");
        busiMap.put("SALE_PRICE", "1");
        busiMap.put("BUYER_ID", "1111");
        busiMap.put("BUYER_PHONE", "1111111");
        busiMap.put("USE_EFF_DATE", "20170328");
        busiMap.put("USE_EXP_DATE", "20170528");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("OP_CODE", "10014");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testDataSyn() throws Exception {

        String inStr = this.getRequestForSyn();
        InDTO inDto = parseInDTO(inStr, SGrpVolumeDataSynInDTO.class);
        OutDTO outDto = bean.dataSyn(inDto);
        System.out.println(outDto.toJson());

    }
}

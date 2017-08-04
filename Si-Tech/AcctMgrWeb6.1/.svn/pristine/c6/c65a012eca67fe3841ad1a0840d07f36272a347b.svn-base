package com.sitech.acctmgr.test.atom.impl.acctmng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.collection.CollEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionFileCheckInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionFileCreateInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionFileInsertTableInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionFileReCreateInDTO;
import com.sitech.acctmgr.inter.acctmng.ICollectionFile;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/8.
 */
public class SCollectionFileTest extends BaseTestCase {
    private ICollectionFile bean;

    @Before
    public void setUp() throws Exception {
        bean = (ICollectionFile) getBean("collectionFileSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForCreate() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("BEG_CONTRACT", "230740002001009431");
        busiMap.put("END_CONTRACT", "230740002001009431");
        busiMap.put("YEAR_MONTH", "201610");
        busiMap.put("POST_BANK_CODE", "001");
        busiMap.put("OPER_TYPE", "00403");
        busiMap.put("ENTER_CODE", "00023");
        busiMap.put("DISTRICT_CODE", "10044");

        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8229");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testCreate() throws Exception {
        String inStr = this.getArgStringForCreate();
        InDTO inDTO = parseInDTO(inStr, SCollectionFileCreateInDTO.class);
        OutDTO outDTO = bean.create(inDTO);
        System.out.println(outDTO.toJson());

    }

    private String getArgStringForReCreate() {
        ArgumentBuilder builder = new ArgumentBuilder();

        List<CollEntity> collList = new ArrayList<>();
        CollEntity collEnt1 = new CollEntity();
        collEnt1.setContractNo(230740002001009431L);
        collEnt1.setPayFee(80);

        collList.add(collEnt1);

        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("COLL_INFO", collList);
        busiMap.put("YEAR_MONTH", "201610");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "3108");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testReCreate() throws Exception {
        String inStr = this.getArgStringForReCreate();
        InDTO inDTO = parseInDTO(inStr, SCollectionFileReCreateInDTO.class);
        OutDTO outDTO = bean.reCreate(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testCheck() throws Exception {
        String inStr = this.getArgStringForReCreate();
        InDTO inDTO = parseInDTO(inStr, SCollectionFileCheckInDTO.class);
        OutDTO outDTO = bean.check(inDTO);
        System.out.println(outDTO.toJson());
    }
    
    private String getArgStringForInsert() {
        ArgumentBuilder builder = new ArgumentBuilder();
        
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("YEAR_MONTH", "201702");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "newweb");
        oprMap.put("GROUP_ID", "13436");
        oprMap.put("OP_CODE", "8229");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
    
    @Test
    public void testInsert() throws Exception {
    	String inStr = this.getArgStringForInsert();
    	InDTO inDTO = parseInDTO(inStr,SCollectionFileInsertTableInDTO.class);
        OutDTO outDTO = bean.insertTable(inDTO);
        System.out.println(outDTO.toJson());
    }
    
    
}
package com.sitech.acctmgr.test.atom.impl.query;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SDistrictRegionGetRegionListInDTO;
import com.sitech.acctmgr.atom.dto.query.SDistrictRegionQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetGroupListInDTO;
import com.sitech.acctmgr.inter.query.IDistrictRegion;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/6.
 */
public class SDistrictRegionTest extends BaseTestCase{
    private IDistrictRegion bean;

    @Before
    public void setUp() throws Exception {
        bean = (IDistrictRegion) getBean("districtRegionSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "csgj13");
        oprMap.put("GROUP_ID", "13968");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDto = parseInDTO(inStr, SDistrictRegionQueryInDTO.class);
        OutDTO outDto = bean.query(inDto);
        System.out.println(outDto.toJson());

    }

    private String getArgStringForList() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();

        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testGetRegionList() throws Exception {
        String inStr = this.getArgStringForList();
        InDTO inDto = parseInDTO(inStr, SDistrictRegionGetRegionListInDTO.class);
        OutDTO outDto = bean.getRegionList(inDto);
        System.out.println(outDto.toJson());
    }

	private String getArgStringForGroupList() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("DISTRICT_GROUP", "10146");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();

		builder.setOperargs(oprMap);
		oprMap.put("PROVINCE_ID", "230000");
		return builder.toString();
	}

	@Test
	public void testGetGroupList() throws Exception {
		String inStr = this.getArgStringForGroupList();
		System.err.println(inStr);
		InDTO inDto = parseInDTO(inStr, SGetGroupListInDTO.class);
		OutDTO outDto = bean.getGroupList(inDto);
		System.err.println(outDto.toJson());
	}

}
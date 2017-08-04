package com.sitech.acctmgr.test.atom.entity;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.test.junit.BaseTestCase;

public class ProdTest extends BaseTestCase {
	private IProd bean;

	@Before
	public void setUp() throws Exception {
		bean = (IProd) getBean("prodEnt");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetPrcDictByPrid() {

		IProd prod = (IProd) getBean("prodEnt");

		String inPrcid = "22CAS25089713";
		Map<String, Object> outMap = null;
	}

	@Test
	public void testGetUserPrcidInfo() throws Exception {
		long idNo = 230180010000068881L;
		System.out.println(bean.getUserPrcidInfo(idNo));
	}

	@Test
	public void testGetPdPrcInfo() throws Exception {
		String prcId = "23MAZ07795";
		System.out.println(bean.getPdPrcInfo(prcId));
	}

	@Test
	public void testGetPdPrcId() throws Exception {
		long idNo = 230180010000068881L;
		System.out.println(bean.getPdPrcId(idNo, null,null,null));
	}

	@Test
	public void testGetPdPrcInfoMap() throws Exception {
		long idNo = 230840002011462474L;
		Map<String, Object> inMap = new HashMap<>();
		inMap.put("ID_NO", idNo);
		inMap.put("ON_FLAG", "");

		System.out.println(bean.getPdPrcInfo(inMap));
	}


	@Test
	public void testHasPrcId() throws Exception {
		long idNo = 230310010000640115L;
		String prcId = "M000910";

		System.out.println(bean.hasPrcid(idNo, prcId));
	}
}

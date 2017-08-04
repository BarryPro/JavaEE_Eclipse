package com.sitech.acctmgr.test.atom.entity;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.GroupEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.test.junit.BaseTestCase;

public class GroupTest  extends BaseTestCase {

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetRegionDisticnt() {
		
		IGroup group = (IGroup) getBean("groupEnt");
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		ChngroupRelEntity  outMap = null;
		inMap.put("GROUP_ID", "49716");
		inMap.put("PARENT_LEVEL", 3);
		
		try {
			group.getRegionDistinct("49716", "3", "23000");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + outMap.toString());
	}
	
	@Test
	public void testGetChgGroup() {
		
		IGroup group = (IGroup) getBean("groupEnt");
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		GroupchgInfoEntity outMap = null;
		inMap.put("ID_NO", "220400200024322050");
		inMap.put("PHONE_NO", "15886095842");
		
		try {
			group.getChgGroup("15886095842", 220400200024322050L, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + outMap.toString());
	}
	
	@Test
	public void testGetGroupName() {
		
		IGroup group = (IGroup) getBean("groupEnt");
		
		GroupEntity  outMap = null;
		String group_id = "51684";
		
		try {
			outMap = group.getGroupInfo("51684", null, "23000");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + outMap.toString());
	}


}

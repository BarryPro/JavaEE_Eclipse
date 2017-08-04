package com.belong.fastjson;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.belong.vo.Address;
import com.belong.vo.User;
/*
 * 自动把属性和属性的值组成键直对来输出
 */
public class Json {
	@Test
	public void arrayJson(){//数组转换成json
		String [] a = {"belong","josn","john","tom","jack"};
		String jsonText = JSON.toJSONString(a,true);
		System.out.println(jsonText);
	}
	@Test
	public void arrayJson2(){//复杂的数组
		User us[]={
				new User("001","mike",20,   new Address("广东省1","深圳市","科苑南路","580053")),
				new User("002","jack",10,   new Address("广东省2","深圳市","科苑南路","580053")),
				new User("003","rose",40,new Address("广东省3","深圳市","科苑南路","580053"))					
		};
		String s=JSON.toJSONString(us, true);
		System.out.println(s);
	}
	@Test
	public void jsonArray(){//将json转换成json数组（必须把双引号转意成双引号才可以）
		String jsonText = "[\"bill\",\"green\",\"maks\",\"jim\"]";  
		JSONArray a = JSON.parseArray(jsonText);
		System.out.println(a);
	}
	@Test
	public void listJson(){//将list转换成json
		List <User>list = new ArrayList <User>();  
		User user1 = new User("L001","TOM",16, null);  
		list.add(user1);  
		User user2 = new User("L002","JACKSON",21, null);  
		list.add(user2);  
		User user3 = new User("L003","MARTIN",20, null);  
		list.add(user3);  
		String json = JSON.toJSONString(list,true);
		System.out.println(json);
	}
	@Test
	public void listJson2(){//复杂的list
		List<User> list = new ArrayList<User>();  
		Address address1 = new Address("广东省","深圳市","科苑南路","580053");  
		User user1 = new User("L001","TOM",16,address1);  
		list.add(user1);  
		Address address2 = new Address("江西省","南昌市","阳明路","330004");  
		User user2 = new User("L002","JACKSON",21,address2);  
		list.add(user2);  
		Address address3 = new Address("陕西省","西安市","长安南路","710114");  
		User user3 = new User("L003","MARTIN",20, address3);  
		list.add(user3);  
		String jsonText = JSON.toJSONString(list, true);  
		System.out.println("list2Json2()方法：jsonText=="+jsonText);  
	}
	@Test
	public void mapJson(){//将map转换成json是{ 而不是[
		Map<String ,User> map = new HashMap<String,User>();
		map.put("A",new User("L001","TOM",16, null));
		map.put("B",new User("L002","ALICE",17, null));
		map.put("C",new User("L003","Betty",18, null));
		map.put("D",new User("L004","Rose",19, null));
		
		String s=JSON.toJSONString(map, true);
		System.out.println(s);  
	}
	@Test
	public void mapJson2(){
		Map<String,List<User>> map =new HashMap<String,List<User>>();
		List<User> list=new ArrayList<User>();
		list.add(new User("L001","TOM",16, null));
		list.add(new User("L002","ALICE",17, null));		
		map.put("A", list);		
		List<User> list1=new ArrayList<User>();
		list1.add(new User("L003","Betty",16, null));
		list1.add(new User("L004","Rose",17, null));		
		map.put("B", list1);
		String s=JSON.toJSONString(map, true);
		System.out.println(s);  
	}
}

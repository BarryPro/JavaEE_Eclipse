<%
  /*
   * 功能: 组织结构树
   * 版本: 1.0.0
   * 日期: 2006/11/01
   * 作者: xiening
   * 版权: si-tech
  */
%>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import ="java.util.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
System.out.println("groupTreeXml.jsp");
System.out.println("-------------groupTreeXml进入组织结构树生成XML------------");
//获取session信息
ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
String[][] baseInfoSession = (String[][])arrSession.get(0);
String[][] otherInfoSession = (String[][])arrSession.get(2);
String loginNo = baseInfoSession[0][2];
String loginName = baseInfoSession[0][3];
String powerCode= otherInfoSession[0][4];
String power_right= baseInfoSession[0][5];
String orgCode = baseInfoSession[0][16];
String ip_Addr = request.getRemoteAddr();
String regionCode = orgCode.substring(0,2);
String regionName = otherInfoSession[0][5];
String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
String[][] pass = (String[][])arrSession.get(4);
String nopass  = pass[0][0];
String groupId="";
String groupName="";

String isRoot = request.getParameter("isRoot");

	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	//获取根节点
	if ("true".equals(isRoot))
	{
		String strSql = "select b.group_id, a.group_name from dChnGroupMsg a, dLoginMsg b "
			+ "where b.login_no = '" + loginNo + "' and a.group_id = b.group_id";

		System.out.println("++++"+strSql+"++++");
		comImpl comResult = new comImpl();
		ArrayList acceptList = comResult.spubqry32("2",strSql);

		String[][] rootGroupMsg = (String[][])acceptList.get(0);

		groupId = rootGroupMsg[0][0];
		groupName = rootGroupMsg[0][1];

	}

	System.out.println("Xml:groupId="+groupId);
	System.out.println("Xml:groupName="+groupName);
	
	//获取父节点
	String startGroupId = request.getParameter("groupId");
	if(startGroupId==null||startGroupId.length()==0)
	{
		startGroupId = groupId;
	}

	String startGroupName = request.getParameter("groupName");
	if(startGroupName==null||startGroupName.length()==0)
	{
		startGroupName = groupName;
	}

	System.out.println("startGroupId="+startGroupId);
	System.out.println("startGroupName="+startGroupName);

	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	System.out.println("+++++++++++++++"+request.getParameter("isDel"));
	String isDel = request.getParameter("isDel");
	String roleCode =request.getParameter("roleCode");
	if(isDel==null)
	{
		isDel = "N";
	}

	//调服务获取子节点
	String paraArr[] = new String[8];
	paraArr[0] = loginNo;
	paraArr[1] = nopass;
	paraArr[2] = "8021";
	paraArr[3] = "a";
	paraArr[4] = startGroupId;
	paraArr[5] = isDel;
	paraArr[6] = roleCode;
	paraArr[7] = "B";
%>
	<wtc:service name="s8021_Qry06" outnum="13" >
	<wtc:params value="<%=paraArr%>" />
	</wtc:service> 
	<wtc:array id="result" scope="end"/>
<%
	int len = result.length;
	if(!retCode.equals("000000"))
	{
		throw new Exception("s8021_Qry06报错！错误代码"+retCode+"！错误信息："+retMsg);
	}
	else
	{
		Document document = DocumentHelper.createDocument();
		Map map = new HashMap();
		Element tmpElm = null;

		if ("true".equals(isRoot))
		{
			tmpElm = document.addElement("TreeNode").addElement("TreeNode");
		}
		else
		{
			tmpElm = document.addElement("TreeNode");
		}
		tmpElm.addAttribute("text",startGroupName);
		tmpElm.addAttribute("id", startGroupId);
		tmpElm.addAttribute("href","javascript:saveTo(\""+startGroupId+"\",\""+startGroupName+"\")");
		map.put(startGroupId, tmpElm);

		System.out.println("本次调用节点数量="+len);
		for (int i = 0; i < len; i++)
		{
			String groupId2=result[i][0];	//组织编号
			String groupName2=result[i][1];//组织名称
			String flag=result[i][12];//叶节点标志 Y/N(Y有子节点)
			//System.out.println("flag:"+flag);
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null)
			{
				throw new Exception("组织资料表数据错误！组织编号：" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",groupName2.trim());
			tmpElm.addAttribute("id", groupId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+groupId2+"\",\""+groupName2+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("N"))
			{
				String url = "groupTreeXml.jsp?groupId="+groupId2.trim()+"&groupName="+groupName2.trim()+"&isDel="+isDel+"&roleCode="+roleCode;
				tmpElm.addAttribute("Xml", url);
			}

			map.put(groupId2.trim(), tmpElm);

		}
		if(len==0)
		{
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null)
			{
				throw new Exception("组织资料表数据错误！组织编号：" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","没有找到数据！");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
		}
		output.write(document);
		output.close();
	}
%>
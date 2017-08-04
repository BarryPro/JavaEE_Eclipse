<%
  /*
   * 功能: 功能代码树。
   * 版本: 1.0.0
   * 日期: 2006/11/01
   * 作者: wuln
   * 版权: si-tech
  */
%>
<%@ page language="java" contentType="text/xml;charset=GBK" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import ="java.util.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
System.out.println("-----------------------进入功能代码树生成XML------------------------");
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
String popeDomCode="";//下级权限代码
String popeDomName="";//下级权限名称
String roleCode = request.getParameter("roleCode");	//角色代码

SPubCallSvrImpl callView = new SPubCallSvrImpl();
ArrayList acceptList = new ArrayList();	

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0)
{
	isRoot = "false";
}
	
	//获取根节点
	if ("true".equals(isRoot))
	{
		String paraArr[] = new String[5];
		paraArr[0] = loginNo;
		paraArr[1] = "8008";
		paraArr[2] = "0";//popeDomCode 根权限代码
		paraArr[3] = roleCode;
		paraArr[4] = ""; 
%>
		<wtc:service name="sQryPDOMList" outnum="4" retmsg="retMsg" retcode="retCode" 
			 routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />	
			<wtc:param value="<%=paraArr[2]%>" />	
			<wtc:param value="<%=paraArr[3]%>" />	
			<wtc:param value="<%=paraArr[4]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
<%
		String errMsg=retMsg;
		
		
		if(!"000000".equals(retCode))
		{
			throw new Exception("sQryPDOMList报错！错误代码"+retCode+"！错误信息："+errMsg);
		}
		else
		{
			popeDomCode=result_t[0][0];
			popeDomName=result_t[0][1];
		}
		System.out.println("***sQryPDOMList***"+popeDomCode+"**"+popeDomName+"..**");
	}
	
	//获取父节点
	String startPopeDomCode = request.getParameter("popeDomCode");
	if(startPopeDomCode==null||startPopeDomCode.length()==0)
	{
		startPopeDomCode = popeDomCode;
	}
	
	String startPopeDomName = request.getParameter("popeDomName");
	if(startPopeDomName==null||startPopeDomName.length()==0)
	{
		startPopeDomName = popeDomName;
	}
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	System.out.println("------------------调服务sQryPDOMList获取子节点-------------------");
	//调服务获取子节点
	String paraArr[] = new String[5];
	paraArr[0] = loginNo;
	paraArr[1] = "8008";
	paraArr[2] = startPopeDomCode; 
	paraArr[3] = roleCode; 
	paraArr[4] = ""; 
%>
			<wtc:service name="sQryPDOMList" outnum="4" retmsg="retMsg2" retcode="retCode2" 
			 routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />	
			<wtc:param value="<%=paraArr[2]%>" />	
			<wtc:param value="<%=paraArr[3]%>" />	
			<wtc:param value="<%=paraArr[4]%>" />	
		</wtc:service>
		<wtc:array id="result_t2" scope="end"  />
<%
	
	if(!"000000".equals(retCode2))
	{
		throw new Exception("sQryPDOMList报错！错误代码"+retCode2+"！错误信息："+retMsg2);
	}
	else
	{
		int len = result_t2.length;
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
		tmpElm.addAttribute("text",startPopeDomName);
		tmpElm.addAttribute("id", startPopeDomCode);
		tmpElm.addAttribute("href","javascript:saveTo(\""+startPopeDomCode+"\",\""+startPopeDomName+"\")");
		map.put(startPopeDomCode, tmpElm);
		
		/*
		String[][] popeDomCodeArr=(String[][])acceptList2.get(0);		//下级权限代码
		String[][] popeDomNameArr=(String[][])acceptList2.get(1);		//下级权限名称
		String[][] hasChildArr=(String[][])acceptList2.get(2);			//叶节点标志 Y/N(Y有子节点)
		String[][] sFuncCode=(String[][])acceptList2.get(3);
		*/
		System.out.println("本次调用节点数量="+len);
		
		for (int i = 0; i < len; i++)
		{
			String popeDomCode2=result_t2[i][0];
			String popeDomName2=result_t2[i][1];
			String flag=result_t2[i][2];
			String funcCode=result_t2[i][3];
			
			System.out.println(">>>>>>>>>>>>"+popeDomCode2+"|"+popeDomName2+">>>>>>");
			
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null)
			{
				throw new Exception("权限表数据错误！权限编号：" + startPopeDomCode.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			
			tmpElm.addAttribute("text",popeDomName2.trim()+"["+funcCode.trim()+"]");
			tmpElm.addAttribute("id", popeDomCode2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+popeDomCode2+"\",\""+popeDomName2+"\")");
			//如果是叶节点将作为目录
			if(flag.equals("Y"))
			{
				String	url = "funcTreeXml.jsp?roleCode="+roleCode+"&popeDomCode="+popeDomCode2.trim()+"&popeDomName="+popeDomName2.trim();			  
				tmpElm.addAttribute("Xml", url);
			}
			map.put(popeDomCode2.trim(), tmpElm);
		}
		if(len==0)
		{
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null) 
			{
				throw new Exception("权限表数据错误！权限编号：" + startPopeDomCode.trim());
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
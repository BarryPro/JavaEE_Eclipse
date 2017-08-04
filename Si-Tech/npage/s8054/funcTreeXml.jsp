   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-27
********************/
%>
              
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>

<%
	System.out.println("-----------------------进入功能代码树生成XML------------------------");
	//获取session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	
	
	String loginNo = (String)session.getAttribute("workNo");
	String powerCode= baseInfoSession[0][4];
	String regionCode = (String)session.getAttribute("regCode");
	
	String popeDomCode="";//下级权限代码
	String popeDomName="";//下级权限名称
	String rtFuncCode=""; //权限对应func
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleTypeCode = request.getParameter("roleTypeCode");
	System.out.println("!!!!!!!!roleCode="+roleCode);
	System.out.println("!!!!!!!!roleTypeCode="+roleTypeCode);
	ArrayList acceptList = new ArrayList();

	String isRoot = request.getParameter("isRoot");

	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	//获取根节点
	if ("true".equals(isRoot))
	{
		String paraArr[] = new String[6];
		paraArr[0] = loginNo;
		paraArr[1] = "8054";
		paraArr[2] = "0";//popeDomCode 根权限代码
		paraArr[3] = roleCode;
		paraArr[4] = powerCode;
		paraArr[5] = roleTypeCode;

		//acceptList = callView.callFXService("sQryPDOMList",paraArr,"4","region",regionCode);
		%>
		
    <wtc:service name="sQryPDOMList" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />
			<wtc:param value="<%=paraArr[2]%>" />
			<wtc:param value="<%=paraArr[3]%>" />			
			<wtc:param value="<%=paraArr[4]%>" />	
			<wtc:param value="<%=paraArr[5]%>" />	
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />		
		
		
		<%
		String errCode=code1;
		String errMsg=msg1;
		System.out.println("--------------------------errCode1-----------------------"+errCode);
		if(!errCode.equals("000000"))
		{
			throw new Exception("sQryPDOMList报错！错误代码"+errCode+"！错误信息："+errMsg);
		}
		else
		{
			popeDomCode=result_t1[0][0];
			popeDomName=result_t1[0][1];
			rtFuncCode=result_t1[0][3];
		}
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

	//调服务获取子节点
	String paraArr[] = new String[6];
	paraArr[0] = loginNo;
	paraArr[1] = "8054";
	paraArr[2] = startPopeDomCode;
	paraArr[3] = roleCode;
	paraArr[4] = powerCode;
	paraArr[5] = roleTypeCode;
	ArrayList acceptList2 = new ArrayList();
	//acceptList2 = callView.callFXService("sQryPDOMList",paraArr,"4","region",regionCode);
	%>
	
    <wtc:service name="sQryPDOMList" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />
			<wtc:param value="<%=paraArr[2]%>" />
			<wtc:param value="<%=paraArr[3]%>" />			
			<wtc:param value="<%=paraArr[4]%>" />	
			<wtc:param value="<%=paraArr[5]%>" />	
		</wtc:service>
		<wtc:array id="popeDomCodeArr" scope="end" start="0"  length="1" />
		<wtc:array id="popeDomNameArr" scope="end" start="1"  length="1" />
		<wtc:array id="hasChildArr" scope="end" start="2"  length="1" />	
		<wtc:array id="funcCode" scope="end" start="3"  length="1" />		

	<%
	String errCode =code2;
	String errMsg=msg2;
System.out.println("--------------------------errCode2-----------------------"+errCode);
	if(!errCode.equals("000000"))
	{
		throw new Exception("sQryPDOMList报错！错误代码"+errCode+"！错误信息："+errMsg);
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
		tmpElm.addAttribute("text",startPopeDomName);
		tmpElm.addAttribute("id", startPopeDomCode);
		tmpElm.addAttribute("href","javascript:saveTo(\""+startPopeDomCode+"\",\""+startPopeDomName+"\",\""+roleTypeCode+"\")");
		map.put(startPopeDomCode, tmpElm);


		System.out.println("本次调用节点数量="+popeDomCodeArr.length);
		for (int i = 0; i < popeDomCodeArr.length; i++)
		{
			String popeDomCode2=popeDomCodeArr[i][0];
			String popeDomName2=popeDomNameArr[i][0];
			String flag=hasChildArr[i][0];
			String chFuncCode=funcCode[i][0];
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null)
			{
				throw new Exception("权限表数据错误！权限编号：" + startPopeDomCode.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",popeDomName2.trim()+"["+chFuncCode.trim()+"]");
			tmpElm.addAttribute("id", popeDomCode2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+popeDomCode2+"\",\""+popeDomName2+"\",\""+roleTypeCode+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("Y")){
			String	url = "funcTreeXml.jsp?roleCode="+roleCode+"&popeDomCode="+popeDomCode2.trim()
				+"&popeDomName="+popeDomName2.trim()+"&roleTypeCode="+roleTypeCode;
			tmpElm.addAttribute("Xml", url);
			}

			map.put(popeDomCode2.trim(), tmpElm);
		}
		if(popeDomCodeArr.length==0){
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null) {
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
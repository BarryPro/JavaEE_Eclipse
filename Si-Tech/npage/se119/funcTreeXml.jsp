<%
/********************
 version v2.0
 开发商 si-tech
 update anln@2009-2-25
********************/
%>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>

<%
System.out.println("-----------------------进入功能代码树生成XML------------------------");
	//获取session信息
	String loginNo =(String)session.getAttribute("workNo");
	String powerCode= (String)session.getAttribute("powerCode");
	String regionCode = (String)session.getAttribute("regCode");

	String popeDomCode="";//下级权限代码
	String popeDomName="";//下级权限名称
	
	String roleCode = request.getParameter("roleCode");
	System.out.println("11111111111roleCode="+roleCode);
	String isRoot = request.getParameter("isRoot");
	if(isRoot==null||isRoot.length()==0){
		isRoot = "false";
	}
	String loginNo1 = request.getParameter("loginNo1");	//新建或修改的工号代码	
	//获取根节点
	if ("true".equals(isRoot))
	{
		String	strSql = " select popedom_code, '工号["+loginNo+"]权限树' from sPopeDOmCode where par_domcode = 0";
		//acceptList = callView.sPubSelect("2",strSql,"region",regionCode);			
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
	<%
		String errCode=retCode1;
		String errMsg=retMsg1;
		if(!errCode.equals("000000"))
		{
			throw new Exception("查询角色权限树出错！错误代码"+errCode+"！错误信息："+errMsg);
		}
		else
		{
			String[][] rootList = result;
			popeDomCode = rootList[0][0];
			popeDomName= rootList[0][1];
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
	
	System.out.println("startPopeDomCode="+startPopeDomCode);
	System.out.println("startPopeDomName="+startPopeDomName);
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	//调服务获取子节点
	String paraArr[] = new String[5];
	paraArr[0] = loginNo;
	paraArr[1] = "e121";
	paraArr[2] = startPopeDomCode; 
	paraArr[3] = powerCode;
	paraArr[4] = roleCode;
	//ArrayList acceptList2 = new ArrayList();				
	//acceptList2 = callView.callFXService("sQryPDOMList",paraArr,"4","region",regionCode);
%>
	<wtc:service name="sQryPDOMList" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=paraArr[0]%>"/>
		<wtc:param value="<%=paraArr[1]%>"/>
		<wtc:param value="<%=paraArr[2]%>"/>
		<wtc:param value="<%=paraArr[3]%>"/>
		<wtc:param value="<%=paraArr[4]%>"/>
	</wtc:service>	
	<wtc:array id="popeDomCodeArr" start="0" length="1" scope="end"/>
	<wtc:array id="popeDomNameArr" start="1" length="1" scope="end"/>
	<wtc:array id="hasChildArr" start="2" length="1" scope="end"/>
	<wtc:array id="sfuncCode" start="3" length="1" scope="end"/>
<%
	String errCode =retCode2;
	String errMsg=retMsg2;
	
	if(!errCode.equals("000000"))
	{
		throw new Exception("sQryPDOMList报错！错误代码"+errCode+"！错误信息："+errMsg);
	}
	else{
		
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
		
		//String[][] popeDomCodeArr=(String[][])acceptList2.get(0);		//下级权限代码
		//String[][] popeDomNameArr=(String[][])acceptList2.get(1);		//下级权限名称
		//String[][] hasChildArr=(String[][])acceptList2.get(2);			//叶节点标志 Y/N(Y有子节点)
		//String[][] sfuncCode=(String[][])acceptList2.get(3);
		
		System.out.println("本次调用节点数量="+popeDomCodeArr.length);
		for (int i = 0; i < popeDomCodeArr.length; i++)
		{
			String popeDomCode2=popeDomCodeArr[i][0];
			String popeDomName2=popeDomNameArr[i][0];
			String flag=hasChildArr[i][0];
			String funcCode=sfuncCode[i][0];
			
			System.out.println("flag:"+flag);
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null)
			{
				throw new Exception("权限表数据错误！权限编号：" + startPopeDomCode.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",popeDomName2.trim());  //+"["+funcCode.trim()+"]"
			tmpElm.addAttribute("id", popeDomCode2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+popeDomCode2+"\",\""+popeDomName2+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("Y"))
			{
				String	url = "funcTreeXml.jsp?loginNo1="+loginNo1+"&popeDomCode="+popeDomCode2.trim()+"&popeDomName="+popeDomName2.trim()+"&roleCode="+roleCode;			  
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
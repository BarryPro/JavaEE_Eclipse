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
System.out.println("-----------------------进入角色结构树生成XML------------------------");
	//获取session信息
	String loginNo =(String)session.getAttribute("workNo");	
	String regionCode = (String)session.getAttribute("regCode");
	String powerCode=  (String)session.getAttribute("powerCode");
	
	String roleCode="01011L";
	String roleName="系统管理员工作台角色";
	String roleTypeName="4";
	String powerDes="系统管理员工作台角色";

	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();	

	String isRoot = request.getParameter("isRoot");
	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	
	 
		
	//获取父节点
	String startRoleId = request.getParameter("roleId");
	if(startRoleId==null||startRoleId.length()==0)
	{
		startRoleId = roleCode;
	}
	System.out.println("111111111111startRoleId"+startRoleId);
	String startRoleName = request.getParameter("roleName");
	if(startRoleName==null||startRoleName.length()==0)
	{
		startRoleName = roleName;
	}
	System.out.println("111111111111startRoleId"+startRoleId);
	String startRoleTypeName = request.getParameter("roleTypeName");
	if(startRoleTypeName==null||startRoleTypeName.length()==0)
	{
		startRoleTypeName = roleTypeName;
	}
	System.out.println("111111111111startRoleId"+startRoleId);
	String startPowerDes = request.getParameter("powerDes");
	if(startPowerDes==null||startPowerDes.length()==0)
	{
		startPowerDes = powerDes;
	}
	System.out.println("111111111111startRoleId"+startRoleId);
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	//获取子节点
	System.out.println("111111111111startRoleId"+startRoleId);
	System.out.println("222222222loginNo"+loginNo);
	String strSql1 = " select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE,  "+
					 " decode((select count(*) from sPowerCode where power_code like trim(a.power_code)||'%' and use_flag ='Y'),1,'Y','N') "+	
					 "  from sPowerCode a, sRoleTypeCode b ,dLoginMsg c, dpowerobjrelation d"+	
					 " where a.power_code like '"+startRoleId+"%' and length(trim(a.power_code)) = length('"+startRoleId+"')+2 "+
					 "   and a.roletype_code = b.ROLETYPE_CODE and a.use_flag='Y' "+
					 "   and c.login_no='"+loginNo+"'"+
					 "   and Trim(c.group_id)=Trim(d.object_id)"+
					 "   and d.power_code=a.power_code"+
					 "   order by a.power_code ";
	//ArrayList acceptList2 = new ArrayList();							 
	//acceptList2 = callView.sPubSelect("5",strSql1,"region",regionCode);		
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="5">
		<wtc:sql><%=strSql1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="acceptList2" scope="end" />
	<%	
	String errCode =retCode2;
	String errMsg=retMsg2;
	
	if(!errCode.equals("000000"))
	{
		throw new Exception("查询角色树出错！错误代码"+errCode+"！错误信息："+errMsg);
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
		tmpElm.addAttribute("text",startRoleName+"["+startRoleId+"]");
		tmpElm.addAttribute("id", startRoleId);
		
		System.out.println("startRoleId["+startRoleId+"],startRoleName["+startRoleName+"]startRoleTypeName["+startRoleTypeName+"],startPowerDes["+startRoleTypeName+"]");
		
	//	tmpElm.addAttribute("href","javascript:saveTo(\""+startRoleId+"\",\""+startRoleName+"\",\""+startRoleTypeName+"\",\""+startPowerDes+"\")");
		map.put(startRoleId, tmpElm);
		
		String[][] rootList2 = acceptList2;
		

		System.out.println("本次调用节点数量="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++)
		{
			String roleId2=rootList2[i][0];
			String roleName2=rootList2[i][1];
			String roleTypeName2=rootList2[i][2];
			String powerDes2=rootList2[i][3];
			String flag=rootList2[i][4];

			Element parentElm = (Element) map.get(startRoleId);
			if (parentElm == null)
			{
				throw new Exception("角色数据错误！角色编号：" + startRoleId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",roleName2.trim()+"["+roleId2.trim()+"]");
			tmpElm.addAttribute("id", roleId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+roleId2+"\",\""+roleName2+"\",\""+roleTypeName2+"\",\""+powerDes2+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("N"))
			{
				String url = "roleTreeXml.jsp?roleId="+roleId2.trim()+"&roleName="+roleName2.trim()+"&roleTypeName="+roleTypeName2.trim()+"&powerDes="+powerDes2.trim();			  
				tmpElm.addAttribute("Xml", url);
			}
			
			map.put(roleId2.trim(), tmpElm);
		}
		if(rootList2.length==0)
		{
			Element parentElm = (Element) map.get(startRoleId);
			if (parentElm == null)
			{
				throw new Exception("角色表数据错误！组织编号：" + startRoleId.trim());
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

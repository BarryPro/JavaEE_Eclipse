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
	
	String roleCode="mp00";
	String roleName="工作台角色 ";
	String roleTypeName="5";
	String powerDes="工作台角色";


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
	String strSql1 = "select a.power_code,a.power_name,'工作台类',a.POWER_DESCRIBE ,decode((select count(*) from sPowerCodemop where power_code like trim(a.power_code)||'%' and use_flag ='Y'),1,'Y','N') 	,"+
					 "a.USE_FLAG,a.OP_NOTE,a.CREATE_LOGIN,a.CREATE_DATE,b.login_name,b.org_code "+
                     "from sPowerCodemop a ,dloginmsg b "+
               		 "where a.use_flag = 'Y' and a.CREATE_LOGIN=b.login_no "+
                 	 "and a.power_code like '"+startRoleId+"%' "+
                 	 "and length(trim(a.power_code)) = length('"+startRoleId+"') + 2";
                 	 
                 	 System.out.println(strSql1);
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="11">
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
		tmpElm.addAttribute("href","javascript:saveTo(\""+startRoleId+"\",\""+startRoleName+"\",'5','工作台类角色','Y','工作台类角色根节点','系统','2011-09-20','系统','')");
		
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
			
			String retUseFlag      = rootList2[i][5];
			String retOpNote       = rootList2[i][6];
			String retCreatLogin   = rootList2[i][7];
			String retCreatDate    = rootList2[i][8];
			String retCreatName    = rootList2[i][9];
			String retCreatGroup   = rootList2[i][10];

			Element parentElm = (Element) map.get(startRoleId);
			if (parentElm == null)
			{
				throw new Exception("角色数据错误！角色编号：" + startRoleId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",roleName2.trim()+"["+roleId2.trim()+"]");
			tmpElm.addAttribute("id", roleId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+roleId2+"\",\""+roleName2+"\",\""+roleTypeName2+"\",\""+powerDes2+"\",\""+retUseFlag+"\",\""+retOpNote+"\",\""+retCreatLogin+"\",\""+retCreatDate+"\",\""+retCreatName+"\",\""+retCreatGroup+"\")");
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

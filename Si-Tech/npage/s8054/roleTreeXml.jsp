   
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

<%
System.out.println("-----------------------进入角色结构树生成XML------------------------");
//获取session信息
String loginNo = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

String roleCode="";
String roleName="";
String roleTypeCode="";
String roleTypeName="";
String powerDes="";


String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0){
	isRoot = "false";
}


	//获取根节点
	if ("true".equals(isRoot))
	{
		String	strSql = "select a.power_code, a.power_name, b.roletype_code, b.ROLETYPE_NAME,a.POWER_DESCRIBE "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c "+
                     " where c.login_no='"+loginNo+"'"+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=c.power_code"+
                     "   and a.power_code in (select d.power_code from dpowerobjrelation d " +
                     "   where Trim(d.object_id) = Trim(c.group_id))";
		//acceptList = callView.sPubSelect("5",strSql,"region",regionCode);
		%>
		
		<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=strSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>		
		
		<%
		String errCode=code1;
		String errMsg=msg1;
		System.out.println("----------------errCode----------------"+errCode);
		if(!errCode.equals("000000"))
		{
			throw new Exception("查询角色树出错！错误代码"+errCode+"！错误信息："+errMsg);
		}
		else
		{
		String[][] rootList = result_t1;
		
		System.out.println("--------------------rootList[0][0]------------------"+rootList[0][0]);
		System.out.println("--------------------rootList[0][1]------------------"+rootList[0][1]);
		System.out.println("--------------------rootList[0][2]------------------"+rootList[0][2]);
		System.out.println("--------------------rootList[0][3]------------------"+rootList[0][3]);
		System.out.println("--------------------rootList[0][4]------------------"+rootList[0][4]);
			
			roleCode = rootList[0][0];
			roleName= rootList[0][1];
			roleTypeCode = rootList[0][2];
			roleTypeName= rootList[0][3];
			powerDes= rootList[0][4];
		}
	}

	//获取父节点
	String startRoleId = request.getParameter("roleId");
	if(startRoleId==null||startRoleId.length()==0)
	{
		startRoleId = roleCode;
	}

	String startRoleName = request.getParameter("roleName");
	if(startRoleName==null||startRoleName.length()==0)
	{
		startRoleName = roleName;
	}

	String startRoleTypeName = request.getParameter("roleTypeName");
	if(startRoleTypeName==null||startRoleTypeName.length()==0)
	{
		startRoleTypeName = roleTypeName;
	}

	String startPowerDes = request.getParameter("powerDes");
	if(startPowerDes==null||startPowerDes.length()==0)
	{
		startPowerDes = powerDes;
	}

	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;

	//获取子节点
	String strSql1 = " select a.power_code, a.power_name, b.roletype_code, b.ROLETYPE_NAME,a.POWER_DESCRIBE,  "+
					 " decode((select count(*) from sPowerCode where power_code like trim(a.power_code)||'%' and use_flag ='Y'),1,'Y','N') "+
					 "  from sPowerCode a, sRoleTypeCode b ,dLoginMsg c, dpowerobjrelation d"+
					 " where a.power_code like '"+startRoleId+"%' and length(trim(a.power_code)) = length('"+startRoleId+"')+2 "+
					 "   and a.roletype_code = b.ROLETYPE_CODE and a.use_flag='Y' "+
					 "   and c.login_no='"+loginNo+"'"+
					 "   and Trim(c.group_id)=Trim(d.object_id)"+
					 "   and d.power_code=a.power_code"+
					 "   order by a.power_code ";


//	acceptList2 = callView.sPubSelect("6",strSql1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=strSql1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%
	String errCode = code2;
	String errMsg= msg2;
System.out.println("----------------errCode----------------"+errCode);
	
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
		//tmpElm.addAttribute("href","javascript:saveTo(\""+startRoleId+"\",\""+startRoleName+"\",\""+startRoleTypeName+"\",\""+startPowerDes+"\",\""+roleTypeCode+"\")");
		map.put(startRoleId, tmpElm);

		String[][] rootList2 = result_t2;
 
		System.out.println("本次调用节点数量="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++)
		{
			System.out.println("--------------------rootList2["+i+"][0]--------------------"+rootList2[i][0]);
			System.out.println("--------------------rootList2["+i+"][1]--------------------"+rootList2[i][1]);
			System.out.println("--------------------rootList2["+i+"][2]--------------------"+rootList2[i][2]);
			System.out.println("--------------------rootList2["+i+"][3]--------------------"+rootList2[i][3]);
			System.out.println("--------------------rootList2["+i+"][4]--------------------"+rootList2[i][4]);
			System.out.println("--------------------rootList2["+i+"][5]--------------------"+rootList2[i][5]);
			String roleId2=rootList2[i][0];
			String roleName2=rootList2[i][1];
			String roleTypeCode2=rootList2[i][2];
			String roleTypeName2=rootList2[i][3];
			String powerDes2=rootList2[i][4];
			String flag=rootList2[i][5];

			Element parentElm = (Element) map.get(startRoleId);
			if (parentElm == null)
			{
				throw new Exception("角色数据错误！角色编号：" + startRoleId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",roleName2.trim()+"["+roleId2.trim()+"]");
			tmpElm.addAttribute("id", roleId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+roleId2+"\",\""+roleName2+"\",\""+roleTypeName2+"\",\""+powerDes2+"\",\""+roleTypeCode2+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("N")){
				String url = "roleTreeXml.jsp?roleId="+roleId2.trim()+"&roleName="+roleName2.trim()+"&roleTypeName="+roleTypeName2.trim()+"&powerDes="+powerDes2.trim();
				tmpElm.addAttribute("Xml", url);
			}
 
			map.put(roleId2.trim(), tmpElm);
		}
		System.out.println("---------------------------rootList2.length-------------------------"+rootList2.length);
		if(rootList2.length==0){
			Element parentElm = (Element) map.get(startRoleId);
			System.out.println("---------------------------parentElm-------------------------"+parentElm);
			if (parentElm == null) {
				throw new Exception("角色表数据错误！组织编号：" + startRoleId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","没有找到数据！");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
		}
		output.write(document);
		output.close();
		System.out.println("---------------------------OK-------------------------");
	}
%>
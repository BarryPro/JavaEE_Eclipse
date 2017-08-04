<%
/********************
 version v2.0
 开发商 si-tech
 update anln@2009-2-19
********************/
%>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import ="java.util.*" %>

<%
	System.out.println("-----------------------进入角色结构树生成XML------------------------");
	//获取session信息
	String loginNo =(String)session.getAttribute("workNo");
	String powerCode= (String)session.getAttribute("powerCode");
	String regionCode = (String)session.getAttribute("regCode");
	
	String roleCode="";
	String roleName="";
	String roleTypeCode="";
	String powerDes="";
	String useFlag="";
	String opNote="";
	String creatLogin="";
	String creatDate="";
	String creatName="";
	String creatGroup="";
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();	

	String isRoot = request.getParameter("isRoot");
	if(isRoot==null||isRoot.length()==0){
		isRoot = "false";
	}
	
	
	//获取根节点
	if ("true".equals(isRoot))
	{
		String	strSql = "select a.power_code, a.power_name, b.ROLETYPE_CODE,a.POWER_DESCRIBE ,a.USE_FLAG,trim(a.OP_NOTE),a.CREATE_LOGIN,a.CREATE_DATE,c.login_Name,e.group_name "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c ,dchngroupmsg e"+    
                     " where c.login_no='"+loginNo+"'"+
                     "   and c.group_id=e.group_id "+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=c.power_code"+
                     "   and a.power_code in (select d.power_code from dpowerobjrelation d where Trim(d.object_id) = Trim(c.group_id))";
	
		//acceptList = callView.sPubSelect("10",strSql,"region",regionCode);	
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%				
		String errCode=retCode1;
		String errMsg=retMsg1;
		System.out.println("errCodeerrCodeerrCodeerrCode"+errCode);
		if(!errCode.equals("000000")){
			throw new Exception("查询角色树出错！错误代码"+errCode+"！错误信息："+errMsg);
		}
		else
		{
			//String[][] rootList = (String[][])acceptList.get(0);
			String[][] rootList =result;
			roleCode = rootList[0][0];
			roleName= rootList[0][1];
			roleTypeCode= rootList[0][2];
			powerDes= rootList[0][3];
			useFlag= rootList[0][4];
			opNote= rootList[0][5];
			creatLogin= rootList[0][6];
			creatDate= rootList[0][7];
			creatName= rootList[0][8];
			creatGroup= rootList[0][9];
			
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
	
	String startRoleTypeCode = request.getParameter("roleTypeCode");
	
	if(startRoleTypeCode==null||startRoleTypeCode.length()==0){
		startRoleTypeCode = roleTypeCode;
	}
	
	String startPowerDes = request.getParameter("powerDes");
	if(startPowerDes==null||startPowerDes.length()==0){
		startPowerDes = powerDes;
	}
	
	String startUseFlag = request.getParameter("useFlag");
	if(startUseFlag==null||startUseFlag.length()==0){
		startUseFlag = useFlag;
	}
	
	String startOpNote = request.getParameter("opNote");
	if(startOpNote==null||startOpNote.length()==0){
		startOpNote = opNote;
	}

	String startCreatLogin = request.getParameter("creatLogin");
	if(startCreatLogin==null||startCreatLogin.length()==0){
		startCreatLogin = creatLogin;
	}
	
	String startCreatDate = request.getParameter("creatDate");
	if(startCreatDate==null||startCreatDate.length()==0){
		startCreatDate = creatDate;
	}
	
	String startCreatName = request.getParameter("creatName");
	if(startCreatName==null||startCreatName.length()==0){
		startCreatName = creatName;
	}
	
	String startCreatGroup = request.getParameter("creatGroup");
	if(startCreatGroup==null||startCreatGroup.length()==0){
		startCreatGroup = creatGroup;
	}	
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
  	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	//获取子节点
	String strSql1 = " select a.power_code, a.power_name, b.ROLETYPE_CODE, "+
					 " a.POWER_DESCRIBE,a.USE_FLAG,trim(a.OP_NOTE) ,a.create_login,a.create_date,c.login_name,d.group_name,  "+
					 " decode((select count(*) from sPowerCode where power_code like trim(a.power_code)||'%'),1,'Y','N') "+
					 " from sPowerCode a, sRoleTypeCode b ,dloginmsg c,dloginmsg f,dchngroupmsg d, dpowerobjrelation e "+
					 " where a.power_code like '"+startRoleId+"%'  "+
					 " and length(trim(a.power_code)) = length('"+startRoleId+"')+2   "+
					 " and a.roletype_code = b.ROLETYPE_CODE   "+
					 " and a.create_login=c.login_no   "+
					 " and c.group_id=d.group_id  "+
					 " and f.login_no='"+loginNo+"'"+
					 " and Trim(f.group_id)=Trim(e.object_id)"+
					 " and e.power_code=a.power_code"+
					 " order by a.power_code  ";
	
	//ArrayList acceptList2 = new ArrayList();
	//acceptList2 = callView.sPubSelect("11",strSql1,"region",regionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="11">
		<wtc:sql><%=strSql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
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
		tmpElm.addAttribute("href","javascript:saveTo(\""+startRoleId+"\",\""+startRoleName+"\",\""+startRoleTypeCode+"\",\""+startPowerDes+"\",\""+startUseFlag+"\",\""+startOpNote+"\",\""+startCreatLogin+"\",\""+startCreatDate+"\",\""+startCreatName+"\",\""+startCreatGroup+"\")");
		map.put(startRoleId, tmpElm);
		
		//String[][] rootList2 = (String[][])acceptList2.get(0);
		String[][] rootList2 =result2;

		System.out.println("本次调用节点数量="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++)
		{
			String roleId2=rootList2[i][0];
			String roleName2=rootList2[i][1];
			String roleTypeCode2=rootList2[i][2];
			String powerDes2=rootList2[i][3];
			String useFlag2=rootList2[i][4];
			String opNote2=rootList2[i][5];
			String creatLogin2=rootList2[i][6];
			String creatDate2=rootList2[i][7];
			String creatName2=rootList2[i][8];
			String creatGroup2=rootList2[i][9];
			String flag=rootList2[i][10];
			
			Element parentElm = (Element) map.get(startRoleId);
			if (parentElm == null)
			{
				throw new Exception("角色数据错误！角色编号：" + startRoleId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",roleName2.trim()+"["+roleId2.trim()+"]");
			tmpElm.addAttribute("id", roleId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+roleId2+"\",\""+roleName2+"\",\""+roleTypeCode2+"\",\""+powerDes2+"\",\""+useFlag2+"\",\""+opNote2+"\",\""+creatLogin2+"\",\""+creatDate2+"\",\""+creatName2+"\",\""+creatGroup2+"\")");
			//如果不是叶节点将作为目录
			if(flag.equals("N")){
				String url = "roleTreeXml.jsp?roleId="+roleId2.trim()+"&roleName="+roleName2.trim()+"&roleTypeCode="+roleTypeCode2.trim()+"&powerDes="+powerDes2.trim()+"&useFlag="+useFlag2.trim()+"&creatLogin="+creatLogin2.trim()+"&creatDate="+creatDate2.trim()+"&creatName="+creatName2.trim()+"&creatGroup="+creatGroup2.trim()+"&opNote="+opNote2.trim();			  
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
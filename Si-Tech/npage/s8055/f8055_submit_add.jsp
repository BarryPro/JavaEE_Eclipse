<%
   /*
   * 功能: 角色发布 - 增加处理
　 * 版本: v1.0
　 * 日期: 2007/06/25
　 * 作者: hanfa
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.06
 模块: 角色发布
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>	

<%
	
	String loginNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
	
	String opCode = "8055";
	String opName = "角色发布"; 	
		
	String power_code = request.getParameter("power_code");            
	String objectId = request.getParameter("objectId");
	String[] objectIds = objectId.split(",");
	
	String loginNote = loginNo + "发布角色代码[" + power_code + "]";
	
	
    ArrayList list = new ArrayList();
    
    list.add(new String[]{loginNo});      //工号         
	list.add(new String[]{nopass});       //密码         
	list.add(new String[]{opCode});       //操作代码     
	list.add(new String[]{ip_Addr});      //工号IP       
	list.add(new String[]{loginNote});    //操作备注     
	list.add(new String[]{power_code});	  //角色代码     
	list.add(objectIds);	              //发布组织节点 
	
	//String[] acceptArray = new String[]{};
	String errCode = "";
	String errMsg ="";
	String url = "";
	
	try
	{	   
		//acceptArray = impl.callService("s8055_Ist", list, "2","region", regionCode);	
%>
		<wtc:service name="s8055_Ist" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>	
		<wtc:param value="<%=opCode%>"/>	
		<wtc:param value="<%=ip_Addr%>"/>	
		<wtc:param value="<%=loginNote%>"/>	
		<wtc:param value="<%=power_code%>"/>	
		<wtc:params value="<%=objectIds%>"/>		
		</wtc:service>	
		<wtc:array id="acceptArray"  scope="end"/>
<%
		errCode = retCode1;
		errMsg = retMsg1;
		//url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+""+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+""+"&contactType=user";
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}	

	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("操作成功！",2);
			 document.location.replace("<%=request.getContextPath()%>/npage/s8055/f8055_1.jsp");
		//	 removeCurrentTab();
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("错误信息：<%=errMsg%><br>错误代码：<%=errCode%>", 0);
	          document.location.replace("<%=request.getContextPath()%>/npage/s8055/f8055_1.jsp");
	          //history.go(-1);
	      </script>         
<%            
    }
%>
 
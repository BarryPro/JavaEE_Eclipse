   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "8008";
  String opName = "注册新功能";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%

	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String roleCode =baseInfoSession[0][4];//角色代码
	
	String regionCode = (String)session.getAttribute("regCode");
	String sqlStr = "select power_name from spowercode where power_code = '"+roleCode+"' ";	
 	
	//acceptList = callView.sPubSelect("1",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%	
	String[][] colNameArr = result_t1;	
	
		if (colNameArr != null)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
			}
		}	
	String roleName = "roleName";	//角色代码
	if(colNameArr!=null)
	{
		roleName=colNameArr[0][0];
	}
	

%>
  <frameset rows="*" cols="240,*" framespacing="0" frameborder="no" border="0">
  
<%  
	
	out.println("<frame src=\"functree.jsp?roleCode="+roleCode+"&roleName="+roleName+"\"   name=\"leftFrame\" scrolling=\"Yes\" noresize=\"noresize\" id=\"leftFrame\" />");
   
 	out.println("<frame src=\"funclist.jsp?roleCode="+roleCode+"&roleName="+roleName+"\"   name=\"rightFrame\"  id=\"rightFrame\" />");
%>  
  </frameset>
<noframes></noframes>
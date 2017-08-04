<%
   /*
   * 功能: 查询营业员常用功能
　 * 版本: v1.0
　 * 日期: 2008年4月17日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
    String workNo = (String)session.getAttribute("workNo");
		String org_code = (String)session.getAttribute("orgCode");
		String password = (String)session.getAttribute("password");
		String regionCode=org_code.substring(0,2);
%>

<wtc:service name="sIndexFuncSel" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">


<div class="itemContent">
	<div id="content">
  	<table cellpadding="0" cellspacing="0">
<%if(retCode.equals("000000")){
// by xingzhan 20090225 屏蔽普通开户、换卡变更、GSM过户、留言日志
out.print("<tr class=\'jiange\'>");
for(int i=0;i<result.length;i++){

 	if(!"普通开户".equals(result[i][1])&&!"换卡变更".equals(result[i][1])&&!"GSM过户".equals(result[i][1])&&!"留言日志".equals(result[i][1])){  
		%>	
		<td><a href=javascript:parent.parent.L("<%=result[i][5]%>","<%=result[i][0]%>","<%=result[i][1]%>","<%=result[i][2]%>","<%=result[i][4]%>")  ><img src="../../../nresources/default/images/arrow_link_orange.gif" width="3" height="5"><%=result[i][1]%></a></td>
		<%
	}
}
out.print("</tr>");  	
}                 
%>  

<%if(retCode.equals("000010")){
		if(result.length>0){
			int rows=0;
		  rows=result.length/4;           
		  for(int j=0;j<rows;j++)
		  {
		  	out.print("<tr class=\'jiange\'>");
		    for(int k=0;k<4;k++)
		    { 
		             
%>   			
        	<td><a href=javascript:parent.parent.L("<%=result[k+j*4][5]%>","<%=result[k+j*4][0]%>","<%=result[k+j*4][1]%>","<%=result[k+j*4][2]%>","<%=result[k+j*4][4]%>")  ><img src="../../../nresources/default/images/arrow_link_orange.gif" width="3" height="5"><%=result[k+4*j][1]%></a></td>
<%
						
        }
        out.print("</tr>");}
        if(result.length%4!=0){out.print("<tr class=\'jiange\'>");
		    	for(int n=0;n<result.length%4;n++){ 
		    			
		    			
%>   
          <td><a href=javascript:parent.parent.L("<%=result[n+4*rows][5]%>","<%=result[n+4*rows][0]%>","<%=result[n+4*rows][1]%>","<%=result[n+4*rows][2]%>","<%=result[n+4*rows][4]%>") ><img src="../../../nresources/default/images/arrow_link_orange.gif" width="3" height="5"><%=result[n+4*rows][1]%></a></td>
<%				
						
				}
        out.print("</tr>");}
     }                  
 }
%>      	    	
    </table>
  </div>
</div>

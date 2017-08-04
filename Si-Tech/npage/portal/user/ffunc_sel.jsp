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

<%@ include file="/npage/common/portalInclude.jsp" %>

<%
    String workNo = (String)session.getAttribute("workNo");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
%>

<%@ include file="/npage/login/dispatch.jsp" %>

<wtc:service name="sIndexFuncSel" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<div class="itemContent">
	<div id="content">
  	<table cellpadding="0" cellspacing="0">
<%if(retCode.equals("000000")){
		if(result.length>0){
			int rows=0;
		  rows=result.length/3;           
		  for(int j=0;j<rows;j++)
		  {
		  	out.print("<tr class=\'jiange\'>");
		    for(int k=0;k<3;k++)
		    {           
		    String tmp = getLink(result[k+j*3][5],result[k+j*3][2],result[k+j*3][0],session,request,result[k+j*3][1]);
%>   
        	<td><a href=javascript:parent.parent.openPage("<%=result[k+j*3][5]%>","<%=result[k+j*3][0]%>","<%=result[k+j*3][1]%>","<%=tmp%>","<%=result[k+j*3][3]%>")  ><img src="../../../nresources/default/images/arrow_link_orange.gif" width="3" height="5"><%=result[k+3*j][1]%></a></td>
<%
        }
        out.print("</tr>");}
        if(result.length%3!=0){out.print("<tr class=\'jiange\'>");
		    	for(int n=0;n<result.length%3;n++){   
		    		String tmp = getLink(result[n+3*rows][5],result[n+3*rows][2],result[n+3*rows][0],session,request,result[n+3*rows][1]);        
%>   
          <td><a href=javascript:parent.parent.openPage("<%=result[n+3*rows][5]%>","<%=result[n+3*rows][0]%>","<%=result[n+3*rows][1]%>","<%=tmp%>","<%=result[n+3*rows][3]%>") ><img src="../../../nresources/default/images/arrow_link_orange.gif" width="3" height="5"><%=result[n+3*rows][1]%></a></td>
<%				}
        for(int m=0;m<(3-result.length%3);m++){           
%>   
          <td>&nbsp;&nbsp;&nbsp;</td>
<%				}
        out.print("</tr>");}
     }                  
 }
%>      	
    </table>
  </div>
</div>

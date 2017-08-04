<%
   /*
   * 功能: 查询用户开通服务信息
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
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  //String phone_no = (String)session.getAttribute("activePhone");
  String phone_no = (String)request.getParameter("activePhone");
  System.out.println("phone_no = "+phone_no);
%>

<wtc:service name="sServiceMsg" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
  <wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<div  id="form">
    <table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list" id="serviceMsg">
  	<tr> 
    	<th>特服类型</th>
		<th>开通时间</th>
		<th>到期时间</th>
	  </tr>
    <%
		if(retCode.equals("000000")){
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	      	String classes="";
					if(i%2==1){classes="grey";}
					{
			%>	             
		<tr>
			<td class="<%=classes%>"><%=result[i][0]%> </td>
			<td class="<%=classes%>"><%=result[i][1]%> </td>
			<td class="<%=classes%>"><%=result[i][2]%>  </td>
		</tr>
		 <%
		       }
			  }
			 }
		}
		%>	
  </table>
</div>
 <script>
 $("#wait1").hide();		   
 </script>
 

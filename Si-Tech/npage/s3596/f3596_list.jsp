<%
   /*
   * 功能: 订购业务列表
　 * 版本: v1.0
　 * 日期: 2009年04月19日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String sPhoneNo = request.getParameter("sPhoneNo");
  String opCode=request.getParameter("opCode");/*huangrong update for 关于求职通业务支撑的函  2011-8-1 */
  
  System.out.println("sPhoneNo:"+sPhoneNo);	  
  
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="25%" nowrap>业务代码</th>
	        <th width="25%" nowrap>业务名称</th>
	        <th width="25%" nowrap>套餐代码</th>
	        <th width="25%" nowrap>套餐名称</th>		 		        
	      </tr>
        <tbody>
<wtc:service name="s3596InitEXC" outnum="12" routerKey="region" routerValue="<%=regionCode%>">			
	<wtc:param value="<%=workNo%>"/>	
	<wtc:param value="<%=sPhoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
</wtc:service>
<wtc:array id="result" start="6" length="4"  scope="end" />
<%
if(retCode.equals("000000")){
System.out.println("-------------length="+result.length);
	if(result.length>0){
		for(int i=0;i<result.length;i++){			
%>
  			  <tr>
  			   		
					  <td>
					  <%=result[i][0]%>					  	
					  </td>
					  <td class="p_Name"><%=result[i][1]%>
					  </td>
					  <td class="p_Name"><%=result[i][2]%>
					  </td>
					  <td class="p_Name"><%=result[i][3]%>
					  </td>
	        </tr>
<%
    }
  }
}
%>

 </tbody>
		</form>
	</table>
</div>

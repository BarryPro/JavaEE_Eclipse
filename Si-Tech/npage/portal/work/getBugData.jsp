<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年4月15日
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
		 String regionCode=org_code.substring(0,2);
%>
<wtc:service name="sBugSel" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th nowrap></th>
	        <th nowrap>状态</th>
	        <th nowrap>简述</th>
	        <th nowrap>发起时间</th>
	        <th nowrap>故障级别</th>
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
             <td  class="<%=classes%>" nowrap>
             		<input type="checkbox" name="checkbug" value="<%=i%>">
             		<input type="hidden" name="bugid" value="<%=result[i][4]%>">
             </td>
					<%			
					if(result[i][0].trim().equals("Y"))
					{%>
						<td class="<%=classes%>" nowrap><span class="green">已回复</span></td>
					<%}else{%>
						<td  class="<%=classes%>" nowrap><span class="orange">未回复</span></td>
					<%}%>
	          <td  class="<%=classes%>" ><a href="javascript:formDetail(<%=result[i][4]%>)" ><%=result[i][1]%></a></td>
	          <td  class="<%=classes%>" nowrap><%=result[i][2]%></td>
	   			<% 	
					if(result[i][3].trim().equals("L"))
					{%>
						<td class="<%=classes%>" nowrap><span class="blue">低</span></td>
					<%}else if(result[i][3].trim().equals("M")){
					%>
						<td class="<%=classes%>" nowrap><span class="green">中</span></td>
					<%}else if(result[i][3].trim().equals("H")){
					%>
						<td class="<%=classes%>" nowrap><span class="orange">高</span></td>   
					<%}%>       	   	
	        </tr>
  			<%
        }
       }
     }
  }%>
		</form>           
	</table>
</div>
		   
<script>
   $("#wait2").hide();
   function formDetail(bugid){
   		window.open('bugsinsel.jsp?bugid='+bugid,'','height=450, width=400,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes' )
   }
</script>
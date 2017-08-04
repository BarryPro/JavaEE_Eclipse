<%
    /*************************************
    * 功  能: 实名制审批查询  m086
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2013-4-15
    **************************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode =request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String passwd = (String)session.getAttribute("password");
	String phoneNo = request.getParameter("phoneNo");
	String tm_b = request.getParameter("tm_b");
	String tm_e = request.getParameter("tm_e");
	String regCode = (String)session.getAttribute("regCode");
	String opName = request.getParameter("opName");
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name = "sM086Qry" outnum = "6"	routerKey = "region" routerValue = "<%=regCode%>" retcode = "retCode" retmsg = "retMsg" >
	<wtc:param value = "<%=printAccept%>"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
	<wtc:param value = "<%=phoneNo%>"/>
	<wtc:param value = ""/>
	<wtc:param value = "<%=tm_b%>"/>
	<wtc:param value = "<%=tm_e%>"/>
</wtc:service>
<wtc:array id="ret" scope="end" />
<%
	System.out.println("diling--ret.length="+ret.length);
	if("000000".equals(retCode)){
%>
		<div id="Main">
			<div id="Operation_Table">
				<div class="title">
					<div id="title_zi">实名制审批查询结果</div>
				</div>
				<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>手机号码</th> 
					<th>审批状态 </th> 
					<th>审批时间</th> 
					<th>审批工号</th> 
					<th>登记来源</th> 
					<th>审批不通过原因</th> 
				</tr>
				<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
				%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=ret[i][5]%></td>
					</tr>
				<%
					}
				}
				%>
				</table>
			</div>
		</div>
<%		
		}else{
%>
			<script language="javascript">
				rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>", 0);
				window.location.href="fm086_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
		}
%> 	

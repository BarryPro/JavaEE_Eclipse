<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
 
<%
     String gCustId = request.getParameter("gCustId") == null ? "100004992435" : request.getParameter("gCustId") ;
     String regionCode = request.getParameter("regionCode");
     String finishFlag = request.getParameter("finishFlag") == null ? "14" : request.getParameter("finishFlag");
      
%>
<!--取客户订单信息-->
<wtc:utype name="sQCustOrders" id="retCustOrderInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
     <wtc:uparam value="<%=finishFlag%>" type="INT"/>     
</wtc:utype>
<%
     UtypeUtil.read(retCustOrderInfo,0,out);
%>
<div id="operation">  
 	<div id="operation_table">
 		<div class="title"><div class="text">基本信息</div></div>
		<div class="list">
			<table>
				<tr>
					<th>订单编号</th>
					<th>服务号码</th>
					<th>业务类型</th>
					<th>创建时间</th>
					<th>当前环节</th>
					<th>当前状态</th>					 
				</tr>
				 
			</table>
		</div>
	</div>
</div>



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
<!--ȡ�ͻ�������Ϣ-->
<wtc:utype name="sQCustOrders" id="retCustOrderInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
     <wtc:uparam value="<%=finishFlag%>" type="INT"/>     
</wtc:utype>
<%
     UtypeUtil.read(retCustOrderInfo,0,out);
%>
<div id="operation">  
 	<div id="operation_table">
 		<div class="title"><div class="text">������Ϣ</div></div>
		<div class="list">
			<table>
				<tr>
					<th>�������</th>
					<th>�������</th>
					<th>ҵ������</th>
					<th>����ʱ��</th>
					<th>��ǰ����</th>
					<th>��ǰ״̬</th>					 
				</tr>
				 
			</table>
		</div>
	</div>
</div>



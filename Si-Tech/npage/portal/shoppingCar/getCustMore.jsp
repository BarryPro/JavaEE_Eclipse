<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%
	String gCustId = request.getParameter("custId");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String retCode ="";
	String retMsg  ="";
%>
<wtc:utype name="sQCustOrders" id="retCustOrder" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
     <wtc:uparam value="14" type="INT"/>
</wtc:utype>

<wtc:utype name="sQryCustCons" id="retConsOrder" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>


<div class="item-col col-1">
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
			<div class="list" id="list1" style="height:100px;overflow-y:auto;overflow-x:hidden;_width:100%">
				<table cellspacing="0">
					<tr>
						<th nowrap >�������</th>
						<th nowrap >ҵ�����</th>
						<th nowrap >����</th>
						<th nowrap >ҵ������</th>
						<th nowrap >״̬</th>
						<th nowrap >״̬�仯���� </th>
						<th nowrap >��������</th>
					</tr>
			<%
				retCode =retCustOrder.getValue(0);
				if(retCode.equals("0"))
				{
					int xsize = retCustOrder.getSize("2");
					%>
					<script>
						if("<%=xsize%>">5)
						{
							$("#list1")[0].style.overflowY="scroll";
						}
					</script>
					<%
					for(int i=0; i<xsize ;i++)		
          {
			%>		
					<tr>
						<td nowrap ><span style="cursor:pointer;color:#ff9900" onclick="getCar('<%=retCustOrder.getValue("2."+i+".0")%>','<%=retCustOrder.getValue("2."+i+".9")%>')"><%=retCustOrder.getValue("2."+i+".0")%></span></td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".10")%>&nbsp;</td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".2")%></td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".4")%></td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".6")%></td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".7").substring(0,8)%></td>
						<td nowrap ><%=retCustOrder.getValue("2."+i+".8").substring(0,8)%></td>
					</tr>
			<%
					}
				}
			%>
				</table>
			</div>
</div>

<div class="item-row col-2">
<div class="title">
	<div id="title_zi">�˻���Ϣ</div>
</div>
	<div class="list" id="list2" style="height:100px; overflow-y:auto; overflow-x:hidden;_width:100%;">
		<table cellspacing="0">
			<tr>
				<th>ID</th>
				<!-- 2014/10/08 9:14:08 gaopeng ��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409�� ȥ�� ���ֵ�չʾ-->
				<th>��������</th>
			</tr>
			<%
		retCode =retConsOrder.getValue(0);
		if(retCode.equals("0"))
		{
			int xsize = retConsOrder.getSize("2");
			%>
			<script>
				if("<%=xsize%>">3)
				{
					$("#list2")[0].style.overflowY="scroll";
				}
			</script>
			<%
			for(int i=0; i<xsize ;i++)		
      {
	%>
			<tr>
				<td><%=retConsOrder.getValue("2."+i+".0")%></td>
				<!-- 2014/10/08 9:14:08 gaopeng ��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409�� ȥ�� ���ֵ�չʾ-->
				<td><%=retConsOrder.getValue("2."+i+".3")%></td>
			</tr>
		<%
			}
		}
	%>	
		</table>
	</div>
</div>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%	
	String serv_order_id = request.getParameter("ordernum");   //��ѯ����
	System.out.println("serv_order_id========================="+serv_order_id);
	String sqlstr="select  a.prodordid, a.contentid, a.parcontendid, a.structid, b.structname,a.structvalue, b.atomFlag "
								+" from PRODUCT_ORDER_CONTENT a, PRODUCT_ORDER_STRUCT b "
								+" where   a.prodOrdID = '"+serv_order_id+"' "
								+" and     a.structid = b.structid "
								+" order by a.contentid ";
  System.out.println("sqlstr==="+sqlstr);
  String regionCode = (String)session.getAttribute("regCode");	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
			<wtc:sql><%=sqlstr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="myresult" scope="end" />
<%
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
if(retCode.equals("000000")){	
//�ͻ���Ϣ
%>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">������Ϣ��</div>
</div>
<table id="dataTable1" cellspacing=0>
	<tr>
		<th>�������</th>
		<th>�ڵ�ʵ��ID</th>
		<th>�ϼ��ڵ�ʵ��ID</th>
		<th>�ڵ�ID</th>
		<th>�ڵ�����</th>
		<th>�ڵ�ֵ</th>
		<th>����</th>
	</tr>
<%	      
System.out.println("----------------------myresult.length------------------"+myresult.length);     
	for(int i=0;i<myresult.length;i++){//�ͻ���������
  %>
				<tr style="cursor:pointer">
					<%for(int j=0;j<6;j++){%>				 
					<td ><%=myresult[i][j]%></td>
					<%}%>
					<td>      
						 <input class="b_foot" onclick="doModify('<%=(i+1)%>')" <%if(myresult[i][6].equals("0")||myresult[i][3].equals("1002"))out.print("disabled");%>  type=button value="�޸�"/>
           </td>
				</tr>
    <%
   }
%>
</table>
</div>
<%
}else{
%>
<script>
	rdShowMessageDialog("[<%=retCode%>]:<%=retMsg%>",0);
</script>
<%}%>

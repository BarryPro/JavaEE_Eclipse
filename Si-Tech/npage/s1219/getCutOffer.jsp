<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
	String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));
System.out.println("����====offerSrvId===="+offerSrvId);	
	String opCOde=WtcUtil.repNull(request.getParameter("opCOde"));
	String workNo=WtcUtil.repNull(request.getParameter("workNo"));
	String offId=WtcUtil.repNull(request.getParameter("offId"));
System.out.println("===offId====="+offId);	
System.out.println("opcode="+opCOde);
System.out.println("workNo="+workNo);

System.out.println("---------------------offerSrvId---------------------------"+offerSrvId);
System.out.println("---------------------workNo---------------------------"+workNo);
System.out.println("---------------------opCOde---------------------------"+opCOde);
System.out.println("---------------------offId---------------------------"+offId);

%>
<wtc:utype name="sPMGetRedoOffer" id="retVal2" scope="end">
	<wtc:uparam value="<%=offerSrvId%>" type="LONG" />
	<wtc:uparam value="<%=workNo%>" type="STRING" />
	<wtc:uparam value="<%=opCOde%>" type="STRING" />
	<wtc:uparam value="<%=offId%>" type="LONG" />	
</wtc:utype>	
<%
	String retCode=retVal2.getValue(0);
	String retMsg=retVal2.getValue(1);
	if(retCode.equals("0"))
	{
%>
		<table id="tab" cellspacing=0>
		  <tr>
		  	<tr><th width=8%>����</th><th width=30%>����Ʒ����</th><th width=30%>״̬</th><th width=16%>��Чʱ��</th><th width=16%>ʧЧʱ��</th></tr> 	
<%		 
System.out.println("=====����====="+retVal2.getUtype(2).getSize()); 	
			String cutOfferList="";
			for(int i=0;i<retVal2.getUtype(2).getSize();i++)
			{
System.out.println("״̬||||||||||||||||||||||||||||||||||||||||||||||||||||||"+retVal2.getValue("2."+i+".0"));
System.out.println("����||||||||||||||||||||||||||||||||||||||||||||||||||||||"+retVal2.getValue("2."+i+".3"));
System.out.println("��Чʱ��||||||||||||||||||||||||||||||||||||||||||||||||||"+retVal2.getValue("2."+i+".5"));
System.out.println("ʧЧʱ��||||||||||||||||||||||||||||||||||||||||||||||||||"+retVal2.getValue("2."+i+".6"));
					if(retVal2.getValue("2."+i+".0").equals("9"))
					{
						cutOfferList="1,"+retVal2.getValue("2."+i+".1")+","+retVal2.getValue("2."+i+".2")+","+retVal2.getValue("2."+i+".5")+","+retVal2.getValue("2."+i+".6")+","+retVal2.getValue("2."+i+".10")+"~";
					}else
					{
					 	cutOfferList="3,"+retVal2.getValue("2."+i+".1")+","+retVal2.getValue("2."+i+".2")+","+retVal2.getValue("2."+i+".5")+","+retVal2.getValue("2."+i+".6")+","+retVal2.getValue("2."+i+".10")+"~";
					}
					if(retVal2.getValue("2."+i+".0").equals("1"))
					{
%>	
				<tr>
				    <td>
				        <input type="checkbox" id="chk_<%=i%>" value="<%=cutOfferList%>" checked disabled>
				    </td>
				    <td>
				        <%=retVal2.getValue("2."+i+".3")%>
				    </td>
				    <td>
				        <input id="statu_<%=i%>" value="�����˶�" readOnly >
				    </td>
				    <td>
				        <%=retVal2.getValue("2."+i+".5").substring(0,8)%>
				    </td>
				    <td>
				        <%=(retVal2.getValue("2."+i+".6").length()>8)?(retVal2.getValue("2."+i+".6").substring(0,8)):(retVal2.getValue("2."+i+".6"))%>
				    </td>
				</tr>		
<%
					}else if(retVal2.getValue("2."+i+".0").equals("0"))
					{
%>			
				<tr><td><input type="checkbox" id="chk_<%=i%>" value="<%=cutOfferList%>" onclick="chgOfferStatu('<%=i%>')"></td><td><%=retVal2.getValue("2."+i+".3")%></td><td><input id="statu_<%=i%>" value="�Ѷ���δ��Ч" readOnly></td><td><%=retVal2.getValue("2."+i+".5").substring(0,8)%></td><td><%=retVal2.getValue("2."+i+".6").substring(0,8)%></td></tr>			
<%
					}else
					{
%>			
				<tr><td><input type="checkbox" id="chk_<%=i%>" value="<%=cutOfferList%>" checked disabled ></td><td><%=retVal2.getValue("2."+i+".3")%></td><td><input id="statu_<%=i%>" value="���붩��" readOnly></td><td><%=retVal2.getValue("2."+i+".5").substring(0,8)%></td><td><%=retVal2.getValue("2."+i+".6").substring(0,8)%></td></tr>			
<%
					}		
			 }
%>					
		  </table>
<%
			}
%>
<script>
	function chgOfferStatu(offerIndex)
	{
		if($("#chk_"+offerIndex)[0].checked == true)
		{
			$("#statu_"+offerIndex).val("�˶�");
		}else
		{
			$("#statu_"+offerIndex).val("�Ѷ���δ��Ч");
		}		
	}
</script>	

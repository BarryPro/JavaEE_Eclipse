<%
/*
 * ����: TD�̻��Ա���TACУ��
 * �汾: 1.0
 * ����: 2012/9/3 11:05:33
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
/*xuyt�ṩsaleCode , ��ʱд��Ϊ 10647487
����imei 86037600
*/
String strSaleType="50";

String txtIno=request.getParameter("txtIno");
String regCode=(String)session.getAttribute("regCode");
String iOpCode=request.getParameter("hdOpCode");
String strOpName=request.getParameter("hdOpName");

System.out.println(iOpCode+"~~~~~~~~~~~~~~~~~~~~~"+txtIno);

String sqlChkIno="	select count(1) from  "
+" dbchnterm.dphonesalecode a , dbchnterm.schnrescodetac b ,schnresbrand c "
+"	where  1=1 "
+"  and b.tac_code = substr(:txtIno,0,8)  "
+"  and a.type_code = b.res_code and a.brand_code = c.brand_code "
+"  and a.region_code=:regCode"
+" and a.sale_type=:saleType "
 +" and a.valid_flag='Y'  ";
String strSqlPrm= "txtIno="+txtIno+",regCode="+regCode+",saleType=" + strSaleType;

%>
<wtc:service name="TlsPubSelCrm" outnum="5"
	routerKey="region" routerValue="<%=regCode%>" 
	retcode="code0" retmsg="msg0" >
	<wtc:param value="<%=sqlChkIno%>"/>
	<wtc:param value="<%=strSqlPrm%>"/>
</wtc:service>
<wtc:array id="result0" scope="end" />
<%
if( "000000".equals(code0))
{
	if (! result0[0][0].equals("0") )
	{
		%>
			<script>
				rdShowMessageDialog("У��ɹ�!" , 2);
				window.location = 'fG067Main.jsp?opCode=<%=iOpCode%>&opName=<%=strOpName%>';
			</script>		
		<%
	}
	else
	{
		%>
			<script>
				rdShowMessageDialog("��TAC����ϵͳ�в�����!" , 0);
				window.location = 'fG067Main.jsp?opCode=<%=iOpCode%>&opName=<%=strOpName%>';
			</script>		
		<%
	}
}
else
{%>
	<script>
		rdShowMessageDialog("<%=code0%>"+":"+"<%=msg0%>" , 0);
		window.location = 'fG067Main.jsp?opCode=<%=iOpCode%>&opName=<%=strOpName%>';
	</script>
<%
}%>
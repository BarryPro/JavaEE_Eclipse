<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
 
<%
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String opCode = "e888";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");

	String opName = "��ͯ�ײͼҳ�֧������޸�";
	String phoneNo = request.getParameter("phoneNo");
	String secondNo = request.getParameter("secondNo");
	String oldmoney = request.getParameter("oldmoney");	
	String newmoney = request.getParameter("newmoney");	
	System.out.println("AAAAAAAAAAAAAAAAAAAAA �ҳ��ֻ� "+phoneNo+" ԭ��� "+oldmoney+" and �¶�� "+newmoney);
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	String printAccept="";
	String parentNo="";
	String parentName="";
	String childNo="";
	String childName="";
	String oldMoney="";
	String newMoney="";
	String s_accept = request.getParameter("s_accept");	
 
%>
 
	 <wtc:service name="e888Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=secondNo%>"/>
		<wtc:param value="<%=oldmoney%>"/>
		<wtc:param value="<%=newmoney%>"/>
		<wtc:param value="<%=s_accept%>"/>
	 </wtc:service>
	 <wtc:array id="ret_val1" scope="end"/>
<%
	String[][] result1  = null ;
	result1=ret_val1;
	iErrorNo = result1[0][0];
	sErrorMessage = result1[0][1];
	String error_msg = iErrorNo;
	
	if(result1!=null && result1.length>0)
	{
		System.out.println("QQQQQQQQQQQQQQQQQQQQQq iErrorNo is "+iErrorNo+" and sErrorMessage is "+sErrorMessage);
		if(iErrorNo.equals("000000"))
		{
			printAccept=result1[0][2];
			parentNo=result1[0][3];
	        parentName=result1[0][4];
	        childNo=result1[0][5];
			childName=result1[0][6];
			oldMoney=result1[0][7];
			newMoney=result1[0][8];
			%>
				<script language="javascript">
					
					rdShowMessageDialog("�����ɹ�!");
					//alert("1");
					window.location="e888_1.jsp?activePhone="+"<%=phoneNo%>"; 
					
					//alert("2");
					
				</script>
				<script language="javascript">
 
  

				</script>
 
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>��ͯ�ײͼҳ��޸Ķ��</TITLE>
</HEAD>
<body>
<FORM method=post name="all">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ͯ�ײͼҳ��޸Ķ��</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	 
    <tr>  
 
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
			<%
		}
		else
		{
			%>
					<script language="javascript">
						rdShowMessageDialog("����ʧ�ܣ�������룺"+"<%=iErrorNo%>������Ϣ��"+"<%=sErrorMessage%>");
						window.location="e888_1.jsp?activePhone="+"<%=phoneNo%>";
					</script>
				<%
		}
	}
	else
	{
		%>
				<script language="javascript">
					rdShowMessageDialog("ҵ�������ʧ��");
					window.location="e888_1.jsp?activePhone="+"<%=phoneNo%>";
				</script>
			<%
	}

%>


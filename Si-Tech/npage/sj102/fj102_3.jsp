<%
  /*
   * ����:6995����������������
   * �汾: 1.0
   * ����: 2015/06/18
   * ����: wangwg
   * ��Ȩ: si-tech
  */
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String workno = (String)session.getAttribute("workNo");
    String workname =  (String)session.getAttribute("workName");
	String nopass =(String)session.getAttribute("password");
	String opCode = "J102"  ;
	String opName = "6995����������������";
	String remark = request.getParameter("remark");
	String sSaveName = request.getParameter("sSaveName");
	String filename = request.getParameter("filename");
	String orgcode = (String)session.getAttribute("orgCode");  
	String regionCode = orgcode.substring(0,2);
	String total_no = "";
	String succ_no = "";
	String err_no = "";
	
	int flag = 0;
%>
	<wtc:service name="sJ102Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="6" >
		<wtc:param value="0"/>
		<wtc:param value="08"/>
		<wtc:param value="J102"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=filename%>"/>
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=remark%>"/>	
	</wtc:service>
	<wtc:array id="result" scope="end" />
	
<%   
	sReturnCode = result[0][0];
	sErrorMessage = result[0][1];
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" ������Ϣ : " + sErrorMessage);
	}
		
	if (flag == 0)
	{	
		total_no = result[0][3];
		succ_no = result[0][4];
		err_no = result[0][5];
	}
	
%>
<HEAD><TITLE>������BOSS-6995������������������</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function gohome()
{
	document.location.replace("fj102_1.jsp");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="fj102_1.jsp" method=post name=form>
	
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue">��������</td>
		    <td >
		         6995����������������
		    </td>
		    <td ></td>
		    <td class="blue">���� <%=orgcode%></td>
		  </tr>
		  </tbody> 
		</table>
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
			<div align="center">6995�����������������Ϸ���ɡ���������<%=total_no%>,�ɹ�������<%=succ_no%>,ʧ��������<%=err_no%><br>
					<% if (flag != 0){%>
						������룺'<%=sReturnCode%>'��<br>������Ϣ��'<%=sErrorMessage%>'��");
					<% } %>	
				</div>
		      </td>
		    </tr>
		    </tbody> 
		</table>
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%"> 
		      <input class="b_foot" name=sure disabled type=submit value=ȷ��>
		      <input class="b_foot" name=reset type=reset value=���� onClick="gohome()">
		      &nbsp; </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

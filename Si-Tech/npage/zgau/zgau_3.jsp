<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String opCode = "zgau";
    String opName = "�߶��˷ѽ�������";
	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zgau";              //��������
	
	String work_no = (String)session.getAttribute("workNo"); 
	
	String[] inParas2 = new String[2];
	inParas2[0]="select login_no from shighlogin_boss where op_code='zgau' ";
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
 
	if (ret_val.length > 0 )
	{
	  
	 
%>
<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
	<table cellspacing="0" >
		<th>����</th>
		<%
			for(int i=0;i<ret_val.length;i++)
			{
				%>
					<tr>
						<td><%=ret_val[i][0]%></td>
					</tr>
				<%
			}
		%>
		<TR> 
	      <TD align="center" id="footer" colspan="4"> 
		  <input type=button class="b_foot" name="Button1" value="����" onclick="window.location.href='zgau_1.jsp'">
	       
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	      </TD>
	    </TR>
	</table>
</form>
 
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ѯ���Ϊ��!",0);
	window.location="zgau_1.jsp";
	</script>
<%}
%>


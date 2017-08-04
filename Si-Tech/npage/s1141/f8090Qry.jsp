<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>�޸�IMEI�󶨹�ϵ</title>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String opCode = "8090";
		String opName = "�޸�IMEI�󶨹�ϵ";
		String iLoginNo = request.getParameter("iLoginNo");
		String phoneno = request.getParameter("phoneno");
   	String plan_code = request.getParameter("plan_code");
   	String saletime = request.getParameter("saletime");
%>

<wtc:service name="s8090Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="10" >
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="<%=plan_code%>"/>		
		<wtc:param value="<%=saletime%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
		
	<%
		if (!sReturnCode.equals("000000") )
    {
  %>
  	
  	<script language="JavaScript">
        rdShowMessageDialog("<%=sErrorMessage%>",0);
        window.location="f8090.jsp";
    </script>
  <%
  }
  %>
  
 <script language="javascript">
		$(document).ready(function(){
			
		});
//ΪԭIMEI�븳ֵ
function opchange(imeno) {
	document.all.imei_no.value="";
	document.all.imei_no.value=imeno.replace(/[ ]/g,""); 

}
//�ύ����
function doSubmit()
{
	if(check(frm))
		{
			var q=document.getElementsByName("unchange");
			var flag=false;
			//��ˮ��
			var v_op_accept;
			for(var i=0;i<q.length;i++)
			{
				 if(q[i].checked==true){
				 	flag=true;
				 	v_op_accept = q[i].value;
				 	break;
				 	
				}
				
			}
			//��ˮ�Ÿ�ֵ
			$("#inAcceptCode").val(v_op_accept);
			if(!flag)
			{
				rdShowMessageDialog("��ѡ��Ҫ�޸ĵ�������Ϣ��",1);
        return false;
			}
			
			var new_imei_no = $("#new_imei_no").val();
			var imei_no = $("#imei_no").val();
			//ȥ�ո�
			new_imei_no=new_imei_no.replace(/\s+/g,"");
			if (new_imei_no.length != 15)
  		{
      rdShowMessageDialog("�������IMEI�볤�ȱ�����15λ�����������룡",1);
      document.all.new_imei_no.select();
      return false;
  		}
			if(imei_no==new_imei_no)
			{
				rdShowMessageDialog("��IMEI��ϵͳ��IMEI��ͬ������Ҫ�ٴθ��ģ�",1);
        return false;
			}
			frm.action="f8090Cfm.jsp";
			frm.submit();
			
		}
	
}
	</script>
</head>
<body>
<form name="frm" method="post" action="">	
	<%@ include file="/npage/include/header.jsp" %>
<div id="items">
     
	<div class="title">
		<div id="title_zi">�޸�IMEI�󶨹�ϵ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th width="10%" >
				
			</th>
			<th width="15%">
				Ʒ���ͺ�
			</th>
			<th width="20%">
				Ӫ����
			</th>
			<th width="15%">
				IMEI��
			</th>
			<th width="20%">
				Ӫ������Чʱ��
			</th>

		</tr>
		<% for(int i=0;i<result.length;i++)
	  {
		%>
		<tr>
			<td width="10%" algin="center"><input type="radio" onclick="opchange('<%=result[i][3]%>')" name="unchange" value="<%=result[i][2]%>"></input>
				</td>
				<td width="15%"><%=result[i][5]%></td>
				<td width="20%"><%=result[i][8]%></td>
				<td width="15%"><%=result[i][3]%></td>
				<td width="20%"><%=result[i][6]%></td>
				
		</tr>
		
		<%
		}
		%>
		<tr>
			<td colspan="6" >&nbsp;</td>
		</tr>
		<tr>
			<td class="blue">ԭIMEI��</td>
			<td colspan="2">
				<input type="text" name="imei_no" id="imei_no" value="" v_must="1" onblur="checkElement(this)" readOnly/>
        <font color="#FF0000">*</font>
			</td>
			
			<td class="blue">��IMEI��</td>
			<td colspan="2">
				<input type="text" name="new_imei_no" id="new_imei_no" value="" v_must="1" onblur="checkElement(this)" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)"/>
			  <font color="#FF0000">*</font>
			</td>
		</tr>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="�ύ" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot"  value="���"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot"  value="����" onclick="JavaScript:document.location.href='/npage/s1141/f8090.jsp';"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
</div>
	<input type="hidden" name="inAcceptCode" id="inAcceptCode" value=""/>
	<input type="hidden" name="iLoginNo2" value="<%=iLoginNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>  
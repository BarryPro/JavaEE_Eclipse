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
<%
	String opCode ="g089"; //"d223";
	String opName = "���ź���������";//"�˷�ͳ��";
 	String[][] result = new String[][]{}; 
 ;	
	 
	String unit_id = request.getParameter("unit_id");
	String id_No="";
 
 
	String inParas[] = new String[2];
//  String phoneNo = request.getParameter("phoneNo");

	//xl add ����Ȩ��У��
	String workNo=(String)session.getAttribute("workNo");
	String inParas_login[] = new String[2];
	inParas_login[0]="select to_char(count(*)) from shighlogin_boss where login_no=:login_no and op_code='g089' ";
	inParas_login[1]="login_no="+workNo;
	

    int i_count=1;
	//xl add for new 13���µ����� begin
	// new ����np���ж�
	String[] inParas_13 = new String[2];
	inParas_13[0]="select distinct  to_char(a.id_no) from dgrpusermsgadd a,dgrpcustmsg b,dgrpusermsg c where b.unit_id=:unit_id and b.cust_id = c.cust_id and c.id_no = a.id_no and a.field_code='1010' and a.field_value in ('118','119','120','121','122','211')   union all select distinct to_char(d.id_no) from dgrpusermsg d,dgrpcustmsg e where e.unit_id=:unit_id and e.cust_id=d.cust_id and d.sm_code='np'  ";
	inParas_13[1]="unit_id="+unit_id+",unit_id="+unit_id;
%>

	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode_login" retmsg="retMsg_login" outnum="1">
		<wtc:param value="<%=inParas_login[0]%>"/>
		<wtc:param value="<%=inParas_login[1]%>"/>
	</wtc:service>
	<wtc:array id="result_login" scope="end" />
	<%
		if(result_login==null||result_login.length==0)
		{
			%>
			<script language="javascript">
			 
				rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ����������ϢΪ��!");
				//history.go(-1); 
			</script>
			<%
		}
		 
	%>



	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:param value="<%=inParas_13[0]%>"/>
		<wtc:param value="<%=inParas_13[1]%>"/>
	</wtc:service>
	<wtc:array id="result_id" scope="end" />
<%
	if(result_id==null||result_id.length==0)
	{
		System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ�û�������ϢΪ��!");
			//history.go(-1); 
		</script>
	<%}
	
	//13�������� end
 
	//�����ж�N��
	//xl add ����ȡred_length
	inParas[0] ="select d.unit_id,  d.id_no,  d.user_name,  to_char(d.begin_time),  to_char(d.end_time),  d.OP_code,  d.LOGIN_NO,  to_char(d.OP_TIME, 'YYYYMMDD hh24:mi:ss'),   nvl(d.red_type, '0'), f.credit_code ,to_char(sysdate,'YYYYMM'),to_char(d.account_id) ,to_char(red_length) from (select to_char(a.unit_id) unit_id,   to_char(b.id_no) id_no,  b.user_name,  c.red_type,  c.begin_time as begin_time,   c.end_time,  c.OP_code,  c.LOGIN_NO,  c.OP_TIME,b.account_id ,to_char(c.red_length) as red_length   from dgrpcustmsg a, dgrpusermsg b, dbcustadm.dgrpredlist c,dconmsg h  where a.cust_id = b.cust_id  and a.unit_id = :unit_id and b.account_id=h.contract_no and b.run_code < 'a' and b.id_no = c.id_no(+)) d,  sgrpredtype e,  dbcustadm.dgrpCreditOpr f where nvl(d.red_type, '0') = e.red_type  and d.unit_id = f.unit_id and to_char(sysdate, 'YYYYMM') >= trim(f.begin_time)  and to_char(sysdate, 'YYYYMM') <= trim(f.end_time) and f.auto_flag='N'";
	inParas[1] ="unit_id="+unit_id;
	//�ж�Y��
	String inParasnew[] = new String[2];
	inParasnew[0] ="select d.unit_id,  d.id_no,  d.user_name,  to_char(d.begin_time),  to_char(d.end_time),  d.OP_code,  d.LOGIN_NO,  to_char(d.OP_TIME, 'YYYYMMDD hh24:mi:ss'),   nvl(d.red_type, '0'), f.credit_code ,to_char(sysdate,'YYYYMM'),to_char(d.account_id) ,to_char(red_length)  from (select to_char(a.unit_id) unit_id,   to_char(b.id_no) id_no,  b.user_name,  c.red_type,  c.begin_time as begin_time,   c.end_time,  c.OP_code,  c.LOGIN_NO,  c.OP_TIME ,b.account_id  ,to_char(c.red_length) as red_length from dgrpcustmsg a, dgrpusermsg b, dbcustadm.dgrpredlist c ,dconmsg h where a.cust_id = b.cust_id  and a.unit_id = :unit_id and  b.account_id=h.contract_no and b.run_code < 'a' and b.id_no = c.id_no(+)) d,  sgrpredtype e,  dbcustadm.dgrpCreditOpr f where nvl(d.red_type, '0') = e.red_type  and d.unit_id = f.unit_id and to_char(sysdate, 'YYYYMM') >= trim(f.begin_time)  and to_char(sysdate, 'YYYYMM') <= trim(f.end_time) and f.auto_flag='Y'";
	inParasnew[1] ="unit_id="+unit_id;
%> 
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="13">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />

<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCodenew" retmsg="sConMoreQryMsgnew" outnum="13">
    <wtc:param value="<%=inParasnew[0]%>"/> 
    <wtc:param value="<%=inParasnew[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_valnew" scope="end" />

<%
System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQ test inParas[0] is "+inParas[0]+" and inParas[1] is "+inParas[1]);
if((ret_val==null||ret_val.length==0) && (ret_valnew==null||ret_valnew.length==0))
{
	%><HEAD><TITLE>���ź���������3</TITLE>
</HEAD>
<script language="javascript">
			
</script>
<body >
<FORM method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���ź���������4</div>
	</div>
	<table cellspacing="0" id="tabList">
 
	<tr>
		<td colspan=6 align=center><font color=red border>�޲�ѯ���</font></td>
	</tr>


		<td align="center" id="footer" colspan="9">
		   <input class="b_foot" name=back onClick="window.location='g089_1.jsp?opCode=g089&opName=���ź����������'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%
}
else if(ret_val!=null && ret_val.length>0 )
{
	%><HEAD><TITLE>��ѯ���1</TITLE>
</HEAD>

<body>
 
 <!--�˴����ӣ� ��ѯȫ���ĺ������ֵ ������-->
 <%
		String inParas2[] = new String[2]; 
		inParas2[0]="select red_type,red_name from sgrpredtype ";
 %>
 <wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title" >
		<div id="title_zi" colspan=10>���ź���������1</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>���ű���</th>
		<th nowrap>���Ų�Ʒ�ʺ�</th>
		<th nowrap>�û�ID</th>
		<th nowrap>��Ʒ����</th>
		<th nowrap>������</th>
		<th nowrap>��ʼʱ��</th>
		<th nowrap>����ʱ��</th>
		<th nowrap>����ʱ�䳤��(����)</th>
		<th nowrap>ҵ�����</th>
		<th nowrap>��������</th>
		<th nowrap>����ʱ��</th>
	    <th nowrap>����</th>
		
	<tr>
	<%
		  for(int y=0;y<ret_val.length;y++)
		  { 
	%>
			<tr>
     	    <td height="25" nowrap>&nbsp;<%= ret_val[y][0]%></td>
			<td height="25" nowrap>&nbsp;<%= ret_val[y][11]%></td>
			<input type="hidden" name="s_value" value="<%=ret_val[y][8]%>">
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][1]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][2]%></td>
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId<%=y%>" value="<%=ret_val[y][8]%>"  onchange="checktype('<%=ret_val[y][9]%>')">
						<%for(int i=0; i<red_val.length; i++){
								if(red_val[i][0].equals(ret_val[y][8])){
									%>
									<option value="<%=red_val[i][0]%>" selected >
						
						<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
									}
							%>
							
						
						<%}%>   
 
					</select>  </td>
					<input type="hidden" id="id_no<%=y%>" value="<%= ret_val[y][1]%>">
					<input type="hidden" id="contract_no<%=y%>" value="<%= ret_val[y][11]%>">
				  <td height="5" nowrap>&nbsp; <%= ret_val[y][3]%> </td>
				  <td height="5" nowrap>&nbsp; <%= ret_val[y][4]%> </td>
				  <!--xl add-->
				  <td height="25" nowrap>
				  <input type="text" id="endYm_lenth<%=y%>" value="<%=ret_val[y][12]%>"  onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10  ></td>

				  <td height="25" nowrap>&nbsp;<%= ret_val[y][5]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][6]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][7]%></td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="����" onclick="doCfm('<%=ret_val[y][8]%>','<%=y%>','<%=ret_val[y][9]%>',sid_code,'<%= ret_valnew[y][11]%>',login_code)">
				   </td>
 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="12">
		 
		&nbsp;&nbsp; <input class="b_foot" name=back onClick="window.location='g089_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
<%
	String inParas_mt[] = new String[2]; 
	inParas_mt[0]="select to_char(a.id_no), decode(to_char(cc_ym),'000000','��',to_char(cc_ym)),decode(to_char(cc_cycle),'0','��',to_char(cc_cycle)),to_char(product_cycle),to_char(min_ym),to_char(end_ym) from dgrpcreditmsg a,dgrpcustmsg b,dgrpusermsg c  where a.id_no=c.id_no and b.cust_id =c.cust_id and b.unit_id=:s_unit_id ";
	inParas_mt[1]="s_unit_id="+unit_id;
%>
<wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="6">
    <wtc:param value="<%=inParas_mt[0]%>"/>  
	<wtc:param value="<%=inParas_mt[1]%>"/> 
</wtc:service>
<wtc:array id="red_val_mt" scope="end" />
<DIV id="Operation_Table">
<div class="title" >
	<div id="title_zi" colspan="12" >��ͣ��Ϣ��ѯ</div>
</div>
<table cellspacing="0" id="tabList">
<tr>
	<th nowrap>�û�ID</th>
	<th nowrap>�ſؿ�ʼʱ��</th>
	<th nowrap>�ɷ�����</th>
	<th nowrap>��Ʒ�ӳ�ͣ������</th>
	<th nowrap>��СǷ������</th>
	<th nowrap>��ͣ��������</th>
</tr>
<%
	for(int i=0;i<red_val_mt.length;i++)
	{
		%>
			
		<tr>
			<td><%=red_val_mt[i][0]%></td>
			<td><%=red_val_mt[i][1]%></td>
			<td><%=red_val_mt[i][2]%></td>
			<td><%=red_val_mt[i][3]%></td>
			<td><%=red_val_mt[i][4]%></td>
			<td><%=red_val_mt[i][5]%></td>
		</tr>
		<%
		
	}
%>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else if(ret_valnew!=null && ret_valnew.length>0)
{
	%><HEAD><TITLE>��ѯ���2</TITLE>
</HEAD>

<body>
 
 <!--�˴����ӣ� ��ѯȫ���ĺ������ֵ ������-->
 <%
		String inParas2[] = new String[2]; 
		inParas2[0]="select red_type,red_name from sgrpredtype ";
 %>
 <wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title" >
		<div id="title_zi" colspan="12" >���ź���������2</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>���ű���</th>
		<th nowrap>���Ų�Ʒ�ʺ�</th>
		<th nowrap>�û�ID</th>
		<th nowrap>��Ʒ����</th>
		<th nowrap>������</th>
		<th nowrap>��ʼʱ��</th>
		<th nowrap>����ʱ��</th>
		<th nowrap>����ʱ�䳤��(����)</th>
		<th nowrap>ҵ�����</th>
		<th nowrap>��������</th>
		<th nowrap>����ʱ��</th>
	    <th nowrap>����</th>
	 
	<tr>
	<%
		  for(int y=0;y<ret_valnew.length;y++)
		  { 
	%>
			<tr>
     	    <td height="25" nowrap>&nbsp;<%= ret_valnew[y][0]%></td>
			<td height="25" nowrap>&nbsp;<%= ret_valnew[y][11]%></td>
			<input type="hidden" name="s_value" value="<%=ret_valnew[y][8]%>">
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][1]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][2]%></td>
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId<%=y%>" value="<%=ret_valnew[y][8]%>"  onchange="checktype('<%=ret_valnew[y][9]%>')">
						<%for(int i=0; i<red_val.length; i++){
								if(red_val[i][0].equals(ret_valnew[y][8])){
									%>
									<option value="<%=red_val[i][0]%>" selected >
						
						<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
									}
							%>
							
						
						<%}%>   
 
					</select>  </td>
					<input type="hidden" id="id_no<%=y%>" value="<%= ret_valnew[y][1]%>">
					<input type="hidden" id="contract_no<%=y%>" value="<%= ret_valnew[y][11]%>">
				  <td height="5" nowrap>&nbsp; <%= ret_valnew[y][3]%> </td>
				  <td height="5" nowrap>&nbsp; <%= ret_valnew[y][4]%></td>
				  <!--xl add begin-->
				  <td height="5" nowrap>&nbsp;<input type="text"  class="InputGrey" id="endYm_lenth<%=y%>" value="<%=ret_valnew[y][12]%>"  size=10  ></td>
				  <!--xl add end-->
				  
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][5]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][6]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][7]%></td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="����" onclick="doCfm('<%=ret_valnew[y][8]%>','<%=y%>','<%=ret_valnew[y][9]%>',sid_code,'<%= ret_valnew[y][11]%>',login_code)">
				   </td>
 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="12">
		 
		&nbsp;&nbsp; <input class="b_foot" name=back onClick="window.location='g089_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
<%
	String inParas_mt[] = new String[2]; 
	inParas_mt[0]="select to_char(a.id_no), decode(to_char(cc_ym),'000000','��',to_char(cc_ym)),decode(to_char(cc_cycle),'0','��',to_char(cc_cycle)),to_char(product_cycle),to_char(min_ym),to_char(end_ym) from dgrpcreditmsg a,dgrpcustmsg b,dgrpusermsg c  where a.id_no=c.id_no and b.cust_id =c.cust_id and b.unit_id=:s_unit_id ";
	inParas_mt[1]="s_unit_id="+unit_id;
%>
<wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="6">
    <wtc:param value="<%=inParas_mt[0]%>"/>  
	<wtc:param value="<%=inParas_mt[1]%>"/> 
</wtc:service>
<wtc:array id="red_val_mt" scope="end" />
<DIV id="Operation_Table">
<div class="title" >
	<div id="title_zi" colspan="12" >��ͣ��Ϣ��ѯ</div>
</div>
<table cellspacing="0" id="tabList">
<tr>
	<th nowrap>�û�ID</th>
	<th nowrap>�ſؿ�ʼʱ��</th>
	<th nowrap>�ɷ�����</th>
	<th nowrap>��Ʒ�ӳ�ͣ������</th>
	<th nowrap>��СǷ������</th>
	<th nowrap>��ͣ��������</th>
</tr>
<%
	for(int i=0;i<red_val_mt.length;i++)
	{
		%>
			
		<tr>
			<td><%=red_val_mt[i][0]%></td>
			<td><%=red_val_mt[i][1]%></td>
			<td><%=red_val_mt[i][2]%></td>
			<td><%=red_val_mt[i][3]%></td>
			<td><%=red_val_mt[i][4]%></td>
			<td><%=red_val_mt[i][5]%></td>
		</tr>
		<%
		
	}
%>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else
{ 
	%>3<%
}
%>	 
<script language="javascript">
	function checktype(i)
	{
		/* 
		if(i=="C")
		{
			rdShowMessageDialog("��ǰ���õȼ�ΪC->�����õȼ������������!");
			return false;
		}
		if(i=="0")
		{
			rdShowMessageDialog("���ŵ�ǰ�����õȼ������������!");
			return false;
		}
		*/
	}
	function doCfm(chk_id,i,dj,sid,contract_no,login_no)
	{
		
		var i_icount = "<%=result_login[0][0]%>" ;
		//alert("test result_login is "+i_icount);
		var endYmId = "endYm_lenth"+i;//�·�length
		var id_nos="id_no"+i;
		var contract_nos = "contract_no"+i;
		var s_redIds = "s_redId"+i;
		var red_value="";
		var idno_new = document.getElementById(id_nos).value;
		var contract_no_new = document.getElementById(contract_nos).value;
		//alert(idno_new); //��ǰ�ȼ�
 
		var end_new = document.getElementById(endYmId).value;//�·�length
		var objSel = document.getElementById(s_redIds);
		red_value=objSel.value;
		if( end_new=="")
		{
			rdShowMessageDialog("��������������!");
			return false;
		}	
		 
 
		  var len = end_new;
	 
		  var i_flag=0;
		 
		  //xl add ����Ȩ��
		  if(i_icount>=1)
		  {
             //alert("��Ȩ��");
			 i_flag=2;
		  }
		  else
		  {
			  for ( x = 0 ; x < sid.length  ; x++ )
			  {
				  //alert("test id_no is "+sid[x]);
				  if(sid[x]==idno_new)
				  {
					//  alert("add here 13���µ�����"+idno_new);
					  if(len>13)
					  {
						  rdShowMessageDialog("���û������ʱ�䷶ΧΪ13���£�����������!");
						  return false;
					  }
					  else
					  {
						  //alert("��������");
						  var url="g089_Cfm.jsp?endYm="+end_new+"&unit_id="+<%=unit_id%>+"&credit_code="+red_value+"&id_no="+idno_new+"&contract_no="+contract_no_new+"&length_month="+len;

							var url_new =url;//URLencode(url);
						 
							document.frm1507_2.action=url;
							var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ�����β�����");
							if (prtFlag==1)
							{
								i_flag=1;
								document.frm1507_2.submit();  
							}
							else
							{
								return false;
							}
					  }
					   
				  }
				  else
				  {
					  // alert("զ����?");
				  }	
			  }
		  }	
		  
		  
		  //if ���� ��ֱ���ж�13���� �����жϵȼ�dj
		 // alert("i_flag is "+i_flag);
		  if(i_flag==0)
		  {
			  if(dj=="0")
			  {
				  rdShowMessageDialog("���ŵ�ǰ�����õȼ��������԰���!");
				  return false;
			  }
			  if(dj=="A" && len>2)
			  {
				  rdShowMessageDialog("���õȼ�ΪA->�����õȼ����������ü��Ϊ2����!");
				  return false;
			  }
			  if(dj=="B" && len>1)
			  {
				  rdShowMessageDialog("���õȼ�ΪB->�����õȼ����������ü��Ϊ1����!");
				  return false;
			  }
			  if(dj=="C")
			  {
				  rdShowMessageDialog("���õȼ�ΪC->�����õȼ��������԰���!");
				  return false;
			  }	
				//end A
				var url="g089_Cfm.jsp?endYm="+end_new+"&unit_id="+<%=unit_id%>+"&credit_code="+red_value+"&id_no="+idno_new+"&contract_no="+contract_no_new+"&length_month="+len;

				var url_new =url;//URLencode(url);
			 
				document.frm1507_2.action=url;
				var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ�����β�����");
				if (prtFlag==1)
				{
					document.frm1507_2.submit();  
				}
				else
				{
					return false;
				}
		  }	
		  if(i_flag==2)
		  {
				//alert("here "+len);
				if(len>13)
				{
					rdShowMessageDialog("�ù���������ͣ�����Ϊ13����!");
					return false;
				}
				else
				{
					var url="g089_Cfm.jsp?endYm="+end_new+"&unit_id="+<%=unit_id%>+"&credit_code="+red_value+"&id_no="+idno_new+"&contract_no="+contract_no_new+"&length_month="+len;
					var url_new =url;//URLencode(url);
				 
					document.frm1507_2.action=url;
					var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ�����β�����");
					if (prtFlag==1)
					{
						document.frm1507_2.submit();  
					}
					else
					{
						return false;
					}
				}
				
		  }
	}

	function checkDate(value)
	{
		if((/^\d{4}-\d{1,2}-\d{1,2}$/).test(value) == false)
			return false;
		
		 
		monthPerDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31);    
		year = value.substring(0,4);
		month = value.substring(4,2);
		day = value.substring(6,2);
		alert(year+month+day);
		if(month >12 || month<0)
			return false;

		if(day>31 || day<0 )
			return false;
	 

		return true;
	}
 
//����ȫ�ֱ���
  var sid_code = new Array();
  <%
  if(result_id.length >0)
  {
	  for(int m=0;m<result_id.length;m++)
	  {
		 out.println("sid_code["+m+"]='"+result_id[m][0]+"';\n");
	  }
  }
  %>
  //���ż�¼
  var login_code = new Array();
  <%
  if(result_login.length >0)
  {
	  for(int m=0;m<result_login.length;m++)
	  {
		 out.println("login_code["+m+"]='"+result_login[m][0]+"';\n");
	  }
  }
  %>
</script> 
 	
 


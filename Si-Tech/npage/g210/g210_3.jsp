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
	String opCode ="g210"; //"d223";
	String opName = "";//"�˷�ͳ��";
 	String[][] result = new String[][]{}; 
	String phone_no = request.getParameter("phone_no");	
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
    String inParas2[] = new String[1];
    inParas2[0]="select to_char(sysdate,'YYYYMM') from dual";
	//��ѯ���
	String date=request.getParameter("date");
	String date_month=date.substring(0,6);
	System.out.println("AAAAAAAAAAAAaaaaaaaaa date_month is "+date_month);
	String total_ll="";
	String fav_ll="";
	String used_ll="";
	String offer_name="";
	//��ѯ����id
	String inParas0[] = new String[2];
	inParas0[0]="select to_char(b.user_no),a.unit_name,c.offer_name from dgrpcustmsg a, dgrpusermsg b, product_offer c, sGrpSmFieldRela d , dcustmsg e,dcustmsgadd f where  a.cust_id = b.cust_id and b.run_code = 'A'  and b.sm_code = d.User_Type and c.offer_id = to_number(b.product_code) and d.Field_Code = '10358' and e.id_no=f.id_no and f.field_code='1004' and f.field_value=b.id_no and e.phone_no=:phone_No ";
	inParas0[1]="phone_No="+phone_no;
	String unit_id="";
	String jtmc="";
	String cpmc="";
 %>
	<wtc:service name="TlsPubSelCrm"  outnum="3">
		<wtc:param value="<%=inParas0[0]%>"/> 
		<wtc:param value="<%=inParas0[1]%>"/> 
	</wtc:service>
	<wtc:array id="ret_1" scope="end" />
<%
	if(ret_1==null||ret_1.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ�ֻ��������������Ϣ����,����5186���и���������ѯ!");
			    window.location='g210_1.jsp';
		    </script>
		<%
	}
	else
	{
		unit_id=ret_1[0][0];
		jtmc=ret_1[0][1];
		cpmc=ret_1[0][2];
	}
%>

	<wtc:service name="TlsPubSelBoss"  outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/> 
		</wtc:service>
	<wtc:array id="ret_0" scope="end" />
<%
	String dates0="";
	dates0=ret_0[0][0];
%>
	<wtc:service name="s5186FavMsg" retcode="sid_code" retmsg="s_id_ret" outnum="8">
    <wtc:param value="<%=work_no%>"/> 
	<wtc:param value="<%=nopass%>"/> 
	<wtc:param value="<%=opCode%>"/> 
	<wtc:param value="<%=phone_no%>"/> 
    <wtc:param value="<%=date%>"/>
 
</wtc:service>
<wtc:array id="ret_id" scope="end" />
<%
	if(ret_id==null||ret_id.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("���Ź���������ѯʧ��,������룺"+"<%=sid_code%>");
			    window.location='g210_1.jsp';
		    </script>
		<%
	}
	else
	{
		total_ll=ret_id[0][5];
		System.out.println("\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA total_ll is \n"+total_ll);
	    fav_ll=ret_id[0][6];
	    used_ll=ret_id[0][7];
		offer_name=ret_id[0][4];
%>
	 
 <HEAD><TITLE>��ѯ���</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">�����Żݲ�ѯ���</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	     <%
			 if(date_month.equals(dates0))
		     {
				System.out.println("~~~~~~~~~~~~~~~~~~~~���µ�");
				%>
				<tr>
					<td>
						��ֹ��ѯʱ���������ļ�������:<%=jtmc%>,��Ʒ���ƣ�<%=cpmc%>,���Ų�Ʒ���룺<%=unit_id%>���ƶ��������������
					</td>
				</tr>
				<tr>
					<td>
						������<%=offer_name%>������<%=ret_id[0][5]%> K;
					</td>
				</tr>
				<tr>
					<td>
						��ʹ��<%=ret_id[0][6]%> K��
					</td>
				</tr>
				<tr>
					<td>
						��ʹ�õ�����Ϊ<%=ret_id[0][7]%> K��
					</td>
				</tr>
				<%
             }
			 else
			 {
				System.out.println("~~~~~~~~~~~~~~~~~~~~���µ�");
				%>
				<tr>
					<td>
						<%=date_month.substring(0,4)%>��<%=date_month.substring(4,6)%>�·ݣ��������ļ�������:<%=jtmc%>,��Ʒ���ƣ�<%=cpmc%>,���Ų�Ʒ���룺<%=unit_id%>���ƶ��������������
					</td>
				</tr>
				<tr>
					<td>
						������<%=offer_name%>��ʹ��������<%=ret_id[0][6]%> K 
					</td>
				</tr>
				<tr>
					<td>
						��ʹ�õ�����Ϊ<%=ret_id[0][7]%> K��
					</td>
				</tr>
				 
				<%
             }
		 %>
	 
	<tr>
	<%
		   
	%>
		<td align="center" id="footer" colspan="8">
		 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g210_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
 
		}
%>	 
 
 	
 


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
	String opCode =""; //"d223";
	String opName = "";//"�˷�ͳ��";
 	
	 
	String req = request.getParameter("req");
	//String kfbm = request.getParameter("kfbm");
	//String pay_value = request.getParameter("pay_value");
	 
	 
 

	String inParas2_now[] = new String[2];
	inParas2_now[0]=" select to_char(a.seq),to_char(a.PRODUCTID),b.productspec_name ,to_char(a.USERLISTSEQ),to_char(a.FEEINFOSEQ) from dbcustadm.dBBOSS_ACCT_EBILL_PRODUCTINFO a,dproductspecinfo@crmquery b where a.seq=:seq and a.productspec_number=b.productspec_number(+)";
	inParas2_now[1]="seq="+req;
	 
	 
		
 
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="5">
		    <wtc:param value="<%=inParas2_now[0]%>"/>
			<wtc:param value="<%=inParas2_now[1]%>"/>
</wtc:service>
<wtc:array id="result_now" scope="end" />   

 
<%
 	if(result_now.length==0 )
	{
	%><HEAD><TITLE>��ѯ���</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">��ѯ�޽��</div>
	</div>
	<table cellspacing="0" id="tabList">
	 
	 
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g339_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
	else
	{
		 
	%><HEAD><TITLE>��ѯ���</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">��ʡ�����˵���ѯ-�������ҳ</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>ȫ��ҵ����Ʒ��������ˮ</th>
		<th nowrap>��Ʒ������ϵ</th>
		<th nowrap>��Ʒ�������</th>
	 
	 
	<tr>
	<%
		  for(int i=0;i<result_now.length;i++)
		  { 
	%>
			<tr>
				<td>
					<a href="g339_4.jsp?USERLISTSEQ=<%=result_now[i][3]%>&fee_seq=<%=result_now[i][4]%>"><%=result_now[i][0]%></a>
				</td>
				<td>
					<%=result_now[i][1]%>
				</td>
				<td>
					<%=result_now[i][2]%> 
				</td>
				 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g339_1.jsp'" type="button" value="����">
		&nbsp;  
		<input class="b_foot" name=print onclick="javascript:window.print();" type="button" value="��ӡ">
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
%>
 
 	
 


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
 	
	 
	String region_code = request.getParameter("region_code");
	String bill_ym =  request.getParameter("bill_ym");
	String bill_bf =  request.getParameter("bill_bf");
	//
	String sm_name=request.getParameter("sm_name");
	String owner_code=request.getParameter("owner_code");
	String service_no = request.getParameter("service_no");
%>

 
<%

	String inParas2[] = new String[2];
	//�󶨱���
	inParas2[0]="select a.unit_id, a.unit_name , to_char(sum(a.owe_fee)) , to_char(a.info_fee_rate) from dgrpoweview a,dgrpcustmsg b,sdiscode c,dbvipadm.dgrpgroups d where a.unit_id = b.unit_id and a.group_id=b.org_code and a.group_id =d.group_id and d.parent_group_id=c.group_id and d.denorm_level='1' and c.region_code=:region_code and a.bill_month=:bill_month and a.service_no=:serv_no ";
	inParas2[1]="region_code="+region_code+",bill_month="+bill_ym+",serv_no="+service_no;
	if(!sm_name.equals("-->��ѡ��"))
	{
		inParas2[0]+=" and a.sm_name=:sm_name";
		inParas2[1]+=" ,sm_name="+sm_name;
	}
	if(!owner_code.equals("0"))
	{
		inParas2[0]+=" and a.owner_code=:owner_code";
		inParas2[1]+=" ,owner_code="+owner_code;
	}

	inParas2[0]+=" group by a.unit_id, a.unit_name,a.info_fee_rate";
	//inParas2[1]="region_code="+region_code+",bill_month="+bill_ym;	
	System.out.println("WWWWWWWWWWWWWWWWEEEEEEEEEEE inParas2[0] is "+inParas2[0]+" and inParas2[1] is "+inParas2[1]); 

	String inParas2_bf[] = new String[2];
	inParas2_bf[0]="select to_char(nvl(sum(owe_fee),0)) from dgrpoweview where region_code=:region_code and bill_month=:min_ym ";
	inParas2_bf[1]="region_code="+region_code+",min_ym="+bill_bf;
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="result_now" scope="end" />  


  

<%
	if(result_now.length==0  )
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
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g138_1.jsp'" type="button" value="����">
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
		<div id="title_zi">Ƿ����ͼ-�弶���ҳ���ɿͻ�ͳһ��ͼ</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>���ſͻ�����</th>
		<th nowrap>���ű���</th>
		<th nowrap>����Ƿ�ѽ��</th>
		<th nowrap>����Ƿ�ѽ��</th>
		<th nowrap>��Ϣ������ռ��</th>
	 
	<tr>
	<%
		  for(int i=0;i<result_now.length;i++)
		  { 
	%>
			<tr>
				<td>
					<a href="g138_6.jsp?region_code=<%=region_code%>&bill_ym=<%=bill_ym%>&bill_bf=<%=bill_bf%>&sm_name=<%=sm_name%>&owner_code=<%=owner_code%>"><%=result_now[i][0]%></a>
				</td>
				<td>
					<a href="s1023/grp_main.jsp?unit_id='4510245983'"><%=result_now[i][1]%></a>
				</td>
				<td>0</td>
				<td>
					<%=result_now[i][2]%>
				</td>
				
				<td>
					<%=result_now[i][3]%>
				</td>
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g138_1.jsp'" type="button" value="����">
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
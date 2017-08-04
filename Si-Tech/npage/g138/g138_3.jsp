<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode =""; //"d223";
	String opName = "";//"退费统计";
 	
	 
	String region_code = request.getParameter("region_code");
	String bill_ym =  request.getParameter("bill_ym");
	String bill_bf =  request.getParameter("bill_bf");
	//
	String sm_name=request.getParameter("sm_name");
	String owner_code=request.getParameter("owner_code");
%>

 
<%

	String inParas2[] = new String[2];
	//绑定变量
	inParas2[0]="select d.name,to_char(count(a.unit_id)),to_char(sum(a.owe_fee)),to_char(a.group_id) from dgrpoweview a,dgrpcustmsg b,sdiscode c,dbvipadm.dgrpgroups d where a.unit_id = b.unit_id and a.group_id=b.org_code and a.group_id =d.group_id and d.parent_group_id=c.group_id and d.denorm_level='1' and c.region_code=:region_code and a.bill_month=:bill_month ";
	inParas2[1]="region_code="+region_code+",bill_month="+bill_ym;
	if(!sm_name.equals("-->请选择"))
	{
		inParas2[0]+=" and a.sm_name=:sm_name";
		inParas2[1]+=" ,sm_name="+sm_name;
	}
	if(!owner_code.equals("0"))
	{
		inParas2[0]+=" and a.owner_code=:owner_code";
		inParas2[1]+=" ,owner_code="+owner_code;
	}

	inParas2[0]+=" group by d.name,a.group_id";
	//inParas2[1]="region_code="+region_code+",bill_month="+bill_ym;	
	System.out.println("EEEEEEEEEEE inParas2[0] is "+inParas2[0]+" and inParas2[1] is "+inParas2[1]); 
	
	String inParas2_bf[] = new String[2];
	inParas2_bf[0]="select  to_char(sum(a.owe_fee))  from dgrpoweview a,dgrpcustmsg b,sdiscode c,dbvipadm.dgrpgroups d where a.unit_id = b.unit_id and a.group_id=b.org_code and a.group_id =d.group_id and d.parent_group_id=c.group_id and d.denorm_level='1' and c.region_code=:region_code and a.bill_month=:bill_montha ";
	inParas2_bf[1]="region_code="+region_code+",bill_montha="+bill_bf;
	if(!sm_name.equals("-->请选择"))
	{
		inParas2_bf[0]+=" and a.sm_name=:sm_name";
		inParas2_bf[1]+=" ,sm_name="+sm_name;
	}
	if(!owner_code.equals("0"))
	{
		inParas2_bf[0]+=" and a.owner_code=:owner_code";
		inParas2_bf[1]+=" ,owner_code="+owner_code;
	}

	inParas2_bf[0]+=" group by d.name,a.group_id";
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="result_now" scope="end" />  

<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		    <wtc:param value="<%=inParas2_bf[0]%>"/>
			<wtc:param value="<%=inParas2_bf[1]%>"/>
</wtc:service>
<wtc:array id="result_bf" scope="end" /> 
  

<%
	if(result_now.length==0  )
	{
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">查询无结果</div>
	</div>
	<table cellspacing="0" id="tabList">
	 
	 
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g138_1.jsp'" type="button" value="返回">
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
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">欠费视图-二级结果页</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>区县名称</th>
		<th nowrap>欠费客户数</th>
		<th nowrap>上月欠费金额</th>
		<th nowrap>本月欠费金额</th>
	 
	<tr>
	<%
		  for(int i=0;i<result_now.length;i++)
		  { 
	%>
			<tr>
				<td>
					<a href="g138_4.jsp?region_code=<%=region_code%>&bill_ym=<%=bill_ym%>&bill_bf=<%=bill_bf%>&sm_name=<%=sm_name%>&owner_code=<%=owner_code%>&group_id=<%=result_now[i][3]%>"><%=result_now[i][0]%></a>
				</td>
				<td>
					<%=result_now[i][1]%>
				</td>
				<td>
					<%=result_now[i][2]%>
				</td>
				<td><%=result_bf[i][0]%></td>
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g138_1.jsp'" type="button" value="返回">
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
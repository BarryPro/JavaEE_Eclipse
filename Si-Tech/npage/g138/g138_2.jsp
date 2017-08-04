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
 	
	String min_ym = request.getParameter("min_ym");
	String region_value = request.getParameter("region_value");
	String sm_value = request.getParameter("sm_value");
	String client_value = request.getParameter("client_value");
	String ym_before="";
	String inParas_dt[] = new String[2];
	inParas_dt[0]="select to_char(add_months(to_date(:min_ym,'YYYYMM'),-1),'YYYYMM') from dual";
	inParas_dt[1]="min_ym="+min_ym;
	
%>
	<wtc:service name="TlsPubSelBoss"  retcode="retCode4" retmsg="retMsg4" outnum="1">
		    <wtc:param value="<%=inParas_dt[0]%>"/>
			<wtc:param value="<%=inParas_dt[1]%>"/>
	</wtc:service>
<wtc:array id="result" scope="end" />
<%
	if(result!=null)
	{
		ym_before=result[0][0];
	}
	System.out.println();
%>
<%

	String inParas2_now[] = new String[2];
	inParas2_now[0]="select b.region_name, to_char(count( distinct unit_id)), to_char(nvl(sum(owe_fee),0)) from dgrpoweview a,sregioncode b where a.region_code=:region_code and bill_month=:bill_month and a.region_code=b.region_code ";
	inParas2_now[1]="region_code="+region_value+",bill_month="+min_ym;
	if(!sm_value.equals("-->请选择"))
	{
		inParas2_now[0]+=" and a.sm_name=:sm_name";
		inParas2_now[1]+=" ,sm_name="+sm_value;
	}
	if(!client_value.equals("0"))
	{
		inParas2_now[0]+=" and a.owner_code=:owner_code";
		inParas2_now[1]+=" ,owner_code="+client_value;
	}
	inParas2_now[0]+=" group by b.region_name";
		
	
	String inParas2_bf[] = new String[2];
	//绑定变量
	inParas2_bf[0]="select to_char(nvl(sum(owe_fee),0)) from dgrpoweview where region_code=:region_code and bill_month=:min_ym ";
	inParas2_bf[1]="region_code="+region_value+",min_ym="+ym_before;
	if(!sm_value.equals("-->请选择"))
	{
		inParas2_bf[0]+=" and sm_name=:sm_name1";
		inParas2_bf[1]+=" ,sm_name1="+sm_value;
	}
	if(!client_value.equals("0"))
	{
		inParas2_bf[0]+=" and owner_code=:owner_code1";
		inParas2_bf[1]+=" ,owner_code1="+client_value;
	}
	//System.out.println("AAAAAAAAAAAADDDDDDDDDDDDDDDDD inParas2_bf[0] is "+inParas2_bf[0]+" and inParas2_bf[1] is "+inParas2_bf[1]+" and sm_value is "+sm_value+" and client_value is "+client_value);
	//inParas2_bf[1]="region_code="+region_value+",min_ym="+ym_before;
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		    <wtc:param value="<%=inParas2_now[0]%>"/>
			<wtc:param value="<%=inParas2_now[1]%>"/>
</wtc:service>
<wtc:array id="result_now" scope="end" />   

<wtc:service name="TlsPubSelBoss"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		    <wtc:param value="<%=inParas2_bf[0]%>"/>
			<wtc:param value="<%=inParas2_bf[1]%>"/>
</wtc:service>
<wtc:array id="result_bf" scope="end" />
<%
System.out.println("SSSSSSSSSSSSSSSSSSSSS inParas2_now[0] is "+inParas2_now[0]+" and inParas2_now[1] is "+inParas2_now[1]+" and inParas2_bf[0] is "+inParas2_bf[0]+" and inParas2_bf[1] is "+inParas2_bf[1]+" and result_bf.length is "+result_bf.length);
	if(result_now.length==0 && result_bf.length==0)
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
		System.out.println("CCCCCCCCCCCCCCCCCCCCCCCC result_bf[][] is "+result_bf[0][0]);
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">欠费视图-一级结果页</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>地市名称</th>
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
					<a href="g138_3.jsp?region_code=<%=region_value%>&bill_ym=<%=min_ym%>&bill_bf=<%=ym_before%>&sm_name=<%=sm_value%>&owner_code=<%=client_value%>"><%=result_now[i][0]%></a>
				</td>
				<td>
					<%=result_now[i][1]%>
				</td>
				<td>
					<%=result_now[i][2]%>
				</td>
				<td><%=result_bf[0][0]%></td>
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
 
 	
 


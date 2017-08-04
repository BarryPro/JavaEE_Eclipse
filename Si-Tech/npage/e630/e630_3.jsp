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
	String opCode = "e630";
	String opName = "集团托收销帐查询";
 
 	String[] inParas2 = new String[2];
	String contract_no = request.getParameter("contract_no").trim();
	String year_month = request.getParameter("year_month").trim();
	/*inParas2[0] = "select a.phone_no,b.sm_name,nvl(c.type_name,'普通用户'),to_char(a.should_pay-a.favour_fee-a.payed_prepay) from dConCustOweTotal a,sSmCode b,sCustGradeCode c where contract_no=:contractNo  and a.sm_code=b.sm_code  and b.region_code = substr(a.belong_code,1,2) and c.region_code(+)=substr(a.belong_code,1,2) and substr(a.attr_code,1,2) = c.owner_code(+) and a.year_month = :yearMonth";*/
	//inParas2[0] = "select a.phone_no,b.sm_name,nvl(c.type_name,'普通用户'),to_char(a.should_pay-a.favour_fee-a.payed_prepay),d.unit_id,d.unit_name,d.service_no,e.user_name from dConCustOweTotal a,sSmCode b,sCustGradeCode c,dgrpcustmsg d,dgrpusermsg e where contract_no=:contractNo  and a.sm_code=b.sm_code  and b.region_code = substr(a.belong_code,1,2) and c.region_code(+)=substr(a.belong_code,1,2) and substr(a.attr_code,1,2) = c.owner_code(+) and a.year_month = :yearMonth and e.account_id=a.contract_no and d.cust_id=e.cust_id ";
	//inParas2[0] = "select a.phone_no,to_char(a.should_pay-a.favour_fee-a.payed_prepay),to_char(d.unit_id),d.unit_name,d.service_no,e.user_name,to_char(a.contract_no) from dGrpConCustOweTotal a,sSmCode b,sCustGradeCode c,dgrpcustmsg d,dgrpusermsg e where contract_no=:contractNo  and a.sm_code=b.sm_code  and b.region_code = substr(a.belong_code,1,2) and c.region_code(+)=substr(a.belong_code,1,2) and substr(a.attr_code,1,2) = c.owner_code(+) and a.year_month = :yearMonth and e.account_id=a.contract_no and d.cust_id=e.cust_id ";
	inParas2[0] = "select a.phone_no,to_char(a.should_pay-a.favour_fee-a.payed_prepay),e.user_name,to_char(a.contract_no) from dGrpConCustOweTotal a,sSmCode b,sCustGradeCode c,dgrpusermsg e where contract_no=:contractNo  and a.sm_code=b.sm_code  and b.region_code = substr(a.belong_code,1,2) and c.region_code(+)=substr(a.belong_code,1,2) and substr(a.attr_code,1,2) = c.owner_code(+) and a.year_month = :yearMonth and e.account_id=a.contract_no  ";
	inParas2[1]="contractNo="+contract_no+",yearMonth="+year_month;
	boolean canPrint = false;
	String phoneNo = "";
	String smName = "";
	String typeName = "";
	String fee = "";

%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val2" scope="end" />

 
<%
	if (ret_val2 != null && ret_val2.length != 0) 
	{
	   canPrint = true;
	}
	if (!canPrint)
	{
		%>
		<script language="JavaScript">
			rdShowMessageDialog("无查询结果，请重新查询! ");
			window.location="e630_1.jsp";
		</script>
		<%
	}
 
	else
	{
		 
		inParas2[0] = "select to_char(d.unit_id),  d.unit_name,d.service_no  from  dgrpcustmsg d,dgrpusermsg e where e.account_id=:contractNo and d.cust_id=e.cust_id";
	    inParas2[1]="contractNo="+contract_no;	
		%>
		<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="ret_val3" scope="end" />
		<%
			if (ret_val3 == null || ret_val3.length == 0) 
			{
			   %><script language="javascript">
				    rdShowMessageDialog("无查询结果，请重新查询! ");
					window.location="e630_1.jsp";  
			     </script><%
			}

%> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>集团托收销帐查询</TITLE>
</HEAD>
<body>
<FORM action="e630_3.jsp" method="post" name="form" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团托收销帐</div>
	</div>
	<table cellspacing="0" id="tabList">
 
    <tr > 
            <td>服务号码</td>
            <!--
			<td>业务类别</td>
            <td>客户类别</td>
			-->
            <td>销帐金额</td>
			
			<td>产品账号</td>
			<td>产品名称</td>
			<td>集团编号</td>
			<td>集团名称</td>
			<td>客户经理</td>
    </tr>	
	<%
		for(int i=0;i<ret_val2.length;i++)
		{%>
		     <tr  > 
               <td ><%=ret_val2[i][0]%></td>
               <td ><%=ret_val2[i][1]%></td>
			  
			   <td ><%=ret_val2[i][3]%></td>
			   <td ><%=ret_val2[i][2]%></td>
			   
              
	  <%}
        for(int i=0;i<ret_val3.length;i++)
		{%>
		    
               <td ><%=ret_val3[i][0]%></td>
               <td ><%=ret_val3[i][1]%></td>
			  
			   <td ><%=ret_val3[i][2]%></td>
			   
             </tr>
	  <%}
	%>
		 
		 
		 
 

 
	<tr>
		<td align="center" id="footer" colspan="8">
			  <input class="b_foot" name=back onClick="window.location='e630_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
		<%
	}
%> 

 
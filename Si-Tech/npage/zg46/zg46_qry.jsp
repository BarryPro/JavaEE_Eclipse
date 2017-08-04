<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zg46";
	String opName = "集团预开发票回收";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String unit_id= request.getParameter("unit_id");
	String work_no = (String)session.getAttribute("workNo");
	 
	String year_month = request.getParameter("year_month"); 
	//分项总金额 
	String paraAray[] = new String[2]; 
	//paraAray[0] = "select to_char(a.invoice_money),to_char(a.grp_phone_no),to_char(nvl(sum(a.invoice_money),0)),a.manager_name   from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by to_char(a.grp_phone_no),to_char(a.invoice_money),a.manager_name";
	//paraAray[0] = "select  to_char(a.grp_phone_no),to_char(nvl(sum(a.invoice_money),0)),a.manager_name   from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by to_char(a.grp_phone_no), a.manager_name";
	paraAray[0] = "select  to_char(a.login_accpet),to_char(sum(a.invoice_money)),to_char(a.op_time,'YYYYMMDD hh24:mi:ss')  from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by a.login_accpet,a.op_time";
	paraAray[1] = "s_id="+ unit_id+",year_month="+year_month;

	 
	//虚拟集团名称
	String paraAray3[] = new String[2]; 
	paraAray3[0] = "select trim(unit_name) from dvirtualgrpmsg where unit_id = :s_id ";
	paraAray3[1] = "s_id="+ unit_id;

	double d_sum=0.0;
%>

<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode3" retmsg="sMsg3" outnum="1" >
    <wtc:param value="<%=paraAray3[0]%>"/>
    <wtc:param value="<%=paraAray3[1]%>"/> 
</wtc:service>
<wtc:array id="sArr3" scope="end"/>

<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="3" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
</wtc:service>
<wtc:array id="sArr" scope="end"/>

 
<%
	String retCode= sCode;
	String retMsg = sMsg;
   

	String errMsg = sMsg;
	if(sArr!=null&&sArr.length>0)
	{ 
 
%>
	<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>虚拟集团查询结果</TITLE>
</HEAD>
<body >
<script language="javascript">
	 
	 onload=function form_load()
	 {
		rdShowMessageDialog("营业员执行确认前，<br>请确定收回金额和预开发票金额相等！");
		 
	 } 
	 function doCfm(d_sum)
	 {
		var	prtFlag = rdShowConfirmDialog("预开发票总金额为"+d_sum+"元,是否确定回收?");
		if (prtFlag==1)
		{
			document.frm1508_2.action="zg46_cfm.jsp";
			document.frm1508_2.submit();
		}
		else
		{
			return false;
		}
		  
		//逻辑： 原表人历史 状态改为r 记录wloginopr
     }
	 function dojf()
	 {
		 alert("123");
	 }
</script>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0"  >
                <tr> 
                  <th >虚拟集团号码</th>
				  <th >虚拟集团名称</th>
                </tr>
			    <tr>
					<td><%=unit_id%></td>
					<td><%=sArr3[0][0]%></td>
				<input type="hidden" name="unit_id" value="<%=unit_id%>">	 
				<input type="hidden" name="unit_name" value="<%=sArr3[0][0]%>">
	 
				</tr>
				<tr> 
                  <th>流水</th>
				  <th>预开发票总金额</th>
				  <th>预开发票时间</th>
				 
                </tr>
		<%
			for(int i=0;i<sArr.length;i++)
			{
				%>
					<tr>
						<td><input type="hidden" id="s_phone<%=i%>" value="<%=sArr[i][0]%>"><%=sArr[i][0]%></td>
				 
						<td><input type="hidden" id="s_money<%=i%>" value="<%=sArr[i][1]%>">
						<a href="zg46_detail.jsp?loginaccept=<%=sArr[i][0]%>"><%=sArr[i][1]%></a></td>
						<td><input type="hidden" id="s_manager<%=i%>" value="<%=sArr[i][2]%>"><%=sArr[i][2]%></td>
					 
					</tr>
				<%
				d_sum  = d_sum+Double.parseDouble(sArr[i][1]);
			}
		%>
		 
        <input type="hidden" id="s_sum" name="s_sum1" value="<%=d_sum%>"> 
		<input type="hidden"  name="year_month" value="<%=year_month%>">
		
          <tr id="footer"> 
      	    <td colspan="4">
			<!--
			  <input class="b_foot" name=back onClick="doCfm('<%=d_sum%>') " type=button value=预开集团发票回收>
			-->
    	      <input class="b_foot" name=back onClick="window.location = 'zg46_1.jsp'  " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("查询失败: <%=retMsg%>,<%=sCode%>",0);
	window.location="zg46_1.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%}
%>
		<%

%>




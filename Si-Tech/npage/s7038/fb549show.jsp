<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-06 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

  String opName = "电子发票补打";
   
	String opCode=request.getParameter("opCode");
	String phone_no = request.getParameter("phone_no");
    String work_no = request.getParameter("work_no");
	String begin_date = request.getParameter("begin_date");
	String end_date = request.getParameter("end_date");
	String billType="2";
	
	String sqlid="select to_char(id_no) as idNo from dcustmsg where phone_no='"+phone_no+"'";
	System.out.println("sqlid====="+sqlid);
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
    	<wtc:sql><%=sqlid%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="idNo" scope="end"/>		
<%
  	if (idNo.length==0) {
%>
  			<script language="JavaScript">
    			rdShowMessageDialog("未能查询到此服务号码的相关信息! ");
    			window.location="fb549_1.jsp?activePhone=<%=activePhone%>";
  			</script>
<%
  	}
		
	//String sql = " select unique login_accept,op_code,op_name,to_char(op_time,'yyyymmdd hh24:mi:ss'),print_count from wPrintOpr"+begin_date.substring(0,6)+idNo[0][0].substring(idNo[0][0].length()-1,idNo[0][0].length())+" a,sfunccode b where a.op_code=b.function_code  and a.phone_no=  '"+phone_no +"'  and a.login_no='"+work_no+"' and  a.total_date between '"+begin_date+"' and '"+end_date+"' and a.commit_flag='Y'";
  	//System.out.println("sql====="+sql);
%>
		<wtc:service name="sBillPrt_Qry" routerKey="phone" routerValue="<%=activePhone%>" outnum="5">
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=billType%>"/>
			<wtc:param value="<%=begin_date%>"/>
			<wtc:param value="<%=end_date%>"/>			
		</wtc:service>
		<wtc:array id="printCodeStr" scope="end"/>		
<% 

		if (printCodeStr.length==0) {
%>
		  <script language="JavaScript">
		    rdShowMessageDialog("未能查询到此服务号码的电子发票打印信息! ");
		    window.location="fb549_1.jsp?activePhone=<%=activePhone%>";
		  </script>

<% 
			return;
		}
%>
<HTML>
<HEAD>
<TITLE>电子发票补打</TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doPrintSubmit()
{
	  document.all.haseval.value="0";
	  document.all.evalcode.value = "0";
	<%for(int j=0; j<printCodeStr.length; j++)
		{%>
			if(document.form.unchange[<%=j%>].checked == true){
		  	document.form.acceptStr.value="<%=printCodeStr[j][0]%>";
				document.form.opcodeStr.value="<%=printCodeStr[j][1]%>";
		  }	
	<%}%>
		document.form.submit();
}

//-->
</SCRIPT>
</HEAD>
<BODY leftmargin="0" topmargin="0">
	
<FORM action="fb549print.jsp" method=post name=form>
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		    <div id="title_zi">电子发票明细</div>
		</div>
		<table cellspacing="0">
		  <tr align="center">
		       <th>选择</th>
		       <th>业务流水</th>
		       <th>操作代码</th>
		       <th>操作名称</th>
		       <th>操作时间</th>
		       <th>已打印次数</th>
		   </tr>
		<% 
		String tbclass="";
		for(int i=0; i < printCodeStr.length  ; i++)
	{
			tbclass=(i%2==0)?"Grey":"";
		%>
			<tr align="center">
			  <td class="<%=tbclass%>">
				  <input type="radio" name="unchange" value="<%=printCodeStr[i][0].trim()%>" checked>
			  </td>
			  <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][0]%></div>
			  </td>
			   <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][1]%></div>
			  </td>
			   <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][2]%></div>
			  </td>
			  <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][3]%></div>
			  </td>
			  <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][4]%></div>
			  </td>
			</tr>
    <%}%>
		</table>
		<table>
			<tr>
			<td id="footer">
	        <input class="b_foot" name=sure type=button value=打印 onclick="doPrintSubmit()">&nbsp;
	        <input class="b_foot" name=doBackButton type=button value=返回 onclick="JavaScript:history.go(-1)">
        </td>
      </tr>
    </table>
<%@ include file="/npage/include/footer.jsp" %>       
<input type="hidden" name="print_num"  value="">
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="work_no"  value="<%=work_no%>">
<input type="hidden" name="phone_no"  value="<%=phone_no%>">
<input type="hidden" name="acceptStr"  value="">
<input type="hidden" name="opcodeStr"  value="">
<input type="hidden" name="sel_type"  value="1">
<input type="hidden" name="beginDate"  value="<%=begin_date%>">
<input type="hidden" name="endDate"  value="<%=end_date%>">
<input type="hidden" name="idNo"  value="<%=idNo[0][0]%>">
<input type="hidden" name="haseval">
<input type="hidden" name="evalcode">
<input type="hidden" name="activePhone" value="<%=activePhone%>">
<input type="hidden" name="billType" value="<%=billType%>">
</FORM>
</BODY>

</HTML>
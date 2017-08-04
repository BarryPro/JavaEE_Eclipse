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

    String opName = "免填单补打";
   
	String opCode=request.getParameter("opCode");
	String phone_no = request.getParameter("phone_no");
	String login_accept22 = request.getParameter("login_accept")==null?"0":request.getParameter("login_accept");
    String work_no = request.getParameter("work_no");
	String begin_date = request.getParameter("begin_date");
	String end_date = request.getParameter("end_date");
	String billType="1";
	
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
  			
<%
  	}
		
	//String sql = " select unique login_accept,op_code,op_name,to_char(op_time,'yyyymmdd hh24:mi:ss'),print_count from wPrintOpr"+begin_date.substring(0,6)+idNo[0][0].substring(idNo[0][0].length()-1,idNo[0][0].length())+" a,sfunccode b where a.op_code=b.function_code  and a.phone_no=  '"+phone_no +"'  and a.login_no='"+work_no+"' and  a.total_date between '"+begin_date+"' and '"+end_date+"' and a.commit_flag='Y'";
  	//System.out.println("sql====="+sql);
%>
		<wtc:service name="sPrt_Qry" routerKey="phone" routerValue="<%=activePhone%>" outnum="6">
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=billType%>"/>
			<wtc:param value="<%=begin_date%>"/>
			<wtc:param value="<%=end_date%>"/>
			<wtc:param value="<%=login_accept22%>"/>			
		</wtc:service>
		<wtc:array id="printCodeStr" scope="end"/>		
<% 

		if (printCodeStr.length==0) {
%>
		  <script language="JavaScript">
		    rdShowMessageDialog("未能查询到此服务号码的免填单打印信息! ");
		    window.location="f7038_1.jsp?activePhone=<%=activePhone%>";
		  </script>

<% 
			return;
		}
%>
<HTML>
<HEAD>
<TITLE>免填单打印</TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doPrintSubmit()
{
  document.all.haseval.value="0";
  document.all.evalcode.value = "0";	
	var l=0;
    document.form.acceptStr.value="";
    <%int k = printCodeStr.length;
      int j=0;
      
    for(j=0;j<k;j++)
	{%>
		if (<%=k%>==1) 
		{
			if (document.form.unchange.checked == true){
				document.form.acceptStr.value="<%=printCodeStr[j][0]%>"+"|";
				document.form.opcodeStr.value="<%=printCodeStr[j][1]%>"+"|";
				l=l+1;
			}
		}
		else if(document.form.unchange[<%=j%>].checked == true)
		{
			l=l+1;
			document.form.acceptStr.value=document.form.acceptStr.value + "<%=printCodeStr[j][0]%>"+"|";
			document.form.opcodeStr.value=document.form.opcodeStr.value + "<%=printCodeStr[j][1]%>"+"|";
		}
	<%}%>
	
	if(l==0){rdShowMessageDialog("请选择要打印的信息");return ;}
	document.form.submit();
}

function doPrintEvalSubmit()
{
	var vEvalValue = GetEvalReq(1);
 
  document.all.haseval.value="1";
  document.all.evalcode.value = vEvalValue;
	
	var l=0;
  document.form.acceptStr.value="";
  <% int ik = printCodeStr.length;
    int ij=0;
    for(ij=0;ij<ik;ij++)
	{%>
		if (<%=ik%>==1) 
		{
			if (document.form.unchange.checked == true){
				document.form.acceptStr.value="<%=printCodeStr[ij][0]%>"+"|";
				l=l+1;
			}
		}
		else if(document.form.unchange[<%=ij%>].checked == true)
		{
			l=l+1;
			document.form.acceptStr.value=document.form.acceptStr.value + "<%=printCodeStr[ij][0]%>"+"|";
		}
	<%}%>
	
	if(l==0){rdShowMessageDialog("请选择要打印的信息");return ;}
	document.form.submit();
}

function allChoose()
{   //复选框全部选中
    var k = <%=printCodeStr.length%>;
    for(i=0;i<k;i++)
    {
        if (k==1)
        {
        	if(document.form.unchange.type=="checkbox")
        	{
        		if(document.form.unchange.disabled == false)
               document.form.unchange.checked = true;
        	}
        }
        else if(document.form.unchange[i].type=="checkbox")
        {    //判断是否是单选或复选框
            if(document.form.unchange[i].disabled == false)
               document.form.unchange[i].checked = true;
        }
    }
}
function cancelChoose()
{   //取消复选框全部选中
	var k = <%=printCodeStr.length%>;
    for(i=0;i<k;i++)
    {
        if (k==1)
        {
        	if(document.form.unchange.type=="checkbox")
        	{
        		if(document.form.unchange.disabled == false)
               document.form.unchange.checked = false;
        	}
        }
        else if(document.form.unchange[i].type =="checkbox")
        {    //判断是否是单选或复选框
            if(document.form.unchange[i].disabled == false)
               document.form.unchange[i].checked = false;
        }
    }
}

function goBack(){
  window.location.href="f7038_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone_no%>";
}

//-->
</SCRIPT>
</HEAD>
<BODY leftmargin="0" topmargin="0">
	
<FORM action="f7038print.jsp" method=post name=form>
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		    <div id="title_zi">免填单明细</div>
		</div>
		<table cellspacing="0">
		  <tr align="center">
		       <th>选择</th>
		       <th>业务流水</th>
		       <th>操作代码</th>
		       <th>操作名称</th>
		       <th>操作时间</th>
		       <th>已打印次数</th>
		       <th>服务号码</th>
		   </tr>
		<% 
		String tbclass="";
		for(int i=0; i < printCodeStr.length  ; i++)
	{
			tbclass=(i%2==0)?"Grey":"";
		%>
			<tr align="center">
			  <td class="<%=tbclass%>">
				<% 
				if (printCodeStr[i][4].equals("0"))
				{
				%>
				  <input type="checkbox" name="unchange" value="<%=printCodeStr[i][0].trim()%>" checked  >
				<%}
				else
				{
				%>
				  <input type="checkbox" name="unchange" value="<%=printCodeStr[i][0].trim()%>" >
				<%}%>
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
			  <td class="<%=tbclass%>">
				<div align="center"><%=printCodeStr[i][5]%></div>
			  </td>
			</tr>
    <%}%>
		</table>
		<table>
			<tr>
			<td id="footer">
	        <input class="b_foot" name=allchoose type=button value=全选 onclick="allChoose()">&nbsp;
	        <input class="b_foot" name=cancelAll type=button value=取消全选 onclick="cancelChoose()">&nbsp;
	        <input class="b_foot" name=sure type=button value=打印 onclick="doPrintSubmit()">&nbsp;
	        <input class="b_foot" name=doBackButton type=button value=返回 onclick="goBack()">
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
<input type="hidden" name="idNo"  value="">
<input type="hidden" name="haseval">
<input type="hidden" name="evalcode">
<input type="hidden" name="activePhone" value="<%=activePhone%>">
<input type="hidden" name="billType" value="<%=billType%>">
</FORM>
</BODY>

</HTML>
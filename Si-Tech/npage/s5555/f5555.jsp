<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>              
<%


 	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String begin_date = "";

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=2;i++)
        {
              if(i!=2)
              {
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        begin_date=begin_date+"01"; 
%>                 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>                 
		<title><%=opName%></title>   
		<script>
			function doCfm(){
				var begin_time=document.form1.clean_stime.value;
				var end_time=document.form1.clean_etime.value;
				var table_name=document.form1.table_name.value;
				var owner_name=document.form1.owner_name.value;
				/*
				if(document.form1.all("clean_stime").value.length == 8)
					document.form1.clean_stime.value=document.form1.clean_stime.value+" 00:00:00";
				if(document.form1.all("clean_etime").value.length == 8)
					document.form1.clean_etime.value=document.form1.clean_etime.value+" 23:59:59";	
				*/
				if(!check(document.form1)){
					return false;
				}				
				if (table_name=="")
				{
				  rdShowMessageDialog("请输入表名！");
				  document.form1.table_name.focus();
				  return false;
				}
				if (owner_name=="")
				{
				  rdShowMessageDialog("请输入属主！");
				  document.form1.owner_name.focus();
				  return false;
				}				
				if(begin_time>end_time){
					rdShowMessageDialog("开始时间比结束时间大",0);
					return false;
				}	
				document.form1.submit();
			}
		</script>
	</head>
	<body>
		<form name="form1" action="f5555_1.jsp">
<div id="Main">
   <DIV id="Operation_Table"> 
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
			<table cellspacing="0">
				<tr> 
					<td nowrap class="blue">属主 </td>
					<td nowrap > 
						<input type="text" name="owner_name" id="table_name" v_type="string"/>
					</td>
					<td nowrap class="blue">表名 </td>
					<td nowrap > 
						<input type="text" name="table_name" id="owner_name" v_type="string"/>
					</td>					
				</tr>
				<tr> 
					<td nowrap class="blue">清理开始时间 </td>
					<td nowrap> 
						<input type="text" v_type="string" class="button" name="clean_stime" value=<%=begin_date%> >
					</td>
					<td nowrap class="blue">清理结束时间 </td>
					<td nowrap > 
						<input type="text" v_type="string" class="button" name="clean_etime"  value=<%=dateStr%> >
					</td>											
				
				</tr>					
				<tr> 
					<td colspan="4" id="footer"> 
						<input class="b_foot" type="button" name="confirm" value="查询" onClick="doCfm()"/>  
						<input class="b_foot" type="button" name="back" value="清除" onClick="document.form1.reset()">  
					</td>
				</tr>
			</table>			
		<%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" value="<%=opName%>"/>
		</form>
	</body>
</html>

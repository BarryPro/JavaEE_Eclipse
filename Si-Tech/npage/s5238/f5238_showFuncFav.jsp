   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	System.out.println("------------f5238_showFuncFav---------------");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	String sm_code = request.getParameter("sm_code");
 		String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                	//登陆密码
	String regionCode= (String)session.getAttribute("regCode");
 	
 		String[] paramsIn=new String[7];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	paramsIn[6]=sm_code;
	
	
	
%>

<html>
<head>
<base target="_self">
<title>特服优惠配置信息查看</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language="JavaScript"> 
function selectAll()
{
	if(document.all.check_flag.length==undefined)
	{
		document.all.check_flag.checked=true;
	}
	else if(document.all.check_flag.length>0)
	{
		for(var i=0;i<document.all.check_flag.length;i++)
		{
			document.all.check_flag[i].checked=true;
		}
	}
}

//----全部取消------
function selectNone()
{
	if(document.all.check_flag.length==undefined)
	{
		document.all.check_flag.checked=false;
	}
	else if(document.all.check_flag.length>0)
	{
		for(var i=0;i<document.all.check_flag.length;i++)
		{
			document.all.check_flag[i].checked=false;
		}
	}
}
</script>
</head>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">特服优惠配置信息查看</div>
	</div>
	
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  		  	<TABLE   id="mainOne" cellspacing="0"  >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;优惠代码</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD height="22" class="blue">&nbsp;&nbsp;优惠描述</TD>
	  					<TD >
	  						<%=note%>
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<table   id="maintwo"   cellspacing="0"  >
	  				<tr height="22">
	  					<Th width="5%"  align="center">选择</Th>
	  					<Th width="10%" align="center">特服代码</Th>
	  					<Th width="45%" align="center">特服名称</Th>
	  					<Th width="15%" align="center">优惠比率</Th>
	  					<Th width="25%" align="center">日收标志</Th>
	  				</tr>
				  
				<%
				String result_t[][]=new String[][]{};
				%>
				    <wtc:service name="s5238_FuncShw" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />					
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />
		
		<%
						if(code.equals("000000")&&result_t1.length>0)
						for(int i=0;i<result_t.length;i++)
						{
						if(i%2==0){
				%>
						<tr   height="20" >
							<TD width="35" Class="Grey"><input type="checkbox" name="check_flag" <%=result_t[i][0].equals("1")==true?"checked":""%>></TD>
							<TD width="75" Class="Grey"> <%=result_t[i][1]%></TD>
							<TD width="368" Class="Grey"><%=result_t[i][2]%></TD>
							<TD width="122" Class="Grey"><input type="text" name="favour_rate" size="6" value="<%=result_t[i][3]%>"></TD>
							<TD width="190" Class="Grey">
								<input type="radio" name="day_flag<%=i%>" value="0" <%=result_t[i][4].equals("0")==true?"checked":""%>>日收
	  						<input type="radio" name="day_flag<%=i%>" value="1" <%=result_t[i][4].equals("1")==true?"checked":""%>>月收
							</TD>
						</tr>
				<%
				}
			else{
				%>
				<tr   height="20" >
							<TD width="35" Class=""><input type="checkbox" name="check_flag" <%=result_t[i][0].equals("1")==true?"checked":""%>></TD>
							<TD width="75" Class=""> <%=result_t[i][1]%></TD>
							<TD width="368" Class=""><%=result_t[i][2]%></TD>
							<TD width="122" Class=""><input type="text" name="favour_rate" size="6" value="<%=result_t[i][3]%>"></TD>
							<TD width="190" Class="">
								<input type="radio" name="day_flag<%=i%>" value="0" <%=result_t[i][4].equals("0")==true?"checked":""%>>日收
	  						<input type="radio" name="day_flag<%=i%>" value="1" <%=result_t[i][4].equals("1")==true?"checked":""%>>月收
							</TD>
						</tr>
				
				<%
				}
						}
	  			%>
	  			
	  				<tr  height="22">
	  					<TD width="10%" colspan="5">&nbsp;&nbsp;<font class="orange">备注优惠比率,如配0.8则优惠费用为（应收*0.2）</font></TD>
	  				</tr>
	  			</table>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="reset" type="button" class="b_foot" value="返回" onClick="window.close()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>


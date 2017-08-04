   
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
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");	
	   	
	   	String[] paramsIn=new String[7];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=mode_code;
				paramsIn[5]=mode_name;
				paramsIn[6]=region_code;
				
%>

<html>
<head>
<base target="_self">
<title>产品变更规则配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

</script>
</head>	  
<form name="form1"  method="post">
	  	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品变更规则配置</div>
	</div>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

 
	  		  	<TABLE   id="mainOne"  cellspacing="0"  >
	  				<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;产品代码</TD>
	  					<TD width="35%">
	  						&nbsp;<%=mode_code%>
	  					</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  					<TD width="35%"> <font class="orange">&nbsp;<%=login_accept%></font></TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD class="blue">&nbsp;&nbsp;产品名称</TD>
	  					<TD colspan="3">
	  						&nbsp;<%=mode_name%>
	  					</TD>
	  				</tr>
	  			</table>
	  			<table  id="mainThree" cellspacing="0">
	  				<tr height="24" >
      		    
      		    <th align="center" >产品代码</Th>
	  					<th align="center" >产品名称</Th>
	  					<th align="center" >关系</Th>
	  					<th align="center" >产品代码</Th>
	  					<th align="center" >产品名称</Th>
	  					<th width="10%" align="center" > 生效方式</Th>
      		  		</tr>
    <%
    String errCode = "";
    String errMsg = "";
    %>  		  		
    <wtc:service name="s5238_BBChgShw" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />						
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
<%				
				errCode = code;
				errMsg = msg;
				System.out.println("------------errCode-------------f5238_showChange.jsp--------"+errCode);
				if(errCode.equals("000000"))
				{
				
					for(int i=0;i<result_t.length;i++)
					{
						if(i%2==0){
				%> 
					<tr  height="20" >
                		<td align="center" width="70"  height="20" Class="Grey"><%=result_t[i][0]%></td>
                		<td align="center" width="228" height="20" Class="Grey"><%=result_t[i][1]%></td>
                		<td align="center" width="74"  height="20" Class="Grey">->></td>
                		<td align="center" width="73"  height="20" Class="Grey"><%=result_t[i][3]%></td>
                		<td align="center" width="229" height="20" Class="Grey"><%=result_t[i][4]%></td>
                		<td align="center" width="56"  height="20" Class="Grey"><%=result_t[i][5]%></td>	
			    	</tr>
			    	<%
			    	}
			    else
			    	{
			    	%>
			    			<tr  height="20">
                		<td align="center" width="70"  height="20"  Class=""><%=result_t[i][0]%></td>
                		<td align="center" width="228" height="20"  Class=""><%=result_t[i][1]%></td>
                		<td align="center" width="74"  height="20"  Class="">->></td>
                		<td align="center" width="73"  height="20"  Class=""><%=result_t[i][3]%></td>
                		<td align="center" width="229" height="20"  Class=""><%=result_t[i][4]%></td>
                		<td align="center" width="56"  height="20"  Class=""><%=result_t[i][5]%></td>	
			    	</tr>
			    	<%
			    	}
					}	
				}
				else
				{	
				%>        
					<script language="javascript">
						rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>",0);
					</script>       
				<%            
				}
			
				%>               	
	          	</TABLE>
	          	<TABLE cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button" class="b_foot" value="返回" onClick="window.close();">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>

</body>
</html>


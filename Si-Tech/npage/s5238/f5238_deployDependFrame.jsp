<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                 	//登陆密码
	String regionCode= (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_name = request.getParameter("mode_name");
	String mode_code = request.getParameter("mode_code");
	String region_code = request.getParameter("region_code");
	String trans_type = request.getParameter("trans_type");
	
	String errCode="";
    String errMsg="";
%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>
</script>
</head>
<body>
<form target="middle" action="" method="post" name="form2">
<div id="Main">
   <DIV id="Operation_Table">                         

      		<table  id="mainThree"  cellspacing="0">
      		  	<%
			
				String[] paramsIn=new String[7];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=mode_code;
				paramsIn[5]=mode_name;
				paramsIn[6]=region_code;
				
				//retArray=callView.callFXService("s5238_DependQry",paramsIn,"6");	
				%>
				
	 <wtc:service name="s5238_DependQry" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
					System.out.println("---------------------errCode------------f52358_deployDependFrame.jsp----------"+errCode);
						for(int iii=0;iii<result_t.length;iii++){
				for(int jjj=0;jjj<result_t[iii].length;jjj++){
					System.out.println("---------------------result_t["+iii+"]["+jjj+"]=-----------------"+result_t[iii][jjj]);
				}
		}
		
				if(errCode.equals("000000"))
				{
					for(int i=0;i<result_t.length;i++)
					{
				%> 
					<tr  height="20" >
                		<td align="center" width="70" height="20"><%=result_t[i][0]%></td>
                		<td align="center" width="228" height="20"><%=result_t[i][1]%></td>
                		<td align="center" width="74" height="20">主->>可选</td>
                		<td align="center" width="73" height="20"><%=result_t[i][3]%></td>
                		<td align="center" width="229" height="20"><%=result_t[i][4]%></td>
                		<td align="center" width="56" height="20"><%=result_t[i][5]%></td>	
			    	</tr>
			    	<%
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
      		</table>
 
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>	
</body>
</html>  

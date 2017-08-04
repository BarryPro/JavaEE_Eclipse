   
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
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	String[][] result = new String[][]{};
	 
	String loginNo = (String)session.getAttribute("workNo");
	String nopass  = (String)session.getAttribute("password");
	String regionCode= (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");    
	String mode_code = request.getParameter("mode_code");
	
	
	

	
	
	String paramsIn[] = new String[5];
    paramsIn[0] = loginNo;				//工号
    paramsIn[1] = nopass;				//密码
    paramsIn[2] = "5240";				//OP_CODE
    paramsIn[3] = login_accept;         //流水
    paramsIn[4] = mode_code;			//产品代码
    
	//acceptList = impl.callFXService("s5240Int",paramsIn,"11");
%>

    <wtc:service name="s5240Int" outnum="11" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />				
		</wtc:service>
		<wtc:array id="result_t1" scope="end"  />

<%	

	
	String errCode=code1;
	String errMsg=msg1;
	
	System.out.println("-------------errCode------------f5240_quertModeCode.jsp-------------"+errCode);
			for(int iii=0;iii<result_t1.length;iii++){
				for(int jjj=0;jjj<result_t1[iii].length;jjj++){
					System.out.println("---------------------result_t1["+iii+"]["+jjj+"]=-----------------"+result_t1[iii][jjj]);
				}
		}
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%
}
%>

<html>
<head>
<title>产品列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择产品</div>
	</div>
<table  cellspacing="0"  id="tab1"	>
	<tr >
		<th>
			选择
	</th>
		<th>
			产品代码
		</th>
		<th>
			产品名称
		</th>
		<th>
			地区代码
		</th>
		<th>
			地区名称
	</th>
		<th>
			配置流水
	</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 " class="b_foot">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < result_t1.length;i++){ %>
			
			var str='<input type="hidden" name="region_code" value="<%=result_t1[i][0]%>">';
			str+='<input type="hidden" name="region_name" value="<%=result_t1[i][1]%>">';
			str+='<input type="hidden" name="mode_code" value="<%=result_t1[i][2]%>">';
			str+='<input type="hidden" name="mode_name" value="<%=result_t1[i][3]%>">';
			str+='<input type="hidden" name="sm_code" value="<%=result_t1[i][4]%>">';
			str+='<input type="hidden" name="sm_name" value="<%=result_t1[i][5]%>">';
			str+='<input type="hidden" name="login_accept" value="<%=result_t1[i][6]%>">';
			str+='<input type="hidden" name="begin_time" value="<%=result_t1[i][7]%>">';
			str+='<input type="hidden" name="end_time" value="<%=result_t1[i][8]%>">';
			str+='<input type="hidden" name="note" value="<%=result_t1[i][9]%>">';
			str+='<input type="hidden" name="statusName" value="<%=result_t1[i][10]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.height="20";
			newrow.align="center";
		  	newrow.insertCell(0).innerHTML ='<input type="radio" name="num"  value="<%=i%>">'+str;
		    newrow.insertCell(1).innerHTML = '<%=result_t1[i][2]%>';
		    newrow.insertCell(2).innerHTML = '<%=result_t1[i][3]%>';
		    newrow.insertCell(3).innerHTML = '<%=result_t1[i][0]%>';
		    newrow.insertCell(4).innerHTML = '<%=result_t1[i][1]%>';
		    newrow.insertCell(5).innerHTML = '<%=result_t1[i][6]%>';

		    	
		<%
		}%>

		function doCommit(){
			if("<%=result_t1.length%>"=="0"){
				rdShowMessageDialog("您没有选择产品代码！",0);
				return false;
			}
			else if("<%=result_t1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.mode_code.value=document.all.mode_code.value;
					window.opener.form1.mode_name.value=document.all.mode_name.value;
					window.opener.form1.region_code.value=document.all.region_code.value;
					window.opener.form1.group_id.value=document.all.region_code.value;
					window.opener.form1.sm_code.value=document.all.sm_code.value;
					window.opener.form1.sm_name.value=document.all.sm_name.value;
					window.opener.form1.login_accept.value=document.all.login_accept.value;
					window.opener.form1.mode_begin_time.value=document.all.begin_time.value;
					window.opener.form1.mode_end_time.value=document.all.end_time.value;
					window.opener.form1.note.value=document.all.note.value;
					window.opener.form1.statusName.value=document.all.statusName.value;
					window.close();
				}
				else{
					rdShowMessageDialog("您没有选择产品代码！",0);
					return false;
				}
			}
			else{//值为多条时需要用数组
				
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.mode_code.value=document.all.mode_code[a].value;
					window.opener.form1.mode_name.value=document.all.mode_name[a].value;
					window.opener.form1.region_code.value=document.all.region_code[a].value;
					window.opener.form1.group_id.value=document.all.region_code[a].value;
					window.opener.form1.sm_code.value=document.all.sm_code[a].value;
					window.opener.form1.sm_name.value=document.all.sm_name[a].value;
					window.opener.form1.login_accept.value=document.all.login_accept[a].value;
					window.opener.form1.mode_begin_time.value=document.all.begin_time[a].value;
					window.opener.form1.mode_end_time.value=document.all.end_time[a].value;
					window.opener.form1.note.value=document.all.note[a].value;
					window.opener.form1.statusName.value=document.all.statusName[a].value;

					window.close();
				}
				else{
					rdShowMessageDialog("您没有选择产品代码！",0);
					return false;
				}
			}
		}
	
	function doClose(){
		window.close();
	}
</script>
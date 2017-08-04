<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "170";
	String opName = "工号查询";
	    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	String login_name =request.getParameter("login_name");
	String action =request.getParameter("myaction");
	String[][] dataRows = new String[][]{};
	String strSql = "";
	if(login_name!=null&&login_name.trim().length()!=0){
	 //strSql += "select  t1.kf_login_no, t1.boss_login_no ,t.login_name,t2.region_name from  dloginmsg t ,dloginmsgrelation t1,scallregioncode t2 where t.login_no=t1.boss_login_no and substr(t.org_code,1,2)= t2. region_code and t.login_name LIKE '%"+login_name+"%' ";
	 //strSql +="select  t1.kf_login_no, t1.boss_login_no ,t.login_name,t2.region_name from  dloginmsg t ,dloginmsgrelation t1,scallregioncode t2 where t.login_no=t1.boss_login_no and substr(t.org_code,1,2)= t2. region_code and (t.login_name LIKE '%'||:login_name||'%' or t.login_no=:vlogin_name  or t1.kf_login_no=:vvlogin_name )";
     //update by songjia 
     strSql = " select t1.kf_login_no, t1.boss_login_no, t.login_name, t2.group_name"+
  			  " from dloginmsg t, dloginmsgrelation t1, dchngroupmsg t2"+
			  " where t.login_no = t1.boss_login_no"+
   			  " and t.group_id = t2.group_id"+
   			  " and (t.login_name LIKE '%'||:login_name||'%' or t.login_no=:vlogin_name)";
   	System.out.println(strSql);
	 //myParams="login_name="+login_name+",vlogin_name="+login_name+",vvlogin_name="+login_name;
	 myParams="login_name="+login_name+",vlogin_name="+login_name;
	}
	if("query".equals(action)){
%>	             
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
					<wtc:param value="<%=strSql%>"/>
					<wtc:param value="<%=myParams%>"/>
				</wtc:service> 
				<wtc:array id="queryList"  scope="end"/>	
<%  
      dataRows = queryList;
	}
  
%>
<html>
<head>
<title>工号查询</title>
<style>
.keybutton { cursor:hand; font-size: 12px; color: #000000; background: #F8F8FF ; 

border: 0px solid;}

.keybutton1 { cursor:hand; font-size: 12px; color: #000000; background: #FFFFFF; 

border: 0px solid;}
</STYLE>
<script language=javascript>

function winClose(){

//alert(document.form1.treeValue.value);
//window.opener.document.getElementById("call_cause_id").value=document.form1.node_Id.value;
window.close();
}

function submitInputCheck(){
   if(document.sitechform.login_name.value.length != 0){
    	 submitMe();	
    }
}

function submitMe(){
    window.sitechform.myaction.value="query";
    window.sitechform.action="k170_getLoginNo.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

function sendParData(login_no){
	window.opener.document.getElementById("accept_login_no").value=login_no;
	window.close();
}

</script>
</head>
<body>
<form name="sitechform"  action="">	
<div id="Operation_Table"> 
	<table cellspacing="0">
   	  <input type="hidden" name="myaction" value="">
		<tr>
			<td align="left" id="footer">
 		工号或姓名&nbsp;<input name="login_name" type="text"  id="login_name" value="" >
   <input name="search" type="button"  id="search" class="b_text" value="查询" onClick="submitInputCheck()"> &nbsp;&nbsp;
  </td>
  </tr>
 </table>
  
   <br>
   	  <table cellspacing="0" >
	  	<tr>
	  		<th align="center" class="blue">平台工号</td>
	  		<th align="center" class="blue">BOSS工号</td>
	  		<th align="center" class="blue">姓名</td>
	  		<th align="center" class="blue">地市</td>
	  	</tr>
 <% for ( int i = 0; i < dataRows.length; i++ ) {             
         String tdClass="";
        if((i+1)%2==1){
          tdClass="grey";
          }
%>

    <tr  >
      
      <td align="center" class="<%=tdClass%>" ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>" ><button class="<%=(tdClass=="")?"keybutton":"keybutton1"%>" onClick="sendParData('<%=dataRows[i][1]%>')"><font color="blue"><%=dataRows[i][1]%></font></button></td>   
      <td align="center" class="<%=tdClass%>" ><%=dataRows[i][2]%></td>
      <td align="center" class="<%=tdClass%>" ><%=dataRows[i][3]%></td>
    </tr>
      <% } %>
	  	</tr>
		</table>
	<div id="Operation_Table">

  </form>
</body>
</html>

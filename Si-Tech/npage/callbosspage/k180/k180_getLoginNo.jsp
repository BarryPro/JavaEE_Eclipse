<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	String opCode = "170";
	String opName = "工号查询";
	String login_no =request.getParameter("login_no");
	String action =request.getParameter("myaction");
	String[][] dataRows = new String[][]{};
	String strSql = "";
	System.out.println("工号查询：login_no="+login_no);
	if(login_no!=null&&login_no.trim().length()!=0){
	/*modify by zhengjiang 20091001 删除条件t1.kf_login_no like '%"+login_no+"%'增加条件(t.login_no='" + login_no + "' or t1.kf_login_no='" + login_no +"')*/
	/*把t1.kf_login_no替换为t1.boss_login_no*/
	  strSql += "select  t1.boss_login_no,t.login_name,t2.region_name from  dloginmsg t ,dloginmsgrelation t1,scallregioncode t2 where t.login_no=t1.boss_login_no and substr(t.org_code,1,2)= t2. region_code and (t.login_no=:vlogin_no  or t1.kf_login_no=:vvlogin_no ) ";//t1.kf_login_no like '%"+login_no+"%' ";
	  myParams="vlogin_no="+login_no+",vvlogin_no="+login_no;
	}

	if("query".equals(action)){
%>	             
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
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

function submitInputCheck(){
   if(document.sitechform.login_no.value.length != 0){
    	 submitMe();	
    }
}

function submitMe(){
    window.sitechform.myaction.value="query";
    window.sitechform.action="k180_getLoginNo.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();;
}

function sendParData(login_no){
	window.opener.document.getElementById("send_login_no").value=login_no;
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
 		工号&nbsp;<input name="login_no" type="text"  id="login_no" value="" >
   <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck()"> &nbsp;&nbsp;
  </td>
  </tr>
 </table>
  
   <br>
   	  <table cellspacing="0" >
	  	<tr>
	  		<th align="center" class="blue">工号</td>
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
      <td align="center" class="<%=tdClass%>" ><button class="<%=(tdClass=="")?"keybutton":"keybutton1"%>" onClick="sendParData('<%=dataRows[i][0]%>')"><font color="blue"><%=dataRows[i][0]%></font></button></td>
      <td align="center" class="<%=tdClass%>" ><%=dataRows[i][1]%></td>
      <td align="center" class="<%=tdClass%>" ><%=dataRows[i][2]%></td>
    </tr>
      <% } %>
	  	</tr>
		</table>
	<div id="Operation_Table">

  </form>
</body>
</html>
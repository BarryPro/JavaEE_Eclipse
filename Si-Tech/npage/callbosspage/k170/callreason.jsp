<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	String contactId = request.getParameter("contactId")==null?"":request.getParameter("contactId");
	String contactMonth = request.getParameter("contactMonth")==null?"":request.getParameter("contactMonth");
	String sqlStr="select call_cause_id,callcausedescs,decode(trunc(sysdate-to_date(to_char(begin_date,'YYYYMMDD'),'YYYYMMDD')),'0','1','0') from dcallcall"+contactMonth+" where contact_id = :contactId ";
	myParams="contactId="+contactId;
	String Callcausedescs="";
	String Callcauseid="";
	String updateflag=""; //0 可以更新 1 不可以更新 add wangyong 20090930
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
<wtc:row id="row" length="3">
<%
   Callcauseid = row[0];
   Callcausedescs = row[1];
   updateflag = row[2];
%>
</wtc:row>
<html>
	<head>
		<title>
			黑龙江移动综合客户服务系统
		</title>
	</head>
	<body>
		<input type='hidden' id='contactId' value='<%=contactId%>'>
		<input type='hidden' id='contactMonth' value='<%=contactMonth%>'>
		<input type='hidden' id='pre_node_Id' value='<%=Callcauseid%>'>
		<input type='hidden' id='pre_node_Name' value='<%=Callcausedescs%>'>
		<input type='hidden' id='updateflag' value='<%=updateflag%>'>
		<div id='call_case' style='display:none'>
		</div>
  <div>
  	<table>
  		<tr>
  			<td width="17%" id=up style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"> 
	  			<iframe  name="myFrame2" frameborder="0" width="100%" height="500px" marginwidth="0" marginheight="0" scrolling="auto" src="callcomereasonemenus.jsp"></iframe>	  
	  		 </td>
	  		 <td id=up style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"> 
	  			<iframe  name="myFrame3" frameborder="0" width="100%" height="500px" marginwidth="0" marginheight="0" scrolling="auto" src="callreasonrightupdate.html"></iframe>	  
	  		 </td>
  		</tr>
  		<table>
  	<div>
		<body>
			<script>
				window.onload=function()
				{
					var sel = myFrame3.document.getElementById('selectcontent');
					var char2 = /&gt;/g;
					var caseid='';
					if(window.opener.isLoadCallCauseWindow!=undefined){
						window.opener.isLoadCallCauseWindow = 1;
					}
					document.getElementById('call_case').innerHTML='<%=Callcausedescs%>';
					$('span').each(function(){
						sel.options.add(new Option(this.innerHTML.substring(4,this.innerHTML.length - 8).replace(char2,'>'),this.id));
						caseid=this.id;
						});
						window.open('callreasonlist.jsp?id='+caseid.substr(0,6),'myFrame4');
						sel=null;
						caseid=null;
				}
				</script>
</html>


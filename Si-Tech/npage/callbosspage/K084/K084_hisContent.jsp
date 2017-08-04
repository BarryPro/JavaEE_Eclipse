<%
  /*
   * 功能:  历史记录
　 * 版本: 1.0
　 * 日期: 2009/02/28
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	//modifiy by songjia
	String beginTime   = request.getParameter("beginTime");            //开始时间
    String endTime     = request.getParameter("endTime");              //结束时间
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

    String opCode="K084";
    String opName="通知历史记录";
        String[][] dataRows = new String[][]{};
        //modify wangyong 20090928
	  //String send_login_no = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));
	  String send_login_no = WtcUtil.repNull((String)session.getAttribute("workNo"));
     String strSql="select receive_login_no,content,to_char(send_time,'yyyy-mm-dd hh24:mi:ss'),decode(send_login_no,'"+send_login_no+"','发送','接收') from dnoticecontent ";
     String sqlFilter = " where send_time >  to_date(:beginTime ,'yyyyMMdd hh24:mi:ss') and send_time < to_date(:endTime,'yyyyMMdd hh24:mi:ss')";
     String sqlFilter3="where to_char(sysdate,'yyyymmdd')=to_char(send_time,'yyyymmdd')";
     String sqlFilter2 =" and bak1='Y' and (send_login_no=:send_login_no or receive_login_no=:send_login_no ) order by send_time  ";
     if(beginTime!=null&&!beginTime.trim().equals("")&&endTime!=null&&!endTime.trim().equals("")){
     	strSql=strSql+sqlFilter+sqlFilter2;
     }
 	else{
 		strSql=strSql+sqlFilter3+sqlFilter2;
 	}
     myParams = "send_login_no="+send_login_no+",send_login_no="+send_login_no+",beginTime="+beginTime+",endTime="+endTime;
%>	  
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
	       <wtc:param value="<%=strSql%>"/>
	       <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
      <wtc:array id="queryList"  scope="end"/>
  <%
  dataRows=queryList;
  %>
<%!
public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<html>
<head>
<title>通知历史记录查询</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}
	function submitInput(){
	    window.sitechform.action="K084_hisContent.jsp";
	    window.sitechform.method='post';
	    window.sitechform.submit();
	}
	//清除表单记录
	function clearValue(){
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
	  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
	  	if(e[i].id=="beginTime"){
		  	e[i].value='<%=getCurrDateStr("00:00:00")%>';
		  }else if(e[i].id=="endTime"){
		  	e[i].value='<%=getCurrDateStr("23:59:59")%>';
		  }else{
		  	e[i].value="";
		  }
	  }else if(e[i].type=="checkbox"){
	  	e[i].checked=false;
	  }
	 }
	 window.location="K084_hisContent.jsp";
	}

</script>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">查询条件</div>
		<table  cellSpacing="0" >
		<tr>
	     <td> 开始时间 </td>
	     <td>
				<input id="beginTime" name="beginTime" type="text" value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	     </td> 
	     <td > 结束时间 </td>
	     <td>
			   <input name ="endTime" type="text" id="endTime"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		  </td>     
		</tr>
		<tr>
			<td colspan='4' id="footer" style="width:420px">
				<input name="search" type="button"  id="search" value="查询" onClick="submitInput()">
       			<input name="clear" type="button"  id="clear" value="重置" onClick="clearValue()">
		</td>
		</tr>
	</table>
	</div>
  <div id="Operation_Table">

      <table  cellSpacing="0" >
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter"  value="">
			  <input type="hidden" name="sqlWhere" value="">
			  
          <tr >
            <th align="center" class="blue" width="10%" > 接受工号 </th>
            <th align="center" class="blue" width="9%" > 通知内容 </th>
            <th align="center" class="blue" width="6%" > 通知时间 </th>
            <th align="center" class="blue" width="6%" > 通知方式 </th>
          </tr>


           <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="Grey_lib_1";
           %>
           
         <%if((i+1)%2==1){
          tdClass="Grey_lib_2";
          }%>
	   <tr>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
    </tr>
      <% } %>
  </table>  
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>


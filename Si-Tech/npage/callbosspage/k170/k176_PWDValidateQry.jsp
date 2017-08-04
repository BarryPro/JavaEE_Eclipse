<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 密码验证查询
　 * 版本: 1.0
　 * 日期: 2010/06/11
　 * 作者: tangsong
　 * 版权: sitech
   *
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>

<%	
    String opCode="k176";
    String opName="综合查询-密码验证查询";
    
    //用于排序
    String orderColumn = request.getParameter("orderColumn");
    String orderCode = request.getParameter("orderCode");
    
    String loginNo = (String)session.getAttribute("workNo");
    String today = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    String contact_id = request.getParameter("contact_id");
    String login_no = request.getParameter("login_no");
    String caller_no = request.getParameter("caller_no");
    String result = request.getParameter("result");

    String[][] dataRows  = new String[][]{};
    HashMap pMap = new HashMap();
    if (start_date == null) {
    	pMap.put("tablename",today.substring(0, 6));
    } else {
    	pMap.put("tablename",start_date.substring(0, 6));
    }
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("contact_id", contact_id);
		pMap.put("login_no", login_no);
		pMap.put("caller_no", caller_no);
		pMap.put("result", result);
	  pMap.put("orderColumn",orderColumn);
	  pMap.put("orderCode",orderCode);
    int rowCount   = 0;              //符合查询条件的总记录数
    int pageSize   = 3;            // 每页记录数
    int pageCount  = 0;             // 总页数
    int curPage    = 0;             // 当前页码
    String strPage;                 // 跳转页码

    String strDateSql= "";           //开始时间和结束时间是查询的必选条件
    String sqlFilter = request.getParameter("sqlFilter");  //sql的where条件
    String action    = request.getParameter("myaction");   //查询标志：只有doload一值

		if("doLoad".equals(action)){
		  rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K176_strCountSql",pMap)).intValue();
	    strPage = request.getParameter("page");
	    if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
	    	curPage = 1;
	    }else {
	    	curPage = Integer.parseInt(strPage);
	      	if( curPage < 1 ) curPage = 1;
	    }
	    pageCount = ( rowCount + pageSize - 1 ) / pageSize;
	    if ( curPage > pageCount ) curPage = pageCount;
	    int start = (curPage - 1) * pageSize + 1;
	    int end = curPage * pageSize;
	    pMap.put("start", ""+start);
	    pMap.put("end", ""+end);
	    List queryList =(List)KFEjbClient.queryForList("query_K176_sqlStr",pMap);
	    dataRows = getArrayFromListMap(queryList,1,6);
		}
%>

<html>
<head>
<style>
	img{
		cursor:hand;
	}

	input{
		height: 1.5em;
		width: 14.6em;
		font-size: 1em;
	}
</style>

<title>密码验证查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
$(document).ready(function() {
	$("td").not("[input]").addClass("blue");
	$("#footer input:button").addClass("b_foot");
	$("td:not(#footer) input:button").addClass("b_text");
	$("input:text[@v_type]").blur(checkElement2);
	$("a").hover(function() {
		$(this).css("color", "orange");
	}, function() {
		$(this).css("color", "#159ee4");
	});
});

function checkElement2() {
	checkElement(this);
}

function submitInputCheck(orderColumn, orderCode){
	if( document.sitechform.start_date.value == ""){
		showTip(document.sitechform.start_date,"开始时间不能为空");
		sitechform.start_date.focus();
	}else if(document.sitechform.end_date.value == ""){
	  showTip(document.sitechform.end_date,"结束时间不能为空");
		sitechform.end_date.focus();
	}else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
	  showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
		sitechform.end_date.focus();
	}else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
	  showTip(document.sitechform.end_date,"只能查询一个月内的记录");
		sitechform.end_date.focus();
	}else{
	  hiddenTip(document.sitechform.start_date);
	  hiddenTip(document.sitechform.end_date);
	  window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
  	window.sitechform.orderColumn.value=orderColumn;
  	window.sitechform.orderCode.value=orderCode;
	  submitMe();
	}
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k176_PWDValidateQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//跳转到指定页面
function jumpToPage(operateCode){
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage1").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
}

function doLoad(operateCode){
	if(operateCode=="load")
	{
		window.sitechform.page.value="";
	}
	else if(operateCode=="first")
	{
		window.sitechform.page.value=1;
	}
	else if(operateCode=="pre")
	{
		window.sitechform.page.value=<%=(curPage-1)%>;
	}
	else if(operateCode=="next")
	{
		window.sitechform.page.value=<%=(curPage+1)%>;
	}
	else if(operateCode=="last")
	{
		window.sitechform.page.value=<%=pageCount%>;
	}
	keepValue();
	submitMe();
}

//清除表单记录
function clearValue(){
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
  	if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
  		if(e[i].id=="start_date"){
	  		e[i].value='<%=getCurrDateStr("00:00:00")%>';
	  	} else if(e[i].id=="end_date"){
	  		e[i].value='<%=getCurrDateStr("23:59:59")%>';
	  	} else{
	  		e[i].value="";
	  	}
  	} else if(e[i].type=="checkbox"){
  		e[i].checked=false;
  	}
 	}
  window.location="k176_PWDValidateQry.jsp";
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.start_date.value="<%=start_date%>";
	window.sitechform.end_date.value="<%=end_date%>";
	window.sitechform.contact_id.value="<%=contact_id%>";
	window.sitechform.login_no.value="<%=login_no%>";
	window.sitechform.caller_no.value="<%=caller_no%>";
}

//去左空格;
function ltrim(s){
  return s.replace( /^\s*/, "");
}

//去右空格;
function rtrim(s){
	return s.replace( /\s*$/, "");
}

//去左右空格;
function trim(s){
	return rtrim(ltrim(s));
}
</script>
</head>

<body>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
	<input type="hidden" name="orderColumn" id="orderColumn" value="<%=(orderColumn==null)?"":orderColumn%>">
	<input type="hidden" name="orderCode" id="orderCode" value="<%=(orderCode==null)?"":orderCode%>">
  <input type="hidden" name="page" value="">
  <input type="hidden" name="myaction" value="">
  <input type="hidden" name="sqlFilter" value="">
  <input type="hidden" name="sqlWhere" value="">
  
	<table cellspacing="0" style="width:98%">
		<tr>
				<td colspan='6'>
					<div class="title" style="color:blue;" ><div id="title_zi">密码验证查询</div></div>
				</td>
		</tr>

    <tr >
      <td nowrap > 开始时间 </td>
      <td  nowrap >
				<input id="start_date" name="start_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td nowrap > 接触流水 </td>
      <td  nowrap >
				<input id="contact_id" name="contact_id" type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" value=<%=(contact_id==null)?"":contact_id%> >
      </td>
		  <td nowrap > 员工账号 </td>
      <td  nowrap >
				<input name="login_no" type="text" id="login_no" onkeyup="value=value.replace(/[^kf\d]/g,'');" value="<%=(login_no==null)?loginNo:login_no%>">
			</td>
    </tr>

    <tr >
      <td nowrap > 结束时间 </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td nowrap > 验证号码 </td>
      <td  nowrap >
      	<input id="caller_no" name="caller_no" type="text" value="<%=(caller_no==null)?"":caller_no%>" >
      </td>
      </td>
		  <td nowrap > 验证结果 </td>
      <td  nowrap >
      	<select name="result" id="result">
      		<option value="">全部</option>
      		<option value="Y">正确</option>
      		<option value="N">错误</option>
      	</select>
      	<script>
      		window.sitechform.result.value="<%=(result==null)?"":result%>";
      	</script>
		  </td>
		</tr>

    <tr>
      <td colspan="6" align="center" id="footer">
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck('','');return false;">
			 <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
      </td>
    </tr>

	</table>
	</div>
	
  <div id="Operation_Table">
  <table  cellspacing="0" style="width:98%">
    <tr >
      <td align="left" colspan="7">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <!--modify hucw 20100830<a>快速选择</a>-->
	    	<span>快速选择</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      	</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>快速跳转</a>-->
	    	<span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="width:30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
    
    <tr >
      <th align="center" width="15%" nowrap >流水号
	    	<%
	    		if ("serialno".equals(orderColumn)) {
	    			if ("desc".equals(orderCode)) {
	    				out.print("<img onclick=\"submitInputCheck('serialno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
	    			} else {
	    				out.print("<img onclick=\"submitInputCheck('serialno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
	    			}
	    		} else {
	    			out.print("<img onclick=\"submitInputCheck('serialno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
	    		}
	    	%>
      </th>
      <th align="center" width="15%" nowrap >接触流水号
	    	<%
	    		if ("contact_id".equals(orderColumn)) {
	    			if ("desc".equals(orderCode)) {
	    				out.print("<img onclick=\"submitInputCheck('contact_id','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
	    			} else {
	    				out.print("<img onclick=\"submitInputCheck('contact_id','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
	    			}
	    		} else {
	    			out.print("<img onclick=\"submitInputCheck('contact_id','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
	    		}
	    	%>
			</th>
      <th align="center" width="20%" nowrap >验证时间
	    	<%
	    		if ("switchtime".equals(orderColumn)) {
	    			if ("desc".equals(orderCode)) {
	    				out.print("<img onclick=\"submitInputCheck('switchtime','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
	    			} else {
	    				out.print("<img onclick=\"submitInputCheck('switchtime','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
	    			}
	    		} else {
	    			out.print("<img onclick=\"submitInputCheck('switchtime','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
	    		}
	    	%>
      </th>
      <th align="center" width="12%" nowrap >验证号码
	    	<%
	    		if ("callerno".equals(orderColumn)) {
	    			if ("desc".equals(orderCode)) {
	    				out.print("<img onclick=\"submitInputCheck('callerno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
	    			} else {
	    				out.print("<img onclick=\"submitInputCheck('callerno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
	    			}
	    		} else {
	    			out.print("<img onclick=\"submitInputCheck('callerno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
	    		}
	    	%>
      </th>
      <th align="center" width="12%" nowrap >员工账号</th>
      <th align="center" width="13%" nowrap >验证类型</th>
      <th align="center" width="13%" nowrap >验证结果
	    	<%
	    		if ("successflag".equals(orderColumn)) {
	    			if ("desc".equals(orderCode)) {
	    				out.print("<img onclick=\"submitInputCheck('successflag','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
	    			} else {
	    				out.print("<img onclick=\"submitInputCheck('successflag','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
	    			}
	    		} else {
	    			out.print("<img onclick=\"submitInputCheck('successflag','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
	    		}
	    	%>
      </th>
    </tr>

    <% for ( int i = 0; i < dataRows.length; i++ ) {
    %>

	  <tr>
      <td align="center" class="Blue" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="Blue" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="Blue" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="Blue" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="Blue" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
    	<td align="center" class="Blue" nowrap >校验查询密码</td>
    	<td align="center" class="Blue" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
    </tr>

    <% } %>

    <tr>
      <td align="right" colspan="7">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <!--modify hucw 20100830<a>快速选择</a>-->
	    	<span>快速选择</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        		out.print("<option value='"+i+"'");
        		if(i==curPage){
        	 		out.print("selected");
        		}
        		out.print(">"+i+"</option>");
        	}
        %>
      	</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>快速跳转</a>-->
	    	<span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
  </table>

</div>
</form>

</body>
</html>

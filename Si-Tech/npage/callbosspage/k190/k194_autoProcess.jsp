<%
  /*
   * 功能: 自动流程
　 * 版本: 1.0
　 * 日期: 2008/10/19
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
 <%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
 %>
<%
    String opCode="K194";
    String opName="接触查询-自动10086流程";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
    String beginTime   = request.getParameter("beginTime");         //开始时间
    String endTime     = request.getParameter("endTime");           //结束时间
    String acceptNo   = request.getParameter("acceptNo");          //受理号码 
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlFilter = "";
    String sqlStr="";
    String tableNamea = "";
    String tableNameb = "";
    String bizFilter = " and a.chn_code='KF' and a.interface_code='02' ";
    String strOrderSql=" order by a.begin_time desc ";
    if(beginTime!=null&&!"".equals(beginTime)){
       tableNamea = "dContactMsg"+beginTime.substring(0,6);
       tableNameb = "dContactInfo"+beginTime.substring(0,6);
    }
    String action = request.getParameter("myaction");
    if ("doLoad".equals(action)) {

	      if((beginTime!=null && !beginTime.trim().equals("")) && (endTime!=null && !endTime.trim().equals(""))){
       	 	 sqlFilter = " where to_char(a.begin_time,'yyyyMMdd hh24:mi:ss') > '"+beginTime+"'  and to_char(a.begin_time,'yyyyMMdd hh24:mi:ss') < '"+endTime+"' ";
       	}else if((beginTime==null || beginTime.trim().equals("")) && endTime!=null && !endTime.trim().equals("")){
       		 sqlFilter = " where to_char(a.begin_time,'yyyyMMdd hh24:mi:ss') < '"+endTime+"' ";
       	}else if((endTime==null || endTime.trim().equals("")) && beginTime!=null && !beginTime.trim().equals("")){
       		 sqlFilter = " where to_char(a.begin_time,'yyyyMMdd hh24:mi:ss') > '"+beginTime+"' ";
       	}
        if(acceptNo!=null && !acceptNo.trim().equals("")){
       		if(sqlFilter!=null && !sqlFilter.trim().equals("")){
             sqlFilter = sqlFilter+" and a.login_no = '"+acceptNo+"'";
           }else{
             sqlFilter = " where a.login_no = '"+acceptNo+"'";
           }
        }
        String sqlTemp = "select to_char(count(*)) count  from "+tableNamea+" a, "+tableNameb+" b,sContactStatus c "+sqlFilter+" and a.contact_id=b.contact_id(+) and a.contact_status=c.contact_status(+) "+bizFilter;
%>	
			
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
System.out.println("\n\n=====sqlTemp==========="+sqlTemp);
System.out.println("\n\n=====rowCount==========="+rowCount);
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        int beginPos = (curPage-1)*pageSize;
        sqlStr = "select a.Callers_phone,b.op_name,to_char(a.begin_time,'yy-MM-dd hh24:mi:ss'),c.constat_status_name from "+tableNamea+" a,"+tableNameb+" b,sContactStatus c  "+sqlFilter+" and a.contact_id=b.contact_id(+) and a.contact_status=c.contact_status(+)"+bizFilter+strOrderSql;     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======beginTime+endTime============="+beginTime+"+"+endTime);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
				
					<wtc:service name="s151Select" outnum="6">
					
						<wtc:param value="<%=querySql%>"/>

					</wtc:service>
					<wtc:array id="queryList"  start="0" length="5" scope="end"/>	
<% 
					dataRows=queryList;
System.out.println("queryList.length="+queryList.length);
 }    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>自动流程</title>
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

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(){
	 if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"开始日期不能为空！请从新选择后输入");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"结束日期不能为空！请从新选择后输入");
		sitechform.endTime.focus();
    }
  else if(document.sitechform.beginTime.value.length>0&&document.sitechform.endTime.value.length>0){
    if(document.sitechform.endTime.value<document.sitechform.beginTime.value){
		   showTip(document.sitechform.endTime,"结束时间必须大于开始时间"); 
    	 sitechform.endTime.focus(); 	
    }else doSubmit();
  }else {
     hiddenTip(document.sitechform.beginTime);
     hiddenTip(document.sitechform.endTime);
     doSubmit();
	}
}

//提交
function doSubmit(){
   	window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k194_autoProcess.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//=========================================================================
// LOAD PAGES.
//=========================================================================
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
   window.sitechform.myaction.value="doLoad";
   window.sitechform.beginTime.value="<%=beginTime%>";
   window.sitechform.endTime.value="<%=endTime%>";
   window.sitechform.acceptNo.value="<%=acceptNo%>";
   window.sitechform.action="k194_autoProcess.jsp";
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
  window.location="k194_autoProcess.jsp";
}
	 
	 //跳转到指定页面
 function jumpToPage(operateCode){
	//alert(operateCode);
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
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">查询条件</div></div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
       <td > 受理号码  </td>
	     <td >
			  <input name="acceptNo" type="text" value="<%=(acceptNo==null)?"":acceptNo%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
	     </td>
	     <td > 开始时间 </td>
	     <td >
				<input id="beginTime" name="beginTime" type="text"  value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	     </td>
	     <td > 结束时间 </td>
	     <td>
			  <input name ="endTime" type="text" id="endTime"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td>   
	   </tr>

        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer">
        <input name="clear" type="button"  id="clear" value="重设" onClick="clearValue()">
        
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()"> &nbsp;&nbsp;
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
			  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" width="720">
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
        <a>快速选择</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>快速跳转</a> 
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
          <tr >
            <th align="center" class="blue" width="22%"  > 受理号码 </th>
            <th align="center" class="blue" width="32%" > 业务类型 </th>
            <th align="center" class="blue" width="25%" > 时间 </th>
            <th align="center" class="blue" width="21%" > 状态 </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      </tr>
      <% } %>
  </table>   
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right" width="720">
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
        <a>快速选择</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>快速跳转</a> 
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>


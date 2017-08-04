<%
  /*
   * 功能: 网上客服
　 * 版本: 1.0
　 * 日期: 2008/10/19
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="k195";
    String opName="接触查询-网上客服";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
    String beginTime    =  "";        //开始时间
    String endTime      =  "";        //结束时间
    String acceptNo    =  "";        //受理号码
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 10;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlFilter = "";
    String sqlStr="";
    //String param1 = "";
    int search_flag = 0;
    String action = request.getParameter("myaction");
System.out.println("=========action======="+action);
    if ("doLoad".equals(action)) {
	    	beginTime   = request.getParameter("beginTime");  
	    	endTime     = request.getParameter("endTime");    
	    	acceptNo   = request.getParameter("acceptNo"); 

    	 //param1="v1="+beginTime+",v2="+endTime;
    	 sqlFilter = " where to_char(send_time,'yyyyMMdd') > '"+beginTime+"' and to_char(send_time,'yyyyMMdd') < '"+endTime+"' ";
       if(acceptNo!=null && !acceptNo.equals("")){
           sqlFilter = sqlFilter+" and send_login_no = '"+acceptNo+"'";
           //param1=param1+",v3="+acceptNo;
       }
        search_flag = 1;
     }
     if(search_flag == 1){
        String sqlTemp = "select to_char(count(*)) count  from dnoticecontent "+sqlFilter;
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
        sqlStr = "select send_login_no,receive_login_no,content,to_char(send_time,'yyyyMMdd hh24:mi:ss'),msg_type from dnoticecontent "+sqlFilter+" order by send_time desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======beginTime+endTime============="+beginTime+"+"+endTime);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="6">
						<wtc:param value="<%=querySql%>"/><ol>
</ol>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="5" scope="end"/>	
<% 
					dataRows=queryList;
System.out.println("queryList.length="+queryList.length);
   }    
%>

<html>
<head>
<title>网上客服</title>
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
function submitInput(url){
   if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"开始日期不能为空！请从新选择后输入");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"结束日期不能为空！请从新选择后输入");
		sitechform.endTime.focus();
    }    
    else {
    	
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    doSubmit(url);
    }
}
function doSubmit(url){
    window.sitechform.action=url;
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
   window.sitechform.action="k195_olineServ.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">查询条件</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
       <td > 受理号码 </td>
	     <td >
			  <input name="acceptNo" type="text" value=<%=(acceptNo==null)?"":acceptNo%>>
	     </td>
	     <td > 开始时间 </td>
	     <td >
				<input id="beginTime" name="beginTime" type="text" readonly value=<%=(beginTime==null)?"":beginTime%>>
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	     </td>
	     <td > 结束时间 </td>
	     <td>
			  <input name ="endTime" type="text" id="endTime" readonly value=<%=(endTime==null)?"":endTime%>>
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td>   
	   </tr>

        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer">
        <input name="clear" type="button"  id="clear" value="重设" onClick="clearValue()">
        
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput('k195_olineServ.jsp?myaction=doLoad')"> &nbsp;&nbsp;
       
        <input name="toOut" type="button"  id="toOut" value="导出" onClick="">
	
       <input name="toOutAll" type="button"  id="toOutAll" value="导出全部" onClick="">
       
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
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
          <tr >
            <th align="center" class="blue" width="60"  > 操作时间 </th>
            <th align="center" class="blue" width="110" > 客户品牌 </th>
            <th align="center" class="blue" width="130" > 地市名称 </th>
            <th align="center" class="blue" width="140" > 操作信息 </th>
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
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][1]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][2]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][3]%></td>
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
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>


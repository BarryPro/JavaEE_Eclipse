<%
  /*
   * 功能: 呼叫保持记录导出
　 * 版本: 1.0
　 * 日期: 2008/10/14
　 * 作者: donglei 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String headName=request.getParameter("headName");
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
		String strCountSql="select to_char(count(*)) count  from dcallcall";
	  String strOrderSql=" order by BEGIN_DATE desc ";
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="来电信息";
	  int intMaxRow=5000+1;
	  if(headName!=null){
	  if(!"".equalsIgnoreCase(headName)){
	   head =headName.split(",");
	   strHead =new String[head.length];
	  for (int i = 0; i < head.length; i++) {
	    strHead[i]=head[i];
      }
    }
	  }        
	  
	  sqlStr+="select "+sql+" from dcallcall"+sqlFilter;
%>	
			
<%	
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
       sqlTemp =strCountSql+sqlFilter;
    	  %>	             
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service> 
					<wtc:array id="rowsC4"  scope="end"/>	
					<%             
	      if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
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
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		           
        <wtc:service name="s151Select" outnum="23">
					<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="22"   scope="end"/>
				<%
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
%>		           
        <wtc:service name="s151Select" outnum="22">
					<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="22"   scope="end"/>
<%
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");		
%>
<%
   }   
%>


<html>
<head>
<title>来电信息导出</title>
<script language="javascript" type="text/javascript"> 
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
 function s_all(x){
  var inps = document.getElementsByName(x);
  for(var i=0;i<inps.length;i++){
   if (inps[i].checked==true){
    inps[i].checked = false;
   }else{
    inps[i].checked = true;
   } 
  // alert(inps[i].value+":"+inps[i].sql);
  }
 }
function s_exp(x){
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from dcallcall"+ window.sitechform.sqlFilter.value;
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k171_expSelect.jsp?exp="+str;
 	 window.sitechform.method='post';
   window.sitechform.submit(); 
 	}
function getCheckboxValue()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].value;
		}
	}
	
	return (val.length)?val:'';
}
function getCheckboxSql()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].sql;
		}
	}
	
	return (val.length)?val:'';
}
 </script>
</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="流水号" />流水号<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="受理方式" />受理方式<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="客户姓名" />客户姓名<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="客户地市" />客户地市<br> 
<input name="area[]" type="checkbox" id="area[]" sql="" value="受理号码" />受理号码<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="主叫号码" />主叫号码<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="被叫号码" />被叫号码<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="受理时间" />受理时间<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="受理时长" />受理时长<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="受理工号" />受理工号<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="挂机方" />挂机方<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="是否质检" />是否质检<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="客户满意度" />客户满意度<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="服务语种" />服务语种<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="来电原因" />来电原因<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="录音听取标志" />录音听取标志<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="是否使用放音" />是否使用放音<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="质检员工号" />质检员工号<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="是否密码验证" />是否密码验证<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="是否他机验证" />是否他机验证<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="备注" />备注<br>
<input name="area[]" type="checkbox" id="area[]" sql="" value="转接备注" />转接备注<br>



<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">
<input type="button" name="expbutton" value="导出" class="b_text" onclick="s_exp('area[]')"/>
<input type="button" name="expclose" value="关闭" class="b_text" onclick="window.close();"/>
</div>
</p>
</div>
</form>
</body>
</html>


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
	String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
	String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
	String sqlMulKfCfm="";
	
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
     /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams=request.getParameter("para");
    String myParamsExp="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String loginNo = (String)session.getAttribute("workNo");  
    String sql=request.getParameter("sql");
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq="";                     // new
    String headName=request.getParameter("headName");
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增
		String strCountSql="select to_char(count(*)) count  from dcallhangup t1, dcallcall";
	  String strOrderSql=" order by t1.begin_time desc ";
	  //新增sql
	  String statusSql="select t.field_id from DCALLEXPSTATUS t where t.boss_login_no=:loginNo and  t.op_code='K179'";
	  myParamsExp="loginNo="+loginNo;
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="呼叫保持记录";
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
	  
	  sqlStr+="select "+sql+" from dcallhangup t1, staffhangup t3,dcallcall"+sqlFilter+" and t2.staffhangup=t3.hangup_code(+)"+strOrderSql;
%>	
			
<%	
   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
%>
         <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
					<wtc:param value="<%=statusSql%>"/>
				  <wtc:param value="<%=myParamsExp%>"/>
					</wtc:service>
				<wtc:row id="row" length="1">
					<%
					strseq=row[0];
					if(!"".equalsIgnoreCase(strseq)){
					stautsflag="Y";
					}
					%> 
					</wtc:row>
  <% 
 }
   //导出当前显示数据 
   if("cur".equalsIgnoreCase(expFlag)){    
       sqlTemp =strCountSql+sqlFilter;
    	  %>	             
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
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
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="13">
					<wtc:param value="<%=querySql%>"/>
					<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="12"   scope="end"/>
				<%
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
%>		           
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="12">
					<wtc:param value="<%=sqlStr%>"/>
					<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="12"   scope="end"/>
<%
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				//out.print("<script language='javascript'>window.close();</script>");		
   }
//保存用户选择的列  
if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){

	String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K179'&&"+loginNo;
	String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K179',:v2,sysdate)&&"+loginNo+"^"+seq;

List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
if("Y".equalsIgnoreCase(stautsflag)){
sqlList.add(deleteStatus);
}
		     sqlList.add(insertStatus);
		     sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);      
%>
	
			<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
			<wtc:param value="<%=sqlMulKfCfm%>"/>
			<wtc:param value="dbchange"/>
			<wtc:params value="<%=sqlArr%>"/>
			</wtc:service>
			<wtc:array id="retRows"  scope="end"/>	
<%}%>

<html>
<head>
<title>呼叫保持导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.contact_id" value="流水号" onclick="judgeCheckAll('area[]')"/>流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="t2.cust_name" value="客户姓名" onclick="judgeCheckAll('area[]')"/>客户姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="t2.accept_phone" value="受理号码" onclick="judgeCheckAll('area[]')"/>受理号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t2.caller_phone" value="主叫号码" onclick="judgeCheckAll('area[]')"/>主叫号码<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="to_char(t2.begin_date,'yyyy-MM-dd hh24:mi:ss')" value="受理时间" onclick="judgeCheckAll('area[]')"/>受理时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="to_char(t2.accept_long)" value="受理时长" onclick="judgeCheckAll('area[]')"/>受理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="t2.accept_login_no" value="受理工号" onclick="judgeCheckAll('area[]')"/>受理工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="t3.hangup_name" value="挂机方" onclick="judgeCheckAll('area[]')"/>挂机方<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="decode(t2.qc_flag,'Y','是','N','否','','否',NULL,'否')" value="是否质检" onclick="judgeCheckAll('area[]')"/>是否质检<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(trim(t1.op_type),'1','保持','2','内部求助')" value="保持类型" onclick="judgeCheckAll('area[]')"/>保持类型<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="to_char(t1.begin_time,'yyyy-MM-dd hh24:mi:ss')" value="开始时间" onclick="judgeCheckAll('area[]')"/>开始时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="to_char(t1.end_time,'yyyy-MM-dd hh24:mi:ss')" value="结束时间" onclick="judgeCheckAll('area[]')"/>结束时间<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="para" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">
<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">
<input type="button" name="expbutton" value="导出" class="b_text" onclick="s_exp('area[]')"/>
<input type="button" name="expclose" value="关闭" class="b_text" onclick="window.close();"/>
</div>
</p>
</div>
</form>
</body>
</html>
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
 	var tmpCheck = document.getElementById("checkAll");
  var inps = document.getElementsByName(x);
  if(tmpCheck.checked==true){
  	for(var i=0;i<inps.length;i++){
  		inps[i].checked = true;
  	}
  }
  if(tmpCheck.checked==false){
  	for(var i=0;i<inps.length;i++){
  		inps[i].checked = false;
  	}
  }
 }
 
 //若全选后去掉某个选择项,则全选不勾中 zengzq add 
 function judgeCheckAll(x){
 	var tmpCheck = document.getElementById("checkAll");
 	var inps = document.getElementsByName(x);
 	var count = 0;
 		for(var i=0;i<inps.length;i++){
  		if(inps[i].checked == false){
  			tmpCheck.checked = false;
  			count++ ;
  		}
  	}
  	if(count==0){
  			tmpCheck.checked = true;
  	}
 }
//判断一个字符串是否数组中出现
function isStr(str,strArr){
	if(strArr!=null&&strArr!=''){
		for(var j=0;j<strArr.length;j++){
     		if(str==strArr[j]){
     			return true;
     		}
		}
	}
	return false;
}
//保存用户上回设置状态
 function setStauts(){
  var inps = document.forms['sitechform'].elements['area[]'];
  var arrid ="<%=strseq%>";
  var temarr=new Array();
  //zengzq add 
  var count = 0;
  if(arrid!=''){
  	temarr=arrid.split(",");
  	for(var i=0;i<inps.length;i++){
	   	if(isStr(inps[i].seq,temarr)){
	   	inps[i].checked=true;
	   	//zengzq add 
	   	count++;
	   	}
  	}
  	//如果上次全选,则此次将"全选/取消"勾选 zengzq add  
  	if(inps.length==count){
  			document.getElementById('checkAll').checked = true;
  	} else{
  			document.getElementById('checkAll').checked = false;
  	}
 }
 }
 setStauts();
function s_exp(x){
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
  //新增start
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	//新增end
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	window.sitechform.page.value = opener.document.sitechform.page.value;
	window.sitechform.para.value = opener.document.sitechform.para.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  //新增start
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
  //新增end
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from dcallhangup t1, staffhangup t3,dcallcall"+ window.sitechform.sqlFilter.value;
    submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k179_expSelect.jsp?exp="+str;
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
function getCheckboxSeq()
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
			val[val.length] = checkbox[i].seq;
		}
	}
	
	return (val.length)?val:'';
}
 </script>

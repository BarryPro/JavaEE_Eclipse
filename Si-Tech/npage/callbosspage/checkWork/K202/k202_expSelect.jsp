<%
  /*
   * 功能: 质检结果确认信息查询导出
　 * 版本: 1.0
　 * 日期: 2009/01/09
　 * 作者: zengzq 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq="";
    String headName=request.getParameter("headName");
    int start=0;
    int end=0;  
    String op_code="K202";
    String[][] queryList = new String[][] {};
    String start_date    =  request.getParameter("start_date");
    String end_date      =  request.getParameter("end_date");
    String submitno      =  request.getParameter("submitno");
    String evterno       =  request.getParameter("evterno");
    String serialno      =  request.getParameter("serialno");
    String staffno       =  request.getParameter("staffno");
    String serialnum     =  request.getParameter("serialnum");
    String statisfy_code   =  request.getParameter("statisfy_code");
    String group_flag   = request.getParameter("group_flag");
    String isPower      = request.getParameter("isPower");
    
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增

		HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("submitno", submitno);
		pMap.put("evterno", evterno);
		pMap.put("serialno", serialno);
		pMap.put("staffno", staffno);
		pMap.put("serialnum", serialnum);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("group_flag", group_flag);
		pMap.put("isPower", isPower);	  
	  pMap.put("op_code",op_code);
    pMap.put("sqlstr",sql);
    pMap.put("boss_login_no",loginNo);
	  
	  
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="质检结果确认信息查询";
	  int intMaxRow=10000+1;
	  if(headName!=null){
	  if(!"".equalsIgnoreCase(headName)){
	   head =headName.split(",");
	   strHead =new String[head.length];
	  for (int i = 0; i < head.length; i++) {
	    strHead[i]=head[i];
      }
    }
	  }        
	 
%>	
		<%
   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
      List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",pMap);                              
		    queryList = getArrayFromListMap(iDataList3 ,0,1); 	
		    if(queryList.length!=0){
				strseq=queryList[0][0];
				}
					if(!"".equalsIgnoreCase(strseq)){
					stautsflag="Y";
					}
   }	
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K202_strCountSql",pMap)).intValue();
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
        start = (curPage - 1) * pageSize + 1;
		    end = curPage * pageSize;
		    pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList2 =(List)KFEjbClient.queryForList("query_K202_expcur",pMap);     
        queryList = getArrayFromListMap(queryList2 ,1,10);  
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
		    List queryList4 =(List)KFEjbClient.queryForList("query_K202_expall",pMap);     
        queryList = getArrayFromListMap(queryList4 ,0,9);  
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");		
		}
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K202'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K202',:v2,sysdate)&&"+loginNo+"^"+seq;
			List sqlList=new ArrayList();
			String[] sqlArr = new String[]{};
			if("Y".equalsIgnoreCase(stautsflag)){
			sqlList.add(deleteStatus);
			}
					     sqlList.add(insertStatus);
					     sqlArr = (String[])sqlList.toArray(new String[0]);
			String outnum = String.valueOf(sqlArr.length + 1);      
			//jiangbing 20091118 批量服务替换
			String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
			String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
			String sqlMulKfCfm="";
			%>
			<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
			<wtc:param value="<%=sqlMulKfCfm%>"/>
			<wtc:param value="dbchange"/>
			<wtc:params value="<%=sqlArr%>"/>
			</wtc:service>
			<wtc:array id="retRows"  scope="end"/>
<%
   }   
%>


<html>
<head>
<title>质检结果确认信息查询导出</title>
</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.serialno" value="质检结果确认流水号" onclick="judgeCheckAll('area[]')" />质检结果确认流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="nvl(t1.belongno,'') belongno" value="后续流水号" onclick="judgeCheckAll('area[]')" />后续流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="t1.title" value="质检结果确认标题" onclick="judgeCheckAll('area[]')" />质检结果确认标题<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t1.submitno" value="提交人工号" onclick="judgeCheckAll('area[]')" />提交人工号<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="decode(t1.type,'0','质检结果通知','1','申诉','2','答复','3','确认') type" value="质检结果状态" onclick="judgeCheckAll('area[]')" />质检结果状态<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="t1.serialnum" value="质检单流水号" onclick="judgeCheckAll('area[]')" />质检单流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="t1.staffno" value="被检工号" onclick="judgeCheckAll('area[]')" />被检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="t1.evterno" value="质检员工号" onclick="judgeCheckAll('area[]')" />质检员工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="to_char(t1.applydate,'yyyy-MM-dd hh24:mi:ss') applydate" value="提交时间" onclick="judgeCheckAll('area[]')" />提交时间<br>

<input name="start_date"           type="hidden" value="">     
<input name="end_date"             type="hidden" value="">
<input name="submitno"              type="hidden" value="">
<input name="evterno"             type="hidden" value="">
<input name="serialno"            type="hidden" value="">
<input name="staffno"              type="hidden" value="">
<input name="serialnum"          type="hidden" value="">
<input name="statisfy_code"         type="hidden" value="">
<input name="group_flag"      type="hidden" value="">
	<input type="hidden" name="isPower" value="">

<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
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
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	
	window.sitechform.start_date.value      =   opener.document.sitechform.start_date.value;      
  window.sitechform.end_date.value        =   opener.document.sitechform.end_date.value;        
  window.sitechform.submitno.value        =   opener.document.sitechform.submitno.value;        
  window.sitechform.evterno.value         =   opener.document.sitechform.evterno.value;         
  window.sitechform.serialno.value        =   opener.document.sitechform.serialno.value;        
  window.sitechform.staffno.value         =   opener.document.sitechform.staffno.value;         
  window.sitechform.serialnum.value       =   opener.document.sitechform.serialnum.value;       
  window.sitechform.statisfy_code.value   =   opener.document.sitechform.statisfy_code.value;   
  window.sitechform.group_flag.value      =   opener.document.sitechform.group_flag.value;    
  window.sitechform.isPower.value      =   opener.document.sitechform.isPower.value;    
    
	
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
    if(head==''){
   	return;
   	}
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k202_expSelect.jsp?exp="+str;
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
		if (checkbox[i].checked){
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
		if (checkbox[i].checked){
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
		if (checkbox[i].checked){
			val[val.length] = checkbox[i].seq;
		}
	}
	
	return (val.length)?val:'';
}
 </script>
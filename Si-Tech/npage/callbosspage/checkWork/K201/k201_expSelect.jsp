<%
  /*
   * 功能: 考评项查询导出
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
    String op_code="K201";
    String[][] queryList = new String[][] {};
    
    String start_date     = (String)request.getParameter("start_date");      
    String end_date       = (String)request.getParameter("end_date");        
    String staffno        = (String)request.getParameter("staffno");    
    String beQcObjId      = (String)request.getParameter("objectid");
    String contentid      = (String)request.getParameter("contentid");
    String qccheckitemId  = (String)request.getParameter("item_id"); 
    String group_flag     = request.getParameter("group_flag");
    
    HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("contentid", contentid);
		pMap.put("staffno", staffno);
		pMap.put("objectid", beQcObjId);
		pMap.put("end_date", end_date);
		pMap.put("item_id", qccheckitemId);
		pMap.put("group_flag", group_flag);
		pMap.put("op_code",op_code);
    pMap.put("sqlstr",sql);
    pMap.put("boss_login_no",loginNo);
    
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增
	  
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="考评项查询";
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
       rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K201_strCountSql",pMap)).intValue();
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
		    List queryList4 =(List)KFEjbClient.queryForList("query_K201_expcur",pMap);     
        queryList = getArrayFromListMap(queryList4 ,1,14);  
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
    List iDataList5 =(List)KFEjbClient.queryForList("query_K201_expall",pMap);                              
		  queryList = getArrayFromListMap(iDataList5 ,0,13); 	
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");		
		}
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K201'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K201',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>考评项查询导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.serialnum" value="流水号" onclick="judgeCheckAll('area[]')"/>流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="t1.staffno" value="被检工号" onclick="judgeCheckAll('area[]')"/>被检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="v.login_name" value="被检员姓名" onclick="judgeCheckAll('area[]')"/>被检员姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t3.object_name" value="被检对象" onclick="judgeCheckAll('area[]')"/>被检对象<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="t4.name" value="质检内容" onclick="judgeCheckAll('area[]')"/>质检内容<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="t2.item_name" value="考评项" onclick="judgeCheckAll('area[]')"/>考评项<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="decode(substr(to_char(trim(t5.score)),0,1),'.','0'||trim(t5.score),t5.score) score" value="考评项得分" onclick="judgeCheckAll('area[]')"/>考评项得分<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="decode(substr(to_char(trim(t2.low_score)),0,1),'.','0'||trim(t2.low_score),t2.low_score) low_score" value="最低分" onclick="judgeCheckAll('area[]')"/>最低分<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="decode(substr(to_char(trim(t2.high_score)),0,1),'.','0'||trim(t2.high_score),t2.high_score) high_score" value="最高分" onclick="judgeCheckAll('area[]')"/>最高分<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss') starttime" value="质检开始时间" onclick="judgeCheckAll('area[]')"/>质检开始时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss') endtime" value="质检结束时间" onclick="judgeCheckAll('area[]')"/>质检结束时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t1.evterno" value="质检工号" onclick="judgeCheckAll('area[]')"/>质检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t1.recordernum" value="被检流水号" onclick="judgeCheckAll('area[]')"/>被检流水号<br>

<input name="start_date"           type="hidden" value="">     
<input name="end_date"             type="hidden" value="">
<input name="staffno"              type="hidden" value="">
<input name="objectid"             type="hidden" value="">
<input name="contentid"            type="hidden" value="">
<input name="item_id"              type="hidden" value="">
<input name="group_flag"           type="hidden" value="">

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
	
	window.sitechform.start_date.value      =    opener.sitechform.start_date.value;      
  window.sitechform.end_date.value        =    opener.sitechform.end_date.value;        
  window.sitechform.staffno.value         =    opener.sitechform.staffno.value;    
  window.sitechform.objectid.value        =    opener.sitechform.objectid.value;
  window.sitechform.contentid.value       =    opener.sitechform.contentid.value;
  window.sitechform.item_id.value         =    opener.sitechform.item_id.value; 
  window.sitechform.group_flag.value      =    opener.sitechform.group_flag.value;
	
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from dqcinfo t1,dqccheckitem t2,dloginmsg v,dloginmsgrelation vl,dqcobject t3,dqccheckcontect t4,dqcinfodetail t5 "+ window.sitechform.sqlFilter.value;
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k201_expSelect.jsp?exp="+str;
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

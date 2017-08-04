<%
  /*
   * 功能: 质检结果查询导出
　 * 版本: 1.0
　 * 日期: 2009/01/09
　 * 作者: zengzq
　 * 版权: sitech
   * update:    mixh    20090730  修改导出全部功能只能导出2000。
   * update:    mixh    20090816  修改导出逻辑，优化sql语句
   *
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>

<%
    String expFlag      = request.getParameter("exp");               //判断导出当前页还是到处全部
    String pageFlag     = request.getParameter("flag");              //判断是导出全部还是导入当前页
    String seq          = request.getParameter("seq");               //保存用户选择状态新增
    String loginNo      = (String)session.getAttribute("workNo");
    String strseq       = "";
    String headName     = request.getParameter("headName");
    int rowCount        = 0;
    int pageSize        = 15;            // Rows each page
    int pageCount       = 0;             // Number of all pages
    int curPage         = 0;             // Current page
    String strPage;                      // 需要从当前上一页面传过来
    String stautsflag   = request.getParameter("stautsflag");  // 保存用户选择状态
    
    String sql          = request.getParameter("sql");               //由选中导出字段转换而成的sql语句
	  String sqlFilter    = request.getParameter("sqlFilter");         //查询页面的检索条件    
    int start=0;
    int end=0;  
    String op_code="K211";
    String[][] queryList = new String[][] {};
    String start_date       = request.getParameter("start_date");
	  String end_date         = request.getParameter("end_date");
    String beQcObjId        = request.getParameter("beQcObjId");
    String errorlevelid     = request.getParameter("errorlevelid");
    String qcobjectid       = request.getParameter("qcobjectid");
    String errorclassid     = request.getParameter("errorclassid");
    String evterno          = request.getParameter("evterno");
    String staffno          = request.getParameter("staffno");
    String recordernum      = request.getParameter("recordernum");
    String flaga          = request.getParameter("flaga");
    String outplanflag   = request.getParameter("outplanflag");
    String group_flag   = request.getParameter("group_flag");
    String checkflag     = request.getParameter("checkflag");
    String qcGroupId     = request.getParameter("qcGroupId");
    String beQcGroupId   = request.getParameter("beQcGroupId");
    String checkreasondesc = request.getParameter("checkreasondesc");
    HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("beQcObjId", beQcObjId);
		pMap.put("errorlevelid", errorlevelid);
		pMap.put("qcobjectid", qcobjectid);
		pMap.put("errorclassid", errorclassid);
		pMap.put("evterno", evterno);
		pMap.put("staffno", staffno);
		pMap.put("recordernum", recordernum);
		pMap.put("flag", flaga);
		pMap.put("outplanflag", outplanflag);
		pMap.put("group_flag", group_flag);
		pMap.put("checkflag", checkflag);
		pMap.put("qcGroupId", qcGroupId);
	  pMap.put("beQcGroupId", beQcGroupId);
	  pMap.put("checkreasondesc", checkreasondesc);
	  pMap.put("op_code",op_code);
    pMap.put("sqlstr",sql);
    pMap.put("boss_login_no",loginNo);
	String[] strHead =null;
	String head[]=null;
	String excelName="质检结果查询";
	int intMaxRow = 5000+1;
	if(headName!=null){
		if(!"".equalsIgnoreCase(headName)){
			head =headName.split(",");
			strHead =new String[head.length];
			for (int i = 0; i < head.length; i++) {
				strHead[i]=head[i];
			}
		}
	}

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
	if("cur".equalsIgnoreCase(expFlag)){ //导出当前显示数据
     rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K211_strCountSql",pMap)).intValue();
     strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }else {
			curPage = Integer.parseInt(strPage);
			if( curPage < 1 ) curPage = 1;
        }
        
        pageCount = (rowCount + pageSize - 1) / pageSize;
        if (curPage > pageCount){
        	curPage = pageCount;
        }
        start = (curPage - 1) * pageSize + 1;
		    end = curPage * pageSize;
		    pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList2 =(List)KFEjbClient.queryForList("query_K211_expcur",pMap);     
        queryList = getArrayFromListMap(queryList2 ,1,34);  
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		out.print("<script language='javascript'>window.close();</script>");
	}
   
	if("all".equalsIgnoreCase(expFlag)){//导出全部
			    List queryList4 =(List)KFEjbClient.queryForList("query_K211_expall",pMap);     
        queryList = getArrayFromListMap(queryList4 ,0,33);  
			XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
			out.print("<script language='javascript'>window.close();</script>");
  }
	//保存用户选择的列
	if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
		String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K211'&&"+loginNo;
		String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K211',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>质检结果查询导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi">
<input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.serialnum" value="流水号" onclick="judgeCheckAll('area[]')"/>流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="t1.recordernum" value="被检流水号" onclick="judgeCheckAll('area[]')"/>被检流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="t1.staffno" value="被检工号" onclick="judgeCheckAll('area[]')"/>被检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t1.login_name" value="被检员姓名" onclick="judgeCheckAll('area[]')"/>被检员姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="(SELECT object_name FROM dqcobject WHERE object_id = t1.objectid) object_name" value="被检对象" onclick="judgeCheckAll('area[]')"/>被检对象<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="decode(t1.flag,'0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃') flaga" value="质检标识" onclick="judgeCheckAll('area[]')"/>质检标识<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="t1.evterno" value="质检工号" onclick="judgeCheckAll('area[]')"/>质检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="(SELECT name FROM dqccheckcontect WHERE object_id=t1.objectid AND contect_id=t1.contentid) name" value="考评内容" onclick="judgeCheckAll('area[]')"/>考评内容<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="decode(to_char(t1.score),'','0',null,'0',t1.score) score" value="总得分" onclick="judgeCheckAll('area[]')"/>总得分<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(to_char(t1.outplanflag),'0','计划内质检','1',' 计划外质检') outplanflag" value="计划类型" onclick="judgeCheckAll('area[]')"/>计划类型<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="t2.plan_name" value="计划名称" onclick="judgeCheckAll('area[]')"/>计划名称<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t1.errorclassdesc" value="差错类别" onclick="judgeCheckAll('area[]')"/>差错类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t1.errorleveldesc" value="差错等级" onclick="judgeCheckAll('area[]')"/>差错等级<br> 
<input name="area[]" type="checkbox" id="area[]" seq="13" sql="t1.contentinsum" value="内容概括" onclick="judgeCheckAll('area[]')"/>内容概括<br>
<input name="area[]" type="checkbox" id="area[]" seq="14" sql="t1.handleinfo" value="处理情况" onclick="judgeCheckAll('area[]')"/>处理情况<br>
<input name="area[]" type="checkbox" id="area[]" seq="15" sql="t1.improveadvice" value="改进建议" onclick="judgeCheckAll('area[]')"/>改进建议<br>
<input name="area[]" type="checkbox" id="area[]" seq="16" sql="t1.abortreasondesc" value="放弃原因" onclick="judgeCheckAll('area[]')"/>放弃原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="17" sql="decode(t1.kind,'0','自动分派','1','人工指定') kind" value="考评方式" onclick="judgeCheckAll('area[]')"/>考评方式<br>
<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(t1.checktype,'0','实时质检','1','事后质检') checktype" value="考评类别" onclick="judgeCheckAll('area[]')"/>考评类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="19" sql="t1.serviceclassdesc" value="业务类别" onclick="judgeCheckAll('area[]')"/>业务类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="20" sql="decode(to_char(t1.group_flag),'0','个人考评','1','团体考评') group_flag" value="考核类别" onclick="judgeCheckAll('area[]')"/>考核类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="21" sql="to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss') starttime" value="质检开始时间" onclick="judgeCheckAll('area[]')"/>质检开始时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="22" sql="to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss') endtime" value="质检结束时间" onclick="judgeCheckAll('area[]')"/>质检结束时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="23" sql="decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration) dealduration" value="处理时长" onclick="judgeCheckAll('area[]')"/>处理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="24" sql="decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration) lisduration" value="放音监听时长" onclick="judgeCheckAll('area[]')"/>放音监听时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="25" sql="decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration) arrduration" value="整理时长" onclick="judgeCheckAll('area[]')"/>整理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="26" sql="decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration) evtduration" value="质检总时长" onclick="judgeCheckAll('area[]')"/>质检总时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="27" sql="t1.signataryid" value="确认人" onclick="judgeCheckAll('area[]')"/>确认人<br>
<input name="area[]" type="checkbox" id="area[]" seq="28" sql="to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss') affirmtime" value="确认日期" onclick="judgeCheckAll('area[]')"/>确认日期<br>
<input name="area[]" type="checkbox" id="area[]" seq="29" sql="decode(t1.checkflag,'0','未复核','-1','未复核','1','已复核') checkflaga" value="复核标识" onclick="judgeCheckAll('area[]')"/>复核标识<br>
<input name="area[]" type="checkbox" id="area[]" seq="30" sql="t1.commentinfo" value="总体评价" onclick="judgeCheckAll('area[]')"/>总体评价<br>
<input name="area[]" type="checkbox" id="area[]" seq="31" sql="t1.checkreasondesc" value="评定原因" onclick="judgeCheckAll('area[]')"/>评定原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="32" sql="decode(VERTIFY_PASSWD_FLAG,'Y','是','N','否','YY','是(正确)','YN','是(失败)','','否',NULL,'否') VERTIFY_PASSWD_FLAG" value="是否密码验证" onclick="judgeCheckAll('area[]')"/>是否密码验证<br>

<input name="start_date"          type="hidden" value="">
<input name="end_date"            type="hidden" value="">
<input name="beQcObjId"            type="hidden" value="">
<input name="errorlevelid"        type="hidden" value="">
<input name="qcobjectid"           type="hidden" value="">
<input name="errorclassid"        type="hidden" value="">
<input name="evterno"             type="hidden" value="">
<input name="staffno"             type="hidden" value="">
<input name="recordernum"         type="hidden" value="">
<input name="flaga"                type="hidden" value="">
<input name="outplanflag"         type="hidden" value="">
<input name="group_flag"          type="hidden" value="">
<input name="checkflag"           type="hidden" value="">
<input name="qcGroupId"           type="hidden" value="">
<input name="beQcGroupId"         type="hidden" value="">
<input name="checkreasondesc"     type="hidden" value="">

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
	function(){
		$("td").not("[input]").addClass("blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");
		$("input:text[@v_type]").blur(checkElement2);
		$("a").hover(function() {$(this).css("color", "orange");}, 
					 function() {$(this).css("color", "blue");});
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

/**
  *导出全部
  */
function s_exp(x){
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value; 
	document.all("start_date").value        = opener.document.all("start_date").value;  
  document.all("end_date").value          = opener.document.all("end_date").value;        
  document.all("beQcObjId").value          = opener.document.all("beQcObjId").value;        
  document.all("errorlevelid").value      = opener.document.all("errorlevelid").value;    
  document.all("qcobjectid").value         = opener.document.all("qcobjectid").value;       
  document.all("errorclassid").value      = opener.document.all("errorclassid").value;    
  document.all("evterno").value           = opener.document.all("evterno").value;         
  document.all("staffno").value           = opener.document.all("staffno").value;         
  document.all("recordernum").value       = opener.document.all("recordernum").value;     
  document.all("flaga").value              = opener.document.all("flag").value;            
  document.all("outplanflag").value       = opener.document.all("outplanflag").value;     
  document.all("group_flag").value        = opener.document.all("group_flag").value;      
  document.all("checkflag").value         = opener.document.all("checkflag").value;       
  document.all("qcGroupId").value         = opener.document.all("qcGroupId").value;       
  document.all("beQcGroupId").value       = opener.document.all("beQcGroupId").value;     
  document.all("checkreasondesc").value   = opener.document.all("checkreasondesc").value;


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
	window.sitechform.action="k211_expSelect.jsp?exp="+str;
	window.sitechform.method='post';
	window.sitechform.submit();
}
 	
function getCheckboxValue(){
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

/**
  *根据选中的字段生成检索字段SQL语句
  */
function getCheckboxSql(){
	var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox'){ 
		return (checkbox.checked)?checkbox.value:''; 
	}

	if (checkbox[0].tagName.toLowerCase() != 'input' || checkbox[0].type.toLowerCase() != 'checkbox'){ 
		return ''; 
	}

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++){
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
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].seq;
		}
	}

	return (val.length)?val:'';
}
 </script>
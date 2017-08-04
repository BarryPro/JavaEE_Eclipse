<%
  /*
   * 功能: 个人质检结果查询导出
　 * 版本: 1.0
　 * 日期: 2009/09/08
　 * 作者: guozw
　 * 版权: sitech
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

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
    //获得满足导出条件的记录数量
	String sqlGetCount = "SELECT count(*) count FROM dqcinfo t1 " + sqlFilter + " AND t1.is_del='N'"; 
	
    //尚未分页的导出数据查询语句    
	String sqlStr = "SELECT " + sql + " FROM dqcinfo t1 " + sqlFilter + 
	                " AND t1.is_del='N' ORDER BY t1.starttime DESC";

    String statusSql = "select t.field_id from DCALLEXPSTATUS t where t.boss_login_no='"+loginNo+"'and  t.op_code='K212'";
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
%>

<%
	//第一次载入页面，获取上次选中记录
	if("cur".equalsIgnoreCase(pageFlag) || "all".equalsIgnoreCase(pageFlag)){
%>
		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=statusSql%>"/>
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
%>

<%
	if("cur".equalsIgnoreCase(expFlag)){ //导出当前显示数据
%>
		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=sqlGetCount%>"/>
		</wtc:service>
		<wtc:array id="rowCountList"  scope="end"/>
<%
		if(rowCountList.length != 0){
			rowCount = Integer.parseInt(rowCountList[0][0]);
		}
	      
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
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>
		<wtc:service name="s151Select" outnum="37">
		<wtc:param value="<%=querySql%>"/>
		</wtc:service>
		<wtc:array id="queryList" start="0" length="36" scope="end"/>

<%
		XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		out.print("<script language='javascript'>window.close();</script>");
	}
   
	if("all".equalsIgnoreCase(expFlag)){//导出全部
		int expAllCount = 0;//符合条件的全部记录数
%>
		<wtc:service name="s151Select" outnum="3">
			<wtc:param value="<%=sqlGetCount%>"/>
		</wtc:service>
		<wtc:array id="countList" scope="end"/>
<%
		
		if(countList.length > 0){
			expAllCount = Integer.parseInt(countList[0][0]);
		}
		if(expAllCount < 2000){ //小于2000直接导出
%>
			<wtc:service name="s151Select" outnum="37">
			<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
			<wtc:array id="queryList" start="0" length="36" scope="end"/>
<%
			XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
			out.print("<script language='javascript'>window.close();</script>");
		}else if(expAllCount >= 2000 && expAllCount <= 50000){ //大于2000时，分批查询数据再拼接到一个Excel文件中
			String[][] dataRows = new String[expAllCount][];
			int n = 0;//所有数据分n次进行插入
			if(expAllCount % 1999 == 0){
				n = expAllCount / 1999;
			}else{
				n = expAllCount / 1999 + 1;
			}
			String sqlStrSum = "";
			for(int a = 0; a < n; a++){
				if(a == n - 1){
					sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
					            expAllCount + ") WHERE rnm >= " + (a * 1999 + 1);				
				}else{
					sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
					            (( a + 1) * 1999) + ") WHERE rnm >= " + (a * 1999 + 1);					
				}
				//sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
				//            (( a + 1) * 1999) + ") WHERE rnm >= " + (a * 1999 + 1);
				//sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
				//            (a * 1999 + 1 + 1999) + ") WHERE rnm >= " + (a * 1999 + 1);
%>
				<wtc:service name="s151Select" outnum="37">
					<wtc:param value="<%=sqlStrSum%>"/>
				</wtc:service>
				<wtc:array id="queryList" start="0" length="36" scope="end"/>
<%				
				System.arraycopy(queryList, 0, dataRows, a*1999, queryList.length);
			}
			XLSExport.toExcel(strHead,dataRows,intMaxRow,excelName,response);
			out.print("<script language='javascript'>window.close();</script>");
		}else if(expAllCount > 50000){
			out.println("<font color='red'>一次最多可导出5万条数据</font>");		
		}
	}
	//保存用户选择的列
	if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
		String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no='"+loginNo+"' and t.op_code='K212'";
		String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values('"+loginNo+"','K212','"+seq+"',sysdate)";
		List sqlList=new ArrayList();
		String[] sqlArr = new String[]{};
		if("Y".equalsIgnoreCase(stautsflag)){
			sqlList.add(deleteStatus);
		}
		sqlList.add(insertStatus);
		sqlArr = (String[])sqlList.toArray(new String[0]);
		String outnum = String.valueOf(sqlArr.length + 1);
%>
		<wtc:service name="sPubModify"  outnum="<%=outnum%>">
		<wtc:params value="<%=sqlArr%>"/>
		<wtc:param value="dbcall"/>
		</wtc:service>
		<wtc:array id="retRows"  scope="end"/>
<%
   }
%>

<html>
<head>
<title>个人质检结果查询导出</title>

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
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="''" value="员工批次" onclick="judgeCheckAll('area[]')"/>员工批次<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="(SELECT object_name FROM dqcobject WHERE object_id = t1.objectid)" value="被检对象" onclick="judgeCheckAll('area[]')"/>被检对象<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="decode(t1.flag,'0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃')" value="质检标识" onclick="judgeCheckAll('area[]')"/>质检标识<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="t1.evterno" value="质检工号" onclick="judgeCheckAll('area[]')"/>质检工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="(SELECT name FROM dqccheckcontect WHERE object_id=t1.objectid AND contect_id=t1.contentid)" value="考评内容" onclick="judgeCheckAll('area[]')"/>考评内容<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(to_char(t1.score),'','0',null,'0',t1.score)" value="总得分" onclick="judgeCheckAll('area[]')"/>总得分<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(to_char(t1.outplanflag),'0','计划内质检','1',' 计划外质检')" value="计划类型" onclick="judgeCheckAll('area[]')"/>计划类型<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t1.contentlevelid" value="等级" onclick="judgeCheckAll('area[]')"/>等级<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t1.errorclassdesc" value="差错类别" onclick="judgeCheckAll('area[]')"/>差错类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="13" sql="t1.errorleveldesc" value="差错等级" onclick="judgeCheckAll('area[]')"/>差错等级<br>
<input name="area[]" type="checkbox" id="area[]" seq="14" sql="t1.contentinsum" value="内容概括" onclick="judgeCheckAll('area[]')"/>内容概括<br>
<input name="area[]" type="checkbox" id="area[]" seq="15" sql="t1.handleinfo" value="处理情况" onclick="judgeCheckAll('area[]')"/>处理情况<br>
<input name="area[]" type="checkbox" id="area[]" seq="16" sql="t1.improveadvice" value="改进建议" onclick="judgeCheckAll('area[]')"/>改进建议<br>
<input name="area[]" type="checkbox" id="area[]" seq="17" sql="t1.abortreasondesc" value="放弃原因" onclick="judgeCheckAll('area[]')"/>放弃原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(t1.kind,'0','自动分派','1','人工指定')" value="考评方式" onclick="judgeCheckAll('area[]')"/>考评方式<br>
<input name="area[]" type="checkbox" id="area[]" seq="19" sql="decode(t1.checktype,'0','实时质检','1','事后质检')" value="考评类别" onclick="judgeCheckAll('area[]')"/>考评类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="20" sql="t1.serviceclassdesc" value="业务类别" onclick="judgeCheckAll('area[]')"/>业务类别<br>
<input name="area[]" type="checkbox" id="area[]" seq="21" sql="to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')" value="质检开始时间" onclick="judgeCheckAll('area[]')"/>质检开始时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="22" sql="to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')" value="质检结束时间" onclick="judgeCheckAll('area[]')"/>质检结束时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="23" sql="decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration)" value="处理时长" onclick="judgeCheckAll('area[]')"/>处理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="24" sql="decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration)" value="放音监听时长" onclick="judgeCheckAll('area[]')"/>放音监听时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="25" sql="decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration)" value="整理时长" onclick="judgeCheckAll('area[]')"/>整理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="26" sql="decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration)" value="质检总时长" onclick="judgeCheckAll('area[]')"/>质检总时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="27" sql="t1.signataryid" value="确认人" onclick="judgeCheckAll('area[]')"/>确认人<br>
<input name="area[]" type="checkbox" id="area[]" seq="28" sql="to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss')" value="确认日期" onclick="judgeCheckAll('area[]')"/>确认日期<br>
<input name="area[]" type="checkbox" id="area[]" seq="29" sql="decode(t1.checkflag,'0','未复核','-1','未复核','1','已复核')" value="复核标识" onclick="judgeCheckAll('area[]')"/>复核标识<br>
<input name="area[]" type="checkbox" id="area[]" seq="30" sql="t1.commentinfo" value="总体评价" onclick="judgeCheckAll('area[]')"/>总体评价<br>
<input name="area[]" type="checkbox" id="area[]" seq="31" sql="decode(t1.vertify_passwd_flag,'Y','是','N','否','','否',NULL,'否')" value="是否密码验证" onclick="judgeCheckAll('area[]')"/>是否密码验证<br>


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
	window.sitechform.page.value = opener.document.sitechform.page.value;
	window.sitechform.headName.value = head;
	window.sitechform.sql.value = sql;
	window.sitechform.seq.value = seq;
	window.sitechform.stautsflag.value = stautsflag;
	if(head==''){
		return;
	}
	temSql="select " + sql + "from dqcinfo t1,dqcobject t3,dqccheckcontect t4,dual t5 "+ window.sitechform.sqlFilter.value;
	submitExp(expFlag);
}

function submitExp(str){
	window.sitechform.action="k212_expSelect.jsp?exp="+str;
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 修改记录查询导出
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
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
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
	String[][] dataRows = new String[][]{};
	//20091120 绑定变量增加
	int start=0;
	int end=0;
	String start_date    =  request.getParameter("start_date");
	String end_date      =  request.getParameter("end_date");
	String mod_start_date    =  request.getParameter("mod_start_date");
	String mod_end_date      =  request.getParameter("mod_end_date");
	String staffno       =  request.getParameter("staffno");
	String evterno       =  request.getParameter("evterno");
	String serialnum     =  request.getParameter("serialnum");
	String modevterno    =  request.getParameter("modevterno");
	String contact_id =  request.getParameter("contact_id");
	String[][] queryList = new String[][] {};

	int rowCount =0;
	int pageSize = 15;            // Rows each page
	int pageCount=0;               // Number of all pages
	int curPage=0;                 // Current page
	String strPage;               // 需要从当前上一页面传过来
	String sqlTemp ="";
	String sqlStr ="";
	String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增

	HashMap pMap=new HashMap();
	pMap.put("op_code", "K213");
	pMap.put("sqlstr",sql);
	pMap.put("boss_login_no", loginNo);
	pMap.put("starttime", start_date);
	pMap.put("endtime", end_date);
	pMap.put("modstarttime", mod_start_date);
	pMap.put("modendtime", mod_end_date);
	pMap.put("staffno", staffno);
	pMap.put("evterno", evterno);
	pMap.put("serialnum", serialnum);
	pMap.put("modevterno", modevterno);
	pMap.put("contact_id", contact_id);

	String[] strHead =null;
	String head[]=null;
	String excelName="修改记录查询";
	int intMaxRow=5000;
	if(headName!=null){
		if(!"".equalsIgnoreCase(headName)){
			head =headName.split(",");
			strHead =new String[head.length];
			for (int i = 0; i < head.length; i++) {
				strHead[i]=head[i];
			}
		}
	}

	  sqlStr+="select "+sql+" from dqcmodinfo m, dqcmodinfo n"+sqlFilter;
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
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_k213_qcModifyRec_strCountSql",pMap)).intValue();

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
		List queryList1 =(List)KFEjbClient.queryForList("exp_k213_qcModifyRec_cur",pMap);
        queryList = getArrayFromListMap(queryList1 ,1,22);
		XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
		  List iDataList2 =(List)KFEjbClient.queryForList("exp_k213_qcModifyRec_all",pMap);
		  queryList = getArrayFromListMap(iDataList2 ,0,21);

          XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		  out.print("<script language='javascript'>window.close();</script>");
	}

			//保存用户选择的列
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K213'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K213',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>修改记录查询导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
		<input name="area[]" type="checkbox" id="area[]" seq="11" sql="m.updatechoose" value="修改选项" onclick="judgeCheckAll('area[]')" />修改选项<br>
		<input name="area[]" type="checkbox" id="area[]" seq="0" sql="m.recordernum" value="被检流水号" onclick="judgeCheckAll('area[]')" />被检流水号<br>
		<input name="area[]" type="checkbox" id="area[]" seq="1" sql="m.serialnum" value="质检结果流水号" onclick="judgeCheckAll('area[]')" />质检结果流水号<br>
		<input name="area[]" type="checkbox" id="area[]" seq="2" sql="(select o.object_name from dqcobject o where o.object_id = m.objectid) objectName" value="被检对象" onclick="judgeCheckAll('area[]')" />被检对象<br>
		<input name="area[]" type="checkbox" id="area[]" seq="3" sql="(select c.name from dqccheckcontect c where c.object_id = m.objectid and c.contect_id = m.contentid) contentName" value="质检内容" onclick="judgeCheckAll('area[]')" />质检内容<br>
		<input name="area[]" type="checkbox" id="area[]" seq="4" sql="m.modevterno" value="修改人" onclick="judgeCheckAll('area[]')" />修改人<br>
		<input name="area[]" type="checkbox" id="area[]" seq="5" sql="m.staffno" value="被检工号" onclick="judgeCheckAll('area[]')" />被检工号<br>
		<input name="area[]" type="checkbox" id="area[]" seq="6" sql="m.evterno" value="质检工号" onclick="judgeCheckAll('area[]')" />质检工号<br>
		<input name="area[]" type="checkbox" id="area[]" seq="7" sql="n.score oldScore" value="原来得分" onclick="judgeCheckAll('area[]')" />原来得分<br>
		<input name="area[]" type="checkbox" id="area[]" seq="8" sql="m.score newScore" value="修改得分" onclick="judgeCheckAll('area[]')" />修改得分<br>
		<input name="area[]" type="checkbox" id="area[]" seq="9" sql="n.errorleveldesc oldLevel" value="原来等级" onclick="judgeCheckAll('area[]')" />原来等级<br>
		<input name="area[]" type="checkbox" id="area[]" seq="10" sql="m.errorleveldesc newLevel" value="修改等级" onclick="judgeCheckAll('area[]')" />修改等级<br>
		<input name="area[]" type="checkbox" id="area[]" seq="12" sql="to_char(m.starttime,'yyyy-mm-dd hh24:mi:ss') starttime" value="质检开始时间" onclick="judgeCheckAll('area[]')" />考评开始时间<br>
		<input name="area[]" type="checkbox" id="area[]" seq="13" sql="to_char(m.endtime,'yyyy-mm-dd hh24:mi:ss') endtime" value="质检结束时间" onclick="judgeCheckAll('area[]')" />考评结束时间<br>
		<input name="area[]" type="checkbox" id="area[]" seq="14" sql="to_char(m.modtime,'yyyy-mm-dd hh24:mi:ss') modtime" value="修改时间" onclick="judgeCheckAll('area[]')" />修改时间<br>
		<input name="area[]" type="checkbox" id="area[]" seq="15" sql="decode(to_char(m.dealduration), '', '0', null, '0', m.dealduration) dealduration" value="处理时长" onclick="judgeCheckAll('area[]')" />处理时长<br>
		<input name="area[]" type="checkbox" id="area[]" seq="16" sql="decode(to_char(m.lisduration), '', '0', null, '0', m.lisduration) lisduration" value="监听时长" onclick="judgeCheckAll('area[]')" />监听时长<br>
		<input name="area[]" type="checkbox" id="area[]" seq="17" sql="decode(to_char(m.arrduration), '', '0', null, '0', m.arrduration) arrduration" value="整理时长" onclick="judgeCheckAll('area[]')" />整理时长<br>
		<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(to_char(m.evtduration), '', '0', null, '0', m.evtduration) evtduration" value="质检总时长" onclick="judgeCheckAll('area[]')" />质检总时长<br>

		<input name="start_date" type="hidden" value="">
		<input name="end_date" type="hidden" value="">
		<input name="mod_start_date" type="hidden" value="">
		<input name="mod_end_date" type="hidden" value="">
		<input name="staffno" type="hidden" value="">
		<input name="evterno" type="hidden" value="">
		<input name="serialnum" type="hidden" value="">
		<input name="modevterno" type="hidden" value="">
		<input name="contact_id" type="hidden" value="">

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
	  var count = 0;
	  if(arrid!=''){
	  		temarr=arrid.split(",");
					for(var i=0;i<inps.length;i++){
							if(isStr(inps[i].seq,temarr)){
									inps[i].checked=true;
							}
					}
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
		window.sitechform.page.value = opener.document.sitechform.page.value;
	  	window.sitechform.headName.value = head;
	  	window.sitechform.sql.value = sql;
	  	window.sitechform.seq.value = seq;
	  	window.sitechform.stautsflag.value = stautsflag;

	    //20091120 绑定变量增加
    	window.sitechform.start_date.value = opener.sitechform.start_date.value;
    	window.sitechform.end_date.value = opener.sitechform.end_date.value;
    	window.sitechform.mod_start_date.value = opener.sitechform.mod_start_date.value;
    	window.sitechform.mod_end_date.value = opener.sitechform.mod_end_date.value;
    	window.sitechform.staffno.value = opener.sitechform.staffno.value;
    	window.sitechform.evterno.value = opener.sitechform.evterno.value;
    	window.sitechform.serialnum.value = opener.sitechform.serialnum.value;
    	window.sitechform.modevterno.value = opener.sitechform.modevterno.value;
    	window.sitechform.contact_id.value = opener.sitechform.contact_id.value;
		//:~
	    if(head==''){
	   	return;
	   	}
	   	temSql="select "+sql+ " from dqcmodinfo m, dqcmodinfo n "+ window.sitechform.sqlFilter.value;
	   submitExp(expFlag);
}

function submitExp(str){
		window.sitechform.action="k213_expSelect.jsp?exp="+str;
		window.sitechform.method='post';
		window.sitechform.submit();
}

function getCheckboxValue(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
				return (checkbox.checked)?checkbox.value:'';
		}

		if (checkbox[0].tagName.toLowerCase() != 'input' ||
				checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }

		var val = [];
		var len = checkbox.length;

		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].value;
				}
		}
		return (val.length)?val:'';
}

function getCheckboxSql(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
				return (checkbox.checked)?checkbox.value:'';
		}

		if (checkbox[0].tagName.toLowerCase() != 'input' ||
				checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }

		var val = [];
		var len = checkbox.length;

		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].sql;
				}
		}

		return (val.length)?val:'';
}

function getCheckboxSeq(){
  var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
			return (checkbox.checked)?checkbox.value:'';
	}

	if (checkbox[0].tagName.toLowerCase() != 'input' ||
			checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++){
			if (checkbox[i].checked){
					val[val.length] = checkbox[i].seq;
			}
	}

	return (val.length)?val:'';
}
 </script>
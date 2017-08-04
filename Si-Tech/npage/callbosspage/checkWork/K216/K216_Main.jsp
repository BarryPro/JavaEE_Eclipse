<%
   /*
    * 功能: 服务评价报告查询汇总页面
　 * 版本: 1.0
　 * 日期: 
　 * 作者: guozw
　 * 版权: sitech
 　*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	String opCode       = "K216";
	String opName       ="质检查询-个人服务评价报告查询";
%>

<%!
	/**
	   *函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
	   *其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
	   */
  public String returnSql(HttpServletRequest request){
    
	StringBuffer buffer = new StringBuffer();
	//输入语句.
	Map map = request.getParameterMap();
	Object[] objNames = map.keySet().toArray();
	Map temp = new HashMap();
	String name="";
	String[] names= new String[0];
	String value="";
	//将结果保存在这里.key是数字.对数字进行排序.value里面放置object数组存值.
	for (int i = 0; i < objNames.length; i++) {
		name = objNames[i] == null ? "" : objNames[i].toString();
		names = name.split("_");
		//将name按照'_'分成3个数组.
		if (names.length >= 3) {
			//如果不能分说明名字不合法.太少区分不了.
	  		value = request.getParameter(name);
			//按照名字得到value
			if (value.trim().equals("")) {
				//如果value是""跳过.
				continue;
			}
			Object[] objs = new Object[3];
			objs[0] = names[1];
			//保持 第一个字符串.是like 或是 =
			name = name.substring(name.indexOf("_") + 1);
			name = name.substring(name.indexOf("_") + 1);
			//这地方做数据库的字段处理.第三个'_'以后的都是数据库字段了.
			objs[1] = name;
			//第二个字符串.查询名字.
			objs[2] = value;
			//第三个.查询的值.
			try {
				temp.put(Integer.valueOf(names[0]), objs);
				//这个地方是将字符串转换成数字.然后进行排序.比如19要在2之后.
			} catch (Exception e) {
			
			}
			//将排序号码放在key里面,ojbs数组放到value里面.
		}
	}
	Object[] objNos = temp.keySet().toArray();
	//得到一个倒序的数组.
	Arrays.sort(objNos);
	//对数字进行排序.
	for (int i = 0; i < objNos.length; i++) {
		Object[] objs = null;
		objs = (Object[]) temp.get(objNos[i]);
		//下面对like 和 = 分别处理.
		if (objs[0].toString().toLowerCase().equalsIgnoreCase("like")) {
			buffer.append(" and " + objs[1] + " " + objs[0] + " '%%" + objs[2].toString().trim() + "%%' ");
		}
		if (objs[0].toString().equalsIgnoreCase("=")) {
			buffer.append(" and " + objs[1] + " " + objs[0] + " '" + objs[2].toString().trim() + "' ");
		}
	}
	return buffer.toString();
}

	public  String getCurrDateStr(String str) {
			java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
			return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%!
	/**
	   *导出Excel
	   *
	   */
	public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
		System.out.println( " 开始导出Excel文件 " );
		XLSExport e  =   new  XLSExport(null);
		String headname = "服务评价报告查询";//Excel文件名
		
		try {
			OutputStream os = response.getOutputStream();//取得输出流
			response.reset();//清空输出流
			response.setContentType("application/ms-excel");//定义输出类型
			response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
			int intMaxRow=5000+1;
			ArrayList datalist = new ArrayList();
			
			for(int i=0;i<queryList.length;i++){
			    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3]};
			    datalist.add(dateSour);
			}
			XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
			e.exportXLS(os);
			System.out.println( " 导出Excel文件[成功] ");
		}catch  (Exception e1) {
			System.out.println( " 导出Excel文件[失败] ");
			e1.printStackTrace();
		}
	}
%>

<%
	String loginNo       = (String)session.getAttribute("kfWorkNo");  //客服系统工号 
	String orgCode       = (String)session.getAttribute("orgCode");   //
	String qc_type       = request.getParameter("qc_type");
	String skill_type     = request.getParameter("skill_type");
	String isCheckLogin = "N";     //是否有权限查看所有业务代表的服务评价报告 ("Y"有，"N"无)
	boolean isPersonal  = true; 
	                                                 //true为个人考评，false为团体考评
	if("1".equals(qc_type)){
	 isPersonal=false;
	}

	String sqlStr              = "select t1.staffno,(100-sum(100-t1.score)),  t1.objectid, t1.contentid from dqcinfo t1 ";
	String strCountSql         = "select count(*) from (select t1.staffno,(100 - sum(100 - t1.score)),t1.objectid,t1.contentid from dqcinfo t1 ";
	String strDateSql          = "";
	String start_date          =  request.getParameter("start_date");
	String end_date            =  request.getParameter("end_date");
	String objectid            =  request.getParameter("0_str_t1.objectid");
	String objectTypeName  = request.getParameter("objectTypeName");
	String staffno             =  request.getParameter("2_=_t1.staffno");

/*取当前登陆工号的角色ID，为逗号分割的字符串 */
		String  powerCode = (String)session.getAttribute("powerCodekf");
		String[]  powerCodeArr = powerCode.split(",");

	/*
	 *是否是质检员 测试环境：[0100020I] 生产环境：[01120O0E]，   上线时改一下
	 *是否是复核员 测试环境：[0100020K] 生产环境：[01120O0B]，   上线时改一下
	 *是否是质检组长 测试环境：[0100020J] 生产环境：[01120O0C]，上线时改一下
	 *
	 */
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<ZHIJIANYUAN_ID.length; j++) {
			if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i]) || FUHEYUAN_ID.equals(powerCodeArr[i])){
				isCheckLogin="Y";	
			}
		}
		for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
			if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
				isCheckLogin="Y";
			}
		}
	}
%>

<%
    String object_id      =  request.getParameter("0_=_t1.object_id");
    String strJoinSql="  and t1.objectid='"+objectid+"'  and t1.is_del != 'Y' and t1.flag<>'0' and t1.flag<>'4' group by t1.staffno, t1.objectid, t1.contentid ";
    String sqlLogin="";

	//非话务员可以查看所有的服务评价报告息
	if("Y".equals(isCheckLogin)){

	}else if("N".equals(isCheckLogin)){
		sqlLogin=" and staffno='"+loginNo+"' ";
	}

	String[][] dataRows = new String[][]{};
	int rowCount =0;
	int pageSize = 15;            // Rows each page
	int pageCount=0;               // Number of all pages
	int curPage=0;                 // Current page
	String strPage;               // Transfered pages
	String sqlTemp ="";
	String action = request.getParameter("myaction");
	String[] strHead= {"工号","普通客户代表","VIP客户代表及全球通客户代表","综合得分"};
	String expFlag = request.getParameter("exp");
	String sqlFilter = request.getParameter("sqlFilter");

	//查询条件
	if(sqlFilter==null || sqlFilter.trim().length()==0){
			if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
					strDateSql = " where 1=1 and  to_char(starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
			}
			
			sqlFilter = strDateSql + returnSql(request) + sqlLogin + strJoinSql;
	}
%>

<%
	if ("doLoad".equals(action) && isPersonal) {
			sqlStr+=sqlFilter;
			sqlTemp = strCountSql+sqlFilter+") bb ";
			System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			System.out.println("sqlTemp:"+sqlTemp);
			System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
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
	if (curPage > pageCount) curPage = pageCount;
	
	String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
	System.out.println("&&&&&&&&&&&&&&&个人&&&&&&&&&&:::::"+querySql);
%>
	<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=querySql%>"/>
	</wtc:service>
	<wtc:array id="queryList"  start="0" length="4"   scope="end"/>
<%
	 dataRows = queryList;
	}
	String thSqlStr = "select t1.name,t1.object_id,t1.contect_id from dqccheckcontect t1,dqcobject t2 where t1.object_id='"+objectid+"' and t1.object_id=t2.object_id and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
 %>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=thSqlStr%>"/>
	</wtc:service>
	<wtc:array id="thName"  scope="end"/>
<%
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){
      sqlTemp = strCountSql+sqlFilter;
%>
			<wtc:service name="s151Select" outnum="1">
				<wtc:param value="<%=sqlTemp%>"/>
			</wtc:service>
			<wtc:array id="rowsC4"  scope="end"/>
<%
      rowCount = Integer.parseInt(rowsC4[0][0]);
      strPage = request.getParameter("page");
      if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
        	curPage = 1;
      } else {
      	curPage = Integer.parseInt(strPage);
        	if( curPage < 1 ) curPage = 1;
      }
      pageCount = ( rowCount + pageSize - 1 ) / pageSize;
      if ( curPage > pageCount ) curPage = pageCount;
      String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>
         <wtc:service name="s151Select" outnum="5">
					<wtc:param value="<%=querySql%>"/>
				</wtc:service>
			<wtc:array id="queryList"  start="0" length="4"   scope="end"/>
<%
			this.toExcel(queryList,strHead,response);
   }

   if("all".equalsIgnoreCase(expFlag)){
     	sqlStr+=sqlFilter;
%>
			<wtc:service name="s151Select" outnum="5">
					<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
			<wtc:array id="queryList" start="0" length="4" scope="end"/>
<%
			this.toExcel(queryList,strHead,response);
   }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>个人服务评价报告查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
$(document).ready(
	function(){
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

function submitInputCheck(){
   if( document.sitechform.start_date.value == ""){
				showTip(document.sitechform.start_date,"开始时间不能为空");
				sitechform.start_date.focus();
    }else if(document.sitechform.end_date.value == ""){
				showTip(document.sitechform.end_date,"结束时间不能为空");
				sitechform.end_date.focus();
    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
				showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
				sitechform.end_date.focus();
    }else if(document.sitechform.objectTypeName.value==""){
				showTip(document.sitechform.objectTypeName,"被检对象不能为空！");
				sitechform.objectTypeName.focus();
    }else{
		    hiddenTip(document.sitechform.start_date);
		    hiddenTip(document.sitechform.end_date);
		    hiddenTip(document.sitechform.objectTypeName);
		    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
		    window.sitechform.sqlWhere.value="<%=sqlFilter%>";
		    submitMe();
    }
}
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K216_Main.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

function doLoad(operateCode){
   if(operateCode=="load"){
   		window.sitechform.page.value="";
   }else if(operateCode=="first"){
   		window.sitechform.page.value=1;
   }else if(operateCode=="pre"){
   		window.sitechform.page.value=<%=(curPage-1)%>;
   }else if(operateCode=="next"){
   		window.sitechform.page.value=<%=(curPage+1)%>;
   }else if(operateCode=="last"){
   		window.sitechform.page.value=<%=pageCount%>;
   }
   keepValue();
   submitMe();
}
//清除表单记录
function clearValue(){
		var e = document.forms[0].elements;
		for(var i=0;i<e.length;i++){
				if(e[i].type=="text"||e[i].type=="hidden"){
						if(e[i].id=="start_date"){
					  		e[i].value='<%=getCurrDateStr("00:00:00")%>';
					  }else if(e[i].id=="end_date"){
					  		e[i].value='<%=getCurrDateStr("23:59:59")%>';
					  }else{
					  		e[i].value="";
					  }
				}else if(e[i].type=="checkbox"){
						e[i].checked=false;
				}
				if(e[i].type=="select-one"){
						document.getElementById(e[i].id).options[0].selected = true;
				}
		}
		document.getElementById("groupflag").value = "0";	//个人为0
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K204/K204_serEvaReport.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.objectTypeName.value="<%=objectTypeName%>";
    window.sitechform.staffno.value="<%=staffno%>";
}

//显示通话详细信息
function getDetail(staffno,objectid){
		var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K216/K216_repDetailQry.jsp";
    path = path + "?staffno=" + staffno;
    path = path + "&start_date=" + "<%=start_date%>";
    path = path + "&end_date=" + "<%=end_date%>";
    path = path + "&objectTypeName=" + "<%=objectTypeName%>";
    path = path + "&objectid=" + objectid;
    window.open(path,"newwindow","height=600, width=960,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

//被检对象
function showObjectCheckTree(){
		var path= '../K204/K204_objectIdTree.jsp';
		var param  = 'dialogWidth=300px;dialogHeight=250px';
		var returnValue = window.showModalDialog(path,'选择质检群组',param);

		if(typeof(returnValue) != "undefined"){
				var objectid = document.getElementById("objectid");
				var objectTypeName   = document.getElementById("objectTypeName");
				var temp = returnValue.split('_');
				objectid.value = trim(temp[0]);
				objectTypeName.value = trim(temp[1]);
	 }
}

//被检群组
function showBeCheckedGroTree(){
	alert("aaaa");
}

function test(){
	alert("aaaa");
}

function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
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

//导出窗口
function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
		window.sitechform.sqlWhere.value="<%=sqlFilter%>";
		var sqlFilter = "<%=sqlFilter%>";
		var objectid ='<%=objectid%>';
		openWinMid('../K204/k204_expSelect.jsp?flag='+flag+'&objectid='+objectid+'&sqlFilter='+sqlFilter,'选择导出列',340,320);
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi">个人服务评价报告查询</div></div>
		<table cellspacing="0" style="width:100%">
     	<tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" >
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		  <td > 被检对象 </td>
      <td >
			  <input id="objectTypeName" name ="objectTypeName" size="20" readonly type="text" onclick="showObjectCheckTree(0);" value="<%=(objectTypeName==null)?"":objectTypeName%>" >
  			<input id="objectid" name ="0_str_t1.objectid" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>">
		    <img onclick="showObjectCheckTree(0);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
    </tr>
    <tr >
     <td >考核类别</td>
      <td >
				<select name="qc_type" id="qc_type" size="1"  >
					<option value="0" <%="0".equals(qc_type)?"selected":""%>>个人考评</option>
					<option value="1" <%="1".equals(qc_type)?"selected":""%>>团体考评</option>
        </select>
      </td>
		  <td > 被检群组 </td>
      <td >
	<input id="object_id" name ="0_=_t1.object_id" type="hidden" value="<%=(object_id==null)?"":object_id%>">
	<input id="beCheckedGroName" name ="beCheckedGroName" disabled type="text" onclick="test();" value=""/>
	<img id="selImg" name="selImg"  onClick="test();" disabled src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
	</td>
		 <td > 被检工号 </td>
      <td >
			  <input name ="2_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
			  <!-- 个人是0，多人是1 -->
			  <input name ="3_=_t1.group_flag" type="hidden" id="groupflag"  maxlength="10" value="0">
      </td>
   </tr>

    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;">
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
			 <input name="export" type="button"  id="search" value="打印" <%if(dataRows.length!=0) out.print("onClick=\"window.print();\"");%>>
       <input name="exportAll" type="button"  id="add" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
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
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <%if(isPersonal){%>
          <tr >
       <script>
       	var tempBool ='flase';
      	if(checkRole(K204A_RolesArr)==true){
	      		document.write('<th align="center" class="blue" width="15%" > 操作 </th>');
	      		tempBool='true';
      	}
        </script>
            <%if(thName.length>0){%>
            <th align="center" class="blue" width="10%" > 工号 </th>
            <%}%>
            <%for(int i=0;i<thName.length;i++){%>
            	<th align="center" class="blue" width="20%" > <%=thName[i][0]%> </th>
            <%}%>
            <%if(thName.length>0){%>
             <th align="center" class="blue" width="20%" > 综合得分 </th>
            <%} else{%>
            <th align="center" class="blue" width="80%" > &nbsp; </th>
            <%}%>
          </tr>
        <%}else if(!isPersonal){%>
          <tr >
            <th align="center" class="blue" width="10%" > 操作 </th>
            <th align="center" class="blue" width="80%" > &nbsp;</th>
          </tr>
        <%}%>

        <%
          for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="";
        %>
        <%
          if((i+1)%2==1){
          tdClass="grey";
        %>
          <tr>
			<%
				}else{
			%>
	   <tr>
	<%}%>
	      <script>
      	if(tempBool=='true'){
      			document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K204A_RolesArr)==true){
      			document.write('<img onclick="getDetail(\'<%=dataRows[i][0]%>\',\'<%=objectid%>\')" alt="显示该记录详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle" />');
      	}
        if(tempBool=='true'){
      			document.write('</td>');
      	}
      </script>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
     <% for ( int j = 0; j < thName.length; j++ ) {
       if(dataRows[i][2].equals(thName[j][1])&&dataRows[i][3].equals(thName[j][2])){
     %>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
     <%
      }else{
     %>
     <td align="center" class="<%=tdClass%>"  >&nbsp;</td>
     <%
      }
     }%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
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


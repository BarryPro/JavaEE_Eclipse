<%
  /*
   * 功能: 质检结果确认信息查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc
　 * 版权: sitech
   * update: mixh 2009/02/19 给弹出窗口增加时间戳，清空缓存。
   * update: mixh 2009/08/19 质检组长及复核员可以查询到所有通知信息。
   *
   *
 　*/
 %>


<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
	String opCode="K202";
	String opName="质检查询-质检结果确认信息查询";
	
	String isCheckLogin = "N";// Y: 具质检权限工号,N:不具质检权限工号
	String loginNo      = (String)session.getAttribute("workNo");  //客服工号，形式为四位数字
	String sqlLogin     = "";
	String bossLoginNo  = "";

	String  powerCode   = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	System.out.println("################################");
	System.out.println(powerCode);
	System.out.println("################################");
	String[] powerCodeArr  = powerCode.split(",");
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<ZHIJIANYUAN_ID.length; j++){
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
    //统一工号
    if(loginNo !=null && loginNo.length() == 5){
	      loginNo = loginNo.substring(loginNo.length()-2,loginNo.length());
	      loginNo = "1" + loginNo;
    }  

  	
	String isPower="N";
	for(int i = 0; i < powerCodeArr.length; i++){
		if(FUHEYUAN_ID.equals(powerCodeArr[i])){
		  isPower="Y";
		}
		for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
			if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
				isPower="Y";
			}
		}
	}

    String start_date    =  request.getParameter("start_date");
    String end_date      =  request.getParameter("end_date");
    String submitno      =  request.getParameter("submitno");
    String evterno       =  request.getParameter("evterno");
    String serialno      =  request.getParameter("serialno");
    String staffno       =  request.getParameter("staffno");
    String serialnum     =  request.getParameter("serialnum");
    String statisfy_code   =  request.getParameter("statisfy_code");
		//zengzq add 增加查询条件 单人考评还是多人考评
    String group_flag   = request.getParameter("group_flag");
    
	String[][] dataRows = new String[][]{};
	int rowCount   = 0;
	int pageSize   = 15;            // Rows each page
	int pageCount  = 0;             // Number of all pages
	int curPage    = 0;             // Current page
	String sqlTemp = "";
	String strPage;                 // Transfered pages	

	String expFlag   = request.getParameter("exp");
	String sqlFilter = request.getParameter("sqlFilter");
	String action    = request.getParameter("myaction");
	String[] strHead= {"质检结果确认流水号","后续流水号","质检结果确认标题","提交人工号","质检结果状态","质检单流水号","被检工号","质检员工号","提交时间"};	
	

	//显示指定页码的数据
	if ("doLoad".equals(action)) {
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
		//added by tangsong 20100524 话务员只能查询自己的记录
		pMap.put("loginNo", loginNo);
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
        int start = (curPage - 1) * pageSize + 1;
		    int end = curPage * pageSize;
		    pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList =(List)KFEjbClient.queryForList("query_K202_sqlStr",pMap);     
        dataRows = getArrayFromListMap(queryList ,1,22);  
    }

	
%>


<html>
<head>
<title>质检结果确认信息查询</title>
<style>
		img{
				cursor:hand;
		}
</style>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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
	}else{
	    hiddenTip(document.sitechform.start_date);
	    hiddenTip(document.sitechform.end_date);
	    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
	    window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	    submitMe();
	}
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K202_qcResultCfmInfo.jsp";
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
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
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
		}
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K202/K202_qcResultCfmInfo.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.start_date.value="<%=start_date%>";
	window.sitechform.end_date.value="<%=end_date%>";
	window.sitechform.statisfy_code.value="<%=request.getParameter("statisfy_code")%>";
	window.sitechform.submitno.value="<%=submitno%>";
	window.sitechform.evterno.value="<%=evterno%>";
	window.sitechform.serialnum.value="<%=serialnum%>";
	window.sitechform.staffno.value="<%=staffno%>";
	window.sitechform.serialno.value="<%=serialno%>";
	window.sitechform.group_flag.value="<%=group_flag%>";
}

//显示通话详细信息
function getDetail(serialno,serialnum){
	var time = new Date();
	var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K203/K203_qcResDetailFeedback.jsp?now=' + time;
	path = path + '&serialno=' + serialno;
	path = path + '&serialnum=' + serialnum;
		var Height = window.screen.availHeight - 200; 
	var width  = window.screen.availWidth  - 200;
	var top    = (window.screen.availHeight-30 - Height)/2; //获得窗口的垂直位置;
	var left   = (window.screen.availWidth-10 - width)/2; //获得窗口的水平位置;
	var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
	             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
	window.open(path, 'feedbackWin', param);	

}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=yes,location=no,status=no');
}

//导出窗口
function showExpWin(flag){
	window.sitechform.page.value="<%=curPage%>";
	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	openWinMid('k202_expSelect.jsp?flag='+flag,'选择导出列',340,320);
}

//选中行高亮显示 行变色
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色

/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
function changeColor(color,obj){
  //恢复原来一行的样式
  if(hisObj != ""){
	 for(var i=0;i<hisObj.cells.length;i++){
		var tempTd=hisObj.cells.item(i);
		//tempTd.className=hisColor; 还原字的颜色
		tempTd.style.backgroundColor = '#F7F7F7';		//还原行背景颜色
	 }
	}
		hisObj   = obj;
		hisColor = color;
  //设置当前行的样式
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; 改变字的颜色
		tempTd.style.backgroundColor='#00BFFF';	//改变行背景颜色
	}
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
<div id="Operation_Table" style="width: 100%;">
	<table cellspacing="0" style="width:100%;">
		<tr><td colspan='6' ><div class="title"><div id="title_zi">质检结果确认信息查询</div></div></td></tr>
    <tr>
    	<td> 开始时间 </td>
        <td>
	    <input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
        </td>
        <td> 提交人工号</td>
        <td>
        <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
		<input id="submitno" name="submitno" type="text" maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(submitno==null)?"":submitno%> >
        </td>
		<td> 质检工号 </td>
        <td>
	    <input name ="evterno" type="text" id="evterno"  maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(evterno==null)?"":evterno%>">
        </td>
    </tr>
    <tr>
    	<td> 结束时间 </td>
    	<td>
		<input id="end_date" name ="end_date" type="text" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"/>
		<img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
		</td>
		<td> 确认流水号 </td>
      	<td>
      <!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->	
			<input name ="serialno" type="text" id="serialno" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serialno==null)?"":serialno%>">
      	</td>
      	<td> 被检工号 </td>
      	<td>
    <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->  	
		<input name ="staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      	</td>
	</tr>
    <tr>
    	<td> 质检流水号 </td>
      	<td>
      	<!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->	
		<input name ="serialnum" type="text" id="serialnum" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serialnum==null)?"":serialnum%>">
      	</td>
       <td>结果状态</td>
      	<td>
      	<select name="statisfy_code" id="statisfy_code" size="1" >
      	<option value="" selected >4：全部</option>
		<option value="0" <%="0".equals(statisfy_code)?"selected":""%>>0:质检结果通知</option>
		<option value="1" <%="1".equals(statisfy_code)?"selected":""%>>1:申诉</option>
		<option value="2" <%="2".equals(statisfy_code)?"selected":""%>>2:答复</option>
		<option value="3" <%="3".equals(statisfy_code)?"selected":""%>>3:确认</option>
        </select>
      	</td>
		<td>考核类别</td>
	<td>
		<select name="group_flag" id="group_flag" size="1"  >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(group_flag)?"selected":""%>>个人考评</option>
		<option value="1" <%="1".equals(group_flag)?"selected":""%>>团体考评</option>
		</select>
	</td>
	</tr>
    <tr>
    	<td colspan="6" align="center" id="footer" style="width:420px">
        <!--zhengjiang 20091004 查询与重置换位置-->
       	<input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
       	<input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
		<input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       	<!--<input name="exportAll" type="button"  id="add" value="导出全部" onClick="showExpWin('all')">-->
      	</td>
	</tr>
	</table>
	</div>
	<div id="Operation_Table">
    <table  cellSpacing="0" >
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<input type="hidden" name="isPower" value="<%=isPower%>">
	
	<tr>
    	<td class="blue"  align="left" colspan="10">
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
    <tr>
	<script>
	var tempBool ='flase';
	if(checkRole(K202A_RolesArr)==true){
		document.write('<th align="center" class="blue" width="15%" ><nobr> 操作 </th>');
		tempBool='true';
	}
	</script>
	
	<th align="center" class="blue" width="25%" ><nobr> 质检结果确认流水号 </th>
	<th align="center" class="blue" width="25%" ><nobr> 后续流水号 </th>
	<th align="center" class="blue" width="25%" ><nobr> 质检结果确认标题 </th>
	<th align="center" class="blue" width="30%" ><nobr> 提交人工号 </th>
	<th align="center" class="blue" width="25%" ><nobr> 质检结果状态 </th>
	<th align="center" class="blue" width="25%" ><nobr> 质检单流水号</th>
	<th align="center" class="blue" width="25%" ><nobr> 被检工号 </th>
	<th align="center" class="blue" width="30%" ><nobr> 质检员工号 </th>
	<th align="center" class="blue" width="25%" ><nobr> 提交时间 </th>
	</tr>

<%
           for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
%>
<%
          if((i+1)%2==1){
          tdClass="blue";
%>
          <tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
				}else{
%>
	   <tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
		}
%>

<script>
      	if(tempBool=='true'){
      			document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K202A_RolesArr)==true){
      			document.write('<img onclick="getDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][5]%>\')" alt="质检结果确认信息详情及反馈信息录入" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">');
      	}
        if(tempBool=='true'){
      			document.write('</td>');
      	}
</script>

      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
<%
      if("Y".equals(isCheckLogin)){
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
<%
      }else{
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> ******</td>
<%
      }
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
    </tr>
<%
      }
%>
	<tr>
		<td class="blue"  align="right" colspan="10">
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
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>
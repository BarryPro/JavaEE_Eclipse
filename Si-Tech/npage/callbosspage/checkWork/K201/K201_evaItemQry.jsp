<%
  /*
   * 功能: 考评项查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%!
  public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<%
    String opCode="K201";
    String opName="质检查询-考评项查询";
	  String loginNo = (String)session.getAttribute("kfWorkNo");
	  String orgCode = (String)session.getAttribute("orgCode"); 
		
   
    String start_date     = (String)request.getParameter("start_date");      
    String end_date       = (String)request.getParameter("end_date");        
    String staffno        = (String)request.getParameter("staffno");    
    String beQcObjId      = (String)request.getParameter("objectid");
    String contentid      = (String)request.getParameter("contentid");
    String qccheckitemId  = (String)request.getParameter("item_id"); 
    String beQcObjName    = (String)request.getParameter("beQcObjName");
    String qcobjectName   = (String)request.getParameter("qcobjectName");
    String qccheckitemName= (String)request.getParameter("qccheckitemName");
    //zengzq add 增加查询条件 单人考评还是多人考评
    String group_flag   = request.getParameter("group_flag");

    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String[] strHead= {"流水号","被检工号","被检员姓名","被检对象","质检内容","考评项","考评项得分","最低分","最高分","质检开始时间","质检结束时间","质检工号","被检流水号"};
	  String expFlag = request.getParameter("exp"); 
	  String sqlFilter = request.getParameter("sqlFilter");
	 
	if ("doLoad".equals(action)) {
   HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("contentid", contentid);
		pMap.put("staffno", staffno);
		pMap.put("objectid", beQcObjId);
		pMap.put("end_date", end_date);
		pMap.put("item_id", qccheckitemId);
		pMap.put("group_flag", group_flag);
		
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
        int start = (curPage - 1) * pageSize + 1;
		    int end = curPage * pageSize;
		    pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList =(List)KFEjbClient.queryForList("query_K201_sqlStr",pMap);     
        dataRows = getArrayFromListMap(queryList ,1,22);  
    }
  
%>


<html>
<head>
<title>考评项查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<style>
		img{
				cursor:hand;
		}
</style>
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

    }else if(document.sitechform.beQcObjName.value == ""){
		     showTip(document.sitechform.beQcObjName,"被检对象不能为空"); 
    	   sitechform.beQcObjName.focus(); 	

    }else if(document.sitechform.qcobjectName.value==""){
		     showTip(document.sitechform.qcobjectName,"质检内容不能为空"); 
    	   sitechform.qcobjectName.focus(); 	

    }else if(document.sitechform.qccheckitemId.value==""){
		     showTip(document.sitechform.qccheckitemName,"考评项不能为空"); 
    	   sitechform.qccheckitemName.focus(); 	

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    hiddenTip(document.sitechform.beQcObjName);
    hiddenTip(document.sitechform.qcobjectName);
    hiddenTip(document.sitechform.qccheckitemName);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    submitMe();
    	}
}
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K201_evaItemQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

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
   keepValue();
    submitMe(); 
    }
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"){
  	if(e[i].id=="start_date"){
	  	e[i].value='<%=getCurrDateStr("00:00:00")%>';
		}else if(e[i].id=="end_date"){
		  	e[i].value='<%=getCurrDateStr("23:59:59")%>';
		}else{
		  	e[i].value="";
		}
  }
 }
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_evaItemQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.beQcObjId.value="<%=beQcObjId%>";
    window.sitechform.contentid.value="<%=contentid%>";
    window.sitechform.qccheckitemId.value="<%=qccheckitemId%>";
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";
    window.sitechform.qccheckitemName.value="<%=qccheckitemName%>";
    window.sitechform.group_flag.value="<%=group_flag%>";
}

//查询条件
function getQcContentTree(){
		var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_getQcContent.jsp";
    window.open(path,"newwindow","height=450, width=740,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//导出窗口
function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
		window.sitechform.sqlWhere.value="<%=sqlFilter%>"; 
		openWinMid('k201_expSelect.jsp?flag='+flag,'选择导出列',340,320);
}

//选中行高亮显示
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
		<table cellspacing="0" style="width:100%">
    <tr><td colspan='6' ><div class="title"><div id="title_zi">考评项查询</div></div></td></tr>
     <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
            <td > 被检对象 </td>
        <td >
        <input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly  value="<%=(beQcObjName==null)?"":beQcObjName%>">
  			
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
     
		  
      <td >被检工号 </td>
      <td >
      <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
				<input id="staffno" name="staffno" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(staffno==null)?"":staffno%>">
      </td>
    </tr>
    <tr >
    	

      <td >结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td > 质检内容 </td>
      <td >
				<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly  value="<%=(qcobjectName==null)?"":qcobjectName%>">
				
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 考评项 </td>
      <td >
      	<input  id="qccheckitemName" name="qccheckitemName" type="text"   readOnly value="<%=(qccheckitemName==null)?"":qccheckitemName%>">
				
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
     </tr>
		 <tr>
		 	<td>考核类别</td>
			<td colspan='5'>
				<select name="group_flag" id="group_flag" size="1"  >
				<option value="" selected >2-全部</option>
				<option value="0" <%="0".equals(group_flag)?"selected":""%>>个人考评</option>
				<option value="1" <%="1".equals(group_flag)?"selected":""%>>团体考评</option>
				</select>
			</td>
		 </tr>
    <tr >
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
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
  	<table  cellspacing="0">
    <tr >
    <!--zhengjiang 20090930 delete width="720" add colspan="13"-->
      <td class="blue"  align="left" colspan="13">
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
  <!--zhengjiang 20090930 
  </table>
      <table  cellSpacing="0" >-->
      <input  id="contentid" name="contentid" type="hidden"    value="<%=(contentid==null)?"":contentid%>">
      <input id="beQcObjId" name="objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
      <input  id="qccheckitemId" name="item_id" type="hidden"    value="<%=(qccheckitemId==null)?"":qccheckitemId%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr >
            <th align="center" class="blue" width="25%" ><nobr>流水号       </th>
            <th align="center" class="blue" width="25%" ><nobr>被检工号     </th>
            <th align="center" class="blue" width="25%" ><nobr>被检员姓名   </th>
            <th align="center" class="blue" width="25%" ><nobr>被检对象     </th>   
            <th align="center" class="blue" width="30%" ><nobr>质检内容     </th>   
            <th align="center" class="blue" width="25%" ><nobr>考评项       </th>   
            <th align="center" class="blue" width="25%" ><nobr>考评项得分   </th>   
            <th align="center" class="blue" width="25%" ><nobr>最低分       </th>   
            <th align="center" class="blue" width="25%" ><nobr>最高分       </th>   
            <th align="center" class="blue" width="30%" ><nobr>质检开始时间 </th>   
            <th align="center" class="blue" width="25%" ><nobr>质检结束时间 </th>   
            <th align="center" class="blue" width="25%" ><nobr>质检工号     </th>   
            <th align="center" class="blue" width="25%" ><nobr>被检流水号   </th>   
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this);"  >
			<%}else{%>
	   <tr onClick="changeColor('<%=tdClass%>',this);" >
	<%}%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      
    </tr>
      <% } %>
  <!--zhengjiang 20090930 
  </table>
  
  <table  cellspacing="0">
  delete width="720" add colspan="13"-->
    <tr >
      <td class="blue"  align="right" colspan="13">
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


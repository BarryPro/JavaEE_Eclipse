
<%
  /*
   * 功能: 临时保存考评结果列表
　 * 版本: 1.0.0
　 * 日期: 2008/12/12
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K206";
	String opName = "临时保存考评结果列表";
%>

<%@page contentType="text/html;charset=GBK"%>
<!--modify by zhengjiang 20090927 public_title_ajax.jsp改为public_title_name.jsp-->
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
//String evterno = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));
String evterno = WtcUtil.repNull((String)session.getAttribute("workNo"));
String [][] queryList = new String[][]{};
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
%>
<%
//首先判断一下是否有结果，如有在执行查询结果。以提高效率。
String sqlCount = "select to_char(count(*)) from dqcinfo t1 where t1.flag='0' and t1.evterno='" + evterno
				 + "' and t1.is_del != 'Y' ";
myParams = "evterno=" + evterno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
<wtc:param value="<%=sqlCount%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="countList" scope="end"/>
<%
if(countList.length>0&&Integer.parseInt(countList[0][0])>0){
/*---------------获得临时保存考评结果列表开始-------------------*/
    String sqlStr = "select "          
                   +"t1.serialnum,     " //流水号
                   +"t1.recordernum,   " //被检流水号
                   +"t1.staffno,       " //被检工号
                   +"t3.object_name,   " //被检对象
                   +"t4.name,          " //考评内容
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //质检开始时间 
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //质检结束时间
                   +"to_char(t1.score),         " //总得分 
                   +"t1.objectid,         " //被检对象ID 
                   +"t1.contentid,         " //考评对象ID
                   +"t1.outplanflag         " //计划内、外质检标识                   
                   +"from dqcinfo t1,dqcobject t3,dqccheckcontect t4 ";
		String strJoinSql = " where t1.flag='0' and t1.evterno=:evterno " 
											+ " and t1.is_del != 'Y' "  
	                    + " and t1.objectid=t3.object_id(+) "                                                   
                      + " and t1.contentid=t4.contect_id(+) " 
                      + " and t1.objectid=t4.object_id(+) " ;
    String strOrderSql = " order by t1.starttime desc ";
    myParams = "evterno=" + evterno;
    sqlStr += strJoinSql;
    sqlStr += strOrderSql;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryTempList" scope="end"/>
<%
  queryList=queryTempList;
}
/*---------------获得临时保存考评结果列表结束-------------------*/
%>

<html>
<head>
<title>临时保存考评结果列表</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<!--modify by zhengjiang 20090927
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
-->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
/**
  *
  *为隐藏域赋值
  *
  */
function getCheckItem(serialnum,object_id,content_id,isOutPlanflag){
    window.sitechform.content_id.value=content_id;
    window.sitechform.object_id.value=object_id;
    window.sitechform.serialnum.value=serialnum;
    window.sitechform.isOutPlanflag.value=isOutPlanflag;
}

//判断是否选择了考评项
function doSubmitCheck(){
		var radio_check_content=document.getElementsByName("check_content");
		var flag="false";
		for(var i=0;i<radio_check_content.length;i++){
			  if(radio_check_content[i].checked==true)
			   {
			      doSubmit();
			      flag="true";
			      break;
			   }     
		}
		if(flag=="false"){
				similarMSNPop("请选择临时考评结果！");
		}
}

function doSubmit(){
		var planflag=window.sitechform.isOutPlanflag.value;
		var content_id=window.sitechform.content_id.value;
		var object_id=window.sitechform.object_id.value;
		var serialnum=window.sitechform.serialnum.value;
		var isOutPlanflag=window.sitechform.isOutPlanflag.value;	
		//updated by tangsong 20100525 修正两颗树问题
		//var  path="../callbosspage/checkWork/K214/K214_modify_plan_qc_main.jsp";
		var  path="../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp";
		path = path + "?content_id=" + content_id;
		path = path + "&object_id=" + object_id
		path = path + "&serialnum=" + serialnum;
		path = path + "&isOutPlanflag=" + isOutPlanflag;
		path = path + "&isAdjust=K206";  
		path = path + "&staffno=" + "<%=(queryList.length>0)?queryList[0][2]:""%>";  
		if(isOutPlanflag=='1'){
				path = path + "&opCode=K206&opName=质检结果整理-对流水质检";
		}else{
				path = path + "&opCode=K206&opName=质检结果整理-计划外质检";
		}
		var opCode='<%=opCode%>';	
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		var tabId = opCode+serialnum;
		
		//zengzq start 090520
		//增加选择，在同一时间只能打开一个质检操作窗口（计划内，计划外，临时保存，修改，复核窗口）
		/*var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K206' == partElement){
								similarMSNPop("已打开一个质检操作窗口！");
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("已打开一个质检操作窗口！");
						return false;
				}
		}
		*/
		//zengzq end 
		
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
			  parent.parent.addTab(true,tabId,'质检操作',path);
		}else{
				similarMSNPop("此流水质检窗口已打开！");
		}
		return true;
}

//选中行高亮显示
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色

/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
function changeColor(color,obj,rdo){
	document.getElementById(rdo).click();
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

<body>
<form  name="sitechform">
<!--
<%@ include file="/npage/include/header.jsp"%>
-->

<!--modify by zhengjiang 20090927 增加<div id="title_zi"></div> -->

<!--table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
		<td id="footer"  align="right">
			<div class="title"><div id="title_zi">临时保存考评结果</div></div>
		</td>
</tr>
</table-->

<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
			<td id="footer"  align="right" colspan='9'>
				<div class="title"><div id="title_zi">临时保存考评结果</div></div>
			</td>
			</tr>
      <tr>
        <th class="blue" nowrap >选择        </th>      
        <th class="blue" nowrap >流水号</th>
        <th class="blue" nowrap >被检流水号</th>
        <th class="blue" nowrap >被检工号    </th>
        <th class="blue" nowrap >被检对象    </th>
        <th class="blue" nowrap >考评内容    </th>
        <th class="blue" nowrap >质检开始时间</th>
        <th class="blue" nowrap >质检结束时间</th>
        <th class="blue" nowrap >总得分      </th>
      </tr>               
                          
<%
			String tdClass="blue";
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){
%>
	      <tr onClick="changeColor('<%=tdClass%>',this,'rdo<%=i%>');" >
	        <td class="<%=tdClass%>" nowrap ><input type="radio" name="check_content" id="rdo<%=i%>" onclick="getCheckItem('<%=queryList[i][0]%>','<%=queryList[i][8]%>','<%=queryList[i][9]%>','<%=queryList[i][10]%>');" value=""/></td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][0]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][1]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][2]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][3]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][4]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][5]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][6]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][7]%>&nbsp;</td>        
      	</tr>
<%
      	}
     }
%>
      </table>
    <br>
    </td>
  </tr>
  <tr>
  <td colspan="8" align="right" id="footer" style="width:420px">
   <input name="add" type="button"  id="add" class="b_foot" value="确定" onClick="doSubmitCheck();return false;">
   <input name="cancle" type="button"  id="cancle"  class="b_foot" value="刷新" onClick="history.go(0);">
  </td>
</tr>
</table>
</div>
<input type="hidden" name="content_id"    value="">
<input type="hidden" name="object_id"     value="">
<input type="hidden" name="serialnum"     value="">
<input type="hidden" name="isOutPlanflag" value="">
</FORM>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</BODY>
</HTML>
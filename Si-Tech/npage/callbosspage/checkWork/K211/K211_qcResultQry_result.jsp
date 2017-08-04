<%
  /*
	* 功能: 质检结果查询
	* 版本: 1.0
	* 日期: 2008/11/10
	* 作者: hanjc
	* 版权: sitech
	* update: mixh 20090807  CSS样式剔除
	* update: mixh 20090811  修改时间选择
	* update: mixh 20090813  修改查询逻辑，优化sql语句
	* update: mixh 20090816  删除cur、all执行逻辑
	* update: tangsong 2011/06/10 实现动态评语
	* update: chentx 20110811 增加考评类别（全部、事后质检、实时质检）查询条件
	* update: lipf 20120518   拆分原jsp，增加查询等待提示语
	* update: liuhaoa 20120820 添加居家座席标识
	*/
 %>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>

<%
	String opCode="K211";
	String opName="质检查询-质检结果查询";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String isHWY = "N";
	String[] powerCodeArr = sysRoles.split(",");
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j = 0; j < HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isHWY = "Y";
				break;
			}
		}
	}

	String start_date       = request.getParameter("start_date");
	String end_date         = request.getParameter("end_date");
	String beQcObjId        = request.getParameter("beQcObjId");
	String errorlevelid     = request.getParameter("errorlevelid");
	String errorlevelName   = request.getParameter("errorlevelName");
	String evterno          = request.getParameter("evterno");
	String staffno          = request.getParameter("staffno");
	String recordernum      = request.getParameter("recordernum");
	String flag          = request.getParameter("flag");
	String outplanflag   = request.getParameter("outplanflag");
	//zengzq add 增加查询条件 单人考评还是多人考评
	String group_flag   = request.getParameter("group_flag");
	String checkflag     = request.getParameter("checkflag");
	String qcGroupId     = request.getParameter("qcGroupId");
	String beQcGroupId   = request.getParameter("beQcGroupId");
	String qcGroupName   = request.getParameter("qcGroupName");
	String beQcGroupName = request.getParameter("beQcGroupName");
	String beQcObjName   = request.getParameter("beQcObjName");
	
	
	//add wanghong 20110802 技能队列
  String skill_quence=request.getParameter("skill_quence");
  
	String accept_long_begin = request.getParameter("accept_long_begin");
	String accept_long_end = request.getParameter("accept_long_end");

	//added by tangsong 20100526 增加查询条件:来电号码、客户级别、被加分的考评项、被扣分的考评项
	String callerphone = request.getParameter("callerphone");
	String usertype = request.getParameter("usertype");
	String itemAndLevel = request.getParameter("itemAndLevel");

	//added by tangsong 20110224 增加客户满意度查询条件
	String statisfy = request.getParameter("statisfy");
	
	//added by lipf 20120817 客户满意度多选
	String statisfyId = request.getParameter("statisfyId");

	//added by tangsong 20100531 增加排序功能
	String orderColumn = request.getParameter("orderColumn");
	String orderCode = request.getParameter("orderCode");

	//added by tangsong 20110413 结果树(根据考评项及其等级查询)
	String rs_itemId = request.getParameter("rs_itemId");
	String rs_objectId = request.getParameter("rs_objectId");
	String rs_contentId = request.getParameter("rs_contentId");
	String rs_levelId = request.getParameter("rs_levelId");
	
	//add by tangsong 20110617 质检计划
	String plan_names = request.getParameter("plan_names");
	String plan_ids = request.getParameter("plan_ids");
	
	//add by liuhaoa 20120815 居家座席
	String SteatOCHome = request.getParameter("SteatOCHome");


	//选择类评语
	String chooseCommentItemName = WtcUtil.repNull(request.getParameter("chooseCommentItemName"));
	String choose_column1 = WtcUtil.repNull(request.getParameter("choose_column1"));
	String choose_column2 = WtcUtil.repNull(request.getParameter("choose_column2"));
	String choose_column3 = WtcUtil.repNull(request.getParameter("choose_column3"));
	String choose_column4 = WtcUtil.repNull(request.getParameter("choose_column4"));
	String choose_column5 = WtcUtil.repNull(request.getParameter("choose_column5"));
	String choose_column6 = WtcUtil.repNull(request.getParameter("choose_column6"));
	String choose_column7 = WtcUtil.repNull(request.getParameter("choose_column7"));
	String choose_column8 = WtcUtil.repNull(request.getParameter("choose_column8"));
	String choose_column9 = WtcUtil.repNull(request.getParameter("choose_column9"));
	String choose_column10 = WtcUtil.repNull(request.getParameter("choose_column10"));
	//手工输入类评语
	String inputCommentItemName = WtcUtil.repNull(request.getParameter("inputCommentItemName"));
	String input_column1 = WtcUtil.repNull(request.getParameter("input_column1"));
	String input_column2 = WtcUtil.repNull(request.getParameter("input_column2"));
	String input_column3 = WtcUtil.repNull(request.getParameter("input_column3"));
	String input_column4 = WtcUtil.repNull(request.getParameter("input_column4"));
	String input_column5 = WtcUtil.repNull(request.getParameter("input_column5"));
	String input_column6 = WtcUtil.repNull(request.getParameter("input_column6"));
	String input_column7 = WtcUtil.repNull(request.getParameter("input_column7"));
	String input_column8 = WtcUtil.repNull(request.getParameter("input_column8"));
	String input_column9 = WtcUtil.repNull(request.getParameter("input_column9"));
	String input_column10 = WtcUtil.repNull(request.getParameter("input_column10"));
	//考评方式
	String plankind = request.getParameter("plankind");
	//考评类别 add by chentx20110811
	String plantype = request.getParameter("plantype");
	String[][] dataRows  = new String[][]{};
	HashMap pMap=new HashMap();
	pMap.put("start_date", start_date);
	pMap.put("end_date", end_date);
	pMap.put("beQcObjId", beQcObjId);
	pMap.put("errorlevelid", errorlevelid);
	pMap.put("evterno", evterno);
	pMap.put("staffno", staffno);
	pMap.put("recordernum", recordernum);
	pMap.put("flag", flag);
	pMap.put("outplanflag", outplanflag);
	pMap.put("group_flag", group_flag);
	pMap.put("checkflag", checkflag);
	pMap.put("qcGroupId", qcGroupId);
	pMap.put("beQcGroupId", beQcGroupId);
	pMap.put("accept_long_begin", accept_long_begin);
	pMap.put("accept_long_end", accept_long_end);
	pMap.put("callerphone",callerphone);
	pMap.put("usertype",usertype);
	pMap.put("statisfy",statisfy);
	//added by lipf 20120817 客户满意度多选
	pMap.put("statisfyId",statisfyId);
	pMap.put("orderColumn",orderColumn);
	pMap.put("orderCode",orderCode);
	pMap.put("rs_itemId",rs_itemId);
	pMap.put("rs_objectId",rs_objectId);
	pMap.put("rs_contentId",rs_contentId);
	pMap.put("rs_levelId",rs_levelId);
	pMap.put("plan_ids",plan_ids);
	pMap.put("skill_quence",skill_quence);
	pMap.put("SteatOCHome",SteatOCHome);  //居家座席
	//选择类评语
	pMap.put("choose_column1", choose_column1);
	pMap.put("choose_column2", choose_column2);
	pMap.put("choose_column3", choose_column3);
	pMap.put("choose_column4", choose_column4);
	pMap.put("choose_column5", choose_column5);
	pMap.put("choose_column6", choose_column6);
	pMap.put("choose_column7", choose_column7);
	pMap.put("choose_column8", choose_column8);
	pMap.put("choose_column9", choose_column9);
	pMap.put("choose_column10", choose_column10);
	pMap.put("choose_column1_arr", choose_column1.split(" "));
	pMap.put("choose_column2_arr", choose_column2.split(" "));
	pMap.put("choose_column3_arr", choose_column3.split(" "));
	pMap.put("choose_column4_arr", choose_column4.split(" "));
	pMap.put("choose_column5_arr", choose_column5.split(" "));
	pMap.put("choose_column6_arr", choose_column6.split(" "));
	pMap.put("choose_column7_arr", choose_column7.split(" "));
	pMap.put("choose_column8_arr", choose_column8.split(" "));
	pMap.put("choose_column9_arr", choose_column9.split(" "));
	pMap.put("choose_column10_arr", choose_column10.split(" "));

	//手工输入类评语
	pMap.put("input_column1", input_column1);
	pMap.put("input_column2", input_column2);
	pMap.put("input_column3", input_column3);
	pMap.put("input_column4", input_column4);
	pMap.put("input_column5", input_column5);
	pMap.put("input_column6", input_column6);
	pMap.put("input_column7", input_column7);
	pMap.put("input_column8", input_column8);
	pMap.put("input_column9", input_column9);
	pMap.put("input_column10", input_column10);
	
	//考评方式
  pMap.put("plankind",plankind);
  //考评类别 add by chentx20110811
  pMap.put("plantype",plantype);
	//added by tangsong 20100701 话务员不能查询临时保存和放弃的质检记录
	if ("Y".equals(isHWY)) {
		pMap.put("exceptFlag","('0','4')");
	}

    int rowCount   =0;              //符合查询条件的总记录数
    int pageSize   = 15;            // 每页记录数
    int pageCount  = 0;             // 总页数
    int curPage    = 0;             // 当前页码
    String strPage;                 // 跳转页码

    String strDateSql="";           //开始时间和结束时间是查询的必选条件
    String sqlFilter = request.getParameter("sqlFilter");  //sql的where条件
	  String expFlag   = request.getParameter("exp");        //导出标志：cur为导出当前页面数据；all为导出所有数据
    String action    = request.getParameter("myaction");   //查询标志：只有doload一值
	if("doLoad".equals(action)){
	    rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K211_strCountSql",pMap)).intValue();
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
        	curPage = 1;
        }else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        int start = (curPage - 1) * pageSize + 1;
			int end = curPage * pageSize;
			pMap.put("start", ""+start);
			pMap.put("end", ""+end);
			List queryList =(List)KFEjbClient.queryForList("query_K211_sqlStr",pMap);
			dataRows = getArrayFromListMap(queryList,1,58);
	}

	/***************add by tangsong 20110610 获得选择类评语项 start******************/
	String chooseCommentSql = "select t.comment_id,t.comment_name,t.column_name from dqcchoosecomment t"
											+ " where t.object_id=:object_id and t.parent_comment_id='0' and t.valid_flag='Y'"
											+ " order by t.comment_id";
	String myParams = "object_id=" + beQcObjId;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=chooseCommentSql%>" />
		<wtc:param value="<%=myParams%>" />
	</wtc:service>
	<wtc:array id="chooseComments" scope="end" />
<%
	/***************add by tangsong 20110610 获得选择类评语项 end******************/

	/***************add by tangsong 20110610 获得手工输入类评语项 start******************/
	String inputCommentSql = "select t.comment_id,t.comment_name,t.column_name from dqcinputcomment t"
											+ " where t.object_id=:object_id and t.valid_flag='Y'"
											+ " order by t.comment_id";
	myParams = "object_id="+beQcObjId;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=inputCommentSql%>" />
		<wtc:param value="<%=myParams%>" />
	</wtc:service>
	<wtc:array id="inputComments" scope="end" />
<%
	/***************add by tangsong 20110610 获得手工输入类评语项 end******************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<style>
		img{
				cursor:hand;
		}
		input{
			height: 1.6em;
			line-height: 1.6em;
			width: 10em;
			font-size: 1em;
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
		window.parent.unLoading();
	}
);

function checkElement2() {
	checkElement(this);
}
function doProcessNavcomring(packet){
	    var retType = packet.data.findValueByName("retType");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    	}else{
	    		return false;
	    	}
	    }
}

 function doLisenRecord(filepath,contact_id)
{
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		   window.top.document.getElementById("K042").click();
			 var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}
function checkCallListen(id){
		if(id==''){
		return;
		}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("contact_id",id);
	core.ajax.sendPacket(packet,doProcessGetPath,false);
	packet=null;
}
function doProcessGetPath(packet){
   var file_path = packet.data.findValueByName("file_path");
   var flag = packet.data.findValueByName("flag");
   var contact_id = packet.data.findValueByName("contact_id");
   if(flag=='Y'){
   	doLisenRecord(file_path,contact_id);
   	}else{
   	getCallListen(contact_id)	;
   	}

}
function getCallListen(id){
	if(id==''){
		return;
		}
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
}

//点击查询按钮
function submitInputCheck(orderColumn, orderCode){
    	//added by tangsong 20100531 增加排序功能
    	//begin
    	window.parent.sitechform.orderColumn.value=orderColumn;
    	window.parent.sitechform.orderCode.value=orderCode;
    	//end
    	window.parent.submitMe();
}


//居中打开窗口
function openWinMidForLoad(url,name,iHeight,iWidth){
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//导出窗口
function showExpWin(flag){
		if(flag =="all")
	{
			var rowCount ="<%=rowCount%>";
			if(rowCount>5000){
				alert("请导出5000条以内的数据！");
				return;
			}
	}
	window.parent.sitechform.page.value     = "<%=curPage%>";
	window.parent.sitechform.sqlWhere.value = "<%=sqlFilter%>";
	var path = "k211_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>&object_id=<%=beQcObjId%>";
	openWinMidForLoad(path, 'selectExpColumnWin',340,320);
}

//显示质检结果详细信息
function getQcDetail(contact_id,isPwdVer,object_id,contact_id_kf){
	var path="K211_getResultDetail.jsp";
	path = path + "?contact_id=" + contact_id + "&isPwdVer=" + isPwdVer + "&object_id=" + object_id+ "&contact_id_kf=" + contact_id_kf;
	var height = 600;
	var width  = 1000;
	var top = (screen.availHeight - height)/2;
	var left = (screen.availWidth - width)/2;
	var param = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	         'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
        window.open(path, 'detailWin', param);
	return true;
}


//显示修改质检结果详细信息
function getModDetail(serialnum,object_id){
	var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_getModRecDetail.jsp";
	path = path + "?serialnum=" + serialnum + "&object_id=" + object_id;
	window.open(path,"newwindow","height=600, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //转向网页的地址;
  //var name; //网页名称，可为空;
  //var iWidth; //弹出窗口的宽度;
  //var iHeight; //弹出窗口的高度;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}


//判断当前工号是否有该流水工号的质检计划
function checkRight(serialnum,staffno,evterno,object_id,content_id,flag,source_id){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_checkModRight_rpc.jsp","正在进行计划校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
	mypacket.data.add("staffno",staffno);
	mypacket.data.add("evterno",evterno);
	mypacket.data.add("object_id",object_id);
	mypacket.data.add("content_id",content_id);
	mypacket.data.add("flag",flag);
	mypacket.data.add("source_id",source_id);
	core.ajax.sendPacket(mypacket,doProcessCheckRight,true);
	mypacket=null;
}

function doProcessCheckRight(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var flag = packet.data.findValueByName("flag");
   var staffno = packet.data.findValueByName("staffno");
   var evterno = packet.data.findValueByName("evterno");
	var object_id = packet.data.findValueByName("object_id");
	var content_id = packet.data.findValueByName("content_id");
   var pass = packet.data.findValueByName("pass");
   var source_id = packet.data.findValueByName("source_id");
   
   //pass='Y';
   
  if(pass=='Y'){
      updateQcResult(serialnum,staffno,object_id,content_id,flag,source_id);
	}else{
		similarMSNPop("您没有修改此流水的权限！");
	}
}

/**
  *
  *弹出对质检结果修改窗口
  */
function updateQcResult(serialnum,staffno,object_id,content_id,flag,source_id){
	if(flag!='4'){
		var opCode='K214';
		var opName='质检结果修改';
		var onlinecheckFlag = "";
		if (source_id == "4") {//在线客服质检
			onlinecheckFlag = "Y";
		}
		//update by tangsong 20110613 将质检修改、整理功能集成到K217_out_plan_qc_form.jsp中
		//var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
		var path ='../callbosspage/checkWork/K217/K217_out_plan_qc_form.jsp?onlinecheckFlag='+onlinecheckFlag+'&serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
		if(!parent.parent.document.getElementById(opCode)){
			path = path+'&tabId='+opCode;
			parent.parent.addTab(true,opCode,'质检结果修改',path);
			}else{
			similarMSNPop("此质检结果修改窗口已打开！");
		}
	}else{
		similarMSNPop("无法修改已放弃的质检结果！");
	}
}

//判断当前工号是否有该流水工号的质检计划
function checkIsHavePlan(serialnum,staffno,object_id,content_id,flag,checkFlag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.parent.sitechform.start_date.value);
  mypacket.data.add("flag",flag);
  mypacket.data.add("staffno",staffno);
  mypacket.data.add("object_id",object_id);
  mypacket.data.add("content_id",content_id);
  mypacket.data.add("checkFlag",checkFlag);
  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
	mypacket=null;
}

function doProcessIsHavePlan(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var planCounts = packet.data.findValueByName("planCounts");
	var flag = packet.data.findValueByName("flag");
  var staffno = packet.data.findValueByName("staffno");
	var object_id = packet.data.findValueByName("object_id");
	var content_id = packet.data.findValueByName("content_id");
  var checkFlag = packet.data.findValueByName("checkFlag");
  if(parseInt(planCounts)>0){
    checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag);
	}else{
		similarMSNPop("您目前无该工号的复核计划！");
	}
}

/**
  *
  *弹出对质检结果复核窗口
  */
function checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag){
  if(checkFlag!='1'){
	 if(flag=='1'||flag=='2'||flag=='3'){
	  //var path = '../callbosspage/checkWork/K219/K219_check_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' + object_id + '&content_id='+content_id+'&staffno='+staffno;
	  var  path = '/npage/callbosspage/checkWork/K219/K219_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&style_flag=1';	//个人1复查
	if(!parent.parent.document.getElementById(serialnum+0)){
	parent.parent.addTab(true,serialnum+0,'质检操作',path);
  }
    //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    //window.showModalDialog(path,'质检结果复核',param);
	 }else{
	 	similarMSNPop("该流水未提交，无法进行复核！");
	 }
	}else{
		similarMSNPop("该流水已完成复核！");
	}
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

//added by tangsong 20110411 新增批量删除功能
//begin
function chooseAll(obj) {
	if (obj.checked) {
		$("input[name='deleteBox']").attr("checked","checked");
	} else {
		$("input[name='deleteBox']").attr("checked","");
	}
}

//删除质检结果
function deleteQcInfo(serialnum){
	if(rdShowConfirmDialog("你确定删除此记录么？")=='1'){
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","正在删除记录，请稍后...");
		chkPacket.data.add("serialnums", serialnum);
		core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
		chkPacket =null;
	}
}

function doProcessDeleteQcInfo(packet){
  	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("删除成功！");
		window.parent.sitechform.myaction.value="doLoad";
		keepValue();
		window.parent.sitechform.action="K211_qcResultQry_result.jsp";
		window.parent.sitechform.method='post';
		setTimeout("parent.document.sitechform.submit()",1500);
	}else{
		similarMSNPop("删除失败！");
	}
}
</script>
</head>
<body>
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->

<div id="Operation_Table">
	<table  cellSpacing="0" >
	 <input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
    <input  id="errorlevelid" name="errorlevelid" type="hidden"  value="<%=(errorlevelid==null)?"":errorlevelid%>">
    <!--添加隐藏属性的差错等级 added by liujied -->
    <input  id="errorlevelName" name="errorlevelName" type="hidden"   value="<%=(errorlevelName==null)?"":errorlevelName%>">
    <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
    <input id="beQcObjId" name="beQcObjId" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 用于排序 -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="<%=(orderColumn==null)?"":orderColumn%>">
	<input type="hidden" name="orderCode" id="orderCode" value="<%=(orderCode==null)?"":orderCode%>">
	<tr>
	<td class="blue"  align="left" colspan="<%=33+chooseComments.length+inputComments.length%>">
	<%if(pageCount!=0){%>
		第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
	<%} else{%>
	<font color="orange">当前记录为空！</font>
	<%}%>
	<%if(pageCount!=1 && pageCount!=0){%>
	<a href="#" onClick="doLoad('first');return false;">首页</a>
	<%}%>
	<%if(curPage>1){%>
	<a href="#"  onClick="doLoad('pre');return false;">上一页</a>
	<%}%>
	<%if(curPage<pageCount){%>
	<a href="#" onClick="doLoad('next');return false;">下一页</a>
	<%}%>
	<%if(pageCount>1){%>
	<a href="#" onClick="doLoad('last');return false;">尾页</a>
	<span>快速选择</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     	 </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>快速跳转</a>-->
			 <span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>
	<%}%>
	</td>
	</tr>
	<tr>
       <script>
       	var tempBool ='false';
       	//updated by tangsong 20110411 新增批量删除功能
	      	if(checkRole(K211A_RolesArr)||checkRole(K211B_RolesArr)||checkRole(K211C_RolesArr)||checkRole(K211D_RolesArr)||checkRole(K211E_RolesArr)||checkRole(K211F_RolesArr)){
	      		tempBool='true';
		      	if (checkRole(K211F_RolesArr)) {
		      		document.write('<th align="center" class="blue" width="15%" ><input type="checkbox" style="width:20px;" onclick="chooseAll(this)" title="全选" />操作</th>');
		      	} else {
		      		document.write('<th align="center" class="blue" width="15%" ><nobr> 操作 </th>');
		      	}
	      	}
        </script>
            <th align="center" class="blue" width="5%" ><nobr> 被检流水号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检工号
            	<%//added by tangosng 20100531 排序
            		if ("t1.staffno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.staffno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.staffno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.staffno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检员姓名 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检标识</th>
            <th align="center" class="blue" width="5%" ><nobr> 质检工号
            	<%//added by tangosng 20100531 排序
            		if ("t1.evterno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.evterno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.evterno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.evterno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 总得分
            	<%//added by tangosng 20100531 排序
            		if ("t1.score".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.score','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.score','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.score','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20100530 客户级别 -->
            <th align="center" class="blue" width="5%" ><nobr> 客户级别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 来电号码 </th>
            <!-- adde by tangsong 20100330 客户满意度 -->
            <th align="center" class="blue" width="5%" ><nobr> 客户满意度
            	<%//added by tangosng 20100630 排序
            		if ("t1.satisfyname".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.satisfyname','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.satisfyname','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.satisfyname','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20110415 受理时长 -->
            <th align="center" class="blue" width="5%" ><nobr> 受理时长
            	<%//added by tangosng 20100630 排序
            		if ("t1.accept_long".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.accept_long','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.accept_long','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.accept_long','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 差错等级 </th>

            <!--/////////////////////动态评语标题区域/////////////////////-->
<%
	//选择类评语标题
	for (int i = 0; i < chooseComments.length; i++) {
%>
            <th align="center" class="blue" width="5%" ><nobr> <%=chooseComments[i][1]%>
<%
		if (("t3." + chooseComments[i][2]).equals(orderColumn)) {
			if ("desc".equals(orderCode)) {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
			} else {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
			}
		} else {
			out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
		}
%>
            </th>
<%
	}

	//手工输入类评语标题
	for (int i = 0; i < inputComments.length; i++) {
%>
            <th align="center" class="blue" width="5%" ><nobr> <%=inputComments[i][1]%>
<%
		if (("t3." + inputComments[i][2]).equals(orderColumn)) {
			if ("desc".equals(orderCode)) {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
			} else {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
			}
		} else {
			out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
		}
%>
            </th>
<%
	}
%>
            <!--/////////////////////动态评语标题区域/////////////////////-->

            <th align="center" class="blue" width="5%" ><nobr> 放弃原因 </th>
            <!-- add by liuhaoa 20120820 居家座席标识 -->
            <th align="center" class="blue" width="5%" ><nobr>居家座席标识</th>
            <th align="center" class="blue" width="5%" ><nobr> 考评方式 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 来电原因 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考核类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检开始时间 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检结束时间</th>
            <th align="center" class="blue" width="5%" ><nobr> 处理时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 放音监听时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 整理时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检总时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 确认人 </th>
            <th align="center" class="blue" width="5%" ><nobr> 确认日期 </th>
            <th align="center" class="blue" width="5%" ><nobr> 复核标识 </th>
            <th align="center" class="blue" width="5%" ><nobr> 是否密码验证 </th>
            <th align="center" class="blue" width="5%" ><nobr> 是否典型案例 </th>
            <th align="center" class="blue" width="5%" ><nobr> 计划类型 </th>
            <th align="center" class="blue" width="5%" ><nobr> 计划名称 </th>
            <th align="center" class="blue" width="5%" ><nobr> 技能队列 </th>
            <th align="center" class="blue" width="5%" ><nobr> 流水号 </th>
          </tr>
          <%
          	boolean isModifyed = false;
          	String tdClass = "blue";
          	for ( int i = 0; i < dataRows.length; i++ ) {
             	if("2".equals(dataRows[i][32])){
                	isModifyed = true;
                	break;
             	}
             }
          	for ( int i = 0; i < dataRows.length; i++ ) {
          %>
			<tr onClick="changeColor('<%=tdClass%>',this);"  >
	      <script>
	   //added by tangsong 20110411 新增批量删除功能
      	if(tempBool=='true'){
      		document.write('<td align="left" class="<%=tdClass%>"  ><nobr>');
      	}
	   	if(checkRole(K211F_RolesArr)==true) {
	   		document.write('<input type="checkbox" name="deleteBox" style="width:20px;" value="\'<%=dataRows[i][0]%>\'" />');
	   	}
      	if(checkRole(K211A_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="听取录音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][26]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][1]%>\');return false;" alt="显示质检结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K211C_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkRight(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][5]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][54]%>\');return false;" alt="修改质检结果" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">&nbsp;');
       	}
				if('<%=isHWY%>' != 'Y'){
	        if(checkRole(K211D_RolesArr)==true){
	        	if(<%=isModifyed%>){
	        	  if('<%=dataRows[i][32]%>'=='2'){
	            document.write('<img style="cursor:hand" onclick="getModDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][30]%>\');return false;" alt="显示修改结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
	           }else{
	            document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	           }
	         }
	        }
     		}
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][33]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][5]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\')" alt="对该流水进行质检复核" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
      	  }
      	}
      	if(checkRole(K211F_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\')" alt="删除该条记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <%
      	//added by tangsong 话务员不能看到质检工号
      	if ("Y".equals(isHWY)) {
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> ******</td>
      <%
      	} else {
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <%
      	}
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <!-- added by tangsong 20100530 客户级别 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <!-- 电话号码 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
      <!-- added by tangsong 20100630 客户满意度 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <!-- added by tangsong 20110415 受理时长 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>

      <!--/////////////////////动态评语内容区域/////////////////////-->
<%
	//选择类评语内容
	for (int j = 0; j < chooseComments.length; j++) {
%>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][j+34].length()!=0)?dataRows[i][j+34]:"&nbsp;"%></td>
<%
	}
	//手工输入类评语内容
	for (int j = 0; j < inputComments.length; j++) {
%>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][j+44].length()!=0)?dataRows[i][j+44]:"&nbsp;"%></td>
<%
	}
%>
      <!--/////////////////////动态评语内容区域/////////////////////-->

      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <%
      	String steatOCHome = "&nbsp;";
      	String steatFlag = dataRows[i][56];
      	if(steatFlag != null && !"".equals(steatFlag)){
      		steatOCHome = "是";
      	}else{
      		steatOCHome = "否";
      	}
      %>
      <td algin="left" class="<%=tdClass%>"  > <nobr> <%=steatOCHome %></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][22].length()!=0)?dataRows[i][22]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
		<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>
		<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][28].length()!=0)?dataRows[i][28]:"&nbsp;"%></td>
		<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][29].length()!=0)?dataRows[i][29]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][55].length()!=0)?dataRows[i][55]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
    </tr>
      <% } %>

    <tr>
      <td class="blue"  align="right" colspan="<%=33+chooseComments.length+inputComments.length%>">
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
        <span>快速选择</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     	 </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>快速跳转</a>-->
			 <span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
<script language="javascript">
	
	//翻页操作
function doLoad(operateCode){
	if(operateCode=="load"){
		window.parent.sitechform.page.value = "";
	}else if(operateCode=="first"){
		window.parent.sitechform.page.value=1;
	}else if(operateCode=="pre"){
		window.parent.sitechform.page.value=<%=(curPage-1)%>;
	}else if(operateCode=="next"){
		window.parent.sitechform.page.value=<%=(curPage+1)%>;
	}else if(operateCode=="last"){
		window.parent.sitechform.page.value=<%=pageCount%>;
	}
	keepValue();
    window.parent.submitMe();
}

function keepValue(){
	window.parent.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.parent.sitechform.start_date.value="<%=start_date%>";
    window.parent.sitechform.end_date.value="<%=end_date%>";

    window.parent.sitechform.errorlevelid.value="<%=errorlevelid%>";
    window.parent.sitechform.evterno.value="<%=evterno%>";
    window.parent.sitechform.staffno.value="<%=staffno%>";
    window.parent.sitechform.recordernum.value="<%=recordernum%>";
    window.parent.sitechform.flag.value="<%=flag%>";
    window.parent.sitechform.outplanflag.value="<%=outplanflag%>";
    //zengzq add 增加考核类别判断 单人考评 多人考评 0为单人 1为多人
    window.parent.sitechform.group_flag.value="<%=group_flag%>";
    window.parent.sitechform.checkflag.value="<%=checkflag%>";
    window.parent.sitechform.qcGroupName.value="<%=qcGroupName%>";
    window.parent.sitechform.beQcGroupName.value="<%=beQcGroupName%>";
    window.parent.sitechform.beQcObjName.value="<%=beQcObjName%>";

    window.parent.sitechform.beQcObjId.value="<%=beQcObjId%>";
    window.parent.sitechform.errorlevelName.value="<%=errorlevelName%>";
    window.parent.sitechform.checkflag.value="<%=checkflag%>";
    window.parent.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.parent.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
    window.parent.sitechform.accept_long_begin.value="<%=accept_long_begin%>";
    window.parent.sitechform.accept_long_end.value="<%=accept_long_end%>";
    window.parent.sitechform.plankind.value="<%=plankind%>";
    window.parent.sitechform.plantype.value="<%=plantype%>";
}
	
	
 //跳转到指定页面
 function jumpToPage(operateCode){
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.parent.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.parent.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.parent.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
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
</script>
</body>
</html>
<%
  /*
   * 功能: 质检结果查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc
　 * 版权: sitech
   * update:	mixh 	20090807  CSS样式剔除
   * update:	mixh 	20090811  修改时间选择
   * update:    mixh    20090813  修改查询逻辑，优化sql语句
   * update:    mixh    20090816  删除cur、all执行逻辑
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

	boolean isModifyed      = false;
	String start_date       = request.getParameter("start_date");
	String end_date         = request.getParameter("end_date");
    String beQcObjId        = request.getParameter("beQcObjId");
    String errorlevelid     = request.getParameter("errorlevelid");
    String errorlevelName   = request.getParameter("errorlevelName");
    String qcobjectid       = request.getParameter("qcobjectid");
    String errorclassid     = request.getParameter("errorclassid");
    String errorclassName   = request.getParameter("errorclassName");
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
    String qcobjectName  = request.getParameter("qcobjectName");
    String qcGroupName   = request.getParameter("qcGroupName");
    String beQcGroupName = request.getParameter("beQcGroupName");
    String beQcObjName   = request.getParameter("beQcObjName");
     //added by liujied 评定原因名字及ID
    String checkreasondesc = request.getParameter("checkreasondesc");
    String checkreasonid = request.getParameter("checkreasonid");
    //end added
    
    //added by tangsong 20100526 增加查询条件:来电号码、客户级别、被加分的考评项、被扣分的考评项
    String callerphone = request.getParameter("callerphone");
   	String usertype = request.getParameter("usertype");
   	String addedScoreItem = request.getParameter("addedItem");
   	String lostScoreItem = request.getParameter("lostItem");
    
    //added by tangsong 20100531 增加排序功能
    String orderColumn = request.getParameter("orderColumn");
    String orderCode = request.getParameter("orderCode");
    
    String[][] dataRows  = new String[][]{};
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
		pMap.put("flag", flag);
		pMap.put("outplanflag", outplanflag);
		pMap.put("group_flag", group_flag);
		pMap.put("checkflag", checkflag);
		pMap.put("qcGroupId", qcGroupId);
	  pMap.put("beQcGroupId", beQcGroupId);
	  pMap.put("checkreasondesc", checkreasondesc);
	  pMap.put("callerphone",callerphone);
	  pMap.put("usertype",usertype);
	  pMap.put("addedScoreItem",addedScoreItem);
	  pMap.put("lostScoreItem",lostScoreItem);
	  pMap.put("orderColumn",orderColumn);
	  pMap.put("orderCode",orderCode);
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
        dataRows = getArrayFromListMap(queryList ,1,40);  
	}
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
	if(document.sitechform.start_date.value == ""){
   		showTip(document.sitechform.start_date,"开始时间不能为空");
    	sitechform.start_date.focus();
    }else if(document.sitechform.end_date.value == ""){
		showTip(document.sitechform.end_date,"结束时间不能为空");
    	sitechform.end_date.focus();
    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
		sitechform.end_date.focus();
    }else{
	    //added by tangsong 20100526 验证来电号码
	    //begin
	    if (document.sitechform.callerphone.value != "") {
	    	var phone = document.sitechform.callerphone.value;
	    	var re = /^[0-9]+$/;
	    	if (!re.test(phone)) {
	    		showTip(document.sitechform.callerphone,"电话号码格式不正确");
	    		sitechform.callerphone.focus();
	    		return;
	    	}
	    }
	    //end
    	hiddenTip(document.sitechform.start_date);
    	hiddenTip(document.sitechform.end_date);
    	window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
    	
    	//added by tangsong 20100531 增加排序功能
    	//begin
    	window.sitechform.orderColumn.value=orderColumn;
    	window.sitechform.orderCode.value=orderCode;
    	//end
    	submitMe();
    }
}

//提交查询操作
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K211_qcResultQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//翻页操作
function doLoad(operateCode){
	if(operateCode=="load"){
		window.sitechform.page.value = "";
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
 //document.getElementById("groupflag").value="1";	//1为多人质检结果查询
}

//导出
function expExcel(expFlag){
	document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcResultQry.jsp?exp="+expFlag;
	keepValue();
	window.sitechform.page.value=<%=curPage%>;
	document.sitechform.method='post';
	document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";

    window.sitechform.errorlevelid.value="<%=errorlevelid%>";
    window.sitechform.qcobjectid.value="<%=qcobjectid%>";
    window.sitechform.errorclassid.value="<%=errorclassid%>";
    window.sitechform.evterno.value="<%=evterno%>";
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.recordernum.value="<%=recordernum%>";
    window.sitechform.flag.value="<%=flag%>";
    window.sitechform.outplanflag.value="<%=outplanflag%>";
    //zengzq add 增加考核类别判断 单人考评 多人考评 0为单人 1为多人
    window.sitechform.group_flag.value="<%=group_flag%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";
    window.sitechform.qcGroupName.value="<%=qcGroupName%>";
    window.sitechform.beQcGroupName.value="<%=beQcGroupName%>";
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";

    window.sitechform.beQcObjId.value="<%=beQcObjId%>";
    window.sitechform.errorlevelName.value="<%=errorlevelName%>";
    window.sitechform.errorclassName.value="<%=errorclassName%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
    //add 评定原因内容 by liujied
    window.sitechform.checkreasondesc.value="<%=checkreasondesc%>";
}

//显示质检结果详细信息
function getQcDetail(contact_id,isPwdVer){
	var path="K211_getResultDetail.jsp";
	path = path + "?contact_id=" + contact_id + "&isPwdVer=" + isPwdVer;
	
	var height = 600;
	var width  = 1000;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	         'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
    window.open(path, 'detailWin', param);
	return true;
}

//显示修改质检结果详细信息
function getModDetail(contact_id,start_date,end_date){
	var path="../K213/K213_qcModifyRecQry.jsp";
	path = path + "?contact_id=" + contact_id;
	path = path + "&start_date=" + start_date;
	path = path + "&end_date=" + end_date;
	path = path + "&opCodeFlag=K211";
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    window.open(path,"结果详情","height=600, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
}

//质检内容
function getQcContentTree(){
	var path="K211_getQcContent.jsp";
  window.open(path,"选择质检内容","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//被检对象
function showObjectCheckTree(){
	var path="K211_beQcObjTree_1.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择被检对象',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcObjId = document.getElementById("beQcObjId");
		 var beQcObjName   = document.getElementById("beQcObjName");
		 var temp = returnValue.split('_');
		 beQcObjId.value = trim(temp[0]);
		 beQcObjName.value   = trim(temp[1]);
	 }
}

//质检群组
function getQcGroupTree(){
	var path="K211_qcGroTree.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择质检群组',param);
	if(typeof(returnValue) != "undefined"){
		 var qcGroupId = document.getElementById("qcGroupId");
		 var qcGroupName   = document.getElementById("qcGroupName");
		 var temp = returnValue.split('_');
		 qcGroupId.value = trim(temp[0]);
		 qcGroupName.value   = trim(temp[1]);
	 }
}

//被检群组
function getBeQcGroTree(){
	var path="K211_beQcGroTree.jsp";
	var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择被检群组',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcGroupId = document.getElementById("beQcGroupId");
		 var beQcGroupName   = document.getElementById("beQcGroupName");
		 var temp = returnValue.split('_');
		 beQcGroupId.value = trim(temp[0]);
		 beQcGroupName.value   = trim(temp[1]);
	 }
}
//业务类别改为评定原因
//差错类别、差错等级、评定原因
function getThisTree(flag,title){
	var path="fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="选择差错类别";
	}else if(flag=='250'){
		title="选择差错等级";
	}else if(flag=='270'){
		title="选择评定原因";
	}
  openWinMid(path,title,300, 250);
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
function checkRight(serialnum,staffno,evterno,object_id,content_id,flag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_checkModRight_rpc.jsp","正在进行计划校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
	mypacket.data.add("staffno",staffno);
	mypacket.data.add("evterno",evterno);
	mypacket.data.add("object_id",object_id);
	mypacket.data.add("content_id",content_id);
	mypacket.data.add("flag",flag);
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
  if(pass=='Y'){
      updateQcResult(serialnum,staffno,object_id,content_id,flag);
	}else{
			similarMSNPop("您没有修改此流水的权限！");
	}
}

/**
  *
  *弹出对质检结果修改窗口
  */
function updateQcResult(serialnum,staffno,object_id,content_id,flag){
	if(flag!='4'){
		 var opCode='K214';
		 var opName='质检结果修改';
	  var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
	  //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
	  //window.showModalDialog(path,'质检结果修改',param);

	  //zengzq start 090520
		//增加选择，在同一时间只能打开一个质检操作窗口（计划内，计划外，临时保存，修改，复核窗口）
		/*var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K216' == partElement){
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

	  if(!parent.parent.document.getElementById(opCode)){
	  	path = path+'&tabId='+opCode;
      parent.parent.addTab(true,opCode,'质检结果修改',path);
  	}else{
	  	similarMSNPop("此质检结果修改窗口已打开！");
	  	//path = path+'&tabId='+opCode+'b';
      //parent.parent.addTab(true,opCode+'b','质检操作',path);
	    //parent.parent.removeTab(opCode);
	  }
  }else{
	   similarMSNPop("无法修改已放弃的质检结果！");
  }
}


//判断当前工号是否有该流水工号的质检计划
function checkIsHavePlan(serialnum,staffno,object_id,content_id,flag,checkFlag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.sitechform.start_date.value);
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

//删除质检结果
function deleteQcInfo(serialnum,flag){
	//只有放弃的结果才可以删除
	//if(flag=='4'){
	if(rdShowConfirmDialog("你确定删除此记录么？")=='1'){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","正在删除记录，请稍后...");
	  chkPacket.data.add("serialnum", serialnum);
    core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
	  chkPacket =null;
	}
	//}else{
		//rdShowMessageDialog("您无删除记录的权限!",1);
	//}
}

function doProcessDeleteQcInfo(packet){
  var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("删除成功！");
		window.sitechform.myaction.value="doLoad";
    keepValue();
    window.sitechform.action="K211_qcResultQry.jsp";
    window.sitechform.method='post';
    setTimeout("document.sitechform.submit()",2000);
    //document.sitechform.submit();
	}else{
		similarMSNPop("删除失败！");
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


//居中打开窗口
function openWinMidForLoad(url,name,iHeight,iWidth){
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
	
//导出窗口
function showExpWin(flag){
	window.sitechform.page.value     = "<%=curPage%>";
	window.sitechform.sqlWhere.value = "<%=sqlFilter%>";
	openWinMidForLoad("k211_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>", 'selectExpColumnWin',340,320);
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

//added by tangosng 20100530 选择被加分的考评项
function getQcItemAdded(){
	var path="K211_getQcItemAdded.jsp";
	window.open(path,"newwindow","height=450, width=740,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//added by tangosng 20100530 选择被扣分的考评项
function getQcItemLost(){
	var path="K211_getQcItemLost.jsp";
	window.open(path,"newwindow","height=450, width=740,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}
</script>
</head>
<body>
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
<div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
	<table cellspacing="0" style="width:100%">
	<tr><td colspan='6' ><div class="title"><div id="title_zi">质检结果查询</div></div></td></tr>
	<tr>
	<td nowrap >开始时间</td>
	<td nowrap >
		<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);"/>
    	<img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
    	<font color="orange">*</font>
    </td>
    <td nowrap >质检群组</td>
	<td nowrap >
		<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
		<!-- <input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>"> -->
		<img onClick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<!-- comment by liujied 注释掉差错等级
	<td nowrap >差错等级</td>
	<td nowrap >
		<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
		<img onClick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	--><!-- 增加评定原因查询条件-->
		<td nowrap >评定原因</td>
	<td nowrap >
		<input  id="checkreasondesc" name="checkreasondesc" type="text" readOnly onClick=""   value="<%=(checkreasondesc==null)?"":checkreasondesc%>">
		
		<img onClick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
	<tr >
	<td nowrap >结束时间</td>
	<td nowrap >
		<input type="text" id="end_date" name ="end_date" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"/>
		<img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
	</td>
	<td nowrap >被检群组</td>
	<td nowrap >
		<input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
		<!-- <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>"> -->
		<img onClick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >差错类别</td>
	<td nowrap >
		<input  id="errorclassName" name="errorclassName" type="text" readOnly onClick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
		<!-- <input  id="errorclassid" name="errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>"> -->
		<img onClick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
</tr>
<tr>
	<td nowrap >质检内容</td>
	<td nowrap >
		<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
		<!-- <input  id="qcobjectid" name="contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>"> -->
		<img onClick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >被检对象</td>
	<td nowrap >
		<input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
		<!-- <input id="beQcObjId" name="objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>"> -->
		<img onClick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >质检工号</td>
	<td nowrap >
	<!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
		<input name ="evterno" type="text" id="evterno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(evterno==null)?"":evterno%>">
	</td>
	</tr>
	<tr>
	<td nowrap >被检工号</td>
	<td nowrap >
		<input name ="staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(staffno==null)?"":staffno%>">
	</td>
	<td nowrap >被检流水号</td>
	<td nowrap >
	<!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
		<input id="recordernum" name="recordernum" type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(recordernum==null)?"":recordernum%>">
	</td>
	<td nowrap >考核类别</td>
	<td nowrap >
		<select name="group_flag" id="group_flag" size="1"  >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(group_flag)?"selected":""%>>个人考评</option>
		<option value="1" <%="1".equals(group_flag)?"selected":""%>>团体考评</option>
		</select>
	</td>
</tr>
	<tr>
	<td nowrap >质检标识</td>
	<td nowrap >
		<select name="flag" id="flag" size="1" >
		<option value="" selected >5-全部</option>
		<option value="0" <%="0".equals(flag)?"selected":""%>>0-临时保存</option>
		<option value="1" <%="1".equals(flag)?"selected":""%>>1-已提交</option>
		<option value="2" <%="2".equals(flag)?"selected":""%>>2-已提交已修改</option>
		<option value="3" <%="3".equals(flag)?"selected":""%>>3-已确认</option>
		<option value="4" <%="4".equals(flag)?"selected":""%>>4-放弃</option>
		</select>
	</td>
	<td nowrap >计划类型</td>
	<td nowrap >
		<select name="outplanflag" id="outplanflag" size="1" >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-计划内质检</option>
		<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-计划外质检</option>
		</select>
	</td>
	<td nowrap >复核标识</td>
	<td nowrap >
		<select name="checkflag" id="checkflag" size="1" >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-未复核</option>
		<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-已复核</option>
		</select>
	</td>
	<!--td>计算等级</td>
	<td>
		<select name="calLevel" id="calLevel" size="1"  >
		<option value="" >--所有计算等级--</option>
		</select>
	</td-->
	</tr>
	
	<!-- added by tangsong 20100526 增加查询条件-->
	<tr>
		<td nowrap >来电号码</td>
		<td nowrap >
			<input id="callerphone" name="callerphone" type="text" value="<%=(callerphone==null)?"":callerphone%>" />
		</td>
		<td nowrap >客户级别</td>
		<td nowrap >
			<%
			String orgCode = (String)session.getAttribute("orgCode");
			String regionCode = orgCode.substring(0,2);
			%>
		  <select name="" id="" onchange="usertype.value=this.options[this.selectedIndex].value">
		  	<option value="">--所有客户级别--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" value="<%=usertype%>">
					<wtc:sql>select user_class_id , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
				</wtc:qoption>
      </select>
			<input name="usertype" type="hidden" value="<%=(usertype==null)?"":usertype%>" />
		</td>
		<td nowrap colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td nowrap >被加分的考评项</td>
		<td nowrap >
    	<input id="addedItem" name="addedItem" type="text" value="<%=(addedScoreItem==null)?"":addedScoreItem%>" />
      <img onclick="getQcItemAdded()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		</td>
		<td nowrap >被扣分的考评项</td>
		<td nowrap >
    	<input id="lostItem" name="lostItem" type="text" value="<%=(lostScoreItem==null)?"":lostScoreItem%>" />
      <img onclick="getQcItemLost()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		</td>
		<td nowrap colspan="2">&nbsp;</td>
	</tr>
	
	<!-- ICON IN THE MIDDLE OF THE PAGE-->
	<tr>
	<td colspan="6" align="center" id="footer" style="width:420px">
		<!--zhengjiang 20091004 查询与重置换位置-->
		<input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck('','');return false;">
		<input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
		<input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>

	</td>
	</tr>
	</table>
</div>

<div id="Operation_Table">
	<table  cellSpacing="0" >
		<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
    <input  id="errorlevelid" name="errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
    <!--添加隐藏属性的评定原因ID added by liujied -->
    <input  id="checkreasonid" name="checkreasonid" type="hidden"  onclick=""   value="<%=(checkreasonid==null)?"":checkreasonid%>">
    <!--添加隐藏属性的差错等级 added by liujied -->
    <input  id="errorlevelName" name="errorlevelName" type="hidden"  onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
    <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>"> 
    <input  id="errorclassid" name="errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
    <input  id="qcobjectid" name="qcobjectid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
    <input id="beQcObjId" name="beQcObjId" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 用于排序 -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="<%=(orderColumn==null)?"":orderColumn%>">
	<input type="hidden" name="orderCode" id="orderCode" value="<%=(orderCode==null)?"":orderCode%>">
	<tr>
	<td class="blue"  align="left" colspan="37">
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
	<%}%>
	</td>
	</tr>	
	<tr>
       <script>
       	var tempBool ='flase';
      	if(checkRole(K211A_RolesArr)==true||checkRole(K211B_RolesArr)==true||checkRole(K211C_RolesArr)==true||checkRole(K211D_RolesArr)==true||checkRole(K211E_RolesArr)==true||checkRole(K211F_RolesArr)==true){
      		document.write('<th align="center" class="blue" width="15%" ><nobr> 操作 </th>');
      		tempBool='true';
      	}

        </script>
            <th align="center" class="blue" width="5%" ><nobr> 被检流水号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检工号
            	<%//added by tangosng 20100531 排序
            		if ("staffno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('staffno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('staffno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('staffno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检员姓名 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检标识</th>
            <th align="center" class="blue" width="5%" ><nobr> 质检工号
            	<%//added by tangosng 20100531 排序
            		if ("evterno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('evterno','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('evterno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('evterno','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 总得分
            	<%//added by tangosng 20100531 排序
            		if ("score".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('score','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('score','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('score','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20100530 客户级别 -->
            <th align="center" class="blue" width="5%" ><nobr> 客户级别 </th>
            <!-- adde by tangsong 20100330 客户满意度 -->
            <th align="center" class="blue" width="5%" ><nobr> 客户满意度
            	<%//added by tangosng 20100630 排序
            		if ("satisfyname".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('satisfyname','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('satisfyname','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('satisfyname','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 差错类别
            	<%//added by tangosng 20100630 排序
            		if ("errorclassid".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('errorclassid','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('errorclassid','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('errorclassid','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> 差错等级 </th> 
            <th align="center" class="blue" width="5%" ><nobr> 评定原因
            	<%//added by tangosng 20100630 排序
            		if ("checkreasondesc".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('checkreasondesc','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('checkreasondesc','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('checkreasondesc','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
						<th align="center" class="blue" width="5%" ><nobr> 总体评价</th>
            <th align="center" class="blue" width="5%" ><nobr> 内容概括 </th>
            <th align="center" class="blue" width="5%" ><nobr> 处理情况</th>
            <th align="center" class="blue" width="5%" ><nobr> 改进建议 </th>
            <th align="center" class="blue" width="5%" ><nobr> 放弃原因 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评方式 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 业务类别 </th>
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
            <th align="center" class="blue" width="5%" ><nobr> 被检对象 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评内容 </th>
            <th align="center" class="blue" width="5%" ><nobr> 计划类型 </th>
            <th align="center" class="blue" width="5%" ><nobr> 计划名称 </th>
            <th align="center" class="blue" width="5%" ><nobr> 流水号 </th>
          </tr>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
                if("2".equals(dataRows[i][33])&&!"3".equals(dataRows[i][33])){
                  isModifyed = true;
                }
             }%>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this);" >
			<%}else{%>
	   <tr onClick="changeColor('<%=tdClass%>',this);"  >
	<%}%>
	      <script>
      	if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>"  ><nobr>');
      	}
      	if(checkRole(K211A_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="听取录音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][30]%>\');return false;" alt="显示质检结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K211C_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkRight(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][6]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\');return false;" alt="修改质检结果" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">&nbsp;');
       	}
        if(checkRole(K211D_RolesArr)==true){
        	if('<%=isModifyed%>'=='true'){
        	  if('<%=dataRows[i][33]%>'=='2'&&'<%=dataRows[i][33]%>'!='3'){
            document.write('<img style="cursor:hand" onclick="getModDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][20]%>\',\'<%=dataRows[i][21]%>\');return false;" alt="显示修改结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
           }else{
            document.write('&nbsp; &nbsp;');
           }
         }
        }
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][34]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][6]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\',\'<%=dataRows[i][34]%>\')" alt="对该流水进行质检复核" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp; &nbsp;&nbsp;');
      	  }
      	}
      	if(checkRole(K211F_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][33]%>\')" alt="删除该条记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--
	    <td align="center" class="<%=tdClass%>"  >
       <img style="cursor:hand" onclick="checkCallListen('<%=dataRows[i][1]%>');return false;" alt="听取录音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="getQcDetail('<%=dataRows[i][0]%>');return false;" alt="显示质检结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="updateQcResult('<%=dataRows[i][0]%>','<%=dataRows[i][2]%>','<%=dataRows[i][31]%>','<%=dataRows[i][32]%>','<%=dataRows[i][33]%>');return false;" alt="修改质检结果" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="deleteQcInfo('<%=dataRows[i][0]%>','<%=dataRows[i][33]%>')" alt="删除该条记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">
      </td>
      -->
      
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>                                                                                       
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>                                                                                             
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <%
      	//added by tangsong 话务员不能看到质检工号
      	if ("Y".equals(isHWY)) {
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> ******</td>
      <%
      	} else {
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <%
      	}
      %>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>

      <!-- adde by tangsong 20100530 客户级别 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][38].length()!=0)?dataRows[i][38]:"&nbsp;"%></td>
      <!-- adde by tangsong 20100630 客户满意度 -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][39].length()!=0)?dataRows[i][39]:"&nbsp;"%></td>
      
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][36].length()!=0)?dataRows[i][36]:"&nbsp;"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][29].length()!=0)?dataRows[i][29]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][35].length()!=0)?dataRows[i][35]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"0"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][22].length()!=0)?dataRows[i][22]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][28].length()!=0)?dataRows[i][28]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][30].length()!=0)?dataRows[i][30]:"否"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=("01".equals(dataRows[i][37]))?"是":"否"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"0"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
    </tr>
      <% } %>
      
    <tr>
      <td class="blue"  align="right" colspan="37">
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
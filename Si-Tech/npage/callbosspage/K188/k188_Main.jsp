<%
  /*
   * 功能: 已删除质检结果查询
　 * 版本: 1.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>

<%
	String opCode="K211";
	String opName="质检查询-已删除质检结果查询";

	boolean isModifyed      = false;
	String start_date       = request.getParameter("start_date");
	String end_date         = request.getParameter("end_date");
    String beQcObjId        = request.getParameter("0_=_t1.objectid");
    String errorlevelid     = request.getParameter("2_Str_t1.errorlevelid");
    String errorlevelName   = request.getParameter("errorlevelName");
    String qcobjectid       = request.getParameter("3_=_t1.contentid");
    String errorclassid     = request.getParameter("5_Str_t1.errorclassid");
    String errorclassName   = request.getParameter("errorclassName");
    String evterno          = request.getParameter("6_=_t1.evterno");
    String staffno          = request.getParameter("7_=_t1.staffno");
    String recordernum      = request.getParameter("8_=_t1.recordernum");
    String qcserviceclassid = request.getParameter("9_Str_t1.qcserviceclassid");
    String qcserviceclassName = request.getParameter("qcserviceclassName");
    String flag          = request.getParameter("10_=_t1.flag");
    String outplanflag   = request.getParameter("11_=_t1.outplanflag");
    String checkflag     = request.getParameter("12_<>_t1.checkflag");
    String qcGroupId     = request.getParameter("qcGroupId");
    String beQcGroupId   = request.getParameter("beQcGroupId");
    String qcobjectName  = request.getParameter("qcobjectName");
    String qcGroupName   = request.getParameter("qcGroupName");
    String beQcGroupName = request.getParameter("beQcGroupName");
    String beQcObjName   = request.getParameter("beQcObjName");
    String[][] dataRows  = new String[][]{};

    int rowCount   =0;              //符合查询条件的总记录数
    int pageSize   = 15;            // 每页记录数
    int pageCount  = 0;             // 总页数
    int curPage    = 0;             // 当前页码
    String strPage;                 // 跳转页码

    String strDateSql="";           //开始时间和结束时间是查询的必选条件
    String sqlFilter = request.getParameter("sqlFilter");  //sql的where条件
	String expFlag   = request.getParameter("exp");        //导出标志：cur为导出当前页面数据；all为导出所有数据
    String action    = request.getParameter("myaction");   //查询标志：只有doload一值
    String[] strHead= {"流水号","被检流水号","被检工号","被检员姓名","员工批次","被检对象","质检标识",
                       "质检工号","考评内容","总得分","计划类型","等级","差错类别","差错等级","内容概括",
                       "处理情况","改进建议","放弃原因","考评方式","考评类别","业务类别","质检开始时间",
                       "质检结束时间","处理时长","放音监听时长","整理时长","质检总时长","确认人","确认日期","复核标识","总体评价","是否密码验证"};

	//查询条件
	if(sqlFilter == null || sqlFilter.length() == 0){
		System.out.println("here1");
	  	if(start_date!=null && end_date!=null){
			sqlFilter = "WHERE t1.starttime >= to_date('" + start_date.trim() + 
			            "','yyyymmdd hh24:mi:ss') AND t1.starttime <= to_date('"+end_date.trim()+"','yyyymmdd hh24:mi:ss') ";
    	}
    	if(qcGroupId != null && !qcGroupId.trim().equals("")){
    		sqlFilter += "AND t1.evterno IN (SELECT check_login_no FROM dqccheckgrouplogin WHERE check_group_id='"+qcGroupId+"') ";
    	}
    	if(beQcGroupId!=null&& !beQcGroupId.trim().equals("")){
    		sqlFilter += "AND t1.staffno in (SELECT login_no FROM dqclogingrouplogin WHERE login_group_id='"+beQcGroupId+"') ";
    	}
    	sqlFilter = sqlFilter + returnSql(request);
    }

    //查询语句的select部分，与strHead的顺序对应
  	String sqlStr = "SELECT t1.serialnum, t1.recordernum, t1.staffno, " +  //流水号、被检流水号、被检工号
  	                        "t1.login_name, " +
                            "'', (SELECT object_name FROM dqcobject WHERE object_id = t1.objectid), " +
                            "decode(t1.flag,'0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃')," +
                            "t1.evterno, (SELECT name FROM dqccheckcontect WHERE object_id=t1.objectid AND contect_id=t1.contentid), " +
                            "decode(to_char(t1.score),'','0',null,'0',t1.score)," //总得分
                   +"decode(to_char(t1.outplanflag),'0','计划内质检','1',' 计划外质检'),     " //计划类型
                   +"t1.contentlevelid," //等级
                   +"t1.errorclassdesc,  " //差错类别
                   +"t1.errorleveldesc,  " //差错等级
                   +"t1.contentinsum,  " //内容概括
                   +"t1.handleinfo,    " //处理情况
                   +"t1.improveadvice, " //改进建议
                   +"t1.abortreasondesc, " //放弃原因
                   +"decode(t1.kind,'0','自动分派','1','人工指定'),     " //考评方式
                   +"decode(t1.checktype,'0','实时质检','1','事后质检')," //考评类别
                   +"t1.serviceclassdesc," //业务类别
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //质检开始时间
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //质检结束时间
                   +"decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration)," //处理时长
                   +"decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration)," //放音监听时长
                   +"decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration)," //整理时长
                   +"decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration)," //质检总时长
                   +"t1.signataryid,   " //确认人
                   +"to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //确认日期
                   +"decode(t1.checkflag,'0','未复核','-1','未复核','1','已复核'),     " //复核标识
                   +"t1.commentinfo,   " //总体评价
                   +"decode(VERTIFY_PASSWD_FLAG,'Y','是','N','否','YY','是(正确)','YN','是(失败)','','否',NULL,'否'),   " //是否密码验证
                   +"t1.objectid,     " //被检对象id
                   +"t1.contentid,   " //考评内容id
                   +"t1.flag,  "
                   +"t1.checkflag, "     //复核标识id
                   +"t1.plan_id, "     //计划id
                   +"t1.GROUP_FLAG "     //是否是多人考评 0为单人考评 1为多人考评
                   +"from dqcinfo t1 ";

	String sqlJoin = " AND t1.is_del='Y' ORDER BY t1.starttime DESC";
	String sqlCount = "SELECT count(*) count FROM dqcinfo t1 ";
	sqlCount += sqlFilter + "AND t1.is_del='Y'";  //查询符合条件的记录数sql
	sqlStr   += sqlFilter + sqlJoin;              //查询符合条件的记录sql
%>

<%
	if("doLoad".equals(action)){
%>
		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=sqlCount%>"/>
		</wtc:service>
		<wtc:array id="rowCountList"  scope="end"/>
<%
		if(rowCountList.length!=0){
			rowCount = Integer.parseInt(rowCountList[0][0]);
		}
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
        	curPage = 1;
        }else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>
		<wtc:service name="s151Select" outnum="39">
		<wtc:param value="<%=querySql%>"/>
		</wtc:service>
		<wtc:array id="queryList"  start="0" length="38"   scope="end"/>
<%
		dataRows = queryList;
	}
%>
<html>
<head>
<title>已删除质检结果查询</title>
<link href="<%=request.getContextPath()%>/npage/callbosspage/css/tablestyle.css" rel="stylesheet" type="text/css"></link>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
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


//显示质检结果详细信息
function getQcDetail(contact_id,isPwdVer){
	var path="K188_getResultDetail.jsp";
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

/*判断该条流水是否能被恢复 根据话务流水和计划及计划是否是单人考评及质检员工号进行判断
1.为单人考评，若考评结果表中已经存在对应流水，计划id。则该条流水不能被恢复；
2.为多人考评，若考评结果表中已经存在对应流水，计划id，及质检员工号，则该条流水不能被恢复。
*/
	function checkIsCanRecovery(serialnum,recordernum,staffno,evterno,objectid,contentid,plan_id,group_flag){
		//若无计划id，则为计划外质检，该类型质检可以恢复
		if(rdShowConfirmDialog("你确定恢复此记录么？")=='1'){
				if(plan_id==undefined || ''==plan_id){
					beginRecovery(serialnum,recordernum,staffno,evterno,objectid,contentid,'-1');
				}
				else{
						var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K188/K188_checkRecoverable_rpc.jsp","正在进行校验，请稍候......");
						mypacket.data.add("serialnum",serialnum);
						mypacket.data.add("recordernum",recordernum);
						mypacket.data.add("staffno",staffno);
						mypacket.data.add("evterno",evterno);
						mypacket.data.add("objectid",objectid);
						mypacket.data.add("contentid",contentid);
						mypacket.data.add("plan_id",plan_id);
						mypacket.data.add("group_flag",group_flag);
						core.ajax.sendPacket(mypacket,doProcessCheckRecoverable,true);
						mypacket=null;
			}
		}
	}
	
function doProcessCheckRecoverable(packet){
	
	var serialnum = packet.data.findValueByName("serialnum");
	var recordernum = packet.data.findValueByName("recordernum");
	var staffno = packet.data.findValueByName("staffno");
	var evterno = packet.data.findValueByName("evterno");
	var objectid = packet.data.findValueByName("objectid");
	var contentid = packet.data.findValueByName("contentid");
	var plan_id = packet.data.findValueByName("plan_id");
	var returnNum = packet.data.findValueByName("returnNum");
  if(parseInt(returnNum)>0){
  		similarMSNPop("该条记录删除后已被重新质检过,或质检次数达到最大，不能恢复！");
	}else{
			beginRecovery(serialnum,recordernum,staffno,evterno,objectid,contentid,plan_id);
	}
}
//进行已删除流水的恢复操作
function beginRecovery(serialnum,recordernum,staffno,evterno,objectid,contentid,plan_id){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K188/K188_beginRecovery_rpc.jsp","正在进行校验，请稍候......");
		mypacket.data.add("serialnum",serialnum);
		mypacket.data.add("recordernum",recordernum);
		mypacket.data.add("staffno",staffno);
		mypacket.data.add("evterno",evterno);
		mypacket.data.add("objectid",objectid);
		mypacket.data.add("contentid",contentid);
		mypacket.data.add("plan_id",plan_id);
		core.ajax.sendPacket(mypacket,doProcessbeginRecovery,true);
		mypacket=null;
}

function doProcessbeginRecovery(packet){
	var retCode = packet.data.findValueByName("retCode");
  if(retCode =="000000"){
  		similarMSNPop("该条流水恢复成功！");
  		window.sitechform.myaction.value="doLoad";
	    keepValue();
	    window.sitechform.action="k188_Main.jsp";
	    window.sitechform.method='post';
	    setTimeout("document.sitechform.submit()",2000);
	}else{
			similarMSNPop("该条流水恢复失败！");
	}
}

//点击查询按钮
function submitInputCheck(){
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
    	hiddenTip(document.sitechform.start_date);
    	hiddenTip(document.sitechform.end_date);
    	window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
    	submitMe();
    }
}

//提交查询操作
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k188_Main.jsp";
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
}

//导出
/*function expExcel(expFlag){
	document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcResultQry.jsp?exp="+expFlag;
	keepValue();
	window.sitechform.page.value=<%=curPage%>;
	document.sitechform.method='post';
	document.sitechform.submit();
}
*/
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
    window.sitechform.qcserviceclassid.value="<%=qcserviceclassid%>";
    window.sitechform.flag.value="<%=flag%>";
    window.sitechform.outplanflag.value="<%=outplanflag%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";
    window.sitechform.qcGroupName.value="<%=qcGroupName%>";
    window.sitechform.beQcGroupName.value="<%=beQcGroupName%>";
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";

    window.sitechform.beQcObjId.value="<%=beQcObjId%>";
    window.sitechform.errorlevelName.value="<%=errorlevelName%>";
    window.sitechform.errorclassName.value="<%=errorclassName%>";
    window.sitechform.qcserviceclassName.value="<%=qcserviceclassName%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
}

//质检内容
function getQcContentTree(){
	var path="../checkWork/K211/K211_getQcContent.jsp";
  window.open(path,"选择质检内容","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//被检对象
function showObjectCheckTree(){
	var path="../checkWork/K211/K211_beQcObjTree_1.jsp";
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
	var path="../checkWork/K211/K211_qcGroTree.jsp";
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
	var path="../checkWork/K211/K211_beQcGroTree.jsp";
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

//差错类别、差错等级、业务类别
function getThisTree(flag,title){
	var path="../checkWork/K211/fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="选择差错类别";
	}else if(flag=='250'){
		title="选择差错等级";
	}else if(flag=='270'){
		title="选择业务类别";
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
	/*window.sitechform.page.value     = "<%=curPage%>";
	window.sitechform.sqlWhere.value = "<%=sqlFilter%>";
	openWinMidForLoad("k211_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>", 'selectExpColumnWin',340,320);
*/
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
<body>
	
<form id=sitechform name=sitechform>
<%--
<%@ include file="/npage/include/header.jsp"%>
--%>
<div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
	<div class="title"><div id="title_zi">质检结果查询</div></div>
	<table cellspacing="0" style="width:100%">
	<!-- THE FIRST LINE OF THE CONTENT -->
	<tr>
	<td>开始时间</td>
	<td>
		<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" maxlength="17" />
    	<img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
    	<font color="orange">*</font>
    </td>
    <td>质检群组</td>
	<td>
		<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
		<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
		<img onClick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>被检群组</td>
	<td>
		<input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
		<input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
		<img onClick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>差错等级</td>
	<td>
		<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
		<input  id="errorlevelid" name="2_Str_t1.errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
		<img onClick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
	<tr >
	<td>结束时间</td>
	<td>
		<input type="text" id="end_date" name ="end_date" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" maxlength="17"/>
		<img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
	</td>
	<td>质检内容</td>
	<td>
		<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
		<input  id="qcobjectid" name="3_=_t1.contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
		<img onClick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>被检对象</td>
	<td>
		<input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
		<input id="beQcObjId" name="0_=_t1.objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
		<img onClick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>差错类别</td>
	<td>
		<input  id="errorclassName" name="errorclassName" type="text" readOnly onClick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
		<input  id="errorclassid" name="5_Str_t1.errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
		<img onClick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
	<!-- THE THIRD LINE OF THE CONTENT -->
	<tr>
	<td>质检工号</td>
	<td>
		<input name ="6_=_t1.evterno" type="text" id="evterno"  maxlength="10" value="<%=(evterno==null)?"":evterno%>">
	</td>
	<td>被检工号</td>
	<td>
		<input name ="7_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
	</td>
	<td>被检流水号</td>
	<td>
		<input id="recordernum" name="8_=_t1.recordernum" type="text"  value="<%=(recordernum==null)?"":recordernum%>">
	</td>
	<td>业务类别</td>
	<td>
		<input  id="qcserviceclassName" name="qcserviceclassName" type="text" readOnly onClick=""   value="<%=(qcserviceclassName==null)?"":qcserviceclassName%>">
		<input  id="qcserviceclassid" name="9_Str_t1.qcserviceclassid" type="hidden"  onclick=""   value="<%=(qcserviceclassid==null)?"":qcserviceclassid%>">
		<img onClick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<!-- THE FOURTH LINE OF THE CONTENT -->
	<tr>
	<td>质检标识</td>
	<td>
		<select name="10_=_t1.flag" id="flag" size="1" >
		<option value="" selected >5-全部</option>
		<option value="0" <%="0".equals(flag)?"selected":""%>>0-临时保存</option>
		<option value="1" <%="1".equals(flag)?"selected":""%>>1-已提交</option>
		<option value="2" <%="2".equals(flag)?"selected":""%>>2-已提交已修改</option>
		<option value="3" <%="3".equals(flag)?"selected":""%>>3-已确认</option>
		<option value="4" <%="4".equals(flag)?"selected":""%>>4-放弃</option>
		</select>
	</td>
	<td>计划类型</td>
	<td>
		<select name="11_=_t1.outplanflag" id="outplanflag" size="1" >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-计划内质检</option>
		<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-计划外质检</option>
		</select>
	</td>
	<td>复核标识</td>
	<td>
		<select name="12_<>_t1.checkflag" id="checkflag" size="1" >
		<option value="" selected >2-全部</option>
		<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-未复核</option>
		<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-已复核</option>
		</select>
	</td>
	<td>计算等级</td>
	<td>
		<select name="calLevel" id="calLevel" size="1"  >
		<option value="" >--所有计算等级--</option>
		</select>
	</td>
	</tr>
	<!-- ICON IN THE MIDDLE OF THE PAGE-->
	<tr>
	<td colspan="8" align="center" id="footer" style="width:420px">
		<input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;">
		<input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
		
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
	<tr>
	<td class="blue"  align="left" colspan="33">
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
            <th align="center" class="blue" width="5%" ><nobr> 流水号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检流水号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检工号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检员姓名 </th>
            <th align="center" class="blue" width="5%" ><nobr> 员工批次 </th>
            <th align="center" class="blue" width="5%" ><nobr> 被检对象 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检标识</th>
            <th align="center" class="blue" width="5%" ><nobr> 质检工号 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评内容 </th>
            <th align="center" class="blue" width="5%" ><nobr> 总得分 </th>
            <th align="center" class="blue" width="5%" ><nobr> 计划类型 </th>
            <th align="center" class="blue" width="5%" ><nobr> 等级 </th>
            <th align="center" class="blue" width="5%" ><nobr> 差错类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 差错等级 </th>
            <th align="center" class="blue" width="5%" ><nobr> 内容概括 </th>
            <th align="center" class="blue" width="5%" ><nobr> 处理情况</th>
            <th align="center" class="blue" width="5%" ><nobr> 改进建议 </th>
            <th align="center" class="blue" width="5%" ><nobr> 放弃原因 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评方式 </th>
            <th align="center" class="blue" width="5%" ><nobr> 考评类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 业务类别 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检开始时间 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检结束时间</th>
            <th align="center" class="blue" width="5%" ><nobr> 处理时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 放音监听时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 整理时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 质检总时长 </th>
            <th align="center" class="blue" width="5%" ><nobr> 确认人 </th>
            <th align="center" class="blue" width="5%" ><nobr> 确认日期 </th>
            <th align="center" class="blue" width="5%" ><nobr> 复核标识 </th>
            <th align="center" class="blue" width="5%" ><nobr> 总体评价 </th>
            <th align="center" class="blue" width="5%" ><nobr> 是否密码验证 </th>
          </tr>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
                if("2".equals(dataRows[i][34])&&!"3".equals(dataRows[i][34])){
                  isModifyed = true;
                }
             }%>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this);"  >
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
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][31]%>\');return false;" alt="显示质检结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][35]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsCanRecovery(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][1]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][7]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\',\'<%=dataRows[i][36]%>\',\'<%=dataRows[i][37]%>\')" alt="恢复该条质检流水" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp; &nbsp;&nbsp;');
      	  }
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <td align="center" class="<%=tdClass%>" > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>

      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>

      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>

      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"0"%></td>

      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][22].length()!=0)?dataRows[i][22]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"0"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][28].length()!=0)?dataRows[i][28]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][29].length()!=0)?dataRows[i][29]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][30].length()!=0)?dataRows[i][30]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][31].length()!=0)?dataRows[i][31]:"否"%></td>


    </tr>
      <% } %>
      
    <tr>
      <td class="blue"  align="right" colspan="33">
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
<%--
<%@ include file="/npage/include/footer.jsp"%>
--%>
</body>
</html>
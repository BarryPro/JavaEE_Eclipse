<%
  /*
	* ����: �ʼ�����ѯ
	* �汾: 1.0
	* ����: 2008/11/10
	* ����: hanjc
	* ��Ȩ: sitech
	* update: mixh 20090807  CSS��ʽ�޳�
	* update: mixh 20090811  �޸�ʱ��ѡ��
	* update: mixh 20090813  �޸Ĳ�ѯ�߼����Ż�sql���
	* update: mixh 20090816  ɾ��cur��allִ���߼�
	* update: tangsong 2011/06/10 ʵ�ֶ�̬����
	* update: chentx 20110811 ���ӿ������ȫ�����º��ʼ졢ʵʱ�ʼ죩��ѯ����
	* update: lipf 20120518   ���ԭjsp�����Ӳ�ѯ�ȴ���ʾ��
	* update: liuhaoa 20120820 ��ӾӼ���ϯ��ʶ
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
	String opName="�ʼ��ѯ-�ʼ�����ѯ";
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
	//zengzq add ���Ӳ�ѯ���� ���˿������Ƕ��˿���
	String group_flag   = request.getParameter("group_flag");
	String checkflag     = request.getParameter("checkflag");
	String qcGroupId     = request.getParameter("qcGroupId");
	String beQcGroupId   = request.getParameter("beQcGroupId");
	String qcGroupName   = request.getParameter("qcGroupName");
	String beQcGroupName = request.getParameter("beQcGroupName");
	String beQcObjName   = request.getParameter("beQcObjName");
	
	
	//add wanghong 20110802 ���ܶ���
  String skill_quence=request.getParameter("skill_quence");
  
	String accept_long_begin = request.getParameter("accept_long_begin");
	String accept_long_end = request.getParameter("accept_long_end");

	//added by tangsong 20100526 ���Ӳ�ѯ����:������롢�ͻ����𡢱��ӷֵĿ�������۷ֵĿ�����
	String callerphone = request.getParameter("callerphone");
	String usertype = request.getParameter("usertype");
	String itemAndLevel = request.getParameter("itemAndLevel");

	//added by tangsong 20110224 ���ӿͻ�����Ȳ�ѯ����
	String statisfy = request.getParameter("statisfy");
	
	//added by lipf 20120817 �ͻ�����ȶ�ѡ
	String statisfyId = request.getParameter("statisfyId");

	//added by tangsong 20100531 ����������
	String orderColumn = request.getParameter("orderColumn");
	String orderCode = request.getParameter("orderCode");

	//added by tangsong 20110413 �����(���ݿ������ȼ���ѯ)
	String rs_itemId = request.getParameter("rs_itemId");
	String rs_objectId = request.getParameter("rs_objectId");
	String rs_contentId = request.getParameter("rs_contentId");
	String rs_levelId = request.getParameter("rs_levelId");
	
	//add by tangsong 20110617 �ʼ�ƻ�
	String plan_names = request.getParameter("plan_names");
	String plan_ids = request.getParameter("plan_ids");
	
	//add by liuhaoa 20120815 �Ӽ���ϯ
	String SteatOCHome = request.getParameter("SteatOCHome");


	//ѡ��������
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
	//�ֹ�����������
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
	//������ʽ
	String plankind = request.getParameter("plankind");
	//������� add by chentx20110811
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
	//added by lipf 20120817 �ͻ�����ȶ�ѡ
	pMap.put("statisfyId",statisfyId);
	pMap.put("orderColumn",orderColumn);
	pMap.put("orderCode",orderCode);
	pMap.put("rs_itemId",rs_itemId);
	pMap.put("rs_objectId",rs_objectId);
	pMap.put("rs_contentId",rs_contentId);
	pMap.put("rs_levelId",rs_levelId);
	pMap.put("plan_ids",plan_ids);
	pMap.put("skill_quence",skill_quence);
	pMap.put("SteatOCHome",SteatOCHome);  //�Ӽ���ϯ
	//ѡ��������
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

	//�ֹ�����������
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
	
	//������ʽ
  pMap.put("plankind",plankind);
  //������� add by chentx20110811
  pMap.put("plantype",plantype);
	//added by tangsong 20100701 ����Ա���ܲ�ѯ��ʱ����ͷ������ʼ��¼
	if ("Y".equals(isHWY)) {
		pMap.put("exceptFlag","('0','4')");
	}

    int rowCount   =0;              //���ϲ�ѯ�������ܼ�¼��
    int pageSize   = 15;            // ÿҳ��¼��
    int pageCount  = 0;             // ��ҳ��
    int curPage    = 0;             // ��ǰҳ��
    String strPage;                 // ��תҳ��

    String strDateSql="";           //��ʼʱ��ͽ���ʱ���ǲ�ѯ�ı�ѡ����
    String sqlFilter = request.getParameter("sqlFilter");  //sql��where����
	  String expFlag   = request.getParameter("exp");        //������־��curΪ������ǰҳ�����ݣ�allΪ������������
    String action    = request.getParameter("myaction");   //��ѯ��־��ֻ��doloadһֵ
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

	/***************add by tangsong 20110610 ���ѡ���������� start******************/
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
	/***************add by tangsong 20110610 ���ѡ���������� end******************/

	/***************add by tangsong 20110610 ����ֹ������������� start******************/
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
	/***************add by tangsong 20110610 ����ֹ������������� end******************/
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
			 var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
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
openWinMid(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
}

//�����ѯ��ť
function submitInputCheck(orderColumn, orderCode){
    	//added by tangsong 20100531 ����������
    	//begin
    	window.parent.sitechform.orderColumn.value=orderColumn;
    	window.parent.sitechform.orderCode.value=orderCode;
    	//end
    	window.parent.submitMe();
}


//���д򿪴���
function openWinMidForLoad(url,name,iHeight,iWidth){
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;  //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//��������
function showExpWin(flag){
		if(flag =="all")
	{
			var rowCount ="<%=rowCount%>";
			if(rowCount>5000){
				alert("�뵼��5000�����ڵ����ݣ�");
				return;
			}
	}
	window.parent.sitechform.page.value     = "<%=curPage%>";
	window.parent.sitechform.sqlWhere.value = "<%=sqlFilter%>";
	var path = "k211_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>&object_id=<%=beQcObjId%>";
	openWinMidForLoad(path, 'selectExpColumnWin',340,320);
}

//��ʾ�ʼ�����ϸ��Ϣ
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


//��ʾ�޸��ʼ�����ϸ��Ϣ
function getModDetail(serialnum,object_id){
	var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_getModRecDetail.jsp";
	path = path + "?serialnum=" + serialnum + "&object_id=" + object_id;
	window.open(path,"newwindow","height=600, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ��;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}


//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
function checkRight(serialnum,staffno,evterno,object_id,content_id,flag,source_id){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_checkModRight_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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
		similarMSNPop("��û���޸Ĵ���ˮ��Ȩ�ޣ�");
	}
}

/**
  *
  *�������ʼ����޸Ĵ���
  */
function updateQcResult(serialnum,staffno,object_id,content_id,flag,source_id){
	if(flag!='4'){
		var opCode='K214';
		var opName='�ʼ����޸�';
		var onlinecheckFlag = "";
		if (source_id == "4") {//���߿ͷ��ʼ�
			onlinecheckFlag = "Y";
		}
		//update by tangsong 20110613 ���ʼ��޸ġ������ܼ��ɵ�K217_out_plan_qc_form.jsp��
		//var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
		var path ='../callbosspage/checkWork/K217/K217_out_plan_qc_form.jsp?onlinecheckFlag='+onlinecheckFlag+'&serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
		if(!parent.parent.document.getElementById(opCode)){
			path = path+'&tabId='+opCode;
			parent.parent.addTab(true,opCode,'�ʼ����޸�',path);
			}else{
			similarMSNPop("���ʼ����޸Ĵ����Ѵ򿪣�");
		}
	}else{
		similarMSNPop("�޷��޸��ѷ������ʼ�����");
	}
}

//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
function checkIsHavePlan(serialnum,staffno,object_id,content_id,flag,checkFlag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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
		similarMSNPop("��Ŀǰ�޸ù��ŵĸ��˼ƻ���");
	}
}

/**
  *
  *�������ʼ������˴���
  */
function checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag){
  if(checkFlag!='1'){
	 if(flag=='1'||flag=='2'||flag=='3'){
	  //var path = '../callbosspage/checkWork/K219/K219_check_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' + object_id + '&content_id='+content_id+'&staffno='+staffno;
	  var  path = '/npage/callbosspage/checkWork/K219/K219_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&style_flag=1';	//����1����
	if(!parent.parent.document.getElementById(serialnum+0)){
	parent.parent.addTab(true,serialnum+0,'�ʼ����',path);
  }
    //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    //window.showModalDialog(path,'�ʼ�������',param);
	 }else{
	 	similarMSNPop("����ˮδ�ύ���޷����и��ˣ�");
	 }
	}else{
		similarMSNPop("����ˮ����ɸ��ˣ�");
	}
}

//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ

/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
function changeColor(color,obj){
  //�ָ�ԭ��һ�е���ʽ
  if(hisObj != ""){
	 for(var i=0;i<hisObj.cells.length;i++){
		var tempTd=hisObj.cells.item(i);
		//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
		tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
	 }
	}
		hisObj   = obj;
		hisColor = color;
  //���õ�ǰ�е���ʽ
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; �ı��ֵ���ɫ
		tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
	}
}

//added by tangsong 20110411 ��������ɾ������
//begin
function chooseAll(obj) {
	if (obj.checked) {
		$("input[name='deleteBox']").attr("checked","checked");
	} else {
		$("input[name='deleteBox']").attr("checked","");
	}
}

//ɾ���ʼ���
function deleteQcInfo(serialnum){
	if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","����ɾ����¼�����Ժ�...");
		chkPacket.data.add("serialnums", serialnum);
		core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
		chkPacket =null;
	}
}

function doProcessDeleteQcInfo(packet){
  	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("ɾ���ɹ���");
		window.parent.sitechform.myaction.value="doLoad";
		keepValue();
		window.parent.sitechform.action="K211_qcResultQry_result.jsp";
		window.parent.sitechform.method='post';
		setTimeout("parent.document.sitechform.submit()",1500);
	}else{
		similarMSNPop("ɾ��ʧ�ܣ�");
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
    <!--����������ԵĲ��ȼ� added by liujied -->
    <input  id="errorlevelName" name="errorlevelName" type="hidden"   value="<%=(errorlevelName==null)?"":errorlevelName%>">
    <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
    <input id="beQcObjId" name="beQcObjId" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 �������� -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="<%=(orderColumn==null)?"":orderColumn%>">
	<input type="hidden" name="orderCode" id="orderCode" value="<%=(orderCode==null)?"":orderCode%>">
	<tr>
	<td class="blue"  align="left" colspan="<%=33+chooseComments.length+inputComments.length%>">
	<%if(pageCount!=0){%>
		��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
	<%} else{%>
	<font color="orange">��ǰ��¼Ϊ�գ�</font>
	<%}%>
	<%if(pageCount!=1 && pageCount!=0){%>
	<a href="#" onClick="doLoad('first');return false;">��ҳ</a>
	<%}%>
	<%if(curPage>1){%>
	<a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
	<%}%>
	<%if(curPage<pageCount){%>
	<a href="#" onClick="doLoad('next');return false;">��һҳ</a>
	<%}%>
	<%if(pageCount>1){%>
	<a href="#" onClick="doLoad('last');return false;">βҳ</a>
	<span>����ѡ��</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     	 </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>������ת</a>-->
			 <span>������ת</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=����>GO</font>
	<%}%>
	</td>
	</tr>
	<tr>
       <script>
       	var tempBool ='false';
       	//updated by tangsong 20110411 ��������ɾ������
	      	if(checkRole(K211A_RolesArr)||checkRole(K211B_RolesArr)||checkRole(K211C_RolesArr)||checkRole(K211D_RolesArr)||checkRole(K211E_RolesArr)||checkRole(K211F_RolesArr)){
	      		tempBool='true';
		      	if (checkRole(K211F_RolesArr)) {
		      		document.write('<th align="center" class="blue" width="15%" ><input type="checkbox" style="width:20px;" onclick="chooseAll(this)" title="ȫѡ" />����</th>');
		      	} else {
		      		document.write('<th align="center" class="blue" width="15%" ><nobr> ���� </th>');
		      	}
	      	}
        </script>
            <th align="center" class="blue" width="5%" ><nobr> ������ˮ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ���칤��
            	<%//added by tangosng 20100531 ����
            		if ("t1.staffno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.staffno','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.staffno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.staffno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> ����Ա���� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ��ʶ</th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ칤��
            	<%//added by tangosng 20100531 ����
            		if ("t1.evterno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.evterno','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.evterno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.evterno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> �ܵ÷�
            	<%//added by tangosng 20100531 ����
            		if ("t1.score".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.score','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.score','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.score','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20100530 �ͻ����� -->
            <th align="center" class="blue" width="5%" ><nobr> �ͻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <!-- adde by tangsong 20100330 �ͻ������ -->
            <th align="center" class="blue" width="5%" ><nobr> �ͻ������
            	<%//added by tangosng 20100630 ����
            		if ("t1.satisfyname".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.satisfyname','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.satisfyname','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.satisfyname','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20110415 ����ʱ�� -->
            <th align="center" class="blue" width="5%" ><nobr> ����ʱ��
            	<%//added by tangosng 20100630 ����
            		if ("t1.accept_long".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('t1.accept_long','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('t1.accept_long','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('t1.accept_long','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> ���ȼ� </th>

            <!--/////////////////////��̬�����������/////////////////////-->
<%
	//ѡ�����������
	for (int i = 0; i < chooseComments.length; i++) {
%>
            <th align="center" class="blue" width="5%" ><nobr> <%=chooseComments[i][1]%>
<%
		if (("t3." + chooseComments[i][2]).equals(orderColumn)) {
			if ("desc".equals(orderCode)) {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
			} else {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
			}
		} else {
			out.print("<img onclick=\"submitInputCheck('" + ("t3." + chooseComments[i][2]) + "','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
		}
%>
            </th>
<%
	}

	//�ֹ��������������
	for (int i = 0; i < inputComments.length; i++) {
%>
            <th align="center" class="blue" width="5%" ><nobr> <%=inputComments[i][1]%>
<%
		if (("t3." + inputComments[i][2]).equals(orderColumn)) {
			if ("desc".equals(orderCode)) {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
			} else {
				out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
			}
		} else {
			out.print("<img onclick=\"submitInputCheck('" + ("t3." + inputComments[i][2]) + "','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
		}
%>
            </th>
<%
	}
%>
            <!--/////////////////////��̬�����������/////////////////////-->

            <th align="center" class="blue" width="5%" ><nobr> ����ԭ�� </th>
            <!-- add by liuhaoa 20120820 �Ӽ���ϯ��ʶ -->
            <th align="center" class="blue" width="5%" ><nobr>�Ӽ���ϯ��ʶ</th>
            <th align="center" class="blue" width="5%" ><nobr> ������ʽ </th>
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> ����ԭ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ쿪ʼʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ����ʱ��</th>
            <th align="center" class="blue" width="5%" ><nobr> ����ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ��������ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ����ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ���ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ȷ���� </th>
            <th align="center" class="blue" width="5%" ><nobr> ȷ������ </th>
            <th align="center" class="blue" width="5%" ><nobr> ���˱�ʶ </th>
            <th align="center" class="blue" width="5%" ><nobr> �Ƿ�������֤ </th>
            <th align="center" class="blue" width="5%" ><nobr> �Ƿ���Ͱ��� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ƻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ƻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> ���ܶ��� </th>
            <th align="center" class="blue" width="5%" ><nobr> ��ˮ�� </th>
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
	   //added by tangsong 20110411 ��������ɾ������
      	if(tempBool=='true'){
      		document.write('<td align="left" class="<%=tdClass%>"  ><nobr>');
      	}
	   	if(checkRole(K211F_RolesArr)==true) {
	   		document.write('<input type="checkbox" name="deleteBox" style="width:20px;" value="\'<%=dataRows[i][0]%>\'" />');
	   	}
      	if(checkRole(K211A_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][26]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][1]%>\');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K211C_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkRight(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][5]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][54]%>\');return false;" alt="�޸��ʼ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">&nbsp;');
       	}
				if('<%=isHWY%>' != 'Y'){
	        if(checkRole(K211D_RolesArr)==true){
	        	if(<%=isModifyed%>){
	        	  if('<%=dataRows[i][32]%>'=='2'){
	            document.write('<img style="cursor:hand" onclick="getModDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][30]%>\');return false;" alt="��ʾ�޸Ľ����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
	           }else{
	            document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	           }
	         }
	        }
     		}
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][33]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][5]%>\',\'<%=dataRows[i][30]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\')" alt="�Ը���ˮ�����ʼ츴��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
      	  }
      	}
      	if(checkRole(K211F_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\')" alt="ɾ��������¼" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
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
      	//added by tangsong ����Ա���ܿ����ʼ칤��
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
      <!-- added by tangsong 20100530 �ͻ����� -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <!-- �绰���� -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
      <!-- added by tangsong 20100630 �ͻ������ -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <!-- added by tangsong 20110415 ����ʱ�� -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>

      <!--/////////////////////��̬������������/////////////////////-->
<%
	//ѡ������������
	for (int j = 0; j < chooseComments.length; j++) {
%>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][j+34].length()!=0)?dataRows[i][j+34]:"&nbsp;"%></td>
<%
	}
	//�ֹ���������������
	for (int j = 0; j < inputComments.length; j++) {
%>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][j+44].length()!=0)?dataRows[i][j+44]:"&nbsp;"%></td>
<%
	}
%>
      <!--/////////////////////��̬������������/////////////////////-->

      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <%
      	String steatOCHome = "&nbsp;";
      	String steatFlag = dataRows[i][56];
      	if(steatFlag != null && !"".equals(steatFlag)){
      		steatOCHome = "��";
      	}else{
      		steatOCHome = "��";
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
        ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
        <%} else{%>
        <font color="orange">��ǰ��¼Ϊ�գ�</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">��ҳ</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>
        <span>����ѡ��</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     	 </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>������ת</a>-->
			 <span>������ת</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=����>GO</font>
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
	
	//��ҳ����
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
    //zengzq add ���ӿ�������ж� ���˿��� ���˿��� 0Ϊ���� 1Ϊ����
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
	
	
 //��ת��ָ��ҳ��
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
 //ȥ��ո�;
function ltrim(s){
  return s.replace( /^\s*/, "");
}
//ȥ�ҿո�;
function rtrim(s){
return s.replace( /\s*$/, "");
}
//ȥ���ҿո�;
function trim(s){
return rtrim(ltrim(s));
}
</script>
</body>
</html>
<%
  /*
   * ����: �ʼ�����ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:	mixh 	20090807  CSS��ʽ�޳�
   * update:	mixh 	20090811  �޸�ʱ��ѡ��
   * update:    mixh    20090813  �޸Ĳ�ѯ�߼����Ż�sql���
   * update:    mixh    20090816  ɾ��cur��allִ���߼�
 ��*/
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
    //zengzq add ���Ӳ�ѯ���� ���˿������Ƕ��˿���
    String group_flag   = request.getParameter("group_flag");
    String checkflag     = request.getParameter("checkflag");
    String qcGroupId     = request.getParameter("qcGroupId");
    String beQcGroupId   = request.getParameter("beQcGroupId");
    String qcobjectName  = request.getParameter("qcobjectName");
    String qcGroupName   = request.getParameter("qcGroupName");
    String beQcGroupName = request.getParameter("beQcGroupName");
    String beQcObjName   = request.getParameter("beQcObjName");
     //added by liujied ����ԭ�����ּ�ID
    String checkreasondesc = request.getParameter("checkreasondesc");
    String checkreasonid = request.getParameter("checkreasonid");
    //end added
    
    //added by tangsong 20100526 ���Ӳ�ѯ����:������롢�ͻ����𡢱��ӷֵĿ�������۷ֵĿ�����
    String callerphone = request.getParameter("callerphone");
   	String usertype = request.getParameter("usertype");
   	String addedScoreItem = request.getParameter("addedItem");
   	String lostScoreItem = request.getParameter("lostItem");
    
    //added by tangsong 20100531 ����������
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
	if(document.sitechform.start_date.value == ""){
   		showTip(document.sitechform.start_date,"��ʼʱ�䲻��Ϊ��");
    	sitechform.start_date.focus();
    }else if(document.sitechform.end_date.value == ""){
		showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��");
    	sitechform.end_date.focus();
    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
		sitechform.end_date.focus();
    }else{
	    //added by tangsong 20100526 ��֤�������
	    //begin
	    if (document.sitechform.callerphone.value != "") {
	    	var phone = document.sitechform.callerphone.value;
	    	var re = /^[0-9]+$/;
	    	if (!re.test(phone)) {
	    		showTip(document.sitechform.callerphone,"�绰�����ʽ����ȷ");
	    		sitechform.callerphone.focus();
	    		return;
	    	}
	    }
	    //end
    	hiddenTip(document.sitechform.start_date);
    	hiddenTip(document.sitechform.end_date);
    	window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
    	
    	//added by tangsong 20100531 ����������
    	//begin
    	window.sitechform.orderColumn.value=orderColumn;
    	window.sitechform.orderCode.value=orderCode;
    	//end
    	submitMe();
    }
}

//�ύ��ѯ����
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K211_qcResultQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//��ҳ����
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
    
//�������¼
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
 //document.getElementById("groupflag").value="1";	//1Ϊ�����ʼ�����ѯ
}

//����
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
    //zengzq add ���ӿ�������ж� ���˿��� ���˿��� 0Ϊ���� 1Ϊ����
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
    //add ����ԭ������ by liujied
    window.sitechform.checkreasondesc.value="<%=checkreasondesc%>";
}

//��ʾ�ʼ�����ϸ��Ϣ
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

//��ʾ�޸��ʼ�����ϸ��Ϣ
function getModDetail(contact_id,start_date,end_date){
	var path="../K213/K213_qcModifyRecQry.jsp";
	path = path + "?contact_id=" + contact_id;
	path = path + "&start_date=" + start_date;
	path = path + "&end_date=" + end_date;
	path = path + "&opCodeFlag=K211";
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    window.open(path,"�������","height=600, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
}

//�ʼ�����
function getQcContentTree(){
	var path="K211_getQcContent.jsp";
  window.open(path,"ѡ���ʼ�����","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//�������
function showObjectCheckTree(){
	var path="K211_beQcObjTree_1.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'ѡ�񱻼����',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcObjId = document.getElementById("beQcObjId");
		 var beQcObjName   = document.getElementById("beQcObjName");
		 var temp = returnValue.split('_');
		 beQcObjId.value = trim(temp[0]);
		 beQcObjName.value   = trim(temp[1]);
	 }
}

//�ʼ�Ⱥ��
function getQcGroupTree(){
	var path="K211_qcGroTree.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'ѡ���ʼ�Ⱥ��',param);
	if(typeof(returnValue) != "undefined"){
		 var qcGroupId = document.getElementById("qcGroupId");
		 var qcGroupName   = document.getElementById("qcGroupName");
		 var temp = returnValue.split('_');
		 qcGroupId.value = trim(temp[0]);
		 qcGroupName.value   = trim(temp[1]);
	 }
}

//����Ⱥ��
function getBeQcGroTree(){
	var path="K211_beQcGroTree.jsp";
	var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'ѡ�񱻼�Ⱥ��',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcGroupId = document.getElementById("beQcGroupId");
		 var beQcGroupName   = document.getElementById("beQcGroupName");
		 var temp = returnValue.split('_');
		 beQcGroupId.value = trim(temp[0]);
		 beQcGroupName.value   = trim(temp[1]);
	 }
}
//ҵ������Ϊ����ԭ��
//�����𡢲��ȼ�������ԭ��
function getThisTree(flag,title){
	var path="fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="ѡ�������";
	}else if(flag=='250'){
		title="ѡ����ȼ�";
	}else if(flag=='270'){
		title="ѡ������ԭ��";
	}
  openWinMid(path,title,300, 250);
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
function checkRight(serialnum,staffno,evterno,object_id,content_id,flag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_checkModRight_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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
			similarMSNPop("��û���޸Ĵ���ˮ��Ȩ�ޣ�");
	}
}

/**
  *
  *�������ʼ����޸Ĵ���
  */
function updateQcResult(serialnum,staffno,object_id,content_id,flag){
	if(flag!='4'){
		 var opCode='K214';
		 var opName='�ʼ����޸�';
	  var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod' + '&opCode='+opCode+ '&opName='+opName;
	  //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
	  //window.showModalDialog(path,'�ʼ����޸�',param);

	  //zengzq start 090520
		//����ѡ����ͬһʱ��ֻ�ܴ�һ���ʼ�������ڣ��ƻ��ڣ��ƻ��⣬��ʱ���棬�޸ģ����˴��ڣ�
		/*var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K216' == partElement){
								similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");
						return false;
				}
		}
		*/
		//zengzq end

	  if(!parent.parent.document.getElementById(opCode)){
	  	path = path+'&tabId='+opCode;
      parent.parent.addTab(true,opCode,'�ʼ����޸�',path);
  	}else{
	  	similarMSNPop("���ʼ����޸Ĵ����Ѵ򿪣�");
	  	//path = path+'&tabId='+opCode+'b';
      //parent.parent.addTab(true,opCode+'b','�ʼ����',path);
	    //parent.parent.removeTab(opCode);
	  }
  }else{
	   similarMSNPop("�޷��޸��ѷ������ʼ�����");
  }
}


//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
function checkIsHavePlan(serialnum,staffno,object_id,content_id,flag,checkFlag){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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

//ɾ���ʼ���
function deleteQcInfo(serialnum,flag){
	//ֻ�з����Ľ���ſ���ɾ��
	//if(flag=='4'){
	if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","����ɾ����¼�����Ժ�...");
	  chkPacket.data.add("serialnum", serialnum);
    core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
	  chkPacket =null;
	}
	//}else{
		//rdShowMessageDialog("����ɾ����¼��Ȩ��!",1);
	//}
}

function doProcessDeleteQcInfo(packet){
  var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("ɾ���ɹ���");
		window.sitechform.myaction.value="doLoad";
    keepValue();
    window.sitechform.action="K211_qcResultQry.jsp";
    window.sitechform.method='post';
    setTimeout("document.sitechform.submit()",2000);
    //document.sitechform.submit();
	}else{
		similarMSNPop("ɾ��ʧ�ܣ�");
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


//���д򿪴���
function openWinMidForLoad(url,name,iHeight,iWidth){
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;  //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
	
//��������
function showExpWin(flag){
	window.sitechform.page.value     = "<%=curPage%>";
	window.sitechform.sqlWhere.value = "<%=sqlFilter%>";
	openWinMidForLoad("k211_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>", 'selectExpColumnWin',340,320);
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

//added by tangosng 20100530 ѡ�񱻼ӷֵĿ�����
function getQcItemAdded(){
	var path="K211_getQcItemAdded.jsp";
	window.open(path,"newwindow","height=450, width=740,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//added by tangosng 20100530 ѡ�񱻿۷ֵĿ�����
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
	<tr><td colspan='6' ><div class="title"><div id="title_zi">�ʼ�����ѯ</div></div></td></tr>
	<tr>
	<td nowrap >��ʼʱ��</td>
	<td nowrap >
		<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);"/>
    	<img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
    	<font color="orange">*</font>
    </td>
    <td nowrap >�ʼ�Ⱥ��</td>
	<td nowrap >
		<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
		<!-- <input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>"> -->
		<img onClick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<!-- comment by liujied ע�͵����ȼ�
	<td nowrap >���ȼ�</td>
	<td nowrap >
		<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
		<img onClick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	--><!-- ��������ԭ���ѯ����-->
		<td nowrap >����ԭ��</td>
	<td nowrap >
		<input  id="checkreasondesc" name="checkreasondesc" type="text" readOnly onClick=""   value="<%=(checkreasondesc==null)?"":checkreasondesc%>">
		
		<img onClick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
	<tr >
	<td nowrap >����ʱ��</td>
	<td nowrap >
		<input type="text" id="end_date" name ="end_date" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"/>
		<img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
	</td>
	<td nowrap >����Ⱥ��</td>
	<td nowrap >
		<input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
		<!-- <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>"> -->
		<img onClick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >������</td>
	<td nowrap >
		<input  id="errorclassName" name="errorclassName" type="text" readOnly onClick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
		<!-- <input  id="errorclassid" name="errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>"> -->
		<img onClick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
</tr>
<tr>
	<td nowrap >�ʼ�����</td>
	<td nowrap >
		<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
		<!-- <input  id="qcobjectid" name="contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>"> -->
		<img onClick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >�������</td>
	<td nowrap >
		<input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
		<!-- <input id="beQcObjId" name="objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>"> -->
		<img onClick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td nowrap >�ʼ칤��</td>
	<td nowrap >
	<!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
		<input name ="evterno" type="text" id="evterno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(evterno==null)?"":evterno%>">
	</td>
	</tr>
	<tr>
	<td nowrap >���칤��</td>
	<td nowrap >
		<input name ="staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(staffno==null)?"":staffno%>">
	</td>
	<td nowrap >������ˮ��</td>
	<td nowrap >
	<!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
		<input id="recordernum" name="recordernum" type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(recordernum==null)?"":recordernum%>">
	</td>
	<td nowrap >�������</td>
	<td nowrap >
		<select name="group_flag" id="group_flag" size="1"  >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(group_flag)?"selected":""%>>���˿���</option>
		<option value="1" <%="1".equals(group_flag)?"selected":""%>>���忼��</option>
		</select>
	</td>
</tr>
	<tr>
	<td nowrap >�ʼ��ʶ</td>
	<td nowrap >
		<select name="flag" id="flag" size="1" >
		<option value="" selected >5-ȫ��</option>
		<option value="0" <%="0".equals(flag)?"selected":""%>>0-��ʱ����</option>
		<option value="1" <%="1".equals(flag)?"selected":""%>>1-���ύ</option>
		<option value="2" <%="2".equals(flag)?"selected":""%>>2-���ύ���޸�</option>
		<option value="3" <%="3".equals(flag)?"selected":""%>>3-��ȷ��</option>
		<option value="4" <%="4".equals(flag)?"selected":""%>>4-����</option>
		</select>
	</td>
	<td nowrap >�ƻ�����</td>
	<td nowrap >
		<select name="outplanflag" id="outplanflag" size="1" >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-�ƻ����ʼ�</option>
		<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-�ƻ����ʼ�</option>
		</select>
	</td>
	<td nowrap >���˱�ʶ</td>
	<td nowrap >
		<select name="checkflag" id="checkflag" size="1" >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-δ����</option>
		<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-�Ѹ���</option>
		</select>
	</td>
	<!--td>����ȼ�</td>
	<td>
		<select name="calLevel" id="calLevel" size="1"  >
		<option value="" >--���м���ȼ�--</option>
		</select>
	</td-->
	</tr>
	
	<!-- added by tangsong 20100526 ���Ӳ�ѯ����-->
	<tr>
		<td nowrap >�������</td>
		<td nowrap >
			<input id="callerphone" name="callerphone" type="text" value="<%=(callerphone==null)?"":callerphone%>" />
		</td>
		<td nowrap >�ͻ�����</td>
		<td nowrap >
			<%
			String orgCode = (String)session.getAttribute("orgCode");
			String regionCode = orgCode.substring(0,2);
			%>
		  <select name="" id="" onchange="usertype.value=this.options[this.selectedIndex].value">
		  	<option value="">--���пͻ�����--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" value="<%=usertype%>">
					<wtc:sql>select user_class_id , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
				</wtc:qoption>
      </select>
			<input name="usertype" type="hidden" value="<%=(usertype==null)?"":usertype%>" />
		</td>
		<td nowrap colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td nowrap >���ӷֵĿ�����</td>
		<td nowrap >
    	<input id="addedItem" name="addedItem" type="text" value="<%=(addedScoreItem==null)?"":addedScoreItem%>" />
      <img onclick="getQcItemAdded()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		</td>
		<td nowrap >���۷ֵĿ�����</td>
		<td nowrap >
    	<input id="lostItem" name="lostItem" type="text" value="<%=(lostScoreItem==null)?"":lostScoreItem%>" />
      <img onclick="getQcItemLost()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		</td>
		<td nowrap colspan="2">&nbsp;</td>
	</tr>
	
	<!-- ICON IN THE MIDDLE OF THE PAGE-->
	<tr>
	<td colspan="6" align="center" id="footer" style="width:420px">
		<!--zhengjiang 20091004 ��ѯ�����û�λ��-->
		<input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck('','');return false;">
		<input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
		<input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>

	</td>
	</tr>
	</table>
</div>

<div id="Operation_Table">
	<table  cellSpacing="0" >
		<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
    <input  id="errorlevelid" name="errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
    <!--����������Ե�����ԭ��ID added by liujied -->
    <input  id="checkreasonid" name="checkreasonid" type="hidden"  onclick=""   value="<%=(checkreasonid==null)?"":checkreasonid%>">
    <!--����������ԵĲ��ȼ� added by liujied -->
    <input  id="errorlevelName" name="errorlevelName" type="hidden"  onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
    <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>"> 
    <input  id="errorclassid" name="errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
    <input  id="qcobjectid" name="qcobjectid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
    <input id="beQcObjId" name="beQcObjId" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 �������� -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="<%=(orderColumn==null)?"":orderColumn%>">
	<input type="hidden" name="orderCode" id="orderCode" value="<%=(orderCode==null)?"":orderCode%>">
	<tr>
	<td class="blue"  align="left" colspan="37">
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
	<%}%>
	</td>
	</tr>	
	<tr>
       <script>
       	var tempBool ='flase';
      	if(checkRole(K211A_RolesArr)==true||checkRole(K211B_RolesArr)==true||checkRole(K211C_RolesArr)==true||checkRole(K211D_RolesArr)==true||checkRole(K211E_RolesArr)==true||checkRole(K211F_RolesArr)==true){
      		document.write('<th align="center" class="blue" width="15%" ><nobr> ���� </th>');
      		tempBool='true';
      	}

        </script>
            <th align="center" class="blue" width="5%" ><nobr> ������ˮ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ���칤��
            	<%//added by tangosng 20100531 ����
            		if ("staffno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('staffno','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('staffno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('staffno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> ����Ա���� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ��ʶ</th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ칤��
            	<%//added by tangosng 20100531 ����
            		if ("evterno".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('evterno','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('evterno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('evterno','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> �ܵ÷�
            	<%//added by tangosng 20100531 ����
            		if ("score".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('score','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('score','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('score','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <!-- adde by tangsong 20100530 �ͻ����� -->
            <th align="center" class="blue" width="5%" ><nobr> �ͻ����� </th>
            <!-- adde by tangsong 20100330 �ͻ������ -->
            <th align="center" class="blue" width="5%" ><nobr> �ͻ������
            	<%//added by tangosng 20100630 ����
            		if ("satisfyname".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('satisfyname','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('satisfyname','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('satisfyname','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> ������
            	<%//added by tangosng 20100630 ����
            		if ("errorclassid".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('errorclassid','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('errorclassid','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('errorclassid','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="5%" ><nobr> ���ȼ� </th> 
            <th align="center" class="blue" width="5%" ><nobr> ����ԭ��
            	<%//added by tangosng 20100630 ����
            		if ("checkreasondesc".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('checkreasondesc','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('checkreasondesc','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('checkreasondesc','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
						<th align="center" class="blue" width="5%" ><nobr> ��������</th>
            <th align="center" class="blue" width="5%" ><nobr> ���ݸ��� </th>
            <th align="center" class="blue" width="5%" ><nobr> �������</th>
            <th align="center" class="blue" width="5%" ><nobr> �Ľ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> ����ԭ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������ʽ </th>
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> ҵ����� </th>
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
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ƻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ƻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> ��ˮ�� </th>
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
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][30]%>\');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K211C_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkRight(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][6]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\');return false;" alt="�޸��ʼ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">&nbsp;');
       	}
        if(checkRole(K211D_RolesArr)==true){
        	if('<%=isModifyed%>'=='true'){
        	  if('<%=dataRows[i][33]%>'=='2'&&'<%=dataRows[i][33]%>'!='3'){
            document.write('<img style="cursor:hand" onclick="getModDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][20]%>\',\'<%=dataRows[i][21]%>\');return false;" alt="��ʾ�޸Ľ����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
           }else{
            document.write('&nbsp; &nbsp;');
           }
         }
        }
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][34]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][6]%>\',\'<%=dataRows[i][31]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\',\'<%=dataRows[i][34]%>\')" alt="�Ը���ˮ�����ʼ츴��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp; &nbsp;&nbsp;');
      	  }
      	}
      	if(checkRole(K211F_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][33]%>\')" alt="ɾ��������¼" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--
	    <td align="center" class="<%=tdClass%>"  >
       <img style="cursor:hand" onclick="checkCallListen('<%=dataRows[i][1]%>');return false;" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="getQcDetail('<%=dataRows[i][0]%>');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="updateQcResult('<%=dataRows[i][0]%>','<%=dataRows[i][2]%>','<%=dataRows[i][31]%>','<%=dataRows[i][32]%>','<%=dataRows[i][33]%>');return false;" alt="�޸��ʼ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="deleteQcInfo('<%=dataRows[i][0]%>','<%=dataRows[i][33]%>')" alt="ɾ��������¼" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">
      </td>
      -->
      
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>                                                                                       
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>                                                                                             
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <%
      	//added by tangsong ����Ա���ܿ����ʼ칤��
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

      <!-- adde by tangsong 20100530 �ͻ����� -->
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][38].length()!=0)?dataRows[i][38]:"&nbsp;"%></td>
      <!-- adde by tangsong 20100630 �ͻ������ -->
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
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][30].length()!=0)?dataRows[i][30]:"��"%></td>
			<td align="left" class="<%=tdClass%>"  > <nobr> <%=("01".equals(dataRows[i][37]))?"��":"��"%></td>
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
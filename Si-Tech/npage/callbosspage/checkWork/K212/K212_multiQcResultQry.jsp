<%
  /*
   * ����: �����ʼ�����ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: guozw
�� * ��Ȩ: sitech
 ��*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>

<%
	String opCode="K212";
	String opName="�ʼ��ѯ-�����ʼ�����ѯ";

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

    int rowCount   =0;              //���ϲ�ѯ�������ܼ�¼��
    int pageSize   = 15;            // ÿҳ��¼��
    int pageCount  = 0;             // ��ҳ��
    int curPage    = 0;             // ��ǰҳ��
    String strPage;                 // ��תҳ��

    String strDateSql="";           //��ʼʱ��ͽ���ʱ���ǲ�ѯ�ı�ѡ����
    String sqlFilter = request.getParameter("sqlFilter");  //sql��where����
	String expFlag   = request.getParameter("exp");        //������־��curΪ������ǰҳ�����ݣ�allΪ������������
    String action    = request.getParameter("myaction");   //��ѯ��־��ֻ��doloadһֵ
    String[] strHead= {"��ˮ��","������ˮ��","���칤��","����Ա����","Ա������","�������","�ʼ��ʶ",
                       "�ʼ칤��","��������","�ܵ÷�","�ƻ�����","�ȼ�","������","���ȼ�","���ݸ���",
                       "�������","�Ľ�����","����ԭ��","������ʽ","�������","ҵ�����","�ʼ쿪ʼʱ��",
                       "�ʼ����ʱ��","����ʱ��","��������ʱ��","����ʱ��","�ʼ���ʱ��","ȷ����","ȷ������","���˱�ʶ","��������","�Ƿ�������֤"};

	//��ѯ����
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
    //��ѯ����select���֣���strHead��˳���Ӧ
  	String sqlStr = "SELECT t1.serialnum, t1.recordernum, t1.staffno, " +  //��ˮ�š�������ˮ�š����칤��
  	                        "t1.login_name, " +
                            "'', (SELECT object_name FROM dqcobject WHERE object_id = t1.objectid), " +
                            "decode(t1.flag,'0','��ʱ����','1','���ύ','2','���ύ���޸�','3','��ȷ��','4','����')," +
                            "t1.evterno, (SELECT name FROM dqccheckcontect WHERE object_id=t1.objectid AND contect_id=t1.contentid), " +
                            "decode(to_char(t1.score),'','0',null,'0',t1.score)," //�ܵ÷�
                   +"decode(to_char(t1.outplanflag),'0','�ƻ����ʼ�','1',' �ƻ����ʼ�'),     " //�ƻ�����
                   +"t1.contentlevelid," //�ȼ�
                   +"t1.errorclassdesc,  " //������
                   +"t1.errorleveldesc,  " //���ȼ�
                   +"t1.contentinsum,  " //���ݸ���
                   +"t1.handleinfo,    " //�������
                   +"t1.improveadvice, " //�Ľ�����
                   +"t1.abortreasondesc, " //����ԭ��
                   +"decode(t1.kind,'0','�Զ�����','1','�˹�ָ��'),     " //������ʽ
                   +"decode(t1.checktype,'0','ʵʱ�ʼ�','1','�º��ʼ�')," //�������
                   +"t1.serviceclassdesc," //ҵ�����
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ쿪ʼʱ��
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ����ʱ��
                   +"decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration)," //����ʱ��
                   +"decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration)," //��������ʱ��
                   +"decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration)," //����ʱ��
                   +"decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration)," //�ʼ���ʱ��
                   +"t1.signataryid,   " //ȷ����
                   +"to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //ȷ������
                   +"decode(t1.checkflag,'0','δ����','-1','δ����','1','�Ѹ���'),     " //���˱�ʶ
                   +"t1.commentinfo,   " //��������
                   +"decode(VERTIFY_PASSWD_FLAG,'Y','��','N','��','YY','��(��ȷ)','YN','��(ʧ��)','','��',NULL,'��'),   " //�Ƿ�������֤
                   +"t1.objectid,     " //�������id
                   +"t1.contentid,   " //��������id
                   +"t1.flag,  "
                   +"t1.checkflag "     //���˱�ʶid
                   +"from dqcinfo t1 ";

	String sqlJoin = " AND t1.is_del='N' ORDER BY t1.starttime DESC";
	String sqlCount = "SELECT count(*) count FROM dqcinfo t1 ";
	sqlCount += sqlFilter + "AND t1.is_del='N'";  //��ѯ���������ļ�¼��sql
	sqlStr   += sqlFilter + sqlJoin;              //��ѯ���������ļ�¼sql
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
		<wtc:service name="s151Select" outnum="37">
		<wtc:param value="<%=querySql%>"/>
		</wtc:service>
		<wtc:array id="queryList"  start="0" length="36"   scope="end"/>
<%
		dataRows = queryList;
	}
%>
<html>
<head>
<title>�����ʼ�����ѯ</title>
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
function submitInputCheck(){
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
    	hiddenTip(document.sitechform.start_date);
    	hiddenTip(document.sitechform.end_date);
    	window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
    	submitMe();
    }
}

//�ύ��ѯ����
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K212_multiQcResultQry.jsp";
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
 document.getElementById("groupflag").value="0";	//0Ϊ����֮������ѯ
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

//��ʾ�ʼ�����ϸ��Ϣ
function getQcDetail(contact_id,isPwdVer){
	var path="K212_getResultDetail.jsp";
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
  window.open(path,"�������","height=750, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
}

//�ʼ�����
function getQcContentTree(){
	var path="K212_getQcContent.jsp";
  window.open(path,"ѡ���ʼ�����","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//�������
function showObjectCheckTree(){
	var path="../K211/K211_beQcObjTree_1.jsp";
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
	var path="../K211/K211_qcGroTree.jsp";
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
	var path="../K211/K211_beQcGroTree.jsp";
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

//�����𡢲��ȼ���ҵ�����
function getThisTree(flag,title){
	var path="../K211/fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="ѡ�������";
	}else if(flag=='250'){
		title="ѡ����ȼ�";
	}else if(flag=='270'){
		title="ѡ��ҵ�����";
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
	  var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_main.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod';
	  //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
	  //window.showModalDialog(path,'�ʼ����޸�',param);

	  //zengzq start 090520
		//����ѡ����ͬһʱ��ֻ�ܴ�һ���ʼ�������ڣ��ƻ��ڣ��ƻ��⣬��ʱ���棬�޸ģ����˴��ڣ�
		var tabtag = top.document.getElementById("tabtag");
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
		//zengzq end


	  var opCode='K214';

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
	  var  path = '/npage/callbosspage/checkWork/K219/K219_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&style_flag=0';
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
    window.sitechform.action="K212_multiQcResultQry.jsp";
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
	openWinMidForLoad("k212_expSelect.jsp?flag=" + flag + "&sqlFilter=<%=sqlFilter%>", 'selectExpColumnWin',340,320);
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
</script>
</head>
<body>
<form id=sitechform name=sitechform>
<%--
<%@ include file="/npage/include/header.jsp"%>
--%>
<div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
	<div class="title"><div id="title_zi">�����ʼ�����ѯ</div></div>
	<table cellspacing="0" style="width:100%">
	<!-- THE FIRST LINE OF THE CONTENT -->
	<tr>
	<td>��ʼʱ��</td>
	<td>
		<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" maxlength="17" />
    	<img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
    	<font color="orange">*</font>
    </td>
    <td>�ʼ�Ⱥ��</td>
	<td>
		<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
		<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
		<img onClick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>����Ⱥ��</td>
	<td>
		<input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
		<input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
		<img onClick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>���ȼ�</td>
	<td>
		<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onClick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
		<input  id="errorlevelid" name="2_Str_t1.errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
		<img onClick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
	<tr >
	<td>����ʱ��</td>
	<td>
		<input type="text" id="end_date" name ="end_date" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" maxlength="17"/>
		<img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
	</td>
	<td>�ʼ�����</td>
	<td>
		<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
		<input  id="qcobjectid" name="3_=_t1.contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
		<img onClick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>�������</td>
	<td>
		<input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
		<input id="beQcObjId" name="0_=_t1.objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
		<img onClick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	<td>������</td>
	<td>
		<input  id="errorclassName" name="errorclassName" type="text" readOnly onClick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
		<input  id="errorclassid" name="5_Str_t1.errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
		<img onClick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	</td>
	</tr>
	<tr>
	<td>�ʼ칤��</td>
	<td>
		<input name ="6_=_t1.evterno" type="text" id="evterno"  maxlength="10" value="<%=(evterno==null)?"":evterno%>">
	</td>
	<td>���칤��</td>
	<td>
		<input name ="7_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
	</td>
	<td>������ˮ��</td>
	<td>
		<input id="recordernum" name="8_=_t1.recordernum" type="text"  value="<%=(recordernum==null)?"":recordernum%>">
	</td>
	<td>ҵ�����</td>
	<td>
		<input  id="qcserviceclassName" name="qcserviceclassName" type="text" readOnly onClick=""   value="<%=(qcserviceclassName==null)?"":qcserviceclassName%>">
		<input  id="qcserviceclassid" name="9_Str_t1.qcserviceclassid" type="hidden"  onclick=""   value="<%=(qcserviceclassid==null)?"":qcserviceclassid%>">
		<img onClick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<input  name="13_=_t1.group_flag" id="groupflag" type="hidden" readOnly  value="0">
	</td>
	<tr>
	<td>�ʼ��ʶ</td>
	<td>
		<select name="10_=_t1.flag" id="flag" size="1" >
		<option value="" selected >5-ȫ��</option>
		<option value="0" <%="0".equals(flag)?"selected":""%>>0-��ʱ����</option>
		<option value="1" <%="1".equals(flag)?"selected":""%>>1-���ύ</option>
		<option value="2" <%="2".equals(flag)?"selected":""%>>2-���ύ���޸�</option>
		<option value="3" <%="3".equals(flag)?"selected":""%>>3-��ȷ��</option>
		<option value="4" <%="4".equals(flag)?"selected":""%>>4-����</option>
		</select>
	</td>
	<td>�ƻ�����</td>
	<td>
		<select name="11_=_t1.outplanflag" id="outplanflag" size="1" >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-�ƻ����ʼ�</option>
		<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-�ƻ����ʼ�</option>
		</select>
	</td>
	<td>���˱�ʶ</td>
	<td>
		<select name="12_<>_t1.checkflag" id="checkflag" size="1" >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-δ����</option>
		<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-�Ѹ���</option>
		</select>
	</td>
	<td>����ȼ�</td>
	<td>
		<select name="calLevel" id="calLevel" size="1"  >
		<option value="" >--���м���ȼ�--</option>
		</select>
	</td>
	</tr>
	<tr>
	<td colspan="8" align="center" id="footer" style="width:420px">
		<input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
		<input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
		<input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
		<input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
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
            <th align="center" class="blue" width="5%" ><nobr> ��ˮ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������ˮ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ���칤�� </th>

            <th align="center" class="blue" width="5%" ><nobr> ����Ա���� </th>
            <th align="center" class="blue" width="5%" ><nobr> Ա������ </th>

            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ��ʶ</th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ칤�� </th>
            <th align="center" class="blue" width="5%" ><nobr> �������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ܵ÷� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ƻ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ȼ� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������ </th>
            <th align="center" class="blue" width="5%" ><nobr> ���ȼ� </th>
            <th align="center" class="blue" width="5%" ><nobr> ���ݸ��� </th>
            <th align="center" class="blue" width="5%" ><nobr> �������</th>
            <th align="center" class="blue" width="5%" ><nobr> �Ľ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> ����ԭ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ������ʽ </th>
            <th align="center" class="blue" width="5%" ><nobr> ������� </th>
            <th align="center" class="blue" width="5%" ><nobr> ҵ����� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ쿪ʼʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ����ʱ��</th>
            <th align="center" class="blue" width="5%" ><nobr> ����ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ��������ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ����ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> �ʼ���ʱ�� </th>
            <th align="center" class="blue" width="5%" ><nobr> ȷ���� </th>
            <th align="center" class="blue" width="5%" ><nobr> ȷ������ </th>
            <th align="center" class="blue" width="5%" ><nobr> ���˱�ʶ </th>
            <th align="center" class="blue" width="5%" ><nobr> �������� </th>
            <th align="center" class="blue" width="5%" ><nobr> �Ƿ�������֤ </th>
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
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K211B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][31]%>\');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K211C_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkRight(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\',\'<%=dataRows[i][7]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\',\'<%=dataRows[i][34]%>\');return false;" alt="�޸��ʼ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">&nbsp;');
       	}
        if(checkRole(K211D_RolesArr)==true){
        	if('<%=isModifyed%>'=='true'){
        	  if('<%=dataRows[i][34]%>'=='2'&&'<%=dataRows[i][34]%>'!='3'){
            document.write('<img style="cursor:hand" onclick="getModDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][21]%>\',\'<%=dataRows[i][22]%>\');return false;" alt="��ʾ�޸Ľ����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
           }else{
            document.write('&nbsp; &nbsp;');
           }
         }
        }
        if(checkRole(K211E_RolesArr)==true){
        	if('<%=dataRows[i][35]%>'!='1'){
      		  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][7]%>\',\'<%=dataRows[i][32]%>\',\'<%=dataRows[i][33]%>\',\'<%=dataRows[i][34]%>\',\'<%=dataRows[i][35]%>\')" alt="�Ը���ˮ�����ʼ츴��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	  }else{
      		  document.write('&nbsp; &nbsp;&nbsp;');
      	  }
      	}
      	if(checkRole(K211F_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][34]%>\')" alt="ɾ��������¼" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
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
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][31].length()!=0)?dataRows[i][31]:"��"%></td>
    </tr>
      <% } %>     
    <tr>
      <td class="blue"  align="right" colspan="33">
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
<%--
<%@ include file="/npage/include/footer.jsp"%>
--%>
</body>
</html>
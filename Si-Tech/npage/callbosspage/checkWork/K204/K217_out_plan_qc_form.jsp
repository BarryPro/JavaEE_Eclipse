<%
  /*
   * ����: �ƻ����ʼ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%!
	public  String getCurrDateStr(String str) {
		  if(str.equals("")){
		    	return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		  }else{
				 	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
							"yyyyMMdd");
				 	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		  }
	}
%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	if(opCode == null || "".equals(opCode)){
			opCode = "K217";
	}
	if(opName == null || "".equals(opName)){
			opName = "����ˮ�����ʼ�";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
/***************��ÿ���������ˮ������������ˮ��ʼ******************/
	String contect_id     = request.getParameter("content_id");
	String object_id      = request.getParameter("object_id");
	String contact_id     = request.getParameter("serialnum");//������ˮ
	String isOutPlanflag  = request.getParameter("isOutPlanflag");
	String staffno        = (String)request.getParameter("staffno");//���칤��
	String evterno        = (String)session.getAttribute("kfWorkNo");//�ʼ칤��
	String plan_id        = WtcUtil.repNull(request.getParameter("plan_id"));
	String tabId          = WtcUtil.repNull(request.getParameter("tabId"));//tabҳ���idֵ
/***************��ÿ���������ˮ������������ˮ����******************/
%>

<%
/***************����ʼ�������ʼ******************/
	String sqlGetObjectName = "SELECT object_name FROM dqcobject WHERE trim(object_id) = '" + object_id + "'";
	String objectName = "";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=sqlGetObjectName%>"/>
	</wtc:service>
	<wtc:array id="objectNames" scope="end"/>
<%
	if(objectNames.length>0){
	  	objectName = objectNames[0][0];
}
/***************����ʼ����������******************/
%> 

<%
/***************��ÿ������ݿ�ʼ******************/
	String sqlGetContentName = "SELECT name FROM dqccheckcontect WHERE trim(object_id) = '" + object_id + "' AND contect_id = '" + contect_id + "'";
	String contentName = "";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=sqlGetContentName%>"/>
	</wtc:service>
	<wtc:array id="contentNames" scope="end"/>
<%
	if(objectNames.length>0){
	  	contentName = contentNames[0][0];
	}
/***************��ÿ������ݽ���******************/
%>  

<%
/***************��õ�ǰ�ʼ�Ա���ʼ�������ʼ******************/
	String starttime = getCurrDateStr("00:00:00");
	String endtime = getCurrDateStr("23:59:59");
	String qccounts="0";
	String getQcCount = "select count(*) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and to_char(endtime,'yyyyMMdd hh24:mi:ss')<='"+endtime+"' and evterno='"+evterno+"'   and flag ='2' or flag='3'  and is_del='N' ";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getQcCount%>"/>
	</wtc:service>
	<wtc:array id="qcCount" scope="end"/>
<%
	if(qcCount.length>0){
	  	qccounts=qcCount[0][0];
	}
/***************��õ�ǰ�ʼ�Ա���ʼ���������******************/
%>  	
  
<%
/***************��õ�ǰ�ʼ�Ա������������ʼ******************/
	String getQcTempCount = "select count(*) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and evterno='"+evterno+"' and flag='0'  and is_del='N'";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getQcTempCount%>"/>
	</wtc:service>
	<wtc:array id="qcTempCount" scope="end"/>
<%
/***************��õ�ǰ�ʼ�Ա��������������******************/
%>

<%
/***************���ͨ����Ϣ��ʼ******************/
	String nowYYYYMM = contact_id.substring(0, 6);
	String tableName = "dcallcall" + nowYYYYMM;
	String sqlCallcall = "select caller_phone, decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'),call_cause_id,callcausedescs,vertify_passwd_flag from " + tableName + " where contact_id='" + contact_id + "'";
%>
	<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlCallcall%>"/>
	</wtc:service>
	<wtc:array id="callcallList" scope="end"/>
<%
/***************���ͨ����Ϣ����******************/
%>

<%
/***************����ʼ���Ϣ��ʼ******************/
	String sqlQcDetail = "select decode(t1.check_type,'0','ʵʱ�ʼ�','1','�º��ʼ�'),decode(t1.check_kind,'0','�Զ�����','1','�˹�ָ��'),decode(t1.check_class,'0','��������','1','����','2','����'),t4.object_name,t5.name,t1.check_type,t1.check_kind,t1.plan_id,t1.current_times "
	                     +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
	                     +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and trim(t1.content_id)='" + contect_id + "' and trim(t1.object_id) = '"+object_id+"'��and trim(t5.object_id) = '"+object_id+"' and (t5.contect_id) = '" + contect_id + "' and t1.plan_id='"+plan_id+"'";
%>
	<wtc:service name="s151Select" outnum="9">
	<wtc:param value="<%=sqlQcDetail%>"/>
	</wtc:service>
	<wtc:array id="qcDetailList" scope="end"/>

<%
/***************����ʼ���Ϣ����********************/	

/***************������ʼ������ʼ******************/
	String completedCounts="";//ʵ������ʼ�����
	String sqlGetTimes = "select current_times from dqcloginplan " + 
	                     "where  object_id='" + object_id + "' and content_id='" + contect_id + 
	                     "' and plan_id='" + plan_id + "' and login_no='" + staffno + "'";
%>
	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlGetTimes%>"/>
	</wtc:service>
	<wtc:array id="qcgetTimeList" scope="end"/>
<%
	if(qcgetTimeList.length>0){
			if("".equals(qcgetTimeList[0][0].trim())){
			  	completedCounts="1";
			}else{
				  int temp =Integer.parseInt(qcgetTimeList[0][0])+1;
				  completedCounts=temp+"";
			}
	}
/***************������ʼ��������******************/
%>

<%
/***************��ÿ������б�ʼ******************/
String sqlStr="select t.item_id, t.item_name, decode(substr(to_char(trim(low_score)),0,1),'.','0'||trim(low_score),low_score), decode(substr(to_char(trim(high_score)),0,1),'.','0'||trim(high_score),high_score) " +
              "from dqccheckitem t where trim(t.contect_id)='" + contect_id + "' and trim(object_id) = '"+object_id+"' and is_leaf='Y'"+" and is_scored='Y' "+
              " and bak1='Y' " + "order by t.item_id";
%>
	<wtc:service name="s151Select" outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>
<%
/***************��ÿ������б����******************/
%>

<%
/***************����ʼ���ˮ��ʼ******************/
	String sqlGetSerialNum = "select '"+nowYYYYMM+"'||lpad(seq_qc_result.nextval,13,'0') from dual";
	//����ʼ���ˮ
%>
	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlGetSerialNum%>"/>
	</wtc:service>
	<wtc:array id="serialNum" scope="end"/>
<%
/***************����ʼ���ˮ����******************/
%>

<%
/***************��øÿ��������ֿܷ�ʼ******************/
	String getTotalScoreSql = "select sum(high_score) from dqccheckitem " +
  	                        "where object_id='" + object_id + "' and contect_id='" + contect_id + "' and is_leaf='Y' "+" and is_scored='Y' "+ " and bak1='Y' ";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getTotalScoreSql%>"/>
	</wtc:service>
	<wtc:array id="totalScore" scope="end"/>
<%
/***************��øÿ��������ֽܷ���******************/
%>

<%
/***************��¼�ʼ쿪ʼ��Ϣ���ʼ���ʼʱ��ȣ���ʼ******************/
	//��ʱ���棨0��״̬
	String checktype = "";
	String kind = "";
	String score= "";
	String vertify_passwd_flag = "";
	if(qcDetailList.length>0){
		  checktype = qcDetailList[0][5];
		  kind = qcDetailList[0][6];
	}
	if(totalScore.length>0){
	  	score=totalScore[0][0];
	}
	if(callcallList.length>0){
	  	vertify_passwd_flag=callcallList[0][4];
	}
	//checkflag����δ���е��ʼ츴�ˣ�ֻҪ���ʼ츴�˵�ҳ��checkflag����Ϊ0������ʱ������ʼ츴�˽��checkflagΪ0���ύ���ʼ�ź�checkflagΪ1
	String sqlInsertQcInfo = "insert into dqcinfo(serialnum, recordernum, starttime, flag, objectid, contentid, staffno, evterno,checktype,kind,is_del,outplanflag,checkflag,score,vertify_passwd_flag) " +
	                         "values (:v1,:v2, sysdate, '4',:v3,:v4,:v5,:v6,:v7,:v8,'N',:v9,'-1','',:v10)";
%>
  <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			 <wtc:param value="<%=sqlInsertQcInfo%>"/>
			 <wtc:param value="dbchange"/>
			 <wtc:param value="<%=serialNum[0][0]%>"/>
			 <wtc:param value="<%=contact_id%>"/>
			 <wtc:param value="<%=object_id%>"/>
			 <wtc:param value="<%=contect_id%>"/>
			 <wtc:param value="<%=staffno%>"/>
			 <wtc:param value="<%=evterno%>"/>
			 <wtc:param value="<%=checktype%>"/>
			 <wtc:param value="<%=kind%>"/>
			 <wtc:param value="<%=isOutPlanflag%>"/>
			 <wtc:param value="<%=vertify_passwd_flag%>"/>
	</wtc:service>
<%
/***************��¼�ʼ쿪ʼ��Ϣ���ʼ���ʼʱ��ȣ�����******************/

/***************����DCALLCALLYYYYMM�е�ǰ��ˮ���ʼ�Ա���ź��Ƿ��ʼ��ʶ��ʼ******************/
  String sqlUpdDcallcall="update "+tableName+" set QC_LOGIN_NO=:v1,QC_FLAG='Y' where contact_id=:v2";
 %>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			 <wtc:param value="<%=sqlUpdDcallcall%>"/>
			 <wtc:param value="dbchange"/>
			 <wtc:param value="<%=evterno%>"/>
			 <wtc:param value="<%=contact_id%>"/>
	</wtc:service>
 <%
/***************����DCALLCALLYYYYMM�е�ǰ��ˮ���ʼ�Ա���ź��Ƿ��ʼ��ʶ����******************/
	/***************�������ԭ�����ݿ�ʼ******************/
	//��ȡ����ԭ��
	String tmp_callcause_id = (callcallList.length>0)?callcallList[0][2]:"";
	
	if(tmp_callcause_id.startsWith(",")){
	  	tmp_callcause_id = tmp_callcause_id.substring(1,tmp_callcause_id.length());
	}
	if(tmp_callcause_id.endsWith(",")){
	  	tmp_callcause_id = tmp_callcause_id.substring(0,tmp_callcause_id.length()-1);
	}
	
  String sqlGetCauseInfo = "select callcause_id,caption,fullname from dcallcausecfg where callcause_id in("+tmp_callcause_id+")";

%>
  <wtc:service name="s151Select" outnum="3">
  		<wtc:param value="<%=sqlGetCauseInfo%>"/>
  </wtc:service>
  <wtc:array id="causeInfo" scope="end"/>
  	
<%
 	String tmpInfo = "";
 	String tmpId ="";
 	
	for(int i=0;i<causeInfo.length;i++){
			tmpInfo += causeInfo[i][2]+",";
			tmpId += causeInfo[i][0]+",";
	}
	
	if(tmpInfo.endsWith(",")){
	  	tmpInfo = tmpInfo.substring(0,tmpInfo.length()-1);
	  	tmpInfo = tmpInfo.trim();
	}
	
	if(tmpId.endsWith(",")){
	  	tmpId = tmpId.substring(0,tmpId.length()-1);
	  	tmpId = tmpId.trim();
	}
 /***************�������ԭ�����ݽ���******************/
%>
 
<html>
<head>
<script>

/**
  *�ʼ���Ϸ��ش�����
  */
function doProcessSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="saveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("�ɹ���¼���������",2);
				}else{
					rdShowConfirmDialog("��¼�������ʧ�ܣ�",2);
				}
		}
	  //��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *�ʼ���ϣ������ʼ���
  *
  */
function saveQcInfo() {
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");

		//��ÿ�����÷�
    var scoreValues    = new Array();
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    
    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;

    
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_text = document.getElementById("error_level_text").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    //�ʼ�ʱ��
    var handleTime = document.getElementById("handleTime").innerHTML;
    //��ȡ¼��ʱ��
    var listenTime = document.getElementById("listenTime").innerHTML;
    //����ʱ��
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //��ʱ��
    var totalTime = document.getElementById("totalTime").innerHTML; 
    
		chkPacket.data.add("retType", "saveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
	  chkPacket.data.add("plan_id", "<%=plan_id%>");// �ʼ�ƻ�id
	  chkPacket.data.add("completedCounts", "<%=completedCounts%>");//�ʼ�ƻ�ִ������
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);	
		chkPacket.data.add("totalTime", totalTime);	
		chkPacket.data.add("staffno","<%=staffno%>");
		
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,true);
		chkPacket =null;
}


/**
  *��ʱ���淵�ش�����
  */
function doProcessTempSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="tempSaveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("��ʱ�����ʼ����ɹ���",2);
				}else{
					rdShowConfirmDialog("��ʱ�����ʼ���ʧ�ܣ�",1);
				}
		}
		//��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}


/**
  *
  *��ʱ�����ʼ���
  *
  */
function tempSaveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
		//��ÿ�����÷�
    var scoreValues    = new Array();
    
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;
    
    
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_text = document.getElementById("error_level_text").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    //�ʼ�ʱ��
    var handleTime = document.getElementById("handleTime").innerHTML;
    //��ȡ¼��ʱ��
    var listenTime = document.getElementById("listenTime").innerHTML;
    //����ʱ��
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //��ʱ��
    var totalTime = document.getElementById("totalTime").innerHTML;    

		chkPacket.data.add("retType", "tempSaveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "0");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("completedCounts", "<%=completedCounts%>");//�ʼ�ƻ�ִ������	
		chkPacket.data.add("staffno","<%=staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// �ʼ�ƻ�id
		<!--����false��ʾͬ��ִ��-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
		chkPacket =null;
}

/**
  *�������ش�����
  */
function doProcessGiveUpQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("�ɹ������ʼ죡",2);
				}else{
					rdShowConfirmDialog("�����ʼ�ʧ�ܣ�",1);
				}
		}
		//��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *�����ʼ�
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
	//��ÿ�����÷�
    var scoreValues    = new Array();
    
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;

    
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_text = document.getElementById("error_level_text").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //����ԭ��id
    var give_up_reason_ids = document.getElementById("give_up_reason_ids").value;    
    //����ԭ��
    var give_up_reason_texts = document.getElementById("give_up_reason_texts").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    //�ʼ�ʱ��
    var handleTime = document.getElementById("handleTime").innerHTML;
    //��ȡ¼��ʱ��
    var listenTime = document.getElementById("listenTime").innerHTML;
    //����ʱ��
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //��ʱ��
    var totalTime = document.getElementById("totalTime").innerHTML; 

		chkPacket.data.add("retType", "giveUpQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("give_up_reason_ids", give_up_reason_ids);
		chkPacket.data.add("give_up_reason_texts", give_up_reason_texts);	
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("completedCounts", "<%=completedCounts%>");//�ʼ�ƻ�ִ������
		chkPacket.data.add("staffno","<%=staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// �ʼ�ƻ�id
		core.ajax.sendPacket(chkPacket, doProcessGiveUpQcInfo, true);
		chkPacket =null;
}

//��ʾͨ����ϸ��Ϣ
function getCallDetail(){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
	  path = path + "?contact_id=" + '<%=contact_id%>';
	  path = path + "&start_date=" + '<%=nowYYYYMM%>';
	  window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

//ѡ�����ȼ���ı�������ܷ�
function changeScore(i){
		var scorei = document.getElementById("score"+i);
		var itemleveli = document.getElementById("itemlevel"+i);
		scorei.value=itemleveli.options[itemleveli.selectedIndex].value;
		sumScore();
}

function checkIsSendTip(){
		var tipCheckBox = document.getElementById("sendTip");
		
		if(tipCheckBox.checked==true){
				window.openWinMid("K217_send_qc_result_tip.jsp","�ʼ�������",150, 400);
		}else{
				saveQcInfo();
		}
}

/**
 *���ܣ���¼�ʼ���֪ͨ
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;	
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","���ڷ����������Ժ�......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=evterno%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialNum[0][0]%>");
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=evterno%>");
		mypacket.data.add("apptitle","��ˮ�ţ�<%=contact_id%> �����÷֣�"+totalScore);                   	
		mypacket.data.add("content","");  
		mypacket.data.add("flag",flag);  	
		core.ajax.sendPacket(mypacket,doQcCfmdoProcess,true);
		mypacket=null;     
}

//����֪ͨ�ص�����
function doQcCfmdoProcess(packet){	
		var flag = packet.data.findValueByName("flag");
		toSendMsg(flag);
}

//add by hanjc for �в� begin
//���͵����ʼ�����
function doMailCfm(){
	 var path='<%=request.getContextPath()%>/npage/callbosspage/K083/K083_mailSend.jsp?mailcontent=��鿴��ˮ�ţ�<%=contact_id%>�����ֽ��';
	 var obj = openWinMid(path,'�ʼ�����',650,850);
}
//add by hanjc for �в� end

//�����ʼ���֪ͨ����
function toSendMsg(flag){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
		mypacket.data.add("description","�ʼ���");//���ܳ���10λ
		mypacket.data.add("send_login_no","<%=evterno%>");
		mypacket.data.add("receive_login_no","<%=staffno%>");
		mypacket.data.add("cityid","");
		mypacket.data.add("content","��鿴��ˮ�ţ�<%=contact_id%>�����ֽ��");
		mypacket.data.add("msg_type",0);
		mypacket.data.add("title","�ʼ���֪ͨ");
	  mypacket.data.add("bak",flag);
	  core.ajax.sendPacket(mypacket,toSendMsgdoProcess,true);
		mypacket=null;
}

//�����ʼ���֪ͨ���ѻص�����
function toSendMsgdoProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		saveQcInfo();
}

/*-------------��ȡ¼�����ܿ�ʼ-----------------*/
function doLisenRecord(filepath,contact_id,idname){
		window.parent.top.document.getElementById("recordfile").value     = filepath;
		window.parent.top.document.getElementById("lisenContactId").value = contact_id;
		window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
		window.parent.top.document.getElementById(idname).click();
}
function ListenPause(idname){
}

/**
	*��ʼ��ʱ��ȡ¼����ַ
	*/
function initCheckCallListen(id,idname){
		if(id==''){
				return;
		}
		
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetInitPath,false);
		packet=null;
}	
	
function doProcessGetInitPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname");
   window.parent.top.document.getElementById("recordfile").value     = file_path;
	 window.parent.top.document.getElementById("lisenContactId").value = contact_id;
	 window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
}

/**
  *¼����ȡ����
  *
  *id:     ��ˮID
  *idname: opcode
  */
function checkCallListen(id,idname){
		if(id==''){
		return;
		}
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetPath,false);
		packet=null;
}

function doProcessGetPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname"); 
 
   if(flag=='Y'){
   		doLisenRecord(file_path,contact_id,idname);
   }else{
   		getCallListen(contact_id,idname);
   }
}

function getCallListen(id,idname){
		if(id==''){
				return;
		}	
		var path = "<%=request.getContextPath()%>"+"/npage/callbosspage/checkWork/K217/K217_getCallListen.jsp?flag_id="+id;
		openWinMid(path,'¼����ȡ',650,850);
}

/*--------------��ȡ¼�����ܽ���----------------*/

/*----------------������ʱ��ʼ--------------*/

var ListenTimer = null;
function ListenTimeStart(){ 
		var listenTime=document.getElementById("listenTime").innerHTML;
		listenTime=parseInt(listenTime)+1; 
	  document.getElementById("listenTime").innerHTML =listenTime;
	  window.ListenTimer = window.setTimeout("ListenTimeStart()",1000);
}

function ListenTimePause(){
		clearTimeout(window.ListenTimer);
}

function ListenTimeStop(){
		ListenTimePause();
}

function ListenTimeEnd(){
		ListenTimeStop();
}
/*----------------������ʱ����--------------*/

/*--------------��ʱ����ʼ----------------*/
window.onload=function(){
		setTimer();
		initCheckCallListen('<%=contact_id%>','K042');
}
var scan = "";
function setTimer(){
		scan = setInterval("timer()",1000);
}

//�����ʼ�ʱ��
function finishedTimer(){
		clearInterval(scan);
}

function timer(){
		var handleTime = document.getElementById("handleTime").innerHTML; 
		var listenTime = document.getElementById("listenTime").innerHTML;
		handleTime=parseInt(handleTime)+1;
		var totalTime = handleTime;
		document.getElementById("handleTime").innerHTML=handleTime;
		document.getElementById("totalTime").innerHTML=totalTime;
}

/*----------------��ʱ������--------------*/

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//�رյ�ǰ����
function closeWin(){
		var tabId='<%=tabId%>';
		var isClosed = document.getElementById("isClosed").value;
		if(tabId!=''&& isClosed=='false'){
	    parent.parent.removeTab(tabId);
	  }
}
</script>

<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
}
#tabtit ul
{
	height:23px;
	position:absolute;
}
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}

/*---------------��ȡ¼����ťstyle��ʼ-------*/
#callSearch
{
	height:1.2%;
	width:100%;
	padding:4px 2px;
	font-size:12px;
	z-index:1000000000000;
}

#callSearch img
{
	width:16px;
	height:16px;
	cursor:pointer;
}

/*---------------��ȡ¼����ťstyle����------------*/

#subScore{
border:1px solid #FFF;
}
</style>

</head>
<body>
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=(serialNum.length>0)?serialNum[0][0]:""%>"/>
	<div id="Operation_Table">
    <div class="title">
    	�ʼ���Ϣ
<% 
    	         if(isOutPlanflag.equals("0")){
%>
    	         	������üƻ��ʼ죬�������<%=qccounts%>��������������<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>��
<%
    	         }
%>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">�������</td>
        <td>
		<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][0]:""%>"/>
        </td>

        <td class="blue">������ʽ</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][1]:""%>"/>
        </td>

      	<td class="blue">��ˮ��</td>
        <td>
        <input type="text" name="" id=""  size="25" readonly value="<%=contact_id%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">�ƻ�����</td>
        <td>
        <%if("1".equals(isOutPlanflag)){%>
        		<input type="text" name="" id="" size="10" readonly value=""/>
        <%}else{%>
		       <input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][2]:""%>"/>
		    <%}%>
        </td>

        <td class="blue">�������</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][3] : objectName%>"/>
        </td>

      	<td class="blue">������</td>
        <td>
        <input type="text" name="" id="" size="25"  readonly value="<%=staffno%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">��������</td>
        <td>
		<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][4]: contentName%>"/>
        </td>

        <td class="blue">�������</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][0]);}%>"/>
        </td>

      	<td class="blue">������</td>
        <td>
        <input type="text" name="" id="" size="25"  readonly value="<%if(callcallList.length>0){out.println(callcallList[0][1]);}%>"/>
        </td>
      </tr>
    </table>

	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td>
		<input type="checkbox" name="sendTip" id="sendTip" value=""/>���ͽ��֪ͨ &nbsp;&nbsp;&nbsp;
		<input type="button" name="" value="����"/>
	</td>
	<td align="right">
		<input type="button" name="" value="ָ���µļƻ�"/>
		<input type="button" name="" value="�鿴������Ϣ" onclick="getCallDetail();"/>
		<input type="button" name="" value="ѡ����ѵ����"/>
	</td>
	</tr>
	</table>
</div>


<div id="Operation_Table">
  <div class="title">
    ������Ŀ &nbsp;����÷ֺϼ� &nbsp;
  	<input type="text" disabled id="subScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>"/> &nbsp;
  </div>
  <table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="2px" cellspacing="0">
	  <tr>
	    <td>���</td>
	    <td>����</td>
	    <td>��ͷ�</td>
	    <td>��߷� </td>
	    <td>�÷�</td>
	    <td>�����ȼ�</td>    
	  </tr>

<%
	for(int i = 0; i < queryList.length; i++){
			out.println("<tr>");
			out.println("<td class='Blue' width='30px'>"+i+"</td>");
			out.println("<td class='Blue'>");
			out.println(queryList[i][1]);
			out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
			out.println("</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][2]+"</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][3]+"</td>");
	    out.println("<td class='Blue' width='10px'><input type='text' name='score"+i+"' id='score"+i+"' size='6' maxlength='6' onblur='sumScore();' value='"+queryList[i][3]+"' onkeyup=\"value=value.replace(/[^\\d]/g,'') \"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\\d]/g,''))\"/></td>");
			out.println("<td class='Blue' width='50px'>");
			out.println("<select style='width:100px;' name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore("+i+");'>");		
%>
	    <wtc:qoption name="s151Select" outnum="2">
	    <wtc:sql>select decode(substr(to_char(trim(score)),0,1),'.','0'||trim(score),trim(score)), decode(substr(to_char(trim(score)),0,1),'.','0'||trim(score),trim(score))||'->'||level_name from dqcckectitemlevel where item_id=<%=(queryList.length>0)?queryList[i][0]:""%> and content_id='<%=contect_id%>' and object_id='<%=object_id%>' order by score desc </wtc:sql>
	    </wtc:qoption>
<%
	    out.println("</select>");
			out.println("</td>");
			out.println("</tr>");
	}
%>
</table>

</div>

<div id="Operation_Table">
	<div class="title">��Ч����(<%=qccounts%>)�� &nbsp;</div>
	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
		<tr>
		<td align="right">���ȼ�</td>
		<td>
		<input type="text" name="error_level_text" id="error_level_text" size="10" value="" readonly/>
		<input type="hidden" name="error_level_id" id="error_level_id" value=""/>
		<input type="button" name="btn_error_level" value="ѡ��" onclick="show_select_error_level_win();"/>
		</td>
		<td align="right">������</td>
		<td>
		<input type="text" name="error_class_texts" id="error_class_texts" size="10" value="" readonly/>
		<input type="hidden" name="error_class_ids" id="error_class_ids" value=""/>
		<input type="button" name="btn_error_class" value="ѡ��" onclick="show_select_error_class_win();"/>
		</td>
		<td align="right">����ԭ��</td>
		<td>
		<input type="text" name="service_class_texts" id="service_class_texts" size="10" value="<%=tmpInfo%>" readonly/>
		<input type="hidden" name="service_class_ids" id="service_class_ids" value="<%=tmpId%>"/>
		<!--����ԭ��������-->
		<input type="hidden" name="give_up_reason_ids" id="give_up_reason_ids" />
		<input type="hidden" name="give_up_reason_texts" id="give_up_reason_texts" />			
		</td>
	</tr>
	</table>
</div>

<div id="Operation_Table">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 ���ݸſ�</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 �������</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 �Ľ�����</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 �ۺ�����</li>
					<!--add for �в� start-->
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 ��ѵ����</li>
					<!--add for �в� finished-->
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    	<textarea id="contentinsum" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="commentinfo" cols="70" rows="3"></textarea>
			</div>

		</div>

		</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer" width="100%">
        <div id="callSearch">
        <!--add for �в� start-->
        Ȩ�أ�<input type="text" name="testWeight" id="testWeight" size="6" value="" />&nbsp;
        <!--add for �в� end-->
				�ܷ֣�<input type="text" name="totalScore" id="totalScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>" readonly/>
				<input name="confirm" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="��ʱ����">
				<input name="confirm" onClick="checkIsSendTip();finishedTimer();" type="button" class="b_foot" value="�ʼ����">
				<input name="confirm" onClick="rdShowMessageDialog('��Ϊ������',1);finishedTimer();" type="button" class="b_foot" value="��Ϊ����">
				<input name="confirm" onClick="show_select_give_up_reason_win()" type="button" class="b_foot_long" value="����">
				<!--	<input name="back" onClick="grpClose();" type="button" class="b_foot" value="ȡ��">-->
		    <b id="K042" onclick="checkCallListen('<%=contact_id%>','K042');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k042.gif" alt="����" /></b>
		    <b id="K043" onclick="checkCallListen('<%=contact_id%>','K043');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k043.gif" alt="ֹͣ����" /></b>
		    <b id="K044" onclick="checkCallListen('<%=contact_id%>','K044');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k044.gif" alt="��ͣ����" /></b>
		    <b id="K064" onclick="checkCallListen('<%=contact_id%>','K064');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k064.gif" alt="��������" /></b>
		    <b id="K045" onclick="checkCallListen('<%=contact_id%>','K045');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k045.gif" alt="���" /></b>
		    <b id="K046" onclick="checkCallListen('<%=contact_id%>','K046');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k046.gif" alt="����" /></b>
      </div>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="left" >�ʼ쿪ʼ��</td>     <td align="left" ><%=getCurrDateStr("")%></td>
			<td align="left" >�ʼ������</td>     <td align="left" >&nbsp;</td>
			<td align="left" >����ʱ����</td>     <td align="left" id="handleTime">0</td>

		</tr>
		<tr>
			<td align="left" >����/����ʱ����</td><td align="left" id="listenTime">0</td>
			<td align="left" >����ʱ����</td>     <td align="left" id="adjustTime">0</td>
			<td align="left" >��ʱ����</td>       <td align="left" id="totalTime">0</td>
		</tr>		
	</table>	
	<!--������isSavedΪfalse ��ʾ��ǰ���δ�����κα��������������������-->
	<input type='hidden' name='isSaved' id='isSaved' value='false'>
	<!--������isSaved����------------->
	<!--������isClosedΪfalse ���ڿ��ƹر�tabҳ����ֻ�ɵ���һ��-->
	<input type='hidden' name='isClosed' id='isClosed' value='false'>
	<!--������isClosed����------------->
</div>

</form>
</body > 
</html>

<script language="javascript">

function grpClose(){
		window.opener = null;
		top.close();
}

/**
  *������¼���ʧȥ����󣬼��㵱ǰ�÷�
  */
function sumScore(){
		var inputs = document.getElementsByTagName('input');
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		
		for(var i = 0; i < inputs.length; i++){
				if(inputs[i].name.substring(0,5) == 'score'){
						totalScore += parseFloat(inputs[i].value);
				}
		}
		
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
}

function g(o){
		return document.getElementById(o);
}
function HoverLi(n){
		//for(var i=1;i<=4;i++)
		//modify for �в� ��4��Ϊ5
		for(var i=1;i<=5;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

function ccc(){
		if(rdShowConfirmDialog("�Ƿ�ȷ���ύ��")){
		}
}

/**
  *����ѡ�����ԭ��Ĵ���
  */
function show_select_give_up_reason_win(){
		var returnValue = window.showModalDialog("./K217_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var give_up_reason_texts = document.getElementById("give_up_reason_texts");
				var give_up_reason_ids   = document.getElementById("give_up_reason_ids");
				var temp = returnValue.split('_');
				give_up_reason_texts.value = trim(temp[0]);
				give_up_reason_ids.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				give_up_reason_texts.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
							if(i!=0&&i%2==0){
							give_up_reason_texts.value +='<br>';
					}
					if(i!=texts_temp_level.length-1){
				    	give_up_reason_texts.value += texts_temp_level[i] + ',';
				  }  
		}
		giveUpQcInfo();
		finishedTimer();
	 }
}

/**
  *����ѡ����ȼ��Ĵ���
  */
function show_select_error_level_win(){
		var returnValue = window.showModalDialog("./K217_get_error_level.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var error_level_text = document.getElementById("error_level_text");
				var error_level_id   = document.getElementById("error_level_id");
				var temp = returnValue.split('_');
				error_level_text.value = trim(temp[0]);
				error_level_id.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				error_level_text.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
						if(i!=0&&i%2==0){
								error_level_text.value +='<br>';
						}
						if(i!=texts_temp_level.length-1){
					    	error_level_text.value += texts_temp_level[i] + ',';
					  } 
				}
		}
}

/**
  *����ѡ�������Ĵ���
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("./K217_get_error_class.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		
		if(typeof(returnValue) != "undefined"){
				var error_class_texts = document.getElementById("error_class_texts");
				var error_class_ids  = document.getElementById("error_class_ids");
				var temp = returnValue.split('_');
				error_class_texts.value = trim(temp[0]);
				error_class_ids.value   = trim(temp[1]);
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_arr = temp1.split(',');
				var ids_temp_arr = temp2.split(',');
				error_class_texts.value="";
				
				for(var i=0; i<texts_temp_arr.length-1; i++){
					
						if(i!=0&&i%2==0){
								error_class_texts.value +='<br>';
						}
						
						if(i!=texts_temp_arr.length-1){
						  	error_class_texts.value += texts_temp_arr[i] + ',';
						}
				}
		}
}

/**
  *����ѡ������ԭ��Ĵ���
  */
function show_select_service_class_win(){
		if(<%=callcallList.length%>==0||trim('<%=(callcallList.length>0)?callcallList[0][2]:""%>')==""){
				rdShowMessageDialog("����ˮ�޶�Ӧ������ԭ��!",1); 
		}else{
				var returnValue = window.showModalDialog("./K217_get_service_class.jsp?call_cause_id=<%=(callcallList.length>0)?callcallList[0][2]:""%>&call_cause_desc=<%=(callcallList.length>0)?callcallList[0][3]:""%>",'',"dialogWidth=800px;dialogHeight=350px");
				
				if(typeof(returnValue) != "undefined"){
						var service_class_texts = document.getElementById("service_class_texts");
						var service_class_ids   = document.getElementById("service_class_ids");
						var temp = returnValue.split('_');
						service_class_texts.value = trim(temp[0]);
						service_class_ids.value   = trim(temp[1]);
				}
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

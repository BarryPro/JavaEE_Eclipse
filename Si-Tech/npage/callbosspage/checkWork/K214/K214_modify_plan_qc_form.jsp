<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �ƻ����ʼ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:		mixh 2009/02/26  ��ȫ�ʼ���Ϣ
   *            tangsong 2010/04/11 ����֪ͨ��ʽ����dqcresultaffirm������ʼ�ȷ������
   * modify by yinzx 20100506 
  1. sql����Ż�
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

if(opCode == null || "".equals(opCode)){
		opCode = "K214";
}
if(opName == null || "".equals(opName)){
		opName = "�޸��ʼ���";
}
%>



<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>

<%
/***************��ÿ���������ˮ������������ˮ��ʼ******************/
String contect_id = request.getParameter("content_id");
String mod_flag  = request.getParameter("mod_flag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
if(null==mod_flag||"".equals(mod_flag)){
		mod_flag = "0";
}
String object_id  = request.getParameter("object_id");
String serialnum = request.getParameter("serialnum");//��ǰ�ʼ���ˮ
String isOutPlanflag = WtcUtil.repNull(request.getParameter("isOutPlanflag"));
String staffno = (String)request.getParameter("staffno");//���칤��
String evterno = (String)session.getAttribute("workNo");//�ʼ칤��
String workNo  = (String)session.getAttribute("workNo");   //090922 �޸�Ϊboss����
String isAdjust = (String)request.getParameter("isAdjust");//�ж��Ƿ����ʼ�������isAdjust��ֵΪK206Ϊ�ʼ�����������Ϊ�ʼ����޸�
String tabId   = WtcUtil.repNull(request.getParameter("tabId"));//tabҳ���idֵ
/***************��ÿ���������ˮ������������ˮ����******************/
%>

<%
/***************����ʼ�������ʼ******************/
String sqlGetObjectName = "SELECT object_name FROM dqcobject WHERE  object_id  = :object_id ";
myParams = "object_id="+object_id.trim();
String objectName = "";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=sqlGetObjectName%>"/>
		<wtc:param value="<%=myParams%>"/>
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
String sqlGetContentName = "SELECT name FROM dqccheckcontect WHERE  object_id  = :object_id AND  contect_id  = :contect_id ";
myParams = "object_id="+object_id.trim()+",contect_id="+contect_id.trim();
String contentName = "";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=sqlGetContentName%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="contentNames" scope="end"/>
<%
if(objectNames.length>0){
  	contentName = contentNames[0][0];
}
/***************��ÿ������ݽ���******************/
%>  

<%
/***************���ͨ����ˮ��ʼ******************/
String serialnumTemp = serialnum;
String sqlGetContactId ="" ;
String contact_id="";
//iΪ99Ϊ�������ݣ�ʵ�ʲ�����ӦΪ����ѭ���������ʼ츴��ʱ����ͨ����ˮid���漰����sql���Ч�ʽϸߣ����ʼ츴��һ�㲻�ᳬ��
//���Σ���ѭ��һ�㲻�ᳬ�����Ρ����������ʼ츴�˿������޽��С���ʹ������ѭ��������Ӱ���������С�
for(int i=0;i<99;i++){
		sqlGetContactId = "select recordernum from dqcinfo where serialnum=:serialnumTemp ";
		myParams = "serialnumTemp="+serialnumTemp;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sqlGetContactId%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="sqlGetcontactIdList" scope="end"/>
	
<%
 if(sqlGetcontactIdList.length>0){
   	serialnumTemp=sqlGetcontactIdList[0][0];
 }else break;
 			contact_id=serialnumTemp;
}
/***************���ͨ����ˮ����******************/
%>

<%
/***************����ʼ���Ϣ��ʼ******************/
String sqlCallcallSerialnum = "SELECT recordernum,to_char(endtime,'yyyyMMdd hh24:mi:ss'),errorlevelid,errorclassid,qcserviceclassid,errorleveldesc,errorclassdesc,serviceclassdesc,to_char(outplanflag),decode(checkreasondesc,null,'',checkreasondesc) " + 
                              "FROM dqcinfo where serialnum=:serialnum ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
		<wtc:param value="<%=sqlCallcallSerialnum%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="sqlCallcallSerialnumList" scope="end"/>
	
<%
if(sqlCallcallSerialnumList.length>0){
  	isOutPlanflag=sqlCallcallSerialnumList[0][8];
}
/***************����ʼ���Ϣ����******************/
%>

<%
/***************���ͨ����Ϣ��ʼ******************/
String nowYYYYMM ="";
String endtime="";

if(sqlCallcallSerialnumList.length>0){
	  nowYYYYMM = contact_id.substring(0, 6);
	  endtime=sqlCallcallSerialnumList[0][1];
}

String tableName = "dcallcall" + nowYYYYMM;
//updated by tangsong 20100528 ���ӿͻ�����
//String sqlCallcall = "select caller_phone, decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'),call_cause_id from " + tableName + " where contact_id=:contact_id ";
	String sqlCallcall = "select caller_phone, decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'),call_cause_id,callcausedescs,vertify_passwd_flag,"
	                   + "t.usertype,"
	                   + "(select t1.accept_name from scallgradecode t1 where t1.user_class_id=t.usertype) usertypeDesc,"
	                   + "decode(t.statisfy_code,null,'δ����',(select s.satisfy_name from ssatisfytype s where s.satisfy_code = t.statisfy_code)) STATISFY_CODE"
	                   + " from " + tableName + " t where t.contact_id=:contact_id ";
myParams = "contact_id="+contact_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
		<wtc:param value="<%=sqlCallcall%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="callcallList" scope="end"/>
	
<%
/***************���ͨ����Ϣ����******************/
%>

<%
String sqlQcDetail = "";

if(!"0".equals(isOutPlanflag)){
/***************����ʼ죨�ʼ�ƻ�����Ϣ��ʼ******************/
		sqlQcDetail = "select '','','',t4.object_name,t5.name,t1.check_type,t1.check_kind "
		              +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
		              +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and  t1.content_id =:contect_id and  t1.object_id  = :object_id��and  t5.object_id  = :object_id1 ";
		myParams = "contect_id="+contect_id+",object_id="+object_id+",object_id1="+object_id;
}else{
		sqlQcDetail = "select decode(t1.check_type,'0','ʵʱ�ʼ�','1','�º��ʼ�'),decode(t1.check_kind,'0','�Զ�����','1','�˹�ָ��'),decode(t1.check_class,'0','��������','1','����','2','����'),t4.object_name,t5.name,t1.check_type,t1.check_kind "
	                +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
	                +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and  t1.content_id =:contect_id and  t1.object_id  = :object_id��and  t5.object_id  = :object_id1 ";
	  myParams = "contect_id="+contect_id+",object_id="+object_id+",object_id1="+object_id;
}
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
		<wtc:param value="<%=sqlQcDetail%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcDetailList" scope="end"/>
<%
/***************����ʼ죨�ʼ�ƻ�����Ϣ����******************/
%>

<%
/***************����ʼ�ʱ����Ϣ��ʼ******************/
String sqlQcTimeDetail = "select to_char(STARTTIME,'yyyy-MM-dd hh24:mi:ss'),to_char(ENDTIME,'yyyy-MM-dd hh24:mi:ss'),to_char(DEALDURATION),to_char(LISDURATION),to_char(ARRDURATION) from DQCINFO t1 where  t1.serialnum =:serialnum ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
		<wtc:param value="<%=sqlQcTimeDetail%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcTimeList" scope="end"/>
<%
/***************����ʼ�ʱ����Ϣ����******************/
System.out.println("qcTimeList.length:==============================================================");
System.out.println("qcTimeList.length:"+qcTimeList.length);
System.out.println("qcTimeList:"+qcTimeList[0][2]);
%>

<%
/***************�ж��Ƿ��Ǹ��˿�ʼ******************/
String sqlGetCheckInfo = "select to_char(count(*)) from DQCINFO t1 where trim(t1.serialnum)=:serialnum  ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sqlGetCheckInfo%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcCheckList" scope="end"/>
<%
/***************�ж��Ƿ��Ǹ��˽���******************/
%>

<%
/***************��ÿ������б�ʼ******************/
String sqlStr="select t.item_id, t.item_name, decode(substr(to_char(trim(t.low_score)),0,1),'.','0'||trim(t.low_score),t.low_score), decode(substr(to_char(trim(t.high_score)),0,1),'.','0'||to_char(trim(t.high_score)),to_char(t.high_score)),t.note  " +
              " from dqccheckitem t where  t.contect_id =:contect_id and  object_id  = :object_id and is_leaf='Y' "+" and is_scored='Y' "+
              " and bak1='Y' " + " order by t.item_id";
myParams = "contect_id="+contect_id+",object_id="+object_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/***************��ÿ������б����******************/
%>

<%
/***************��õ�ǰ�޸Ľ����ˮ��ʼ******************/
//������ˮ���ǵ�ǰ��ˮ
String modserialnum="";
String getModSerialnumsql = "select to_char(max(modserialnum)) from dqcmodinfo where serialnum=:serialnum and modflag='1'";
myParams = "serialnum="+serialnum;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=getModSerialnumsql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modserialnumList" scope="end"/>	
<%
if(modserialnumList.length>0){
  	modserialnum=modserialnumList[0][0];
}
/***************��õ�ǰ�޸Ľ����ˮ����******************/
%>

<%
/***************��ÿ�����÷ֿ�ʼ******************/
String[][] scoreList = new String[][]{};
String modCountsql = "select to_char(count(*)) from dqcmodinfo where serialnum=:serialnum ";
myParams = "serialnum="+serialnum;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=modCountsql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modCountList" scope="end"/>	
<%
if(modCountList.length>0){ 
		 if(!(Integer.parseInt(modCountList[0][0])>0)){
				 String sqlStrScore="select decode(substr(to_char(trim(t.score)),0,1),'.','0'||to_char(trim(t.score)),to_char(t.score))  " +
				              " from dqcinfodetail t where  t.contentid  =:contect_id and  t.objectid  = :object_id and t.serialnum=:serialnum "+
				              " order by t.itemid";
		myParams = "contect_id="+contect_id+",object_id="+object_id+",serialnum="+serialnum;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
				<wtc:param value="<%=sqlStrScore%>"/>
				<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="scoreTempList" scope="end"/>
<%
 		scoreList=scoreTempList;
 		}else{
	/***************��ÿ�����÷ֿ�ʼ******************/
				String sqlStrScore="select decode(substr(to_char(trim(t.score)),0,1),'.','0'||to_char(trim(t.score)),to_char(trim(t.score))) " +
				                   "from dqcmodinfodetail t " +
				                   "where modflag='1' and  t.contentid =:contect_id  and  t.objectid  = :object_id and t.modserialnum=:modserialnum "+
				                   "order by t.itemid";
			myParams = "contect_id="+contect_id+",object_id="+object_id+",modserialnum="+modserialnum; 
%>
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
						<wtc:param value="<%=sqlStrScore%>"/>
						<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="scoreTempList" scope="end"/>
<%
 				scoreList=scoreTempList;
		}
}

/**************��ÿ�����÷ֽ���******************/
%>
<%
/***************��øÿ��������ֿܷ�ʼ******************/
String getTotalScoreSql = "select to_char(sum(t.score))  " +
              " from dqcinfodetail t where  t.contentid =:contect_id and  t.objectid  = :object_id  and t.serialnum=:serialnum ";
myParams = "contect_id="+contect_id+",object_id="+object_id+",serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:param value="<%=getTotalScoreSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="totalScore" scope="end"/>
<%
/***************��øÿ��������ֽܷ���******************/
%>

<%
/***************��õ�ǰ�ʼ�Ա���ʼ�������ʼ******************/
String starttime = getCurrDateStr("00:00:00");
String endtimeTemp = getCurrDateStr("23:59:59");
String getQcCount = "select to_char(count(*)) from dqcinfo where starttime>=to_date(:starttime,'yyyyMMdd hh24:mi:ss') and  endtime <=to_date(:endtimeTemp,'yyyyMMdd hh24:mi:ss') and evterno=:evterno and flag <>'4'   and flag<>'0' and is_del='N' ";
myParams = "starttime="+starttime+",endtimeTemp="+endtimeTemp+",evterno="+evterno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:param value="<%=getQcCount%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcCount" scope="end"/>
	
<%
/***************��õ�ǰ�ʼ�Ա���ʼ���������******************/
%>  	

<%
/***************��õ�ǰ�ʼ�Ա������������ʼ******************/
String getQcTempCount = "select to_char(count(*)) from dqcinfo where  starttime>=to_date(:starttime,'yyyyMMdd hh24:mi:ss') and evterno=:evterno and flag='0'  and flag <>'4' and is_del='N'";
myParams = "starttime="+starttime+",evterno="+evterno;
/* guozw �޸�ǰ δ�󶨱���
String getQcTempCount = "select to_char(count(*)) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and evterno='"+evterno+"' and flag='0'  and flag <>'4' and is_del='N'";
myParams = "starttime="+starttime+",evterno="+evterno;
*/
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=getQcTempCount%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcTempCount" scope="end"/>
	
<%
/***************��õ�ǰ�ʼ�Ա��������������******************/
%> 

<%
/***************ȡ 1 ���ݸſ� 2 ������� 3 �Ľ����� 4 �ۺ����� ��Ϣ******************/
String getInfoSql = "select t1.contentinsum,t1.handleinfo,t1.improveadvice,t1.commentinfo,t1.moddes  from DQCINFO t1 where  t1.serialnum ='" + serialnum + "'";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
<wtc:param value="<%=getInfoSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="getInfoList" scope="end"/>
<html>
<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<script>
	
	//�������ʾ���ֿ�����˵��
	function showReadMe(note){
		var note = note;
		if(""==note || note==undefined){
			note = "��������Ŀǰ�����˵����";
		}
		window.document.getElementById('readMeContent').innerText = note;
		window.document.getElementById('readMeContent').className = "blue";
	}
/**
  *����ѡ�����ԭ��Ĵ���
  */
function show_select_give_up_reason_win(){
		//�����ж�������Ϣ���ܹ���
		var wordlength1 = document.getElementById('contentinsum').value.length;
		var wordlength2 = document.getElementById('handleinfo').value.length;
		var wordlength3 = document.getElementById('improveadvice').value.length;
		var wordlength4 = document.getElementById('commentinfo').value.length;
		var wordlength5 = document.getElementById('moddes').value.length;
		if(wordlength1>480){
			similarMSNPop("��������ݸſ���Ϣ���ȹ�����");
			document.getElementById('tb_1').click();
			document.getElementById('contentinsum').select();
			return false;
		}
		if(wordlength2>480){
			similarMSNPop("����Ĵ��������Ϣ���ȹ�����");
			document.getElementById('tb_2').click();
			document.getElementById('handleinfo').select();
			return false;
		}
		if(wordlength3>480){
			similarMSNPop("����ĸĽ�������Ϣ���ȹ�����");
			document.getElementById('tb_3').click();
			document.getElementById('improveadvice').select();
			return false;
		}
		if(wordlength4>480){
			similarMSNPop("������ۺ�������Ϣ���ȹ�����");
			document.getElementById('tb_4').click();
			document.getElementById('commentinfo').select();
			return false;
		}
		if(wordlength5>480){
			similarMSNPop("������޸�˵����Ϣ���ȹ�����");
			document.getElementById('tb_5').click();
			document.getElementById('moddes').select();
			return false;
		}
		
		var returnValue = window.showModalDialog("./K214_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=410px");
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
  *
  *�����ʼ�
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_plan_qc.jsp","���Ժ�...");
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
    var error_level_text = document.getElementById("error_level_texts").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //����ԭ��id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //����ԭ��
    var check_reason_texts = document.getElementById("check_reason_texts").value;
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);	
		core.ajax.sendPacket(chkPacket, doProcessGiveUpQcInfo, true);
		chkPacket =null;
}

/**
  *�������ش�����
  */
function doProcessGiveUpQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
						similarMSNPop("�ɹ������ʼ죡");
				}else{
						similarMSNPop("�����ʼ�ʧ�ܣ�");
				}
		}
		
		//��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		//closeWin();
		setTimeout("closeWin()",2500);
}

/**
  *
  *��ʱ�����ʼ���
  *
  */
function tempSaveQcInfo(){
	//�����ж�������Ϣ���ܹ���
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	var wordlength5 = document.getElementById('moddes').value.length;
	if(wordlength1>480){
		similarMSNPop("��������ݸſ���Ϣ���ȹ�����");
		document.getElementById('tb_1').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("����Ĵ��������Ϣ���ȹ�����");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("����ĸĽ�������Ϣ���ȹ�����");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("������ۺ�������Ϣ���ȹ�����");
		document.getElementById('tb_4').click();
		document.getElementById('commentinfo').select();
		return false;
	}
	if(wordlength5>480){
		similarMSNPop("������޸�˵����Ϣ���ȹ�����");
		document.getElementById('tb_5').click();
		document.getElementById('moddes').select();
		return false;
	}
	
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_plan_qc.jsp","���Ժ�...");
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
    var error_level_text = document.getElementById("error_level_texts").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //����ԭ��id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //����ԭ��
    var check_reason_texts = document.getElementById("check_reason_texts").value;
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
    //added by tangsong 20100528 �ͻ�����������룬�ͻ������
    var usertype = document.getElementById("usertype").value;
    var callerphone = document.getElementById("callerphone").value;
    var satisfyName = document.getElementById("satisfyName").value;
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "0");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("callerphone",callerphone);
		chkPacket.data.add("usertype",usertype);
		chkPacket.data.add("satisfyName",satisfyName);
		<!--����false��ʾͬ��ִ��-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
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
				similarMSNPop("��ʱ�����ʼ����ɹ���");
				tmp = 0 ;
			}else{
				similarMSNPop("��ʱ�����ʼ���ʧ�ܣ�");
				tmp = 0 ;
			}
	}
	//��������isSaved��ֵ��Ϊtrue
	document.getElementById("isSaved").value='true';
	setTimeout("closeWin()",2500);
}

/**

  *�ʼ���Ϸ��ش�����

  */

function doProcessSaveQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="saveQcInfo"){
				if(retCode=="000000"){
					similarMSNPop("�ɹ���¼���������");  
				}else{
					similarMSNPop("��¼�������ʧ�ܣ�");
				}
	   		window.returnValue='refresh';
		}
		
	  //��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		setTimeout("closeWin()",2500);
}
/**
  *
  *�ʼ���ϣ������ʼ���
  *
  */
function saveQcInfo() {
		var mod_flag = '<%=mod_flag%>';
		var flag = "2";
		if('<%=isAdjust%>'=='K206'){
	 			flag = "1";
  	}
		//�����ж�������Ϣ���ܹ���
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	var wordlength5 = document.getElementById('moddes').value.length;
	if(wordlength1>480){
		similarMSNPop("��������ݸſ���Ϣ���ȹ�����");
		document.getElementById('tb_1').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("����Ĵ��������Ϣ���ȹ�����");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("����ĸĽ�������Ϣ���ȹ�����");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("������ۺ�������Ϣ���ȹ�����");
		document.getElementById('tb_4').click();
		document.getElementById('commentinfo').select();
		return false;
	}
	if(wordlength5>480){
		similarMSNPop("������޸�˵����Ϣ���ȹ�����");
		document.getElementById('tb_5').click();
		document.getElementById('moddes').select();
		return false;
	}
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_modify_plan_qc.jsp","���Ժ�...");
		//zhengjiang 20091023 add ����޸�ǰ������÷�
		var scoreBefValues = new Array();
		for (var i = 0;i< parseInt('<%=queryList.length%>');i++){
				scoreBefValues[i] = document.getElementById("befScore"+i).value; 
		}
		//��ÿ�����÷�
    var scoreValues    = new Array();
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
		//added by tangsong 20100531 ���ӷֵĿ��������ơ����۷ֵĿ���������
		var addedScoreItem = "";
		var lostScoreItem = "";
    for(var i = 0; i < itemIdObjs.length; i++){
    	itemIdValues[i] = itemIdObjs[i].value;
  		var highScore = Number(document.getElementById("highScore" + i).value);
  		var getScore = Number(document.getElementById("score" + i).value);
  		var itemName = document.getElementById("itemName" + i).value;
  		if (getScore > highScore) {
  			addedScoreItem += itemName + ",";
  		}
  		if (getScore < highScore) {
  			lostScoreItem += itemName + ",";
  		}
    }
    
		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
			//��ÿ�������id
		var content_id = document.getElementById("content_id").value;
			//��ÿ�������id
		var object_id = document.getElementById("object_id").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;
    //�޸�˵��
    var moddes = document.getElementById("moddes").value;
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_texts = document.getElementById("error_level_texts").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
      //����ԭ��id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //����ԭ��
    var check_reason_texts = document.getElementById("check_reason_texts").value;
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
    //added by tangsong 20100528 �ͻ�����������룬�ͻ������
    var usertype = document.getElementById("usertype").value;
    var callerphone = document.getElementById("callerphone").value;
    var satisfyName = document.getElementById("satisfyName").value; 
		chkPacket.data.add("retType", "saveQcInfo");
		chkPacket.data.add("scoreBefValues",scoreBefValues);
	  chkPacket.data.add("scores", scoreValues);
	  chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("moddes", moddes);
		chkPacket.data.add("mod_flag", mod_flag);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
	  chkPacket.data.add("evterno", "<%=evterno%>");  	
		chkPacket.data.add("object_id", object_id);  
		chkPacket.data.add("content_id", content_id);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_texts", error_level_texts);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", flag);
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("endtime", "<%=endtime%>");
		chkPacket.data.add("nowYYYYMM", "<%=nowYYYYMM%>");
		//������ʼ����������¼ʱ�����ʼ����޸Ĳ���¼ʱ��
    chkPacket.data.add("handleTime", handleTime);
	  chkPacket.data.add("listenTime", listenTime);
	  chkPacket.data.add("adjustTime", adjustTime);	
	  chkPacket.data.add("totalTime", totalTime);	
		chkPacket.data.add("usertype",usertype);
		chkPacket.data.add("callerphone",callerphone);
		chkPacket.data.add("satisfyName",satisfyName);
		chkPacket.data.add("addedScoreItem",addedScoreItem);
		chkPacket.data.add("lostScoreItem",lostScoreItem);
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,false);
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
//zengzq add 20091021�����жϡ����ݵ�ǰ��ֵ���жϿ�����ȼ�ѡ�е����ĸ�������
function checkSelected(i,curscore){
			var tmp_itemleveli;
			var tmp_itmeLevelNameArr;
			var tmp_scoreArr;
			var tmp_l_score;
			var tmp_h_score;
			var tmp_Arr = document.getElementById("itemlevel"+i).options;
			
			for(var j =0;j<tmp_Arr.length;j++){
					tmp_itmeLevelName = tmp_Arr[j].innerText;
					tmp_itmeLevelNameArr = tmp_itmeLevelName.split("->");
					tmp_scoreArr = tmp_itmeLevelNameArr[0].split("--");
					tmp_l_score = tmp_scoreArr[0];
					tmp_h_score = tmp_scoreArr[1];
					
					if(parseInt(curscore)>=parseInt(tmp_l_score) && parseInt(curscore)<=parseInt(tmp_h_score)){
							document.getElementById("itemlevel"+i).options[j].selected = true;
					}
			}
	}
	
//ѡ�����ȼ���ı�������ܷ�
function changeScore(i){
    var scorei = document.getElementById("score"+i);
		var itemleveli = document.getElementById("itemlevel"+i);
		var tmpVal = itemleveli.options[itemleveli.selectedIndex].value;
		var tmpArr = tmpVal.split("->");
    scorei.value = tmpArr[0];
		//getLevelValue();
		sumScore();
                
		//var scorei = document.getElementById("score"+i);
		//var itemleveli = document.getElementById("itemlevel"+i);
		//scorei.value=itemleveli.options[itemleveli.selectedIndex].value;
		//sumScore();
}

//added by tangsong 20100904 ����Ŀ�����:"ҵ������"��"��������"
//"ҵ������"��"��������"�÷ֲ������ܷ֣���������һ��Ϊ�������ˮ��0��
//"ҵ������"��"��������"�����뱨��ͳ�ƣ���˱�����Ϊ������
function changeScore2(i){
	var len = Number("<%=queryList.length%>");
	var itemleveli = document.getElementById("itemlevel"+i);
	var optionName = itemleveli.options[itemleveli.selectedIndex].innerText;
	var levelName = optionName.split("->")[1];
	for (var j=0;j<len;j++) {
		var tmpItemName = $("#itemName"+j).val();
		if (tmpItemName == "ҵ������" || tmpItemName == "��������") {
			continue; //��ִ������Ĳ���������ѭ��
		}
		var options = document.getElementById("itemlevel"+j).options;
		if (levelName == "��") {
			//��"ҵ������"��"��������"�ȼ�ѡ��"��"�������������⿼����Ķ���Ϊ"��"
			for (var k=0;k<options.length;k++) {
				var tmpLevelName = options[k].innerText.split("->")[1];
				if (tmpLevelName == "��") {
					$("#itemlevel"+j).val(options[k].value);
					break;
				}
			}
			//��������÷�Ϊ0���ܷ�Ϊ0
			$("#score"+j).val("0");
			$("#subScore").val("0");
			$("#totalScore").val("0");
		} else {
			//��"ҵ������"��"��������"�ȼ�ѡ��"��"�������������⿼����ĵȼ�����Ϊ"��"
			//������÷�Ϊ"��"�ķ���
			for (var k=0;k<options.length;k++) {
				var tmpLevelName = options[k].innerText.split("->")[1];
				if (tmpLevelName == "��") {
					$("#itemlevel"+j).val(options[k].value);
					$("#score"+j).val(options[k].value.split("->")[0]);
					break;
				}
			}
			//�ܷ�Ϊ100
			$("#subScore").val("100");
			$("#totalScore").val("100");
		}
	}
}

//zengzq add 20091016�����ʼ�ģ�彫ѡ�еĵȼ���������ƴ������������������ʾ
//modified by liujied 20091016 getLenth change to getLength,for
//you want to get the "length" of the list,rturnVal change to
//returnVal,I think you want to got a returned value
//
function getLevelValue(){
		document.getElementById("commentinfo").value = "";
    var getLength = '<%=queryList.length>0?queryList.length:0 %>';
    var returnVal = "";
    var itemleveli = "";
    var tmpVal1 = "";
    var tmpArr;
    var count = 0;
    
    for(var i=0;i < parseInt(getLength); i++){
        itemleveli = document.getElementById("itemlevel"+i);
        tmpVal = itemleveli.options[itemleveli.selectedIndex].value;
        tmpArr = tmpVal.split("->");
        if(tmpArr.length<2){
            continue;
        }else{
            //zengzq add 20091030 ��ѡ��Ϊ�ȼ���߷����Σ��򲻼�¼�����ۺ�����������������Ϣ
            if(tmpArr[1]=="" || tmpArr[1]=="undefined" || parseInt(tmpArr[0])==parseInt(tmpArr[2])){
					  		continue;
					  }
            count++;
            if(i == parseInt(getLength)-1){
								returnVal = returnVal + count + ":" + tmpArr[1] +"��"+ "\n";
				    }else{
								returnVal = returnVal + count + ":" + tmpArr[1] +";"+ "\n";
				    }
        }
    }
    if(!(""==returnVal) && returnVal!="undefined"){
	  		document.getElementById("commentinfo").value = returnVal;
	  }
}


/**
 *���ܣ���¼�ʼ���֪ͨ
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","���ڷ����������Ժ�......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=workNo%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialnum%>");
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=workNo%>");
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

function checkIsSendTip(){
	
	var tipCheckBox = document.getElementById("sendTip");
		
		if(tipCheckBox.checked==true){
				finishedTimer();
				var urlnotes = "../K217/K217_send_qc_result_tip.jsp?userId=<%=evterno%>&receiverPersons=<%=staffno%>&title=���'<%=contact_id.trim()%>'��ˮ���ʼ���";	//�޸�by guozw2010-3-16
				window.openWinMid(urlnotes,"�ʼ�������",150, 400);
				saveQcInfo();
				finishedTimer();
		}else{
				saveQcInfo();
				finishedTimer();
		}
		/*
		var tipCheckBox = document.getElementById("sendTip");
		if(tipCheckBox.checked==true){
				window.openWinMid("../K217/K217_send_qc_result_tip.jsp","�ʼ�������",150, 400);
		}else{
				saveQcInfo();
		}*/
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
   /**add by hanjc 20090714 begin ��ʱ���浱ǰ��ȡ¼������ˮ*/
   document.getElementById("lisenContactId").value = contact_id; 
   /**add by hanjc 20090714 end ��ʱ���浱ǰ��ȡ¼������ˮ*/     
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

/*----------------��ʱ����ʼ--------------*/
window.onload=function(){
		//Ϊ�޸�ҳ��ʱ������ʱ���桱�͡���������ť������
		if("mod"=='<%=mod_flag%>'){
				document.getElementById("tmpSavButton").disabled=true;
				document.getElementById("giveUpButton").disabled=true;
		}
		
		//�ж��Ƿ��ʱ���޸�ҳ�棺ֻ��¼�����ʱ�������Բ��ƣ�����ҳ�棺����ʱ������ʱ����ʱ
		if('<%=isAdjust%>'=='K206'){
		 		setTimer();
		}
		
		//��ʼ��ʱ��ֵ��¼��������
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
		var adjustTime = document.getElementById("adjustTime").innerHTML;
		var totalTime = document.getElementById("totalTime").innerHTML;
		adjustTime = parseInt(adjustTime)+1;
		totalTime = parseInt(totalTime)+1;
		document.getElementById("totalTime").innerHTML=totalTime;
		document.getElementById("adjustTime").innerHTML=adjustTime;
}
/*----------------��ʱ������--------------*/

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth) {
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

//added by tangsong 20100411 ��dqcresultaffirm������ʼ�ȷ������
function addAffirmData() {
	  var totalScore = document.getElementById("totalScore").value;
		var mypacket = new AJAXPacket("../K214/add_qc_result_affirm_data.jsp","���ڷ����������Ժ�......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=workNo%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialnum%>");
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=workNo%>");
		mypacket.data.add("apptitle","��ˮ�ţ�<%=contact_id%> �����÷֣�"+totalScore);
		mypacket.data.add("content","");
		core.ajax.sendPacket(mypacket,donothing,true);
		mypacket=null;
}

function donothing() {

}
</script>

<style>
.content_02
{
	font-size:12px;
}

#tabtit_ts
{
	height:23px;
	padding:0px 0 0 12px;
}

#tabtit_ts ul
{
	height:23px;
	position:absolute;
}

#tabtit_ts ul li
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

#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab
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
#basetree td {
	padding:0;
	height:0;
}
</style>
</head>
<body>
<table style="table-layout:fixed;">
<tr>
<td valign='top' style="width:170px;height:100%;border-right:3px solid #DFE8F6;">
		<input type="button" name="cTree" class="b_text" value="������" onclick="HoverLiTmp(1);"/>
		<input type="button" name="rMe" class="b_text" value="˵��" onclick="HoverLiTmp(2);"/>	
				
		<div id="checkTree" class="dis">	
		<table width="100%">
		<tr>
			<td valign="top" width="100%">
			<div id="basetree" ></div>
			</td>
			<td valign=top width="100%">
			<div id="childtree"></div>
			</td>
		</tr>
		</table>
		</div>
		<div id="readMe" class="undis" >
			<div id="Operation_Table" style="width:120%;" >
			<table cellspacing="0">
				<tr>
					<td valign="top" id = "readMeContent" class="blue">��ѡ���Ҳ�������!</td>
				</tr>
			</table>
			</div>
		</div>
</td>
<td>
	
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=serialnum%>"/>
<div id="Operation_Table"><!-- guozw20090829 -->
	<div class="title"><div id="title_zi">
	<!--�ʼ���Ϣ������üƻ��ʼ죬�������<%=(qcCount.length>0)?qcCount[0][0]:"0"%>��������������<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>��-->
	�ʼ���Ϣ<% 
	         if(isOutPlanflag.equals("0")){
	         %>
	         	������üƻ��ʼ죬�������<%=(qcCount.length>0)?qcCount[0][0]:"0"%>��������������<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>��
	         <%
	         }
	         %>	
	</div></div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">�������</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][0]:""%>"/>
        </td>
        <td class="blue">������ʽ</td>
        <td>
     	<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][1]:""%>"/>
        </td>
      	<td class="blue">��ˮ��</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%=contact_id%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">�ƻ�����</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][2]:""%>"/>
        </td>
        <td class="blue">�������</td>
        <td>
     	<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][3] : objectName%>"/>
        </td>
      	<td class="blue">������</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%=staffno%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">��������</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][4]: contentName%>"/>
        </td>
        <td class="blue">�������</td>
        <td>
     	<input type="text" name="callerphone" id="callerphone" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][0]);}%>"/>
        </td>
      	<td class="blue">������</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][1]);}%>"/>
        </td>
      </tr>
      
      <!-- added by tangsong 20100528 ��ӿͻ�����-->
      <tr>
        <td class="blue">�ͻ�����</td>
        <td>
        	<input type="text" name="usertypeDesc" id="usertypeDesc" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][6]);}%>"/>
        	<input type="hidden" name="usertype" id="usertype" value="<%if(callcallList.length>0){out.println(callcallList[0][5]);}%>"/>
        </td>
        <td class="blue">�ͻ������</td>
        <td class="blue">
        	<input type="text" name="satisfyName" id="satisfyName" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][7]);}%>"/>
        </td>
        <td class="blue" colspan="2">&nbsp;</td>
      </tr>
      
	<tr>
	<td class="blue" colspan="2">
		<input type="checkbox" name="sendTip" id="sendTip" value=""/>&nbsp;&nbsp;&nbsp;&nbsp;���ͽ��֪ͨ &nbsp;&nbsp;&nbsp;&nbsp;
		<!--input type="button" name="" class="b_text" value="����" /-->
	</td>
	<td align="left" colspan="2">&nbsp;&nbsp;
		<!--input type="button" name="" class="b_text" value="ָ���µļƻ�" /-->
		<input type="button" name="" class="b_text" value="�鿴������Ϣ" onclick="getCallDetail();" />
		<!--input type="button" name="" class="b_text" value="ѡ����ѵ����" /--> 
	</td>
	<td colspan="2">&nbsp;&nbsp;</td>
	</tr>
	</table>
</div>

<!-- updated by tangsong 20100525 ȥ��������ֵĹ�������Ϊȫ��չʾ
<div id="Operation_Table"  style="height:150px;width:99%;overflow:auto;">
-->
<div id="Operation_Table"  style="width:99%;overflow:auto;">
  <div class="title"><div id="title_zi">
    ������Ŀ &nbsp;����÷ֺϼ� &nbsp;
  	<input type="text" disabled id="subScore" size="6" style="height:13px;" value="<%=(totalScore.length>0)?totalScore[0][0]:"0"%>" /> &nbsp;
  </div></div>
<table width="99%" height="25" border="0" align="left" cellpadding="0px" cellspacing="0">
  <tr>
	    <td class="blue" width="10%">���</td>
	    <td class="blue" width="40%">����</td>
	    <td class="blue" width="10%">��ͷ�</td>
	    <td class="blue" width="10%">��߷� </td>
	    <td class="blue" width="10%">�÷�</td>
	    <td class="blue" width="20%">�����ȼ�</td>   
  </tr>
<%
	String curscore="";
	for(int i = 0; i < queryList.length; i++){
	  if(scoreList.length==0){
	    curscore=queryList[i][3];
	  }else{
	  	curscore=scoreList[i][0];
	  }
		out.println("<tr>");
		//updated by tangsong 20100531 ���������ƺ���߷ֵ�������
		//out.println("<td class='Blue' width='30px'>"+i+"</td>");
		out.println("<td class='Blue' width='30px'>"+i);
		out.println("<input type='hidden' id='itemName"+i+"' value='"+queryList[i][1]+"'/>");
		out.println("<input type='hidden' id='highScore"+i+"' value='"+queryList[i][3]+"'/>");
		out.println("<input type='hidden' name='befScore"+i+"' id='befScore"+i+"' value='"+curscore+"' >");
		out.println("</td>");
		out.println("<td class='Blue' width='40%' onclick=showReadMe('"+ queryList[i][4] +"')>");
		out.println(queryList[i][1]);
		out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
		out.println("</td>");
		out.println("<td class='Blue' width='40px'>"+queryList[i][2]+"</td>");
		out.println("<td class='Blue' width='40px'>"+queryList[i][3]+"</td>");
		out.println("<td class='Blue' width='10px'><input type='text' readonly='readonly' name='score"+i+"' id='score"+i+"' size='6' maxlength='6' value='"+curscore+"' /></td></td>");
		out.println("<td class='Blue' width='50px'>");
    if ("ҵ������".equals(queryList[i][1])
     || "��������".equals(queryList[i][1])) {
			out.println("<select name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore2("+i+");' style='width:100px;'>");
    } else {
			out.println("<select name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore("+i+");' style='width:100px;'>");
    }
		//updated by tangsong 20100525 Ĭ��ѡ�п����ȼ�Ϊ'��'��һ��
		String item_id= (queryList.length>0)?queryList[i][0]:"";
		String middleLevelSqlStr = "select t.value from (select decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||note||'->'||'"+queryList[i][3]+"' value, decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(trim(low_score)))||'--'||decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||level_name text from dqcckectitemlevel where item_id="+item_id+" and content_id='"+contect_id+"' and object_id='"+object_id+"') t where t.text like '%��'";
		%>
		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=middleLevelSqlStr%>"/>
		<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="middleLevelList" scope="end"/>	
		
		<%
			String defaultLevelValue = "";
			if (middleLevelList != null && middleLevelList.length > 0) {
				defaultLevelValue = (middleLevelList[0][0]==null)?"":middleLevelList[0][0];
			}
		%>

    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" value="<%=defaultLevelValue%>">
    <wtc:sql>select decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||note||'->'||'<%=queryList[i][3]%>',decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(trim(low_score)))||'--'||decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||level_name from dqcckectitemlevel where item_id='<%=(queryList.length>0)?queryList[i][0]:""%>' and content_id='<%=contect_id%>' and object_id='<%=object_id%>' order by score desc </wtc:sql>
    </wtc:qoption>
    
    <%
    out.println("</select>");
		out.println("</td>");
		out.println("</tr>");
                
//zengzq  start 20091017 select�еĿ�����������ʱ�������һ��Ĭ��ֵ
%>
<script>
	if(document.getElementById("itemlevel"+ '<%=i%>').options.length<1){
		//document.getElementById("itemlevel"+ '<%=i%>').options.add(new Option('<%=queryList[i][2]%>'+"--"+'<%=queryList[i][3]%>'+"->"+"Ĭ�ϵȼ�",'<%=queryList[i][3]%>'+"->"+"Ĭ�ϵȼ�") );
		document.getElementById("itemlevel"+ '<%=i%>').options[0] = new Option('<%=queryList[i][2]%>'+"--"+'<%=queryList[i][3]%>'+"->"+"Ĭ�ϵȼ�",'<%=queryList[i][3]%>');
	}
	//�����жΣ����ݵ�ǰ��ֵ�ж�ѡ���ĸ�������
	checkSelected('<%=i%>','<%=curscore%>');
</script>
<%
//zengzq  end 20091017 select�еĿ�����������ʱ�������һ��Ĭ��ֵ

	}
%>
</table>
</div>
<div id="Operation_Table" >
<div class="title"><div id="title_zi">��Ч����(<%=(qcCount.length>0)?qcCount[0][0]:"0"%>)�� &nbsp;</div></div>
<table width="100%" height="25" border="0" align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td class="blue" align="left" width="8%">���ȼ�</td>
	<td width="22%" >
	  <input type='text' name='error_level_texts' id='error_level_texts' style="width:90%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][5]:""%>' readonly />
		<input type="hidden" name="error_level_id" id="error_level_id" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][2]:""%>"/>
		<!--input type="button" name="btn_error_level" class="b_text" value="ѡ��" onclick="show_select_error_level_win();"/-->
	</td>
		<td class="blue" align="left" width="8%">������</td>
	<td width="22%" >			
		<input type='text' name='error_class_texts' id='error_class_texts' style="width:70%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][6]:""%>' readonly/>
		<input type="hidden" name="error_class_ids" id="error_class_ids" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][3]:""%>"/>
		<input type="button" name="btn_error_class" class="b_text" value="ѡ��" onclick="show_select_error_class_win();"/>
	</td>
	<td class="blue" align="left" width="8%">���ﷶ��</td>
		<td width="22%">
		<input type="button" name="btn_error_level" class="b_text" value="ѡ��" onclick="show_select_error_level_win();">
		</td>
	</tr>
	<tr>
		<td class="blue" align="left" width="8%">����ԭ��</td>
	<td width="22%" >
	<input type='text' name='service_class_texts' id='service_class_texts' style="width:90%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][7]:""%>' readonly/>
	<input type="hidden" name="service_class_ids" id="service_class_ids" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][4]:""%>"/>
          <!--����ԭ��������-->
          <input type="hidden" name="give_up_reason_ids" id="give_up_reason_ids" />
          <input type="hidden" name="give_up_reason_texts" id="give_up_reason_texts" />
	</td>
               <!--liujied ��������ԭ�� 20091015 start -->
		<td class="blue" align="left" width="8%">����ԭ��</td>
		<td width="22%">
		<input type="text" name="check_reason_texts" id="check_reason_texts" style="width:70%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][9]:""%>' readonly/>
		<input type="hidden" name="check_reason_ids" id="check_reason_ids" value=""/>
		<input type="button" name="btn_check_reason" value="ѡ��" class="b_text" onclick="show_select_check_reason_win();"/>
		</td>
		<td class="blue" colspan="2" width="8%">&nbsp;</td>
</tr>
</table>
</div>
<div id="Operation_Table"><!-- guozw20090828 -->
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit_ts">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 �ۺ�����</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 �������</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 �Ľ�����</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 ���ݸſ�</li>
					<%
					if("mod".equals(mod_flag.trim())){
					%>
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 �޸�˵��</li>
					<%}%>
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
					<textarea id="commentinfo" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][3]:""%></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][1]:""%></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][2]:""%></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="contentinsum" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][0]:""%></textarea>
			</div>
			<div class="undis" id="tbc_05">
				<textarea id="moddes" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][4]:""%></textarea>
			</div>		
		</div>
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="blue" align="center" id="footer">
        <div id="callSearch">
				��&nbsp;�֣�<input type="text" name="totalScore" id="totalScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:"0"%>" readonly/>
				<input name="confirm" id="tmpSavButton" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="��ʱ����">
				<input name="confirm" onClick="checkIsSendTip();finishedTimer();" type="button" class="b_foot" value="�ʼ����">
				<input name="confirm" onClick="rdShowMessageDialog('��Ϊ������',1);finishedTimer();" type="button" disabled class="b_foot" value="��Ϊ����">
				<input name="confirm" id="giveUpButton" onClick="show_select_give_up_reason_win();" type="button" class="b_foot_long" value="����">
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
		<%if(qcTimeList.length>0){
		  int handleTime=0;
		  int listenTime=0;
		  int adjustTime=0;
		  int totalTime=0;
		  if(qcTimeList[0][2].length()>0){
		    handleTime=Integer.parseInt(qcTimeList[0][2]);
		  }
		  if(qcTimeList[0][3].length()>0){
		    listenTime=Integer.parseInt(qcTimeList[0][3]);
		  }
		  if(qcTimeList[0][4].length()>0){
		    adjustTime=Integer.parseInt(qcTimeList[0][4]);
		  }	
		  totalTime=	handleTime+listenTime+adjustTime;  
		%>
		<tr>
			<td align="left" class="blue">�ʼ쿪ʼ��</td>     <td align="left" ><%=(qcTimeList[0][0].length()>0)?qcTimeList[0][0]:"&nbsp;"%></td>
			<td align="left" class="blue">�ʼ������</td>     <td align="left" ><%=(qcTimeList[0][1].length()>0)?qcTimeList[0][1]:"&nbsp;"%></td>
			<td align="left" class="blue">����ʱ����</td>     <td align="left" id="handleTime"><%=handleTime%></td>
		</tr>
		<tr>
			<td align="left" class="blue">����/����ʱ����</td><td align="left" id="listenTime"><%=listenTime%></td>
			<td align="left" class="blue">����ʱ����</td>     <td align="left" id="adjustTime"><%=adjustTime%></td>
			<td align="left" class="blue">��ʱ����</td>       <td align="left" id="totalTime"><%=totalTime%></td>
		</tr>
		<%}else{%>
     <tr>
			<td align="left" class="blue">�ʼ쿪ʼ��</td>     <td align="left" ><%=getCurrDateStr("")%></td>
			<td align="left" class="blue">�ʼ������</td>     <td align="left" >&nbsp;</td>
			<td align="left" class="blue">����ʱ����</td>     <td align="left" id="handleTime">0</td>
		 </tr>
		 <tr>
			<td align="left" class="blue">����/����ʱ����</td><td align="left" id="listenTime">0</td>
			<td align="left" class="blue">����ʱ����</td>     <td align="left" id="adjustTime">0</td>
			<td align="left" class="blue">��ʱ����</td>       <td align="left" id="totalTime">0</td>
		</tr>
		<%}%>
	</table>	
</div>
	<input name="content_id" id="content_id" type="hidden" value="<%=contect_id%>"/>
	<input name="object_id" id="object_id" type="hidden" value="<%=object_id%>"/>	
<!--������isSavedΪfalse ��ʾ��ǰ���δ�����κα��������������������-->
<input type='hidden' name='isSaved' id='isSaved' value='false'>
<!--������isSaved����------------->
<!--������isClosedΪfalse ���ڿ��ƹر�tabҳ����ֻ�ɵ���һ��-->
<input type='hidden' name='isClosed' id='isClosed' value='false'>
<!--������isClosed����------------->
<!--������lisenContactIdΪ��ǰ�ʼ���ȡ¼������ˮ��-->
<input type='hidden' name='lisenContactId' id='lisenContactId' value=''>
<!--������lisenContactId����------------->	
</div>
</form>

</td>
</tr>
</table>

</body>
</html>
<script language="javascript">

/**
  * �����жϣ���ǰ����ķ�ֵ�����ڵȼ���Χ֮��
  * zengzq 20091017
  */
function judgeWidth(i){
	var itemleveli = document.getElementById("itemlevel"+i);
	var itmeLevelName = itemleveli.options[itemleveli.selectedIndex].innerText;
	var itmeLevelNameArr = itmeLevelName.split("->");
	var scoreArr = itmeLevelNameArr[0].split("--");
	var l_score = scoreArr[0];
	var h_score = scoreArr[1];
	var  s_score = "score"+i;
	var curr_score = document.getElementById(s_score).value;
	
	if(parseInt(curr_score)>parseInt(h_score) || parseInt(curr_score)<parseInt(l_score)){
			similarMSNPop("����ķ�������ѡ��ĵȼ������Σ����õķ����ظ�Ϊ�÷�������߷֣�");
			document.getElementById(s_score).value = h_score;
			document.getElementById(s_score).select();
	}
	sumScore();
}  

/**
  *������¼���ʧȥ����󣬼��㵱ǰ�÷�
  */
//updated by tangsong 20100905
function sumScore(){
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		//�����Զ���ʾ���ȼ����� zengzq add 20091103 
		var error_l_texts = "";
		var error_l_ids = ""; 
		
		var len = Number("<%=queryList.length%>");
		for(var i = 0; i < len; i++){
			var tmpItemName = $("#itemName"+i).val();
			if (tmpItemName != "ҵ������" && tmpItemName != "��������") {
				totalScore += parseFloat($("#score"+i).val());
			}
		}
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
		//�����Զ�������ʾ���ȼ�start zengzq add 20091103 
		 if(parseInt(totalScore)>=200){
					 	error_l_texts = "����";
					 	error_l_ids = "01";
			 }else if(totalScore>100 && totalScore<200){
			 			error_l_texts = "��";
					 	error_l_ids = "02";
			 }else if(totalScore==100){
			 			error_l_texts = "��";
					 	error_l_ids = "03";
			 }else if(totalScore<100){
			 			error_l_texts = "��";
					 	error_l_ids = "04";
			 }
		 document.getElementById("error_level_texts").value = error_l_texts;
		 document.getElementById("error_level_id").value = error_l_ids;
		 //�����Զ�������ʾ���ȼ�end zengzq add 20091103 
}

function g(o){
		return document.getElementById(o);
}

function HoverLi(n){
		var fingure = '<%=mod_flag%>';
		var num = 0;
		if("mod"==fingure.trim()){
			num = 5;
		}else{
			num = 4;
		}
		for(var i=1;i<=num;i++)
		{
			g('tb_'+i).className='normaltab';
			g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

/**
  *����ѡ����ȼ��Ĵ���
  */
function show_select_error_level_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_error_level.jsp",'',"dialogWidth=1000px;dialogHeight=530px");
	/*
		if(typeof(returnValue) != "undefined"){
					var error_level_texts = document.getElementById("error_level_texts");
					var error_level_id   = document.getElementById("error_level_id");
					var temp = returnValue.split('_');			
					error_level_texts.value = trim(temp[0]);
					error_level_id.value = trim(temp[1]);	
					var temp1= trim(temp[0]);
					var temp2= trim(temp[1]);
					var texts_temp_level = temp1.split(',');
					var ids_temp_level = temp2.split(',');
					error_level_texts.value="";
					
					for(var i=0; i<texts_temp_level.length-1; i++){
							if(i!=0&&i%2==0){
								error_level_texts.value +='<br>';
							}
							if(i!=texts_temp_level.length-1){
						    error_level_texts.value += texts_temp_level[i] + ',';
						  }  
					}
		}*/
		if(typeof(returnValue) != "undefined"){
				document.getElementById("commentinfo").value = returnValue;
		}
}

/**
  *����ѡ�������Ĵ���
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_error_class.jsp",'',"dialogWidth=720px;dialogHeight=350px");
		
		if(typeof(returnValue) != "undefined"){
				var error_class_texts = document.getElementById("error_class_texts");
				var error_class_ids  = document.getElementById("error_class_ids");
				var temp = returnValue.split('_');
				error_class_texts.value = trim(temp[0]);
				error_class_ids.value   = trim(temp[1]);
		}
}

/**
  *����ѡ������ԭ��Ĵ���
  */
function show_select_service_class_win(){
		if(<%=callcallList.length%>==0||trim('<%=(callcallList.length>0)?callcallList[0][2]:""%>')==""){
				similarMSNPop("����ˮ�޶�Ӧ������ԭ��"); 
		}else{
			  var returnValue = window.showModalDialog("../K217/K217_get_service_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
			  if(typeof(returnValue) != "undefined"){
				  	var service_class_texts = document.getElementById("service_class_texts");
				  	var service_class_ids   = document.getElementById("service_class_ids");
				  	var temp = returnValue.split('_');
				  	service_class_texts.value = trim(temp[0]);
				  	service_class_ids.value   = trim(temp[1]);
			  }
  }
}
//added by liujied 20091016
function show_select_check_reason_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_check_reason.jsp",'',"dialogWidth=720px;dialogHeight=350px");
		
		if(typeof(returnValue) != "undefined"){
				var check_reason_texts = document.getElementById("check_reason_texts");
				var check_reason_ids  = document.getElementById("check_reason_ids");
				var temp = returnValue.split('_');
				check_reason_texts.value = trim(temp[0]);
				check_reason_ids.value   = trim(temp[1]);
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_arr = temp1.split(',');
				var ids_temp_arr = temp2.split(',');
				check_reason_texts.value="";
				
				for(var i=0; i<texts_temp_arr.length-1; i++){
					
						if(i!=0&&i%2==0){
                                                     //comment by liujied 20091020
                                                     //check_reason_texts.value +='<br>';
						}
						
						if(i!=texts_temp_arr.length-1){
						  	check_reason_texts.value += texts_temp_arr[i] + ',';
						}
				}
		}
}

/*
 *��ʼ�����ĵ�һ��ڵ�
 */
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");	
	tree.enableCheckBoxes(0);
	tree.enableDragAndDrop(0);
	tree.enableTreeLines(true);
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_create_qc_item_tree_xml.jsp?content_id=<%=contect_id%>&object_id=<%=object_id%>");
	//���ĸ��ڵ�Ϊ0
	var subItemsArr = tree.getAllSubItems("0").split(',');
	for(var i = 0; i < subItemsArr.length; i++){
		if(tree.getUserData(subItemsArr[i], 'isleaf') != 'Y'){
			tree.setItemImage2(subItemsArr[i],'folderClosed.gif','folderClosed.gif','folderClosed.gif');
		}
	}
	
	//added by tangsong 20100902 Ĭ��չ��ȫ���ڵ�
	var itemObject = tree._globalIdStorageFind(0);
  for (var i=0; i<itemObject.childsCount; i++) {
  	getTreeListByNodeId(itemObject.childNodes[i].id);
  }
}


/**
  *��Ӧ��굥���¼���ѡ�е�ǰ�ڵ㣬��չʾ��ǰ�ڵ��µ��ӽ��
  */
function onNodeClick(){
	if(tree.getSelectedItemId() == '0'){
		return;
	}
	getTreeListByNodeId();
}

//����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
//updated by tangsong 20100902
//begin
/*
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}

	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=contect_id%>", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}
*/
function getTreeListByNodeId(nodeId){
	if (nodeId == null) {
		nodeId = tree.getSelectedItemId();
		var varSubItems=tree.getSubItems(tree.getSelectedItemId());
		if(varSubItems!=null&&varSubItems!=''){
			return;
		}
	}
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=contect_id%>", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}
//end

//getTreeListByNodeId�Ļص�����
function doProcessGetList(packet){
	var childNodeList = packet.data.findValueByName("worknos");
	var nodeId        = packet.data.findValueByName("nodeId");
	insertChildNodeList(childNodeList);
}

/**
  *���������߼�
  */
function insertChildNodeList(retData){
	//alert("begin insertChildNodeList....");
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
   	var str = new Array();

   	//�жϸýڵ�д�Ƿ����ӽڵ㣬������жϹ���һ�µ�ǰ�ڵ�ֵ�Ƿ������ݿ����ֵһ��
	if(varSubItems != null && varSubItems != ''){
		str=varSubItems.split(",");
		for(var i=0;i<retData.length;i++){
			//���˵�ǰ�ڵ����ӽڵ������ݿ��Ƿ���ͬ
			if(!isStr(retData[i][0],str)){
				tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
				tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
				tree.setUserData(retData[i][0],"isscored",retData[i][4]);
				tree.setUserData(retData[i][0],"object_id",retData[i][5]);
			}
     	}
	}else{//�����ǰ�ڵ������ӽڵ㣬�����䵱ǰ�ڵ��������ӽڵ�
		for(var i = 0; i < retData.length; i++){
			tree.insertNewItem(retData[i][1], retData[i][0], retData[i][2], 0, 0, 0, 0, 'TOP');
			tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
			tree.setUserData(retData[i][0],"isscored",retData[i][4]);
			tree.setUserData(retData[i][0],"object_id",retData[i][5]);
		}
	}
	//alert("end insertChildNodeList....");
}

//�ж�һ���ַ����Ƿ��������г���
function isStr(strtreeData,str){
		if(str!=null){
				for(var j=0;j<str.length;j++){
						if(strtreeData.trim()==str[j].trim()){
								return true;
						}
				}
		}
		return false;
}

function HoverLiTmp(n){
		if(n==1){
			document.getElementById('checkTree').className='dis';
			document.getElementById('readMe').className='undis';
		}
		if(n==2){
			document.getElementById('checkTree').className='undis';
			document.getElementById('readMe').className='dis';
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
//��ʼ����
initBaseTree();
</script>


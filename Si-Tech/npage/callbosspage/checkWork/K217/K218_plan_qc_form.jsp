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
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	if(opCode == null || opCode ==""){
			opCode = "K217";
	}
	if(opName == null || opName ==""){
			opName = "�ƻ����ʼ�";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
/***************��ÿ���������ˮ������������ˮ��ʼ******************/
//���²�����Դ��K217_qc_object_tree.jsp
String contect_id = request.getParameter("content_id");
String object_id  = request.getParameter("object_id");
if(contect_id == null || contect_id == ""){
		contect_id = "02";
}
if(object_id == null || object_id == ""){
		object_id = "01";
}

//ͨ����ˮ
String contact_id = "111120081200000000000872";
/***************��ÿ���������ˮ������������ˮ����******************/
%>

<%
/***************���ͨ����Ϣ��ʼ******************/
java.text.SimpleDateFormat mydf = new java.text.SimpleDateFormat("yyyyMM");
String nowYYYYMM = mydf.format(new Date());
String tableName = "dcallcall" + nowYYYYMM;
String sqlCallcall = "select caller_phone, servicecity from " + tableName + " where contact_id='" + contact_id + "'";
%>
<wtc:service name="s151Select" outnum="6">
<wtc:param value="<%=sqlCallcall%>"/>
</wtc:service>
<wtc:array id="callcallList" scope="end"/>
<%
/***************���ͨ����Ϣ����******************/
%>

<%
/***************��ÿ������б�ʼ******************/
String sqlStr="select t.item_id, t.item_name, round(low_score), round(high_score) " +
              "from dqccheckitem t where trim(t.contect_id)='" + contect_id + "' and trim(object_id) = '"+object_id+"' and is_leaf='1'"+
              "order by t.item_id";
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
String sqlGetSerialNum = "select seq_qc_result.nextval from dual";
%>
<%
//����ʼ���ˮ
%>
<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlGetSerialNum%>"/>
</wtc:service>
<wtc:array id="serialNum" scope="end"/>
<%
/***************����ʼ���ˮ����******************/
%>

<%
/***************��øÿ��������ֿܷ�ʼ******************/
String getTotalScoreSql = "select sum(high_score) from dqccheckitem " +
                          "where object_id='" + object_id + "' and contect_id='" + contect_id + "' and is_leaf='1'";
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
String sqlInsertQcInfo = "insert into dqcinfo(serialnum, starttime, flag) " +
                         "values ('" + serialNum[0][0] + "', sysdate, '0')";
%>

<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlInsertQcInfo%>"/>
</wtc:service>
<%
/***************��¼�ʼ쿪ʼ��Ϣ���ʼ���ʼʱ��ȣ�����******************/
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
						alert("�ɹ���¼�������");
				}else{
						alert("��¼�������ʧ��!");
				}
		}
}

/**
  *
  *�ʼ���ϣ������ʼ���
  *
  */
function saveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
		//��ÿ�����÷�
    var scoreObjs      = document.getElementsByName("score");
    var scoreValues    = new Array();
    for(var i = 0; i < scoreObjs.length; i++){
    		scoreValues[i] = scoreObjs[i].value;
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
    //���ȼ�
    var error_level_id = document.getElementById("error_level_id").value;
    //������
    var error_class_ids = document.getElementById("error_class_ids").value;
    //ҵ�����
    var service_class_ids = document.getElementById("service_class_ids").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;

		chkPacket.data.add("retType", "saveQcInfo");
    chkPacket.data.add("scores", scoreValues);
    chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");

    core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,false);
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
						alert("�ɹ���ʱ�������");
				}else{
						alert("��ʱ���濼�����ʧ��!");
				}
		}
}

/**
  *
  *��ʱ�����ʼ���
  *
  */
function tempSaveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
		//��ÿ�����÷�
    var scoreObjs      = document.getElementsByName("score");
    var scoreValues    = new Array();
    
    for(var i = 0; i < scoreObjs.length; i++){
    		scoreValues[i] = scoreObjs[i].value;
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
    //���ȼ�
    var error_level_id = document.getElementById("error_level_id").value;
    //������
    var error_class_ids = document.getElementById("error_class_ids").value;
    //ҵ�����
    var service_class_ids = document.getElementById("service_class_ids").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;

		chkPacket.data.add("retType", "tempSaveQcInfo");
    chkPacket.data.add("scores", scoreValues);
    chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "0");

    core.ajax.sendPacket(chkPacket,doProcessTempSaveQcInfo,false);
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
						alert("�ɹ������ʼ�");
				}else{
						alert("�����ʼ�ʧ��!");
				}
		}
}
/**
  *
  *�����ʼ�
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
		//��ÿ�����÷�
    var scoreObjs      = document.getElementsByName("score");
    var scoreValues    = new Array();
    for(var i = 0; i < scoreObjs.length; i++){
    		scoreValues[i] = scoreObjs[i].value;
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
    //���ȼ�
    var error_level_id = document.getElementById("error_level_id").value;
    //������
    var error_class_ids = document.getElementById("error_class_ids").value;
    //ҵ�����
    var service_class_ids = document.getElementById("service_class_ids").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;

		chkPacket.data.add("retType", "giveUpQcInfo");
    chkPacket.data.add("scores", scoreValues);
    chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");

    core.ajax.sendPacket(chkPacket,doProcessGiveUpQcInfo,false);
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


</style>

</head>
<body >
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=serialNum[0][0]%>"/>

<%@ include file="/npage/include/header.jsp" %>
<div class="title">�ʼ���Ϣ</div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width="16%" class="blue">�������</td>
        <td width="34%">
		<input type="text" name="" id=""/>
        </td>

        <td width=16% class="blue">������ʽ</td>
        <td width="34%">
     	<input type="text" name="" id=""/>
        </td>

      	<td width=16% class="blue">��ˮ��</td>
        <td width="34%">
        <input type="text" name="" id=""/>
        </td>
      </tr>
      <tr>
      	<td width="16%" class="blue">�ƻ�����</td>
        <td width="34%">
		<input type="text" name="" id=""/>
        </td>

        <td width=16% class="blue">�������</td>
        <td width="34%">
     	<input type="text" name="" id=""/>
        </td>

      	<td width=16% class="blue">������</td>
        <td width="34%">
        <input type="text" name="" id=""/>
        </td>
      </tr>
      <tr>
      	<td width="16%" class="blue">��������</td>
        <td width="34%">
		<input type="text" name="" id=""/>
        </td>

        <td width=16% class="blue">�������</td>
        <td width="34%">
     	<input type="text" name="" id="" value="<%if(callcallList.length>0){out.println(callcallList[0][0]);}%>"/>
        </td>

      	<td width=16% class="blue">������</td>
        <td width="34%">
        <input type="text" name="" id="" value="<%if(callcallList.length>0){out.println(callcallList[0][1]);}%>"/>
        </td>
      </tr>
    </table>

	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td>
		<input type="checkbox" name="" value=""/>���ͽ��֪ͨ &nbsp;&nbsp;&nbsp;
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


<div id="Operation_Table" style="height:60px;width:99%;overflow:auto;">
<div class="title">������Ŀ</div>
<table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td>���</td>
    <td>����</td>
    <td>��ͷ�</td>
    <td>��߷� </td>
    <td>�÷�</td>
  </tr>

<%
	for(int i = 0; i < queryList.length; i++){
			out.println("<tr>");
			out.println("<td class='Blue' width='50px'>"+i+"</td>");
			out.println("<td class='Blue'>");
			out.println(queryList[i][1]);
			out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
			out.println("</td>");
			out.println("<td class='Blue' width='50px'>"+queryList[i][2]+"</td>");
			out.println("<td class='Blue' width='50px'>"+queryList[i][3]+"</td>");
			out.println("<td class='Blue' width='50px'><input type='text' name='score' size='8' maxlength='2' onblur='sumScore();' value='"+queryList[i][3]+"'/></td>");
			out.println("</tr>");
	}
%>
</table>

</div>
<div id="Operation_Table">
<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td align="right">���ȼ�</td>
	<td>
	<input type="text" name="error_level_text" id="error_level_text" value="" readonly/>
	<input type="hidden" name="error_level_id" id="error_level_id" value=""/>
	<input type="button" name="btn_error_level" value="ѡ��" onclick="show_select_error_level_win();"/>
	</td>
	<td align="right">������</td>
	<td>
	<input type="text" name="error_class_texts" id="error_class_texts" value="" readonly/>
	<input type="hidden" name="error_class_ids" id="error_class_ids" value=""/>
	<input type="button" name="btn_error_class" value="ѡ��" onclick="show_select_error_class_win();"/>
	</td>
	<td align="right">ҵ�����</td>
	<td>
	<input type="text" name="service_class_texts" id="service_class_texts" value="" readonly/>
	<input type="hidden" name="service_class_ids" id="service_class_ids" value=""/>
	<input type="button" name="btn_service_class" value="ѡ��" onclick="show_select_service_class_win();"/>
	</td>
</tr>
</table>

</div>
<div id="Operation_Table">

	<div class="title"></div>
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
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    	<textarea id="contentinsum" cols="110" rows="5">aaaa</textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="110" rows="5">bbbb</textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="110" rows="5">cccc</textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="commentinfo" cols="110" rows="5">dddd</textarea>
			</div>
		</div>

		</td>
	</tr>
	</table>


	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				��&nbsp;�֣�<input type="text" name="totalScore" id="totalScore" value="<%=totalScore[0][0]%>" readonly/>
				<input name="confirm" onClick="tempSaveQcInfo()" type="button" class="b_foot" value="��ʱ����">
				<input name="confirm" onClick="saveQcInfo()" type="button" class="b_foot" value="�ʼ����">
				<input name="confirm" onClick="rdShowMessageDialog('��Ϊ������',1);" type="button" class="b_foot" value="��Ϊ����">
				<input name="confirm" onClick="giveUpQcInfo()" type="button" class="b_foot_long" value="����">
				<input name="back" onClick="window.close()" type="button" class="b_foot" value="�ر�">

			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>

<script language="javascript">

/**
  *������¼���ʧȥ����󣬼��㵱ǰ�÷�
  */	
function sumScore(){
	var inputs = document.getElementsByTagName('input');
	var objTotalScore = document.getElementById("totalScore");
	var totalScore = 0;
	for(var i = 0; i < inputs.length; i++){
			if(inputs[i].name == 'score'){
					totalScore += parseInt(inputs[i].value);
			}
	}
	objTotalScore.value = totalScore;
}

function g(o){
		return document.getElementById(o);
}

function HoverLi(n){
		for(var i=1;i<=4;i++){
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
		var returnValue = window.showModalDialog("./K217_get_error_level.jsp",'',"dialogWidth=430px;dialogHeight=310px");
		var temp = returnValue.split('_');
		var error_level_text = document.getElementById("error_level_text");
		var error_level_id   = document.getElementById("error_level_id");
		error_level_id.value = trim(temp[0]);
		error_level_text.value = trim(temp[1]);
}

/**
  *����ѡ�������Ĵ���
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("./K217_get_error_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
		var error_class_texts = document.getElementById("error_class_texts");
		var error_class_ids  = document.getElementById("error_class_ids");
		var temp = returnValue.split('_');
		error_class_texts.value = trim(temp[0]);
		error_class_ids.value   = trim(temp[1]);
}

/**
  *����ѡ��ҵ�����Ĵ���
  */
function show_select_service_class_win(){
		var returnValue = window.showModalDialog("./K217_get_service_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
		var service_class_texts = document.getElementById("service_class_texts");
		var service_class_ids   = document.getElementById("service_class_ids");
		var temp = returnValue.split('_');
		service_class_texts.value = trim(temp[0]);
		service_class_ids.value   = trim(temp[1]);
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

<%
  /*
   * ����: �ʼ����޸�
�� * �汾: 1.0.0
�� * ����: 2008/11/29
�� * ����: mixh,hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K214";
	String opName = "�ʼ����޸�";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
/***************��ÿ���������ˮ������������ˮ��ʼ******************/
//���²�����Դ��K214_qc_object_tree.jsp
String contect_id = request.getParameter("content_id");
String object_id  = request.getParameter("object_id");
String belongserialnum = request.getParameter("belongserialnum");
if(contect_id == null || contect_id == ""){
contect_id = "02";
}
if(object_id == null || object_id == ""){
object_id = "01";
}

//ͨ����ˮ
String contact_id = "111120081100000000000591";
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
/***************���ÿ�����÷ֿ�ʼ******************/
String sqlStr="select t1.item_id, t1.item_name, round(t1.low_score), round(t1.high_score),t2.score " +
              "from dqccheckitem t1,dqcinfodetail t2 where trim(t2.contentid)='" + contect_id + "' and trim(t2.objectid) = '"+object_id+"' and t1.content_id=t2.contentid and t1.object_id=t2.objectid and t1.is_leaf='1'"+
              "order by t1.item_id";
%>
<wtc:service name="s151Select" outnum="6">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/***************���ÿ�����÷ֽ���******************/
%>

<%
/***************����ʼ����޸���ˮ��ʼ******************/
String sqlGetSerialNum = "select seq_qc_result.nextval from dual";
%>
<%
//����ʼ���ˮ
%>
<wtc:service name="s151Select" outnum="1">
<wtc:param value="<%=sqlGetSerialNum%>"/>
</wtc:service>
<wtc:array id="serialNum" scope="end"/>
<%
/***************����ʼ����޸���ˮ����******************/
%>

<%
/***************����ʼ�����Ϣ��ʼ******************/
String sqlGetQcResultInfo  = "select "   
                            +"t1.kind,          " //������ʽ
                            +"t1.checktype,     " //�������
                            +"t1.serialnum,     " //�ƻ�����
                            +"t3.object_name,   " //�������
                            +"t1.staffno,       " //���칤��
                            +"t4.name,          " //��������
                            +"t1.contentlevelid," //�ȼ�
                            +"t1.errorclassid,  " //������
                            +"t1.errorlevelid,  " //���ȼ�
                            +"t1.serviceclassid," //ҵ�����
                            +"t1.contentinsum,  " //���ݸ���
                            +"t1.handleinfo,    " //�������
                            +"t1.improveadvice, " //�Ľ�����
                            +"t1.commentinfo,   " //��������
                            +"t1.starttime,     " //�ʼ쿪ʼʱ�� 
                            +"t1.endtime,       " //�ʼ����ʱ�� 
                            +"t1.flag           " //�ʼ��ʶ                                              
                            +"from dqcinfo t1,dqcobject t3,dqccheckcontect t4 where t1.serialnum='"+belongserialnum+"' ";
		String strJoinSql=" and t1.objectid=t3.object_id(+) "
                     +" and t1.contentid=t4.contect_id(+) ";
    sqlGetQcResultInfo+=strJoinSql;
%>
<wtc:service name="s151Select" outnum="17">
<wtc:param value="<%=sqlGetQcResultInfo%>"/>
</wtc:service>
<wtc:array id="qcResultInfo" scope="end"/>
<%
/***************����ʼ�����Ϣ����******************/
%>

<%
/***************��ñ���Ա������ʼ******************/

String login_no="";
if(qcResultInfo.length!=0) {
  login_no = qcResultInfo[0][5];
  System.out.println("==================login_no=="+login_no);
}
String getQcLoginName = "select login_name from dloginmsg " +
                          "where login_no='" + login_no + "'";                         
%>

<wtc:service name="sPubSelect" outnum="1">
<wtc:param value="<%=getQcLoginName%>"/>
</wtc:service>
<wtc:array id="qcLoginName" scope="end"/>
<%
/***************��ñ���Ա��������******************/
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
String sqlInsertQcInfo="";
if(qcResultInfo.length!=0){
  System.out.println("===========qcResultInfo[0][14]=="+qcResultInfo[0][14]);
  sqlInsertQcInfo = "insert into dqcmodinfo(serialnum, starttime, flag) " +
                         "values ('" + belongserialnum + "', "+qcResultInfo[0][14]+", '0')";
}
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
  *�ʼ��޸ı�����Ϸ��ش�����
  */
function doProcessSaveQcInfo(packet)
{
	alert("Begin call doProcessSaveQcInfo()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="saveQcInfo"){
		if(retCode=="000000"){
			alert("�ɹ��޸Ŀ������");
		}else{
			alert("�޸Ŀ������ʧ��!");
		}
	}
	alert("End call doProcessSaveQcInfo()......");
}

/**
  *
  *�ʼ����޸���ϣ�������
  *
  */
function saveQcInfo()
{
	alert("Begin call saveQcInfo()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_modify_plan_qc.jsp","���Ժ�...");

	//��ÿ�����÷�
    var scoreObjs      = document.getElementsByName("score");
    var scoreValues    = new Array();
    for(var i = 0; i < scoreObjs.length; i++){
    	scoreValues[i] = scoreObjs[i].value;
    	//alert(scoreValues[i]);
    }

    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    	itemIdValues[i] = itemIdObjs[i].value;
    	//alert(itemIdValues[i]);
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
    //�޸�˵��
    var modmemo = document.getElementById("modmemo").value;
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
	chkPacket.data.add("flag", "<%=(qcResultInfo.length!=0)?qcResultInfo[0][16]:""%>");
	chkPacket.data.add("modflag", "1");
	chkPacket.data.add("modmemo", modmemo);

  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,false);
  alert(chkPacket.data.value);
	chkPacket =null;
	alert("End call saveQcInfo()....");
}

//��ʾͨ����ϸ��Ϣ
function getCallDetail(){
	var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + '<%=contact_id%>';
    path = path + "&start_date=" + '<%=nowYYYYMM%>';
    alert(path);
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
		<input type="text" name="" readonly id="" value=""/>
        </td>

        <td width=16% class="blue">������ʽ</td>
        <td width="34%">
     	<input type="text" name="" readonly id=""/>
        </td>

      	<td width=16% class="blue">��ˮ��</td>
        <td width="34%">
        <input type="text" name="" id=""/>
        </td>
      </tr>
      <tr>
      	<td width="16%" class="blue">�ƻ�����</td>
        <td width="34%">
		<input type="text" name="" readonly id=""/>
        </td>

        <td width=16% class="blue">�������</td>
        <td width="34%">
     	<input type="text" name="" readonly id=""/>
        </td>

      	<td width=16% class="blue">������</td>
        <td width="34%">
        <input type="text" name="" id="" value=""/>
        </td>
      </tr>
      <tr>
      	<td width="16%" class="blue">��������</td>
        <td width="34%">
		<input type="text" name="" readonly id=""/>
        </td>

        <td width=16% class="blue">�������</td>
        <td width="34%">
     	<input type="text" name="" id="" value="<%=(callcallList.length!=0)?callcallList[0][0]:""%>"/>
        </td>

      	<td width=16% class="blue">������</td>
        <td width="34%">
        <input type="text" name="" id="" value="<%=(callcallList.length!=0)?callcallList[0][1]:""%>"/>
        </td>
      </tr>
    </table>

	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="" value="����"/>
	</td>
	<td align="right">
		<input type="button" name="" value="�鿴������Ϣ" onclick="getCallDetail();"/>
		<input type="button" name="" value="ѡ����ѵ����"/>
	</td>
	</tr>
	</table>
</div>

<div id="Operation_Table" style="height:170px;width:99%;overflow:auto;">
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
	System.out.println("#####################################");
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
	System.out.println("#####################################");
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
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);"> 1 ���ݸſ�</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 �������</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 �Ľ�����</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 �ۺ�����</li>
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 �޸�˵��</li>
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    	<textarea id="contentinsum" cols="110" rows="5"><%=(qcResultInfo.length!=0)?qcResultInfo[0][10]:"aaaa"%></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="110" rows="5"><%=(qcResultInfo.length!=0)?qcResultInfo[0][11]:"bbbb"%></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="110" rows="5"><%=(qcResultInfo.length!=0)?qcResultInfo[0][12]:"cccc"%></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="commentinfo" cols="110" rows="5"><%=(qcResultInfo.length!=0)?qcResultInfo[0][13]:"dddd"%></textarea>
			</div>
			<div class="undis" id="tbc_05">
				<textarea id="modmemo" cols="110" rows="5">eeee</textarea>
			</div>
		</div>

		</td>
	</tr>
	</table>


	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				����ȼ�:
				  <select id="calLevel" name="calLevel" size="1">
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql></wtc:sql>
				  </wtc:qoption>
        </select>
				��&nbsp;�֣�<input type="text" size="5" name="totalScore" id="totalScore" value="<%=totalScore[0][0]%>" readonly/>
				<input name="confirm" onClick="saveQcInfo()" type="button" class="b_foot" value="�޸����">
				<input name="confirm" onClick="rdShowMessageDialog('��Ϊ������',1);" type="button" class="b_foot" value="��Ϊ����">
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

function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=5;i++)
	{
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
  *����ѡ����ȼ��Ĵ���
  */
function show_select_error_level_win(){
	var returnValue = window.showModalDialog("./K214_get_error_level.jsp",'',"dialogWidth=430px;dialogHeight=310px");
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
	var returnValue = window.showModalDialog("./K214_get_error_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
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
	var returnValue = window.showModalDialog("./K214_get_service_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
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

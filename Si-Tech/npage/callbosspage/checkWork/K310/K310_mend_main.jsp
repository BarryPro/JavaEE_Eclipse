<%
  /*
   * ����: �ܼƻ��޸�
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����:
�� * ��Ȩ: sitech
   *
 ��*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String plan_id=request.getParameter("plan_id");
String content_id=request.getParameter("content_id");
String object_id=request.getParameter("object_id");
String sqltotal="select plan_name,to_char(begin_date,'yyyyMMdd hh24:mi:ss'),to_char(end_date,'yyyyMMdd hh24:mi:ss'),to_char(plan_time),to_char(min_time),to_char(max_time),check_type,check_kind,group_flag,group_id,check_class,check_item,priority,max_item,min_item from dqcplan where PLAN_ID= :plan_id and content_id= :content_id and object_id = :object_id " ;
myParams = "plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="15">
	<wtc:param value="<%=sqltotal%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="totalPlan" start="0" length="15" scope="end"/>	
<html>
<head>
<title>�޸��ʼ��ܼƻ�</title>
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
	width:160px;
}
#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_long.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab 
{ 
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_long.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
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

		img{
				cursor:hand;
		}

</style>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
        public String returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();

		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//��name����'_'�ֳ�3������.
			if (names.length >= 3) {
		//������ܷ�˵�����ֲ��Ϸ�.̫�����ֲ���.
		    value = request.getParameter(name);
		//�������ֵõ�value
		if (value.trim().equals("")) {
			//���value��""����.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//���� ��һ���ַ���.��like ���� =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//��ط������ݿ���ֶδ���.������'_'�Ժ�Ķ������ݿ��ֶ���.
		objs[1] = name;
		//�ڶ����ַ���.��ѯ����.
		objs[2] = value;
		//������.��ѯ��ֵ.
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//����ط��ǽ��ַ���ת��������.Ȼ���������.����19Ҫ��2֮��.
		} catch (Exception e) {

		}
		//������������key����,ojbs����ŵ�value����.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//�õ�һ�����������.
		Arrays.sort(objNos);
		//�����ֽ�������.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//�����like �� = �ֱ���.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
		}
    return buffer.toString();
}
   
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}

%>

<%
   String start_date=totalPlan[0][1];
    String end_date=totalPlan[0][2];
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>

/*�Է���ֵ���д���*/
function doProcessAddQcContent(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
		if(retCode=="000000"){
				similarMSNPop("�޸ĳɹ���");
	      setTimeout("window.close()",1500);
		}else{
				similarMSNPop("�޸�ʧ�ܣ�");
				return false;                   
		}
}

/**
  *
  *��ӿ�������
  *
  */
function submitQcContent(){
	var minTime = document.getElementById("MIN_TIME").value;
	var maxTime = document.getElementById("MAX_TIME").value;	
	//У��
	if(minTime == ''){
		similarMSNPop("û������ƻ�����������ޣ�");
		return false;
	}
	if( maxTime== ''){
		similarMSNPop("û������ƻ�����������ޣ�");
		return false;
	}
		//add wangyong 20091002 �����ż�ֵ�ȶ�
	if( minTime*1 > maxTime*1)
	{
		similarMSNPop("�ƻ�����������޳����ƻ�����������ޣ�");
		return false;
	}
	if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		 showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
    sitechform.endTime.focus();
    }
	
  var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K310/K310_mend_update.jsp","���Ժ�...");
  var select_object=window.frames["frameCheckNo"].frames["leftFrame"].document.getElementById("select_object_id").value;
  var bqcArray = new Array();
  var bqcUncheckArray = new Array();
  var bqcObject=window.frames["frameCheckNo"].frames["leftFrame"].document.getElementsByName("bqc");
  if(bqcObject.length>0)
  {
 	for(var i=0;i<bqcObject.length;i++){
 		//if (bqcObject[i].checked==false)
 		if (bqcObject[i].checked==true)
		{
			bqcArray.push(bqcObject[i].value);
		}else{
			bqcUncheckArray.push(bqcObject[i].value);
		}
 	}
   }
   
	if(bqcArray.length<1){
		similarMSNPop("���ٱ��뱣��һ�����칤�ţ�");
		return false;
	}
	
  var qcArray = new Array();
  var qcUncheckArray = new Array();
  var qcObject=window.frames["frameCheckNo"].frames["rightFrame"].document.getElementsByName("qc");
  if(qcObject.length>0){
	 for(var i=0;i<qcObject.length;i++) {
	 	if (qcObject[i].checked==true)
		{
			qcArray.push(qcObject[i].value);		
		}else{
			qcUncheckArray.push(qcObject[i].value);
		}
	 }
  }
  
  if(qcArray.length<1){
		similarMSNPop("���ٱ��뱣��һ���ʼ칤�ţ�");
		return false;
	}


       //��ҳ����
 var MIN_TIME    = document.getElementById("MIN_TIME").value;
 var start_date  = document.getElementById("start_date").value;
 var MAX_TIME    = document.getElementById("MAX_TIME").value;
 var PLAN_NAME   = document.getElementById("PLAN_NAME").value;
 var end_date    = document.getElementById("end_date").value;
 var PRIORITY    = document.getElementById("PRIORITY").value;
 var PLAN_TIME   = document.getElementById("PLAN_TIME").value;
 var bqcObject=window.frames["frameCheckNo"].frames["leftFrame"].document.formbar.st;
  	 chkPacket.data.add("bqcArray", bqcArray);
	 chkPacket.data.add("qcArray", qcArray); 
	 chkPacket.data.add("bqcUncheckArray", bqcUncheckArray);
	 chkPacket.data.add("qcUncheckArray", qcUncheckArray);   
	 chkPacket.data.add("plan_id", '<%=plan_id%>');
	 chkPacket.data.add("content_id", '<%=content_id%>'); 
	 chkPacket.data.add("object_id", '<%=object_id%>'); 
	    
	 chkPacket.data.add("MIN_TIME", MIN_TIME);
	 chkPacket.data.add("start_date", start_date);
	 chkPacket.data.add("MAX_TIME", MAX_TIME);
	 chkPacket.data.add("PLAN_NAME", PLAN_NAME);
	 chkPacket.data.add("end_date", end_date);
	 chkPacket.data.add("PRIORITY", PRIORITY);
	 chkPacket.data.add("PLAN_TIME", PLAN_TIME);
	 //���ȷ����ť�󣬽���ť��Ϊ������
	 document.getElementById('submita').disabled=true;
	 core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
	 chkPacket =null;
}
	
	
	
	function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}

/*
**ˢ�¿�������ҳ��
*/
function changeVal(){
	
	window.frames["frameCheckContent"].window.location.href=window.frames["frameCheckContent"].window.location.href; 

}

/**
	������ƻ���������ʱ�Զ���ֵ����������޺��������
**/
function grantVal(){
	var tmpPlanTime = document.getElementById("PLAN_TIME").value;
	if(tmpPlanTime!=undefined&&tmpPlanTime!=''){
		document.getElementById("MIN_TIME").value = tmpPlanTime ;
  		document.getElementById("MAX_TIME").value = tmpPlanTime ;
	}
}
</script>

</head>
<body>

<form  name="sitechform" id="sitechform">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<!--updated by tangsong 20100831 ����ʽ�¸ñ���������
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	-->
	<td valign="top">
	<div id="Operation_Title"><B>�ƶ��ʼ��ܼƻ�</B></div>
    <div id="Operation_Table" style="width:100%;">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width="" class="blue">�������</td>
        <td width="">
					<select name="CHECK_TYPE" id="CHECK_TYPE" disabled>
	 				<option value="0" <%if(totalPlan[0][6].equals("0")){%>selected<%}%> >ʵʱ�ʼ�</option>
	 				<option value="1" <%if(totalPlan[0][6].equals("1")){%>selected<%}%>>�º��ʼ�</option>
        	</select> 
        </td>
        <td width="" class="blue">�ƻ����</td>
        <td width="">  
	 	    <select name="CHECK_CLASS" id="CHECK_CLASS" disabled>
	 				<option value="0" <%if(totalPlan[0][10].equals("0")){%>selected<%}%>>��������</option>
	 				<option value="1" <%if(totalPlan[0][10].equals("1")){%>selected<%}%>>����</option>
	 				<option value="2" <%if(totalPlan[0][10].equals("2")){%>selected<%}%>>����</option>
        	</select>         
        </td>
         <td width="" class="blue">�ƻ������������</td>
        <td width="">  
	 	    <input id="MIN_TIME" name="MIN_TIME" value="<%=totalPlan[0][4]%>" maxlength="4" v_must="1" v_type="int" onBlur="checkElement(this);changeVal();"/><font class="orange">*</font>     
        </td>
      </tr>
       
             <tr>
      	<td width="" class="blue">������ʽ</td>
        <td width="">
					<select name="CHECK_KIND" id="CHECK_KIND" disabled>
	 				<option value="0" <%if(totalPlan[0][7].equals("0")){%>selected<%}%> >�Զ�����</option>
	 				<option value="1" <%if(totalPlan[0][7].equals("1")){%>selected<%}%> >�˹�ָ��</option>
        	</select> 
        </td>
        <td width="" class="blue">��ʼ����</td>
        <td width="">  
	 	    <input id="start_date" name ="start_date" type="text"  value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>       
        </td>
         <td width="" class="blue">�ƻ������������</td>
        <td width="">  
	 	    <input id="MAX_TIME" name="MAX_TIME" value="<%=totalPlan[0][5]%>"  maxlength="4" v_must="1" v_type="int" onBlur="checkElement(this);changeVal();"/><font class="orange">*</font>     
        </td>
      </tr>
       <tr>
      	<td width="" class="blue">�ƻ�����</td>
        <td width="">
						<input id="PLAN_NAME" index="27"  v_must=1 v_maxlength=8 v_type="date" value="<%=totalPlan[0][0]%>" >
        </td>
        <td width="" class="blue">��ֹ����</td>
        <td width="">  
	 	    <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>       
        </td>
         <td width="" class="blue">���ȼ���</td>
        <td width="">  
	 	   	 	    <select name="PRIORITY" id="PRIORITY">
	 				<option value="0" <%if(totalPlan[0][12].equals("0")){%>selected<%}%> >һ��</option>
	 				<option value="1" <%if(totalPlan[0][12].equals("1")){%>selected<%}%> >��Ҫ</option>
	 				<option value="2" <%if(totalPlan[0][12].equals("2")){%>selected<%}%> >�ǳ���Ҫ</option>
        	</select> 
        </td>
      </tr>
       <tr>
      	<td width="" class="blue">�ƻ����</td>
        <td width="">
        	<select name="GROUP_FLAG" id="GROUP_FLAG" disabled>
	 				<option value="0" <%if(totalPlan[0][8].equals("0")){%>selected<%}%> >����</option>
	 				<option value="1" <%if(totalPlan[0][8].equals("1")){%>selected<%}%> >�Ŷ�</option>
        	</select>  
						
        </td>
        <td width="" class="blue">�ƻ���������</td>
        <td width="">
           <input id="PLAN_TIME" name="PLAN_TIME" value="<%=totalPlan[0][3]%>" v_must="1" v_type="int" onBlur="checkElement(this);grantVal();changeVal();"/><font class="orange">*</font> 
	       <!--input id="PLAN_TIME" name="PLAN_TIME" value="<%=totalPlan[0][3]%>" -->
        </td>
         <td width="" class="blue" colspan="2">
         <!--updated by tangsong 20100502 �ù���δʵ�֣���ʱȥ��
         <input type="checkbox" name="isNotice">֪ͨ����ִ�мƻ����ʼ�Ա
         -->
         	</td>
      </tr>
       
      </table>


  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
         <td width="100%">  
        &nbsp;
         </td>
 			</tr>   	
   </table>
   
   
<div class="content_02" width="100%">
	<div id="tabtit_ts" width="100%">
		<ul>
			<li id="tb_1" class="hovertab" onclick="HoverLi(1);" nowrap>1ָ�����칤�š��ʼ칤��</li>
			<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2��������ָ��</li>
		</ul>
	</div>
	<div  class="dis" id="tbc_01" width="100%">
	  <iframe style="height:100%" name="frameCheckNo" src="K310_mend_leftMan.jsp?plan_id=<%=plan_id%>&content_id=<%=content_id%>&object_id=<%=object_id%>" FRAMEBORDER="0" SCROLLING="NO" width="100%"></iframe>
	</div>
	<div  class="undis" id="tbc_02" width="100%">
		 <iframe  style="height:100%" name="frameCheckContent" src="K310_mend_content.jsp?plan_id=<%=plan_id%>&content_id=<%=content_id%>&object_id=<%=object_id%>"  FRAMEBORDER="0" SCROLLING="NO" width="100%"></iframe>
	</div>
</div>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" id="submita" name="submita" type="button" value="ȷ��" onclick="submitQcContent()">
        	<input class="b_foot" name="reset1" type="button"  onclick="window.close()" value="�˳�">
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
</body>
</html>
 





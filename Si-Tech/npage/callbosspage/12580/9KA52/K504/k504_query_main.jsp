
<%
	 /*
	 * ����: 12580���˵绰��
	 * �汾: 1.0.0
	 * ����: 2009/01/08
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="../../headTotal.jsp" %>
<%!/** 
	 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
	 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
	 */
	public String returnSql(HttpServletRequest request) {
		StringBuffer buffer = new StringBuffer();

		//�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name = "";
		String[] names = new String[0];
		String value = "";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i].toString();
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
				//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
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
			if (objs[0].toString().toLowerCase().equalsIgnoreCase("like")) {
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

	public String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}%>
<%
	String opCode = "K504";
	String opName = "���˵绰��";
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) session.getAttribute("kfWorkNo");
	String savelist = request.getParameter("savelist")==null?"":request.getParameter("savelist");

	String sqlStr = " select SERIAL_NO,PERSON_NAME,decode(PERSON_SEX,'F','Ů','M','��') ,PERSON_PHONE,IS_MOBILE_NET,PERSON_FAX,PERSON_EMAIL,PERSON_QQ,PERSON_DESCR,PERSON_BIRTH,PERSON_UNIT,TO_CHAR(CREATE_TIME,'yyyy/mm/dd hh24:mi:ss'),ACCEPT_NO,decode(source_flag,'B','�绰��','G','Ⱥ��') from DPHONLIST";
	String strCountSql = "select to_char(count(*)) count  from DPHONLIST";
	String strAcceptLogSql = "";
	String strAcceptTimeSql = "";
	String strDateSql = "";
	String strOrderSql = " order by SERIAL_NO  ";
	String flag = request.getParameter("flag");

	String phone_name = "";
	String phone_sex = "";
	String phone_num = "";
	String con_id = "";
	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 15; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String sqlTemp = "";
	String querySql = "";
	String ACCEPT_NO = "";

	String[] strHead = { "���", "����", "�Ա�", "������", "�Ƿ���", "����", "����",
			"QQ/BP", "��ַ", "��ע", "����", "��λ", "����ʱ��", "����޸�ʱ��" };

	String action = request.getParameter("myaction");
	String expFlag = request.getParameter("exp");
	phone_name = request.getParameter("phone_name");
	phone_sex = request.getParameter("phone_sex");
	phone_num = request.getParameter("phone_num");
	String pnno = (String)session.getAttribute("capn");//�������
	ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?pnno:request.getParameter("ACCEPT_NO");
	con_id = request.getParameter("con_id");

	String sqlFilter = request.getParameter("sqlFilter");
	if (sqlFilter == null || sqlFilter.trim().length() == 0) {

		sqlFilter = " where 1=1 AND PERSON_TYPE = '1' AND ACCEPT_NO = '"+ACCEPT_NO+"'";
		if (phone_name != null && !phone_name.trim().equals("")) {

			sqlFilter += " and PERSON_NAME = '" + phone_name + "'";
		}
		if (phone_sex != null && !phone_sex.trim().equals("")
		&& !"0".equals(phone_sex)) {

			sqlFilter += " and PERSON_SEX = '" + phone_sex + "'";
		}
		if (phone_num != null && !phone_num.trim().equals("")) {

			sqlFilter += " and PERSON_PHONE = '" + phone_num + "'";
		}
	}

	//if ("doLoad".equals(action)) {

		sqlStr += sqlFilter +strOrderSql;
		sqlTemp = strCountSql + sqlFilter;
		
%>

<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp%>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />

<%
			if (rowsC4.length != 0) {

			rowCount = Integer.parseInt(rowsC4[0][0]);
		}
		strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		querySql = PageFilterSQL.getOraQuerySQL(sqlStr, String
		.valueOf(curPage), String.valueOf(pageSize), String
		.valueOf(rowCount));
		
%>
<wtc:service name="s151Select" outnum="27">
	<wtc:param value="<%=querySql%>" />
</wtc:service>
<wtc:array id="queryList" start="1" length="23" scope="end" />
<%
	dataRows = queryList;
	//}
%>


<html>
	<head>
		<title>���˵绰��</title>
		<style>
			  #msg{
				width:180px;
				height:120px;
				position:absolute;
				right:0px;
				bottom:0px;
				z-index:2;
				border:1px solid #555;
				background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
				font-size:12px;
				}
				#msgTitle{
				height:16px;
				padding:8px 0px 0px 10px;
				border-bottom:2px solid #b3f9ff;
				position:relative;
				}
				#msgContent{
				padding:10px;
				height:1%;
				color:#555;
				}
				#msgImg{
				position:absolute;
				right:5px;
				top:5px;
				z-index:10;
				width:10px;
				height:10px;
			  }
    </style>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
//=========================================================================
// LOAD PAGES.
//=========================================================================
   //chengh 20090424
    smp();
		function smp(){
			var falg = "<%=flag %>";
			if(falg=="msgY"){
				parent.similarMSNPop("���ŷ��ͳɹ�");
		  }
		  else if(falg=="msgN"){
		  	parent.similarMSNPop("���ŷ���ʧ��");
		  }
		  else if(falg=="NumMsgY"){
		  	parent.similarMSNPop("�ɹ�");
		  }
		  else if(falg=="NumMsgN"){
		  	parent.similarMSNPop("ʧ��");
		  }
		  else if(falg=="2"){
		  	parent.similarMSNPop("�ɹ�");
		  }
		  else if(falg=="Y"){
		  	parent.similarMSNPop("�����������֤��");
		  }
		  else
		  	return;
	  }
//����
function doLoad(operateCode){
	 var str='1';
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   	str='0';
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
    keepValue();
    submitMe(str); 
    }
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitMe(flag){
   window.sitechform.myaction.value="doLoad";
   	if(flag=='0'){
		   var vCon_id=window.top.document.getElementById('contactId').value;
       window.sitechform.action="k504_query_main.jsp?con_id="+vCon_id;
		//chengh 20090424
		}else if(flag=='msgY'){
			 window.sitechform.action="k504_query_main.jsp?flag=msgY";
		}else if(flag=='msgN'){
			 window.sitechform.action="k504_query_main.jsp?flag=msgN";
		}
		else if(flag=='NumMsgY'){
		   window.sitechform.action="k504_query_main.jsp?flag=NumMsgY";
		}
		else if(flag=='NumMsgN'){
		 window.sitechform.action="k504_query_main.jsp?flag=NumMsgN";
		}
		else if(flag=='1'){
		 window.sitechform.action="k504_query_main.jsp";
		}
		else if(flag=='2'){
		 window.sitechform.action="k504_query_main.jsp?flag=2";
		}
		//����
   window.sitechform.method='post';
   window.sitechform.submit(); 
}
//=========================================================================
// LOAD PAGES.
//=========================================================================	
//�������¼
function clearValue(){
var e = document.sitechform.elements;
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

function submitQcContent()
{
	//chengh
	window.sitechform.action="k504_query_main.jsp";
	//var tf32 = document.getElementById("tf32ty").value;//�ж��Ƿ�ͨ�ƶ��������
	//			if(tf32 != "availability"){
	//				rdShowMessageDialog("�������û�п�ͨ�ƶ�����������ʧЧ��");
	//				return;
	//			}
	var ACCEPT_NO = document.getElementById("ACCEPT_NO").value;
	if(""==ACCEPT_NO){
		 parent.similarMSNPop("����Ų���Ϊ�գ�");
	   return;
	}
	if(!f_check_mobile(ACCEPT_NO)){
		 parent.similarMSNPop("����Ÿ�ʽ����ȷ��");		
	   return;
	}
	var winParam = 'dialogWidth=800px;dialogHeight=600px';
	window.showModelessDialog("../../../../callbosspage/12580/9KA52/K504/k504_new_obj.jsp?ACCEPT_NO="+ACCEPT_NO,window, winParam);

}
function submitUpContent()
{
	
	var name = document.getElementsByName("obj_id");
	var n="0";
	for(var i =0;i<name.length;i++){
		if(name[i].checked){
			n++;
		}
	}
	
	var obj_id = document.getElementById("checkid").value;
	//alert(obj_id+"-"+n);
	if("0"==obj_id||n>1){
		 parent.similarMSNPop("����ѡ��һ����¼��");	   
	   return;
	}
	var winParam = 'dialogWidth=800px;dialogHeight=600px';
	window.showModelessDialog("../../../../callbosspage/12580/9KA52/K504/k504_new_obj.jsp?obj_id="+obj_id+"&ACCEPT_NO=<%=ACCEPT_NO%>",window, winParam);
}
function submitDELContent()
{
	var name = document.getElementsByName("obj_id");
	var obj_id="0";
	for(var i =0;i<name.length;i++){
		
		if(name[i].checked){
			
			var obj_iid = name[i].value;
			obj_id = obj_id + "_"+obj_iid;
		}
	}
	
	if(obj_id=="0"){
		parent.similarMSNPop("����ѡ��һ����¼��");		
		return;
	}
	if(rdShowConfirmDialog("ȷʵҪɾ����?",2) != 1){
				
	}else{
    	
       	var myPacket = new AJAXPacket("k504_delete_obj.jsp","�����ύ�����Ժ�......");
       	myPacket.data.add("obj_id",obj_id);
       	core.ajax.sendPacket(myPacket,doProcess,true);
	  	myPacket=null;
   }
}
function doProcess(myPacket)
{

  var retType = myPacket.data.findValueByName("retType");
	var retCode = myPacket.data.findValueByName("retCode");
	var retMsg = myPacket.data.findValueByName("retMsg");
		if(retCode=="000000"){
			
			//alert("����ɹ�");
			//rdShowMessageDialog("�ɹ�",2);
			//chengh 20090425
			submitMe('NumMsgY');
			//similarMSNPop("�ɹ�");
		    //window.close();
		}else{
			//similarMSNPop("ʧ��");
			//alert("����ʧ��!");
			//chengh 20090425
			submitMe('NumMsgN');
			//rdShowMessageDialog("ʧ��",0);
			return false;
		}
}
function setObjID(idvalue)
{
	var name = document.getElementsByName("obj_id");
	//alert(name.length);
	var n = 0;
	for(var i = 0;i<name.length;i++){
		
		//alert(name[i].value);
		if(name[i].checked){
			
		    document.getElementById("checkid").value = name[i].value;
		    n++;
		}
	}
	if(n==0){
		document.getElementById("checkid").value  = "0";
	}
	//alert(document.getElementById("checkid").value);
}
function keepValue()
{

}
function getPhoneNum(){
	//document.getElementById("ACCEPT_NO").value = window.top.cCcommonTool.getCaller();
	document.getElementById("ACCEPT_NO").value = "13709811146";
	setTimeout("getPhoneNum()", 1000);
}
var bool = false;
function setAllCheck(){

	var name = document.getElementsByName("obj_id");
	if(bool){
		bool = false;
		for(var i = 0;i<name.length;i++){
			
			name[i].checked="";
			setObjID();
		}
	}else{
		bool = true;
		for(var i = 0;i<name.length;i++){
			
			name[i].checked="checked";
			setObjID();
		}
	}
}
function submitSaveContent(){
		 	
	var savelist =document.getElementById("savelist").value;
	var obj_id = document.getElementById("checkid").value;
	var name = document.getElementsByName("obj_id");
	//alert(savelist+"-"+"obj_id");
	var n="0";
	for(var i =0;i<name.length;i++){
		if(name[i].checked){
			n++;
		}
	}
	if("0"==obj_id||n>1){
		 parent.similarMSNPop("����ѡ��һ����¼��");
	   return;
	}
	if(savelist != ""){
		
    var mylist = savelist.split("_");
    for(var i = 0;i<mylist.length;i++){
    	
    	if(mylist[i] ==obj_id ){
    		parent.similarMSNPop("����ϵ���ڶ������Ѵ��ڣ�");
    		//rdShowMessageDialog("����ϵ���ڶ������Ѵ��ڣ�",0);
    		return;
    	}
    }
		
		savelist = savelist+"_"+obj_id;
	}else{
		savelist =obj_id;
	}
	
	document.getElementById("savelist").value = savelist;
	parent.similarMSNPop("�ѽ�����ϵ����ӵ������У�");
	//rdShowMessageDialog("�ѽ�����ϵ����ӵ������У�",2);
}
function submitSendContent(){
	var obj_id = document.getElementById("checkid").value;
	var ACCEPT_NO = document.getElementById("ACCEPT_NO").value
	var savelist =document.getElementById("savelist").value;
	//var tf32 = document.getElementById("tf32ty").value;//�ж��Ƿ�ͨ�ƶ��������
	//			if(tf32 != "availability"){
	//				rdShowMessageDialog("�������û�п�ͨ�ƶ�����������ʧЧ��");
	//				return;
	//			}
    if(""==ACCEPT_NO){
   	  parent.similarMSNPop("����Ų���Ϊ�գ�");
   		return;
   	}
	
	var name = document.getElementsByName("obj_id");
	var n=0;
	var serial_no = "";
	for(var i =0;i<name.length;i++){
		if(name[i].checked){
			serial_no += name[i].value + ";";
			n++;
		}
	}

	if(n==0){
		 parent.similarMSNPop("����ѡ��һ����¼��");
	   return;
	}
		
	var winParam = 'toolbar=no,menubar=no,width=800px,height=550px';
	window.open("../../../../callbosspage/12580/9KA52/K504/k504_sendmessage_obj.jsp?SERIAL_NO="+serial_no+"&ACCEPT_NO="+ACCEPT_NO+"&savelist="+savelist,'', winParam);
 
}
//ȥ���ҿո�;
		function trim(s){
				return rtrim(ltrim(s));
		}
		//ȥ��ո�;
		function ltrim(s){
		  	return s.replace( /^\s*/, "");
		}
		
		//ȥ�ҿո�;
		function rtrim(s){
				return s.replace( /\s*$/, "");
		}
function submitSendNumContent(){
	//var tf32 = document.getElementById("tf32ty").value;//�ж��Ƿ�ͨ�ƶ��������
	//			if(tf32 != "availability"){
	//				rdShowMessageDialog("�������û�п�ͨ�ƶ�����������ʧЧ��");
	//				return;
	//			}
	var contactid = trim(parent.document.getElementById("contactIdnew").innerHTML);
	var name = document.getElementsByName("obj_id");
	var n="0";
	for(var i =0;i<name.length;i++){
		if(name[i].checked){
			n++;
		}
	}
	
	var obj_id = document.getElementById("checkid").value;
	//alert(obj_id+"-"+n);
	if("0"==obj_id||n>1){
		 parent.similarMSNPop("����ѡ��һ����¼��");
	   return;
	}
	if(rdShowConfirmDialog("�Ƿ�ȷ�����Ͷ��ţ�")!=1){
				window.close();
				return;
	}
	var myPacket = new AJAXPacket("k504_sendnum_obj.jsp","�����ύ�����Ժ�......");
   	myPacket.data.add("obj_id",obj_id);
   	
   	myPacket.data.add("contactid",contactid);
   	myPacket.data.add("ACCEPT_NO","<%=ACCEPT_NO%>");
   	core.ajax.sendPacket(myPacket,doProcess,true);
		myPacket=null;
}
</script>

	</head>
	<body>

<%@ include file="/npage/include/header.jsp"%>
		<form name="sitechform" id="sitechform">

			<div id="Operation_Table">
				<div class="title">
					���ò�ѯ����
				</div>
				<table cellspacing="0">
					<tr>
						<td noWrap>����</td>
						<td><input type="text" name="phone_name" value="<%=(request.getParameter("phone_name")!=null)?request.getParameter("phone_name"):"" %>" /></td>
						<td noWrap>�Ա�</td>
						<td>
							<select name="phone_sex">
								<option value="0" >--�����Ա�--</option>
								<option value="M" <%if("M".equalsIgnoreCase(phone_sex)){ %>selected<%} %> >��</option>
								<option value="F" <%if("F".equalsIgnoreCase(phone_sex)){ %>selected<%} %> >Ů</option>
							</select>
						</td>
					</tr>
					<tr>						
						
						<td noWrap>������</td>
						<td><input type="text" name="phone_num" value="<%=(request.getParameter("phone_num")!=null)?request.getParameter("phone_num"):"" %>" /></td>
						
						<td noWrap><!--�����-->&nbsp;</td>
						<td>&nbsp;<input type="hidden" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=(request.getParameter("ACCEPT_NO")!=null)?request.getParameter("ACCEPT_NO"):"" %>" /></td>						
					</tr>					
					<tr>
						<td colspan="4" align="center" id="footer" nowrap>
							<!--<input name="delete_value" class="b_foot" type="button" id="add" value="����" onClick="clearValue();">-->
							<input name="search" class="b_foot" type="button" id="search" value="��ѯ" onClick="submitMe('1');">
							<input name="new" class="b_foot" type="button" id="new" value="�½�" onClick="submitQcContent();">
							<input name="update" class="b_foot" type="button" id="update" value="�޸�" onClick="submitUpContent();">
							<input name="delete" class="b_foot" type="button" id="delete" value="ɾ��" onClick="submitDELContent();">
							<input name="savemessage" class="b_foot_long" type="button" id="savemessage" value="��ӵ����ŷ��Ͷ���" onClick="submitSaveContent();">
							<input name="sendmessage" class="b_foot" type="button" id="sendmessage" value="���Ͷ���" onClick="submitSendContent();">
							<input name="sendnum" class="b_foot_long" type="button" id="sendnum" value="���ͺ��������" onClick="submitSendNumContent();">
						</td>
					</tr>
				</table>
			</div>
			<div id="Operation_Table">
				<table  cellspacing="0">
				    <tr >
				      <td class="blue"  align="left" width="720">
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
				<table cellSpacing="0">
					<input type="hidden" name="page" value="">
					<input type="hidden" name="myaction" value="">
					<input type="hidden" name="sqlFilter" value="">
					<input type="hidden" name="sqlWhere" value="">
					<input type="hidden" name="savelist" id="savelist" value="<%=savelist %>">
					<tr>

            <th align="center" class="blue" width="8%">ѡ������<input type="checkbox" id="allcheck" name="allcheck" onclick="setAllCheck();" value="0" > </th> 
						<th align="center" class="blue" width="8%">���</th>
						<th align="center" class="blue" width="8%">����</th>
						<th align="center" class="blue" width="8%">�Ա�</th>
						<th align="center" class="blue" width="8%">������</th>
						<th align="center" class="blue" width="8%">�����</th>
						<th align="center" class="blue" width="8%">������Դ</th>
						<th align="center" class="blue" width="8%">�Ƿ���</th>
						
						<!--<th align="center" class="blue" width="8%">����</th>
						<th align="center" class="blue" width="8%">����</th>
						<th align="center" class="blue" width="8%">QQ/BP</th>
						<th align="center" class="blue" width="8%">��ע</th>-->
						<th align="center" class="blue" width="8%">����</th>
						<th align="center" class="blue" width="8%">��λ</th>
						<th align="center" class="blue" width="8%">����ʱ��</th>

					</tr>
					
					<div id ="checknull" style="display: none;">
					<input type="hidden" name="checkid" id ="checkid" value="0">
					</div>
					<%
							for (int i = 0; i < dataRows.length; i++) {
							String tdClass = "";
					%>

					<%
								if ((i + 1) % 2 == 1) {
								tdClass = "grey";
							}
					%>
					<tr>
					    
					    <td align="center" class="<%=tdClass%>" nowrap="nowrap"><input type="checkbox" name="obj_id"  value="<%= dataRows[i][0] %>" onclick="setObjID(this.value);"></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][0].length() != 0) ? dataRows[i][0]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][1].length() != 0) ? dataRows[i][1]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][2].length() != 0) ? dataRows[i][2]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length() != 0) ? dataRows[i][3]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][12].length() != 0) ? dataRows[i][12]: "&nbsp;"%></td>
						
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][13].length() != 0) ? dataRows[i][13]: "&nbsp;"%></td>
						
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length() != 0) ? dataRows[i][4]: "&nbsp;"%></td>
						<!--<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][5].length() != 0) ? dataRows[i][5]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][6].length() != 0) ? dataRows[i][6]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][7].length() != 0) ? dataRows[i][7]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][8].length() != 0) ? dataRows[i][8]: "&nbsp;"%></td>-->
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><%=(dataRows[i][9].length() != 0) ? dataRows[i][9]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][10].length() != 0) ? dataRows[i][10]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><%=(dataRows[i][11].length() != 0) ? dataRows[i][11]: "&nbsp;"%></td>

					</tr>
					<%
					}
					%>
				</table>
				<table  cellspacing="0">
				    <tr >
				      <td class="blue"  align="right" width="720">
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
		<%@ include file="/npage/include/footer.jsp"%>
	</body>
</html>

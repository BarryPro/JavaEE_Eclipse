<%
  /*
	* ����: ���Ͱ�����ѯ
	* �汾: 1.0
	* ����: 2009/09/09
	* ����: guozw
	* ��Ȩ: sitech
	* update: tangsong 2011/06/12 ��ΪCSP6.0ģʽ
	*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
	String start_date = request.getParameter("start_date");
	String end_date = request.getParameter("end_date");
	String remarkClassId = request.getParameter("remarkClassId");
	String remarkClassName = request.getParameter("remarkClassName");
	String evterno = request.getParameter("evterno");
	String staffno = request.getParameter("staffno");
	String recordernum = request.getParameter("recordernum");
	String remarkDesc = request.getParameter("remarkDesc");
	
	String[][] dataRows  = new String[][]{};
	
	int rowCount   =0;              //���ϲ�ѯ�������ܼ�¼��
	int pageSize   = 15;            // ÿҳ��¼��
	int pageCount  = 0;             // ��ҳ��
	int curPage    = 0;             // ��ǰҳ��
	String strPage;                 // ��תҳ��
	String action    = request.getParameter("myaction");   //��ѯ��־��ֻ��doloadһֵ
	if("doLoad".equals(action)){
		HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("remarkClassId", remarkClassId);
		pMap.put("evterno", evterno);
		pMap.put("staffno", staffno);
		pMap.put("recordernum", recordernum);
		pMap.put("remarkDesc", remarkDesc);
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K210_strCountSql",pMap)).intValue();
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
		List queryList =(List)KFEjbClient.queryForList("query_K210_sqlStr",pMap);     
		dataRows = getArrayFromListMap(queryList,1,9);  
	}
%>
<html>
<head>
<title>���Ͱ�����ѯ</title>
<link href="<%=request.getContextPath()%>/npage/callbosspage/css/tablestyle.css" rel="stylesheet" type="text/css"></link>
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
    	submitMe();
    }
}

//�ύ��ѯ����
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K210_Main.jsp";
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
}

//����
function expExcel(expFlag){
	document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcResultQry.jsp?exp="+expFlag;
	document.sitechform.method='post';
	document.sitechform.submit();
}

//��ʾ�ʼ�����ϸ��Ϣ
function getQcDetail(contact_id,isPwdVer,object_id,contact_id_kf){
	var path="../K211/K211_getResultDetail.jsp";
	path = path + "?contact_id=" + contact_id + "&isPwdVer=" + isPwdVer + "&object_id=" + object_id + "&contact_id_kf=" + contact_id_kf;
	var height = 600;
	var width  = 1000;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	         'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
    window.open(path, 'detailWin', param);
	return true;
}

//ҵ������Ϊ����ԭ��
//�����𡢲��ȼ�������ԭ��
function getThisTree(flag,title){
	var path="../K209/fk240to270_tree.jsp?op_code="+flag;
	flag = flag.substr(1,flag.length-1);
	if(flag=='240'){
		title="ѡ�������";
	}else if(flag=='250'){
		title="ѡ����ȼ�";
	}else if(flag=='270'){
		title="ѡ������ԭ��";
	}else if (flag=='271'){
		title="ѡ��������";
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

//ɾ���ʼ���
function deleteQcInfo(serialnum){
	if(rdShowConfirmDialog("��ȷ��ȡ���˰���ô��")=='1'){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K210/K210_deleteQcInfo_rpc.jsp","����ȡ�����������Ժ�...");
	  chkPacket.data.add("serialnum", serialnum);
    core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
	  chkPacket =null;
	}
}

function doProcessDeleteQcInfo(packet){
  var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("ȡ�����Ͱ����ɹ���");
		window.sitechform.myaction.value="doLoad";
    window.sitechform.action="K210_Main.jsp";
    window.sitechform.method='post';
    setTimeout("document.sitechform.submit()",2000);
    //document.sitechform.submit();
	}else{
		similarMSNPop("ȡ�����Ͱ���ʧ�ܣ�");
	}
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
	openWinMidForLoad("k210_expSelect.jsp?flag=" + flag, 'selectExpColumnWin',340,320);
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
<input type="hidden" name="myaction" value="">
<input type="hidden" name="page" value="">
<div id="Operation_Table" style="width: 100%;">
	<table cellspacing="0" style="width:100%">
		<tr><td colspan='6' ><div class="title"><div id="title_zi">���Ͱ�����ѯ</div></div></td></tr>
		<tr>
			<td nowrap >��ʼʱ��</td>
			<td nowrap >
				<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" />
				<img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
			</td>
			<td nowrap >�ʼ칤��</td>
			<td nowrap >
				<input type="text" name="evterno" id="evterno" value="<%=(evterno==null)?"":evterno%>">
			</td>
			<td nowrap >������ˮ��</td>
			<td nowrap >
				<input id="recordernum" name="recordernum" type="text" value="<%=(recordernum==null)?"":recordernum%>">
			</td>
		</tr>
		<tr >
			<td nowrap >����ʱ��</td>
			<td nowrap >
				<input type="text" id="end_date" name ="end_date" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" maxlength="17" onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"/>
				<img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
			</td>
			<td nowrap >��������</td>
			<td nowrap >
				<input id="remarkClassName" name="remarkClassName" type="text" value="<%=(remarkClassName==null)?"":remarkClassName%>" readonly="readonly" />
				<img onClick="getThisTree('K271')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<img onClick="remarkClassName.value='';remarkClassId.value=''" alt="���" src="<%=request.getContextPath()%>/nresources/default/images/tabimages/icon_close_off.gif" width="16" height="16" align="absmiddle">
				<input  id="remarkClassId" name="remarkClassId" type="hidden" value="<%=(remarkClassId==null)?"":remarkClassId%>">
			</td>
			<td nowrap >��������</td>
			<td nowrap >
				<input type="text" name="remarkDesc" id="remarkDesc"value="<%=(remarkDesc==null)?"":remarkDesc%>">
			</td>
		</tr>
		<tr>
			<td colspan="6" align="center" id="footer" style="width:420px">
				<input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
				<input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
				<input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
				<input name="export" type="button"  id="search" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table" style="width:100%">
	<table  cellSpacing="0" >
	<tr>
	<td class="blue"  align="left" colspan="7">
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
	<span>������ת</span>
	<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
	<font face=����>GO</font> 
	<%}%>
	</td>
	</tr>	
	<tr>
		<script>
			var tempBool ='flase';
			if(checkRole(K210A_RolesArr)==true||checkRole(K210B_RolesArr)==true||checkRole(K210D_RolesArr)==true){
				document.write('<th align="center" class="blue" width="15%" ><nobr> ���� </th>');
				tempBool='true';
			}
		</script>
		<th align="center" class="blue" width="15%" ><nobr> ������ˮ�� </th>
		<th align="center" class="blue" width="15%" ><nobr> �ʼ칤��</th>
		<th align="center" class="blue" width="15%" ><nobr> ���칤�� </th>
		<th align="center" class="blue" width="15%" ><nobr> ����ʱ��</th>
		<th align="center" class="blue" width="15%" ><nobr> ��������</th>
		<th align="center" class="blue" width="15%" ><nobr> ��������</th>
	</tr>
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
      	if(checkRole(K210A_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][1]%>\');return false;" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(checkRole(K210B_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="getQcDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][7]%>\',\'<%=dataRows[i][8]%>\',\'<%=dataRows[i][1]%>\');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
      	if(checkRole(K210D_RolesArr)==true){
      		document.write('<img style="cursor:hand" onclick="deleteQcInfo(\'<%=dataRows[i][0]%>\')" alt="ȡ�����Ͱ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">&nbsp;');
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>                                                                                       
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>                                                                                             
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="left" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
    </tr>
    <% } %>
      
    <tr>
      <td class="blue" align="right" colspan="7">
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
<script language="javascript">
 //��ת��ָ��ҳ��
 function jumpToPage(operateCode){
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
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
<%
  /*
   * ����: �ʼ���ȷ����Ϣ��ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update: mixh 2009/02/19 ��������������ʱ�������ջ��档
   * update: mixh 2009/08/19 �ʼ��鳤������Ա���Բ�ѯ������֪ͨ��Ϣ��
   *
   *
 ��*/
 %>


<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
	String opCode="K202";
	String opName="�ʼ��ѯ-�ʼ���ȷ����Ϣ��ѯ";
	
	String isCheckLogin = "N";// Y: ���ʼ�Ȩ�޹���,N:�����ʼ�Ȩ�޹���
	String loginNo      = (String)session.getAttribute("workNo");  //�ͷ����ţ���ʽΪ��λ����
	String sqlLogin     = "";
	String bossLoginNo  = "";

	String  powerCode   = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	System.out.println("################################");
	System.out.println(powerCode);
	System.out.println("################################");
	String[] powerCodeArr  = powerCode.split(",");
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<ZHIJIANYUAN_ID.length; j++){
			if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i]) || FUHEYUAN_ID.equals(powerCodeArr[i])){
				isCheckLogin="Y";
			}
		}
		for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
			if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
				isCheckLogin="Y";
			}
		}
	}
%>

<%
    //ͳһ����
    if(loginNo !=null && loginNo.length() == 5){
	      loginNo = loginNo.substring(loginNo.length()-2,loginNo.length());
	      loginNo = "1" + loginNo;
    }  

  	
	String isPower="N";
	for(int i = 0; i < powerCodeArr.length; i++){
		if(FUHEYUAN_ID.equals(powerCodeArr[i])){
		  isPower="Y";
		}
		for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
			if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
				isPower="Y";
			}
		}
	}

    String start_date    =  request.getParameter("start_date");
    String end_date      =  request.getParameter("end_date");
    String submitno      =  request.getParameter("submitno");
    String evterno       =  request.getParameter("evterno");
    String serialno      =  request.getParameter("serialno");
    String staffno       =  request.getParameter("staffno");
    String serialnum     =  request.getParameter("serialnum");
    String statisfy_code   =  request.getParameter("statisfy_code");
		//zengzq add ���Ӳ�ѯ���� ���˿������Ƕ��˿���
    String group_flag   = request.getParameter("group_flag");
    
	String[][] dataRows = new String[][]{};
	int rowCount   = 0;
	int pageSize   = 15;            // Rows each page
	int pageCount  = 0;             // Number of all pages
	int curPage    = 0;             // Current page
	String sqlTemp = "";
	String strPage;                 // Transfered pages	

	String expFlag   = request.getParameter("exp");
	String sqlFilter = request.getParameter("sqlFilter");
	String action    = request.getParameter("myaction");
	String[] strHead= {"�ʼ���ȷ����ˮ��","������ˮ��","�ʼ���ȷ�ϱ���","�ύ�˹���","�ʼ���״̬","�ʼ쵥��ˮ��","���칤��","�ʼ�Ա����","�ύʱ��"};	
	

	//��ʾָ��ҳ�������
	if ("doLoad".equals(action)) {
		HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("submitno", submitno);
		pMap.put("evterno", evterno);
		pMap.put("serialno", serialno);
		pMap.put("staffno", staffno);
		pMap.put("serialnum", serialnum);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("group_flag", group_flag);
		pMap.put("isPower", isPower);
		//added by tangsong 20100524 ����Աֻ�ܲ�ѯ�Լ��ļ�¼
		pMap.put("loginNo", loginNo);
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K202_strCountSql",pMap)).intValue();
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
			curPage = Integer.parseInt(strPage);
			if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        int start = (curPage - 1) * pageSize + 1;
		    int end = curPage * pageSize;
		    pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList =(List)KFEjbClient.queryForList("query_K202_sqlStr",pMap);     
        dataRows = getArrayFromListMap(queryList ,1,22);  
    }

	
%>


<html>
<head>
<title>�ʼ���ȷ����Ϣ��ѯ</title>
<style>
		img{
				cursor:hand;
		}
</style>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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

function submitInputCheck(){
	if( document.sitechform.start_date.value == ""){
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

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K202_qcResultCfmInfo.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

function doLoad(operateCode){
   if(operateCode=="load"){
   		window.sitechform.page.value="";
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
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K202/K202_qcResultCfmInfo.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.start_date.value="<%=start_date%>";
	window.sitechform.end_date.value="<%=end_date%>";
	window.sitechform.statisfy_code.value="<%=request.getParameter("statisfy_code")%>";
	window.sitechform.submitno.value="<%=submitno%>";
	window.sitechform.evterno.value="<%=evterno%>";
	window.sitechform.serialnum.value="<%=serialnum%>";
	window.sitechform.staffno.value="<%=staffno%>";
	window.sitechform.serialno.value="<%=serialno%>";
	window.sitechform.group_flag.value="<%=group_flag%>";
}

//��ʾͨ����ϸ��Ϣ
function getDetail(serialno,serialnum){
	var time = new Date();
	var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K203/K203_qcResDetailFeedback.jsp?now=' + time;
	path = path + '&serialno=' + serialno;
	path = path + '&serialnum=' + serialnum;
		var Height = window.screen.availHeight - 200; 
	var width  = window.screen.availWidth  - 200;
	var top    = (window.screen.availHeight-30 - Height)/2; //��ô��ڵĴ�ֱλ��;
	var left   = (window.screen.availWidth-10 - width)/2; //��ô��ڵ�ˮƽλ��;
	var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
	             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
	window.open(path, 'feedbackWin', param);	

}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=yes,location=no,status=no');
}

//��������
function showExpWin(flag){
	window.sitechform.page.value="<%=curPage%>";
	window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	openWinMid('k202_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
}

//ѡ���и�����ʾ �б�ɫ
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

<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
<div id="Operation_Table" style="width: 100%;">
	<table cellspacing="0" style="width:100%;">
		<tr><td colspan='6' ><div class="title"><div id="title_zi">�ʼ���ȷ����Ϣ��ѯ</div></div></td></tr>
    <tr>
    	<td> ��ʼʱ�� </td>
        <td>
	    <input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
        </td>
        <td> �ύ�˹���</td>
        <td>
        <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
		<input id="submitno" name="submitno" type="text" maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(submitno==null)?"":submitno%> >
        </td>
		<td> �ʼ칤�� </td>
        <td>
	    <input name ="evterno" type="text" id="evterno"  maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(evterno==null)?"":evterno%>">
        </td>
    </tr>
    <tr>
    	<td> ����ʱ�� </td>
    	<td>
		<input id="end_date" name ="end_date" type="text" value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"/>
		<img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		<font color="orange">*</font>
		</td>
		<td> ȷ����ˮ�� </td>
      	<td>
      <!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->	
			<input name ="serialno" type="text" id="serialno" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serialno==null)?"":serialno%>">
      	</td>
      	<td> ���칤�� </td>
      	<td>
    <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->  	
		<input name ="staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      	</td>
	</tr>
    <tr>
    	<td> �ʼ���ˮ�� </td>
      	<td>
      	<!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->	
		<input name ="serialnum" type="text" id="serialnum" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serialnum==null)?"":serialnum%>">
      	</td>
       <td>���״̬</td>
      	<td>
      	<select name="statisfy_code" id="statisfy_code" size="1" >
      	<option value="" selected >4��ȫ��</option>
		<option value="0" <%="0".equals(statisfy_code)?"selected":""%>>0:�ʼ���֪ͨ</option>
		<option value="1" <%="1".equals(statisfy_code)?"selected":""%>>1:����</option>
		<option value="2" <%="2".equals(statisfy_code)?"selected":""%>>2:��</option>
		<option value="3" <%="3".equals(statisfy_code)?"selected":""%>>3:ȷ��</option>
        </select>
      	</td>
		<td>�������</td>
	<td>
		<select name="group_flag" id="group_flag" size="1"  >
		<option value="" selected >2-ȫ��</option>
		<option value="0" <%="0".equals(group_flag)?"selected":""%>>���˿���</option>
		<option value="1" <%="1".equals(group_flag)?"selected":""%>>���忼��</option>
		</select>
	</td>
	</tr>
    <tr>
    	<td colspan="6" align="center" id="footer" style="width:420px">
        <!--zhengjiang 20091004 ��ѯ�����û�λ��-->
       	<input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
       	<input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
		<input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       	<!--<input name="exportAll" type="button"  id="add" value="����ȫ��" onClick="showExpWin('all')">-->
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
	<input type="hidden" name="isPower" value="<%=isPower%>">
	
	<tr>
    	<td class="blue"  align="left" colspan="10">
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
    <tr>
	<script>
	var tempBool ='flase';
	if(checkRole(K202A_RolesArr)==true){
		document.write('<th align="center" class="blue" width="15%" ><nobr> ���� </th>');
		tempBool='true';
	}
	</script>
	
	<th align="center" class="blue" width="25%" ><nobr> �ʼ���ȷ����ˮ�� </th>
	<th align="center" class="blue" width="25%" ><nobr> ������ˮ�� </th>
	<th align="center" class="blue" width="25%" ><nobr> �ʼ���ȷ�ϱ��� </th>
	<th align="center" class="blue" width="30%" ><nobr> �ύ�˹��� </th>
	<th align="center" class="blue" width="25%" ><nobr> �ʼ���״̬ </th>
	<th align="center" class="blue" width="25%" ><nobr> �ʼ쵥��ˮ��</th>
	<th align="center" class="blue" width="25%" ><nobr> ���칤�� </th>
	<th align="center" class="blue" width="30%" ><nobr> �ʼ�Ա���� </th>
	<th align="center" class="blue" width="25%" ><nobr> �ύʱ�� </th>
	</tr>

<%
           for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
%>
<%
          if((i+1)%2==1){
          tdClass="blue";
%>
          <tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
				}else{
%>
	   <tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
		}
%>

<script>
      	if(tempBool=='true'){
      			document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K202A_RolesArr)==true){
      			document.write('<img onclick="getDetail(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][5]%>\')" alt="�ʼ���ȷ����Ϣ���鼰������Ϣ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">');
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
<%
      if("Y".equals(isCheckLogin)){
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
<%
      }else{
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> ******</td>
<%
      }
%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
    </tr>
<%
      }
%>
	<tr>
		<td class="blue"  align="right" colspan="10">
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
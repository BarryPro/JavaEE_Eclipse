<%
  /*
   * ����: ��ϸ�ƻ�չʾҳ��
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����:
�� * ��Ȩ: sitech
   *
 ��*/
%>

<%
	String opCode = "K310";
	String opName = "��ϸ�ƻ�չʾҳ��";
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "֪ͨ���Ͳ�ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
        }catch  (Exception e1) {
           e1.printStackTrace();
        }
    }

  public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
    //��ѯDQCPLAN
    String beginTime   = request.getParameter("beginTime");            //��ʼʱ��
    String endTime     = request.getParameter("endTime");
    String CHECK_TYPE   = request.getParameter("CHECK_TYPE");
    String CHECK_KIND   = request.getParameter("CHECK_KIND");
    String GROUP_FLAG   = request.getParameter("GROUP_FLAG");
    String CHECK_CLASS   = request.getParameter("CHECK_CLASS");
    String PLAN_ID   = request.getParameter("PLAN_ID");
    String PLAN_NAME   = request.getParameter("PLAN_NAME");

    //��ѯDQCLOGINPLAN
    String OBJECT_ID   = request.getParameter("OBJECT_ID");
    String CONTENT_ID   = request.getParameter("CONTENT_ID");
    String LOGIN_NO   = request.getParameter("LOGIN_NO");

    //��ѯDQCCHECKLOGINPLAN
    String CHECK_LOGIN_NO   = request.getParameter("CHECK_LOGIN_NO");

    //��������
    String[][] dataRows = new String[][]{};
    String[][] dataTemp = new String[][]{};
    int rowCount=0;
    int pageSize = 10;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String[] strHead= {"���͹���","���չ���","֪ͨ����","����ʱ��","��Ϣ���"};
    String action = request.getParameter("myaction");
	String expFlag = request.getParameter("exp");        //������ʾ
	String sqlFilter = request.getParameter("sqlFilter");
	String needt3 = "";
	String sqlFilter2 = "";
    
	
    
    //���������ļ�¼����
    if ("doLoad".equals(action)) {
       HashMap pMap=new HashMap();
				pMap.put("beginTime",beginTime);
				pMap.put("endTime",endTime);
				pMap.put("CHECK_TYPE",CHECK_TYPE);
				pMap.put("CHECK_KIND",CHECK_KIND);
				pMap.put("GROUP_FLAG",GROUP_FLAG);
				pMap.put("CHECK_CLASS",CHECK_CLASS);
				pMap.put("PLAN_ID",PLAN_ID);
				pMap.put("PLAN_NAME",PLAN_NAME);
				pMap.put("OBJECT_ID",OBJECT_ID);
				pMap.put("CONTENT_ID",CONTENT_ID);
				pMap.put("LOGIN_NO",LOGIN_NO);
				pMap.put("CHECK_LOGIN_NO",CHECK_LOGIN_NO); 
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K310_detail_strCountSql",pMap)).intValue();
	
	//��ҳ����
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
		    
		    List queryList =(List)KFEjbClient.queryForList("query_K310_detail_sqlStr",pMap); 
	      dataRows = getArrayFromListMap(queryList ,1,18);        
	
}


%>

<html>
<head>
<title>�ʼ�ƻ���ϸҳ��</title>

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

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(){
   if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"�������ڲ���Ϊ�գ������ѡ�������");
		sitechform.endTime.focus();
    }
  else if(document.sitechform.endTime.value<=document.sitechform.beginTime.value){
		 showTip(document.sitechform.endTime,"����ʱ�������ڿ�ʼʱ��");
    sitechform.endTime.focus();
    }
   else {
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    doSubmit();
    }
}
function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="K310_query_detail.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//=========================================================================
// LOAD PAGES.
//=========================================================================
function doLoad(operateCode){
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
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
   window.sitechform.myaction.value="doLoad";
   keepValue();
   window.sitechform.action="K310_query_detail.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/K310_query_detail.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

/**
  *���ֲ�ѯ����
  */
function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
}

/**
  *�޸�һ���ƻ���ϸ
  */
function mendCheck(){
   var primarykeys = document.getElementsByName("primarykey");
	var primarykey = "";
	for(var i = 0; i < primarykeys.length; i++){
		if(primarykeys[i].checked){
			primarykey = primarykeys[i].value;
			break;
		}
	}
	if(primarykey==''){
	similarMSNPop("û��ѡ��Ҫ�޸ĵļ�¼��");
	return false;
	}
	var time     = new Date();
	var winParam = 'dialogWidth=500px;dialogHeight=380px';
        //modified by liujied 20091015
        var return_value = window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_mend.jsp?time="+time+"&primarykey="+primarykey,window, winParam);
        
        if(return_value == "reload")
        {
             window.location.reload();
        }
}

/**
  *ɾ���ƻ���ϸǰ���ж�
  */
function deleteCheck(){
	var primarykeys = document.getElementsByName("primarykey");
	var primarykey = "";
	for(var i = 0; i < primarykeys.length; i++){
		if(primarykeys[i].checked){
			primarykey = primarykeys[i].value;
			break;
		}
	}
	if(primarykey == ''){
		similarMSNPop("û��ѡ��Ҫɾ���ļ�¼��");
		return false;
	}
	
	if(rdShowConfirmDialog("��ȷ����Ҫɾ��������¼��")=="1"){
		deleteRec(primarykey);
	}
}

/**
  *ɾ��һ���ƻ���ϸ
  */
function deleteRec(primarykey){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_delet_login_plan.jsp","...");
	mypacket.data.add("primarykey",primarykey);
	core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

/**
  *ɾ��֮�󷵻ش�����
  */
function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("ɾ���ɹ���");
		window.sitechform.myaction.value="doLoad";
	    keepValue();
	    window.sitechform.action="K310_query_detail.jsp";
	    window.sitechform.method='post';
	    //document.sitechform.submit();
	    //�ȴ�2.5���ִ�в�����ȷ���������Ѿ����� zengzq 20090526
	    setTimeout("document.sitechform.submit()",2500);    
	}else{
		similarMSNPop("ɾ��ʧ�ܣ�");
	}
}

//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ

/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
function changeColor(color,obj,pkey){
	document.getElementById(pkey).click();
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

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form id="sitechform" name="sitechform">

  <div id="Operation_Table" style="width:100%">
	<table  cellspacing="0">
    <tr>
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
    <table  cellSpacing="0" >
		<input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<input type="hidden" name="sqlFilter" value="">
		<!--ҳ�����-->
		<input type="hidden" name="beginTime" value="<%=beginTime%>">
		<input type="hidden" name="endTime" value="<%=endTime%>">
		<input type="hidden" name="CHECK_TYPE" value="<%=CHECK_TYPE%>">
		<input type="hidden" name="CHECK_KIND" value="<%=CHECK_KIND%>">
		<input type="hidden" name="GROUP_FLAG" value="<%=GROUP_FLAG%>">
		<input type="hidden" name="CHECK_CLASS" value="<%=CHECK_CLASS%>">
		<input type="hidden" name="PLAN_ID" value="<%=PLAN_ID%>">
		<input type="hidden" name="PLAN_NAME" value="<%=PLAN_NAME%>">
		<input type="hidden" name="OBJECT_ID" value="<%=OBJECT_ID%>">
		<input type="hidden" name="CONTENT_ID" value="<%=CONTENT_ID%>">
		<input type="hidden" name="LOGIN_NO" value="<%=LOGIN_NO%>">
		<input type="hidden" name="CHECK_LOGIN_NO" value="<%=CHECK_LOGIN_NO%>">
		<!--ѡ�е�ֵ��������-->
		<input type="hidden" name="checkPlanNo" value="">
		<input type="hidden" name="content_id" value="">
		<input type="hidden" name="object_id" value="">
		<input type="hidden" name="login_id" value="">

		<tr>
		<th align="center" class="blue" nowrap > ѡ�� </th>
		<th align="center" class="blue" nowrap> �ƻ�ID�� </th>
		<th align="center" class="blue" nowrap> ���� </th>
		<th align="center" class="blue" nowrap> ��ʼ���� </th>
		<th align="center" class="blue" nowrap> ��ֹ���� </th>
		<th align="center" class="blue" nowrap> ���ʼ칤��/��ˮ�� </th>
		<th align="center" class="blue" nowrap> ���������� </th>
		<th align="center" class="blue" nowrap> �ƻ���� </th>
		<th align="center" class="blue" nowrap> �������� </th>
		<th align="center" class="blue" nowrap> ������� </th>
		<th align="center" class="blue" nowrap> ������ʽ </th>
		<th align="center" class="blue" nowrap> �ƻ����� </th>
		<th align="center" class="blue" nowrap> ������� </th>
		<th align="center" class="blue" nowrap> ������� </th>
		</tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this,'primarykey<%=i%>');">
			<%}else{%>
	   <tr onClick="changeColor('<%=tdClass%>',this,'primarykey<%=i%>');">
	<%}%>
      <td align="center" class="<%=tdClass%>">
      	<input type="radio" name="primarykey" id="primarykey<%=i%>" value="<%=dataRows[i][14]%>"/>
      </td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>">
      	<%
	      	if("0".equals(dataRows[i][5])){
	        	  	out.println("��������");
	        }else if("1".equals(dataRows[i][5])){
	        	  	out.println("����");
	        }else if("2".equals(dataRows[i][5])){
	        	  	out.println("����");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      </td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>">
      	<%
	      	if("0".equals(dataRows[i][7])){
	        	  	out.println("ʵʱ�ʼ�");	
	        }else if("1".equals(dataRows[i][7])){
	        	  	out.println("�º��ʼ�");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      	</td>
      <td align="center" class="<%=tdClass%>">
      	<%
	      	if("0".equals(dataRows[i][8])){
	        	  	out.println("�Զ�����");
	        }else if("1".equals(dataRows[i][8])){
	        	  	out.println("�˹�ָ��");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      </td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>      
      <% } %>
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

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td id="footer"  align=left>
	
		<input class="b_foot" name="modifyOne" type="button"  value="�޸�" onclick="mendCheck();" >
		<input class="b_foot" name="deletOne" type="button"  value="ɾ��" onclick="deleteCheck();" >
	</td>
	</tr>
	</table>

</div>
</form>
</div>
</body>
</html>

<script language="javascript">

function setPlanNo(planNo)
{
  document.getElementById("checkPlanNo").value = document.getElementById("plan_id"+planNo).value;
  document.getElementById("content_id").value  = document.getElementById("content_id"+planNo).value;
  document.getElementById("object_id").value   = document.getElementById("object_id"+planNo).value;
  document.getElementById("login_id").value    = document.getElementById("login_id"+planNo).value;
}

function submitQcContent(){
		var height = 700;
		var width = 1000;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	  window.open("../../../../npage/callbosspage/checkWork/K310/K310_qc_main.jsp", "outHelp", winParam);
}

function viewCheck1(){
	 var planNo=document.getElementById("checkPlanNo").value;

	if(planNo=='')
	{
	similarMSNPop("û��ѡ��Ҫ�鿴�ļ�¼��");
	return false;
	}
	var height = 300;
	var width = 420;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	window.open("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?plan_id="+planNo, "outHelp", winParam);
}
</script>
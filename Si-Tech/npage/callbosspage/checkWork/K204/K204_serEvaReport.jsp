<%
   /*
    * ����: �������۱����ѯ����ҳ��
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc
�� * ��Ȩ: sitech
    *  upd : mixh 2009/02/20
    *          1��һ������ֻ��ʾһ����¼
    *          2��������ťû����ʾ
    *
    *          mixh  2009/03/27
    *          1�����Ȩ��У��
    *
 ��*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	String opCode       = "K204";
	String opName       ="�ʼ��ѯ-�������۱����ѯ";
%>

<%!

	public  String getCurrDateStr(String str) {
			java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
			return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>



<%
	//zengzq modify 20091021 ��(String)session.getAttribute("kfWorkNo") ��kfWorkNo ����ΪworkNo��ȡkf��ͷ�Ĺ���
	//String loginNo       = (String)session.getAttribute("kfWorkNo");  //�ͷ�ϵͳ���� 
	
	String loginNo       = (String)session.getAttribute("workNo");  //�ͷ�ϵͳ���� 
	String orgCode       = (String)session.getAttribute("orgCode");   //
	/*midify by yinzx 20091113 ������ѯ�����滻*/
	String myParamspub="";  
 	String regionCode = orgCode.substring(0,2);
	String qc_type       = request.getParameter("qc_type");
	String skill_type     = request.getParameter("skill_type");
	String isCheckLogin = "N";     //�Ƿ���Ȩ�޲鿴����ҵ�����ķ������۱��� ("Y"�У�"N"��)
	boolean isPersonal  = true; 
	                                                 //trueΪ���˿�����falseΪ���忼��
	if("1".equals(qc_type)){
			//isPersonal=false;
	}

	String start_date          =  request.getParameter("start_date");
	String end_date            =  request.getParameter("end_date");
	String objectid            =  request.getParameter("0_str_t1.objectid");
		
	if(objectid==null){
		objectid="";
	}
	String objectTypeName  = request.getParameter("objectTypeName");
	String staffno             =  request.getParameter("2_=_t1.staffno");

	/*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� mixh add 20090327*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
        for(int j = 0;j < powerCodeArr.length;j++ ){
            System.out.println("powerCodeArr["+j+"]:"+powerCodeArr[j]);
        }
            System.out.println("zhijianyuanid:"+ZHIJIANYUAN_ID);
	/*
	 *�Ƿ����ʼ�Ա ���Ի�����[0100020I] ����������[01120O0E]��   ����ʱ��һ��
	 *�Ƿ��Ǹ���Ա ���Ի�����[0100020K] ����������[01120O0B]��   ����ʱ��һ��
	 *�Ƿ����ʼ��鳤 ���Ի�����[0100020J] ����������[01120O0C]������ʱ��һ��
	 *
	 */
		for(int i = 0; i < powerCodeArr.length; i++){
			if (FUHEYUAN_ID.equals(powerCodeArr[i])) {
				isCheckLogin="Y";
				break;
			}
			for(int j=0; j< ZHIJIANYUAN_ID.length; j++) {
				if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i])){
					isCheckLogin="Y";
					break;
				}
			}
			for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
				if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
					isCheckLogin="Y";
					break;
				}
			}
		}
	//isCheckLogin="Y";	

%>

<%
  
	String[][] dataRows = new String[][]{};
	int rowCount =0;
	int pageSize = 15;            // Rows each page
	int pageCount=0;               // Number of all pages
	int curPage=0;                 // Current page
	String strPage;               // Transfered pages
	String sqlTemp ="";
	String action = request.getParameter("myaction");
	String[] strHead= {"����","��ͨ�ͻ�����","VIP�ͻ�����ȫ��ͨ�ͻ�����","�ۺϵ÷�"};
	String expFlag = request.getParameter("exp");

%>

<%
   HashMap hashMap =new HashMap();
  
	 hashMap.put("start_date",start_date); 
   hashMap.put("end_date",end_date); 
   hashMap.put("loginNo",loginNo); 
   hashMap.put("staffNo",staffno); 
   hashMap.put("objectid",objectid); 
   hashMap.put("group_flag",qc_type); 
   hashMap.put("hasMoreCondition","Y"); 
   hashMap.put("isCheckLogin",isCheckLogin);

	if ("doLoad".equals(action) && isPersonal) {
	    rowCount=((Integer)KFEjbClient.queryForObject("k204reportselect_CountSql",hashMap)).intValue(); 
      
			strPage = request.getParameter("page");
			if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
					curPage = 1;
			}
	else {
				curPage = Integer.parseInt(strPage);
				if( curPage < 1 ) curPage = 1;
	}
    
	pageCount = ( rowCount + pageSize - 1 ) / pageSize;
	if (curPage > pageCount) curPage = pageCount;
	 int start = (curPage - 1) * pageSize + 1;
	 int end = curPage * pageSize;
	 hashMap.put("start", ""+start);
	 hashMap.put("end", ""+end);

   List iDataList3 =(List)KFEjbClient.queryForList("k204reportselect",hashMap);                              
	 dataRows = getArrayFromListMap(iDataList3 ,1,25);    

	}
	String thSqlStr = "select t1.name,t1.object_id,t1.contect_id from dqccheckcontect t1,dqcobject t2 where t1.object_id=:objectid and t1.object_id=t2.object_id and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
	myParamspub= "objectid="+objectid.trim() ;
 %>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=thSqlStr%>"/>
	<wtc:param value="<%=myParamspub%>"/>
	</wtc:service>
	<wtc:array id="thName"  scope="end"/>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������۱����ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<style>
  img{
  cursor:hand;
  }
</style>
<script language=javascript>
$(document).ready(
	function(){
    		$("td").not("[input]").addClass("blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");
		$("input:text[@v_type]").blur(checkElement2);

		$("a").hover(function() {
			$(this).css("color", "orange");
		}, function() {
			$(this).css("color", "blue");
		});
});

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
    }else if(document.sitechform.objectTypeName.value==""){
				showTip(document.sitechform.objectTypeName,"���������Ϊ�գ�");
				sitechform.end_date.focus();
    }else{
    	/*�ж��Ǹ��˷������۱����ѯ���Ƕ��˷������۱����ѯ*/
    	var tmp_qc_type = document.getElementById("qc_type").value ;	//����Ϊ0 ����Ϊ1
    	
				document.getElementById("groupflag").value = tmp_qc_type;	//����Ϊ0 ����Ϊ1
		    hiddenTip(document.sitechform.start_date);
		    hiddenTip(document.sitechform.end_date);
		    hiddenTip(document.sitechform.objectTypeName);
		    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
		    submitMe();
    }
}


function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K204_serEvaReport.jsp";
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
				if(e[i].type=="text"||e[i].type=="hidden"){
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
				if(e[i].type=="select-one"){
						document.getElementById(e[i].id).options[0].selected = true;
				}
		}
		document.getElementById("groupflag").value = "0";	//����Ϊ0 ����Ϊ1
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K204/K204_serEvaReport.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.objectTypeName.value="<%=objectTypeName%>";
    window.sitechform.staffno.value="<%=staffno%>";
}

//��ʾͨ����ϸ��Ϣ
function getDetail(staffno,objectid){
		var group_flag = document.getElementById("qc_type").value;
		var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K204/K204_repDetailQry.jsp";
    path = path + "?staffno=" + staffno;
    path = path + "&start_date=" + "<%=start_date%>";
    path = path + "&end_date=" + "<%=end_date%>";
    path = path + "&objectTypeName=" + "<%=objectTypeName%>";
    path = path + "&objectid=" + objectid;
     path = path + "&group_flag=" + group_flag;
    window.open(path,"newwindow","height=600, width=960,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

//�������
function showObjectCheckTree(){
		var path= 'K204_objectIdTree.jsp';
		var param  = 'dialogWidth=300px;dialogHeight=250px';
		var returnValue = window.showModalDialog(path,'ѡ���ʼ�Ⱥ��',param);

		if(typeof(returnValue) != "undefined"){
				var objectid = document.getElementById("objectid");
				var objectTypeName   = document.getElementById("objectTypeName");
				var temp = returnValue.split('_');
				objectid.value = trim(temp[0]);
				objectTypeName.value = trim(temp[1]);
	 }
}

//����Ⱥ��
function showBeCheckedGroTree(){
	alert("aaaa");
}

function test(){
	alert("aaaa");
}

function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
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

//��������
function showExpWin(flag){
		var sqlFilter = "";
		var objectid ='<%=objectid%>';
		var group_flag = document.getElementById("qc_type").value;
		var staffno = document.getElementById("staffno").value;
		var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K204/k204_expSelect.jsp?flag="+flag;
    path = path + "&staffno=" + staffno;
    path = path + "&start_date=" + "<%=start_date%>";
    path = path + "&end_date=" + "<%=end_date%>";
    path = path + "&objectTypeName=" + "<%=objectTypeName%>";
    path = path + "&objectid=" + objectid;
    path = path + "&group_flag=" + group_flag;
		openWinMid(path,'ѡ�񵼳���',340,320);
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
    <div id="Operation_Table" style="width:100%;">
      <table cellspacing="0" style="width:100%">
	<tr><td colspan='6' ><div class="title"><div id="title_zi">�������۱����ѯ</div></div></td></tr>
     	<tr >
          <td > ��ʼʱ�� </td>
          <td >
	    <input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
              <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                <font color="orange">*</font>
              </td>
              

	      
	      <td > ������� </td>
              <td >
		<!--input id="objectTypeName" name ="objectTypeName" size="20" readonly type="text" onclick="showObjectCheckTree(0);" value="<%=(objectTypeName==null)?"":objectTypeName%>" style="cursor:hand;"-->
		
		<input id="objectTypeName" name ="objectTypeName" size="20" readonly type="text"   value="<%=(objectTypeName==null)?"":objectTypeName%>">
                  <!--   <input id="objectid" name ="0_str_t1.objectid" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>" > -->
		  <img onclick="showObjectCheckTree(0);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		  <td > ���칤�� </td>
                  <td >
         <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->         
		    <input name ="2_=_t1.staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(staffno==null)?"":staffno%>">
		      <!-- ������0��������1 -->
		      <input name ="3_=_t1.group_flag" type="hidden" id="groupflag"  maxlength="10" value="0">
                      </td>
                    </tr>
                    <tr >
    	              <td > ����ʱ�� </td>
                      <td >
			<input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" >
		          <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		            <font color="orange">*</font>
		          </td>
                          <td >�������</td>
                          <td >
                            <select name="qc_type" id="qc_type" size="1"  >
                              <option value="" selected >2-ȫ��</option>
	                      <option value="0" <%="0".equals(qc_type)?"selected":""%>>���˿���</option>
	                      <option value="1" <%="1".equals(qc_type)?"selected":""%>>���忼��</option>
                            </select>
                          </td>

      <td colspan='2'>&nbsp;
<input id="objectid" name ="0_str_t1.objectid" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>" >
</td>
   </tr>

    <tr >
      <td colspan="6" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 ��ѯ�����û�λ��-->
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
			 <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
			 <!-- <input name="export" type="button"  id="search" value="��ӡ" <%if(dataRows.length!=0) out.print("onClick=\"window.print();\"");%>> -->
       <!--<input name="exportAll" type="button"  id="add" value="����ȫ��" onClick="showExpWin('all')">-->
      </td>
    </tr>
		</table>
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left">
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
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
                          
			  <%if(isPersonal){%>
          <tr >
       <script>
       	var tempBool ='flase';
      	if(checkRole(K204A_RolesArr)==true){
	      		document.write('<th align="center" class="blue" width="15%" > ���� </th>');
	      		tempBool='true';
      	}
        </script>
            <%if(thName.length>0){%>
            <th align="center" class="blue" width="10%" > ���� </th>
            <%}%>
            <%for(int i=0;i<thName.length;i++){%>
            	<th align="center" class="blue" width="20%" > <%=thName[i][0]%> </th>
            <%}%>
            <%if(thName.length>0){%>
             <th align="center" class="blue" width="20%" > �ۺϵ÷� </th>
            <%} else{%>
            <th align="center" class="blue" width="80%" >&nbsp;  </th>
            <%}%>
          </tr>
        <%}else if(!isPersonal){%>
          <tr >
            <th align="center" class="blue" width="10%" > ���� </th>
            <th align="center" class="blue" width="80%" >&nbsp; </th>
          </tr>
        <%}%>

        <%
          for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="Blue";
        %>
        <%
          if((i+1)%2==1){
          tdClass="Blue";
        %>
          <tr onClick="changeColor('<%=tdClass%>',this);" >
			<%
				}else{
			%>
	   <tr onClick="changeColor('<%=tdClass%>',this);" >
	<%}%>
	      <script>
      	if(tempBool=='true'){
      			document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K204A_RolesArr)==true){
 
      			document.write('<img onclick="getDetail(\'<%=dataRows[i][0]%>\',\'<%=objectid%>\')" alt="��ʾ�ü�¼��ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle" />');
      	}
        if(tempBool=='true'){
      			document.write('</td>');
      	}
      </script>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
     <% for ( int j = 0; j < thName.length; j++ ) {
       if(dataRows[i][2].equals(thName[j][1])&&dataRows[i][3].equals(thName[j][2])){
     %>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
     <%
      }else{
     %>
     <td align="center" class="<%=tdClass%>"  >&nbsp;</td>
     <%
      }
     }%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
    </tr>
      <% } %>
  </table>

  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right">
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


<%
  /*
   * ����: �޸ļ�¼��ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%! 
	
public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
}
%>

<%
    String opCode="K213";
    String opName="�ʼ��ѯ-�޸ļ�¼��ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  		regionCode = orgCode.substring(0,2);
	  }	
		
    String start_date    =  request.getParameter("start_date");      
    String end_date      =  request.getParameter("end_date");        
    String staffno       =  request.getParameter("0_=_t1.staffno");    
    String score         =  request.getParameter("1_=_t1.score"); 
    String evterno       =  request.getParameter("2_=_t1.evterno");
    String serialnum     =  request.getParameter("3_=_t1.serialnum"); 
    String modevterno    =  request.getParameter("4_=_t1.modevterno");   
    String opCodeFlag    =  request.getParameter("opCodeFlag");//�Ƿ��Ǵ��ʼ�����ѯ��ת������Ҫ�ʼ��ѯ�����
    String contact_id    =  request.getParameter("contact_id");//�ʼ쵥��ˮ��
    String K211_start_date  =  request.getParameter("start_date");//���ʼ�����ѯ�д������Ŀ�ʼʱ��
    String K211_end_date    =  request.getParameter("end_date");
    //zengzq add ���Ӳ�ѯ���� ���˿������Ƕ��˿���
    String group_flag   = request.getParameter("5_=_t5.group_flag");
    if(K211_start_date!=null&&K211_start_date.length()>10){
	      String[] temp = new String[]{};
	      temp=K211_start_date.split(" ");
	      temp=temp[0].split("-");
	      K211_start_date="";
	      K211_end_date="";
	      
	      for(int i=0;i<temp.length;i++){
	        	K211_start_date+=temp[i];
	      }
	      
	      K211_end_date=K211_start_date+" 23:59:59";
	      K211_start_date+=" 00:00:00";
	  }
        
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;              // Number of all pages
    int curPage=0;                // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action  = request.getParameter("myaction");
    String[] strHead= {"��ˮ��","�ʼ�����ˮ��","�������","�ʼ�����","���칤��","�÷�","�ȼ�","�ʼ칤��","�ʼ����","�ʼ췽ʽ","������","ҵ�����","����ʱ��","����ʱ��","����ʱ��","�����ʶ","ȷ����","ȷ������","�Ƿ��޸�","�޸���","�޸�ʱ��"};
	  String expFlag = request.getParameter("exp"); 
	  String sqlFilter = request.getParameter("sqlFilter");
	  
%>	
		
<%	
	if ("doLoad".equals(action)) {
		HashMap pMap=new HashMap();
				pMap.put("starttime", start_date);
				pMap.put("endtime", end_date);
				pMap.put("staffno", staffno);
				pMap.put("score",score);
				pMap.put("evterno", evterno);
				pMap.put("serialnum", serialnum);
				pMap.put("modevterno", modevterno);
				pMap.put("group_flag", group_flag);
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_k213_qcModifyRec_strCountSql",pMap)).intValue();
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

			
		int start = (curPage - 1) * pageSize + 1;
		int end = curPage * pageSize;
		pMap.put("start", ""+start);
		pMap.put("end", ""+end);
		
		List queryList =(List)KFEjbClient.queryForList("query_k213_qcModifyRec_sqlStr",pMap);     
    	dataRows = getArrayFromListMap(queryList ,1,22);  
		
    }
   
%>

<html>
<head>
<title>�޸ļ�¼��ѯ</title>
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
   if(checkFloatNum(document.sitechform.score)==false) return;
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
		    window.sitechform.opCodeFlag.value="";
		    submitMe();
    }
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K213_qcModifyRecQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

function doLoad(operateCode){
		if(operateCode=="load"){
			window.sitechform.page.value="";
		}
		else if(operateCode=="first"){
			window.sitechform.page.value=1;
		}
		else if(operateCode=="pre"){
			window.sitechform.page.value=<%=(curPage-1)%>;
		}
		else if(operateCode=="next"){
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
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K213/K213_qcModifyRecQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.score.value="<%=score%>";
    window.sitechform.evterno.value="<%=evterno%>";
    window.sitechform.serialnum.value="<%=serialnum%>";
    window.sitechform.modevterno.value="<%=modevterno%>";
}

//��ʾͨ����ϸ��Ϣ
function getModRecDetail(contact_id){
		var path="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_getModRecDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    window.open(path,"newwindow","height=600, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

/*--------------�Զ���ѯ���ݿ�ʼ----------------*/
window.onload=function(){
	  getCurDate();
}


function getCurDate(){
		var opCodeFlag = document.getElementById("opCodeFlag").value;
		if(opCodeFlag=='K211'){
				document.getElementById("serialnum").value=document.getElementById("contact_id").value;
				document.getElementById("start_date").value=document.getElementById("K211_start_date").value;
				document.getElementById("end_date").value=document.getElementById("K211_end_date").value;
				submitInputCheck();
		}
}
/*--------------�Զ���ѯ���ݽ���----------------*/
//��������
function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
		window.sitechform.sqlWhere.value="<%=sqlFilter%>";
		openWinMid('k213_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth){
		var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
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
	/*
	*
	* ��֤�����ֵΪ�Ǹ�������
	* @author zhengjiang 
	* 20091014
	*/
	function checkFloatNum(obj){
		if(null==obj.value || 0==obj.value.length){
			hiddenTip(obj);
			return true;
		}else{
			var t1 = (/^(\+|-)?\d+$/.test( obj.value ));
			var t2 = (/^(\+|-)?\d+($|\.\d+$)/.test( obj.value )) ;
			if(!t1&&!t2){
				showTip(obj,"�������벻��ȷ��"); 
    	  		obj.focus();
    	  		return false;
			}
		}
	}
	
</script>
</head>

<body >
<form id=sitechform name=sitechform>
<%--
<%@ include file="/npage/include/header.jsp"%>	
--%>
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi">�޸ļ�¼��ѯ</div></div>
		<table cellspacing="0" style="width:100%"> 
         <tr >
      <td class="blue" nowrap > ��ʼʱ�� </td>
      <td nowrap  >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td class="blue" nowrap > ���칤�� </td>
      <td  nowrap >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="0_=_t1.staffno" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      </td> 
      <td class="blue" nowrap > �÷� </td>
      <td  nowrap >
      	<!--zhengjiang 20091014 ���onblur="checkFloatNum(this);"-->
			  <input name ="1_=_t1.score" type="text" id="score"  maxlength="10" onblur="checkFloatNum(this);" value="<%=(score==null)?"":score%>">
      </td> 
    </tr>
    <tr >
      <td class="blue" nowrap > ����ʱ�� </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);"/>
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td class="blue" nowrap > �ʼ칤�� </td>
      <td  nowrap >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="2_=_t1.evterno" type="text" id="evterno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(evterno==null)?"":evterno%>">
      </td> 
      <td nowrap >�������</td>
			<td nowrap >
				<select name="5_=_t5.group_flag" id="group_flag" size="1"  >
				<option value="" selected >2-ȫ��</option>
				<option value="0" <%="0".equals(group_flag)?"selected":""%>>���˿���</option>
				<option value="1" <%="1".equals(group_flag)?"selected":""%>>���忼��</option>
				</select>
			</td>
     </tr>
     <tr>     	
      <td class="blue" nowrap > �ʼ�����ˮ�� </td>
      <td  nowrap >
      <!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
			  <input name ="3_=_t1.serialnum" type="text" id="serialnum" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serialnum==null)?"":serialnum%>">
      </td>      
      <td class="blue" nowrap > �޸��˹��� </td>
      <td  nowrap >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="4_=_t1.modevterno" type="text" id="modevterno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(modevterno==null)?"":modevterno%>">
      </td> 
      <td colspan="2" nowrap >&nbsp;</td>
    <tr >
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
  	<table  cellspacing="0">
    <tr >
      <td class="blue" align="left" colspan="23">
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
  
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
        <tr >
<script>
       	var tempBool ='flase';
      	if(checkRole(K213A_RolesArr)==true){	
	      		document.write('<th align="center" class="blue" width="15%" ><nobr> ���� </th>');	
	      		tempBool='true';
      	}
</script>  
          <th align="center" class="blue" width="25%" ><nobr> ��ˮ�� </th>
          <th align="center" class="blue" width="25%" ><nobr> �ʼ�����ˮ�� </th>
          <th align="center" class="blue" width="25%" ><nobr> ������� </th>
          <th align="center" class="blue" width="30%" ><nobr> �ʼ����� </th>
          <th align="center" class="blue" width="25%" ><nobr> ���칤�� </th>            
          <th align="center" class="blue" width="25%" ><nobr> �÷� </th>
          <th align="center" class="blue" width="25%" ><nobr> �ȼ�</th>
          <th align="center" class="blue" width="25%" ><nobr> �ʼ칤�� </th>            
          <th align="center" class="blue" width="25%" ><nobr> �ʼ���� </th>
          <th align="center" class="blue" width="30%" ><nobr> �ʼ췽ʽ </th>
          <th align="center" class="blue" width="25%" ><nobr> ������ </th>            
          <th align="center" class="blue" width="30%" ><nobr> ҵ����� </th>
          <th align="center" class="blue" width="30%" ><nobr> ������� </th>
          <th align="center" class="blue" width="30%" ><nobr> ����ʱ�� </th>
          <th align="center" class="blue" width="25%" ><nobr> ����ʱ�� </th>
          <th align="center" class="blue" width="30%" ><nobr> ����ʱ�� </th>            
          <th align="center" class="blue" width="25%" ><nobr> �����ʶ</th>
          <th align="center" class="blue" width="25%" ><nobr> ȷ���� </th>
          <th align="center" class="blue" width="25%" ><nobr> ȷ������ </th>
          <th align="center" class="blue" width="25%" ><nobr> �Ƿ��޸�</th>
          <th align="center" class="blue" width="25%" ><nobr> �޸��� </th>
          <th align="center" class="blue" width="25%" ><nobr> �޸�ʱ�� </th>                        
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
      	if(checkRole(K213A_RolesArr)==true){	
      	//zhengjiang 20091004 ��dataRows[i][1]��ΪdataRows[i][0]
      			document.write('<img onclick="getModRecDetail(\'<%=dataRows[i][0]%>\');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">');	
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
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>      
    
    </tr>
      <% } %>

  

    <tr >
      <td class="blue"  align="right" colspan="23">
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

<input type="hidden" name="opCodeFlag" id="opCodeFlag" value="<%=opCodeFlag%>"/>
<input type="hidden" name="contact_id" id="contact_id" value="<%=contact_id%>"/>
<input type="hidden" name="K211_start_date" id="K211_start_date" value="<%=K211_start_date%>"/>
<input type="hidden" name="K211_end_date" id="K211_end_date" value="<%=K211_end_date%>"/>
</div>
</form>
<%--
<%@ include file="/npage/include/footer.jsp"%>
--%>
</body>
</html>


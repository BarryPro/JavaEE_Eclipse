<%
  /*
   * ����: ת��¼����ѯ
�� * �汾: 1.0
�� * ����: 2008/10/18
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%! 
   public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%!
//����Excel
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "ת��¼����ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11],queryList[i][12],queryList[i][13],queryList[i][14]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
        }catch  (Exception e1) {
           e1.printStackTrace();
        } 
    }
%>

<%
    String opCode="K17D";
    String opName="�ۺϲ�ѯ-ת��¼����ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode");
	  String org_code = (String)session.getAttribute("orgCode");
    String regionCode = org_code.substring(0,2);
	   
    String start_date        =  request.getParameter("start_date");            //��ʼʱ��
    String end_date          =  request.getParameter("end_date");              //����ʱ��
    String contact_id        =  request.getParameter("0_=_t1.contact_id");        //��ˮ��
    String region_code       =  request.getParameter("1_=_region_code");       //�ͻ�����
    //�����Ÿ�ΪBOSS����
    String accept_login_no   =  request.getParameter("2_=_accept_login_no");   //������
    String accept_phone      =  request.getParameter("3_=_accept_phone");      //�������
    String mail_address      =  request.getParameter("4_=_mail_address");      //�����ʼ�
    String contact_address   =  request.getParameter("5_=_contact_address");   //��ϵ��ַ
    String grade_code        =  request.getParameter("6_=_grade_code");        //�ͻ�����
    String contact_phone     =  request.getParameter("7_=_contact_phone");     //��ϵ�绰
    String caller_phone      =  request.getParameter("8_=_caller_phone");      //���к���  
    String statisfy_code     =  request.getParameter("9_=_statisfy_code");     //�ͻ������
    String cust_name         =  request.getParameter("10_=_cust_name");        //�ͻ�����
    String fax_no            =  request.getParameter("11_=_fax_no");           //�������
    String accept_long_begin =  request.getParameter("accept_long_begin");     //����ʱ��(��ʼ)
    String accept_long_end   =  request.getParameter("accept_long_end");       //����ʱ��(����)
    String callee_phone      =  request.getParameter("12_=_callee_phone");     //���к���  
    String skill_quence      =  request.getParameter("14_=_skill_quence");     //�жӼ���
    String staffHangup       =  request.getParameter("15_=_staffHangup");      //�һ���
    String acceptid          =  request.getParameter("16_=_acceptid");         //����ʽ 
    String oper_code         =  request.getParameter("17_=_staffcity");        //Ա������
    //ת�湤�Ÿ�ΪBOSS����
    String kf_login_no       =  request.getParameter("18_=_t2.kf_login_no");  //ת�湤��
    String ipAddr            =  request.getParameter("19_=_t2.bak2");         //ת��IP  
    
    String[][] dataRows = new String[][]{};                      
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"��ˮ��","�ͻ�����","�ͻ�����","�������","���к���","���к���","����ʱ��","����ʱ��","������","�һ���","�Ƿ��ʼ�","�ͻ������","����ԭ��","ת�湤��","ת��IP"};

		
    if ("doLoad".equals(action)) {
        HashMap pMap=new HashMap();
				pMap.put("start_date", start_date);
				pMap.put("end_date", end_date);
				pMap.put("contact_id", contact_id);
				pMap.put("region_code", region_code);
				pMap.put("accept_login_no", accept_login_no);
				pMap.put("accept_phone", accept_phone);
				pMap.put("mail_address", mail_address);
				pMap.put("contact_address", contact_address);
				pMap.put("grade_code", grade_code);
				pMap.put("contact_phone", contact_phone);
				pMap.put("caller_phone", caller_phone);
				pMap.put("statisfy_code", statisfy_code);
				pMap.put("cust_name", cust_name);
				pMap.put("fax_no", fax_no);
				pMap.put("accept_long_begin", accept_long_begin);
				pMap.put("accept_long_end", accept_long_end);
				pMap.put("callee_phone", callee_phone);
				pMap.put("skill_quence", skill_quence);
				pMap.put("staffHangup", staffHangup);
				pMap.put("acceptid", acceptid);
				pMap.put("oper_code", oper_code);
				pMap.put("kf_login_no", kf_login_no);
				pMap.put("ipAddr", ipAddr);
				String tablename = start_date.substring(0, 6);
				pMap.put("tablename", tablename);
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K17D_strCountSql",pMap)).intValue();

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
		    
		    List queryList =(List)KFEjbClient.queryForList("query_K17D_sqlStr",pMap);     
		    dataRows = getArrayFromListMap(queryList ,1,16);        
   }  
   
  
    
%>

<html>
<head>
		<style>
		img{
				cursor:hand;
		}
		
		input{
				height: 1.5em;
				width: 15 em;
				font-size: 1em;
		}
  </style>	
<title>ת��¼����ѯ</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
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
   if( document.sitechform.start_date.value == ""){
    	  showTip(document.sitechform.start_date,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
        sitechform.start_date.focus();
    } else if(document.sitechform.end_date.value == ""){
		showTip(document.sitechform.end_date,"�������ڲ���Ϊ�գ������ѡ�������");
		sitechform.end_date.focus();
    } else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��"); 
    	   sitechform.end_date.focus(); 	
    /* ����ʱ���ֶβ�ѯ�������⣬�����ѯһ�������ݵ�����
    }else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯһ�����ڵļ�¼"); 
    	   sitechform.end_date.focus(); 
    */	

    }else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"����ʱ���Ҳ�ֵ����������ֵ"); 
    	   sitechform.accept_long_end.focus(); 	

    }  
//  else if(document.sitechform.oper_code.value == ""){
//		showTip(document.sitechform.oper_code,"Ա�����в���Ϊ�գ������ѡ�������");
//		sitechform.oper_code.focus();
//    }  
//  else if(document.sitechform.contact_id.value == ""){
//		showTip(document.sitechform.contact_id,"��ˮ�Ų���Ϊ�գ������ѡ�������");
//		sitechform.contact_id.focus();
//    }  
//  else if(document.sitechform.accLogNo.value == ""){
//		showTip(document.sitechform.accLogNo,"�����Ų���Ϊ�գ������ѡ�������");
//		sitechform.accLogNo.focus();
//    }  
//  else if(document.sitechform.accNo.value == ""){
//		showTip(document.sitechform.accNo,"������벻��Ϊ�գ������ѡ�������");
//		sitechform.accNo.focus();
//    }  
    else {
    	
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    doSubmit();
    }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k1716_keepRecQry.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
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
    window.location="k1716_keepRecQry.jsp";
}


//��ת��ָ��ҳ��
function jumpToPage(operateCode){
	//alert(operateCode);
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
   	  var thePage=document.getElementById("thePage1").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
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
   window.sitechform.action="k1716_keepRecQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1716_keepRecQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

//������ѯ��ֵ
function keepValue(){
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.region.value="<%=request.getParameter("region")%>";
   window.sitechform.hangup.value="<%=request.getParameter("hangup")%>";
   //window.sitechform.listen.value="<%=request.getParameter("listen")%>";
   window.sitechform.skill.value="<%=request.getParameter("skill")%>";
   window.sitechform.oper.value="<%=request.getParameter("oper")%>";
   window.sitechform.region_code.value="<%=request.getParameter("1_=_region_code")%>";
   window.sitechform.statisfy_code.value="<%=request.getParameter("9_=_statisfy_code")%>";
   window.sitechform.oper_code.value="<%=request.getParameter("17_=_staffcity")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("16_=_acceptid")%>";
   window.sitechform.staffHangup.value="<%=request.getParameter("15_=_staffHangup")%>";
   //window.sitechform.listen_flag.value="<%=request.getParameter("13_=_listen_flag")%>";
   window.sitechform.skill_quence.value="<%=request.getParameter("14_=_skill_quence")%>";	
   
   window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
   window.sitechform.end_date.value="<%=end_date%>";
   //window.sitechform.oper_code.value="";//Ա������
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.mail_address.value="<%=mail_address%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.accept_phone.value="<%=accept_phone%>";
   window.sitechform.contact_address.value="<%=contact_address%>";
   window.sitechform.contact_phone.value="<%=contact_phone%>";
   window.sitechform.caller_phone.value="<%=caller_phone%>";
   window.sitechform.cust_name.value="<%=cust_name%>";
   window.sitechform.fax_no.value="<%=fax_no%>";
   window.sitechform.accept_long_begin.value="<%=accept_long_begin%>";
   window.sitechform.accept_long_end.value="<%=accept_long_end%>";
   window.sitechform.callee_phone.value="<%=callee_phone%>";
   window.sitechform.kf_login_no.value="<%=kf_login_no%>";
   window.sitechform.ipAddr.value="<%=ipAddr%>";   
}
	
	//���д򿪴���
	function openWinMid(url,name,iHeight,iWidth)
	{
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}

	 
//��ʾͨ����ϸ��Ϣ
function getCallDetail(contact_id,start_date){
	if(contact_id==''){
		return;
		}
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    openWinMid(path,"��Ϣ����",680,960);
	return true;
}


	//��������
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	 
		openWinMid('k1716_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table" width="100%">
		<table cellspacing="0" ><!--style="width:650px"-->
    <tr><td colspan='8' ><div class="title"><div id="title_zi">ת��¼����ѯ</div></div></td></tr>
    <tr >
      <td nowrap > ��ʼʱ��</td>
      <td >
			  <input id="start_date" name ="start_date" type="text"  value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
		    <img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		  <td nowrap > Ա������ </td>
     <td nowrap >
			 <select id="oper_code" name="17_=_staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].text">
			 	<!-- value Ϊ�գ���ѯʱ���Զ����Դ�����-->
        <%if(oper_code==null || oper_code.equals("")|| request.getParameter("oper")==null || request.getParameter("oper").equals("")){%>
			 	<option value="" selected>--����Ա������--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>			 	
			 	<%}else {%>
      	 	 	<option value="" >--����Ա������--</option>			 	
      	 			<option value="<%=oper_code%>" selected >
      	 				<%=request.getParameter("oper")%>
      	 			</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=oper_code%>' order by region_code</wtc:sql>
				  </wtc:qoption>      	 			
      	 	<%}%>
        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
			  <font color="orange">*</font>

      </td>
      <td nowrap > ��ˮ�� </td>
      <td nowrap >
      <!--zhengjiang 20091010���value=value.replace(/[^a-zA-Z\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input id="contact_id" name="0_=_t1.contact_id" onKeyUp="hiddenTip(this);value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text" value=<%=(contact_id==null)?"":contact_id%>>
				<font color="orange">*</font>
      </td>
      </td>
      <td nowrap > �����ʼ� </td>
      <td nowrap >
			  <input name="4_=_mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td nowrap > ����ʱ�� </td>
      <td nowrap >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
		  <td nowrap > ������ </td>
      <td nowrap >
      <!--zhengjiang 20091010���value=value.replace(/[^kf\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="2_=_accept_login_no" type="text" id="accept_login_no" onKeyUp="hiddenTip(this);value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(accept_login_no==null)?"":accept_login_no%>">
		    <!--img onclick="" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" -->
		    <font color="orange">*</font>
		  </td> 
		  <td nowrap > ������� </td>
      <td nowrap >
			  <input name ="3_=_accept_phone" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onKeyUp="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		   <font color="orange">*</font>
		  </td> 
		  <td nowrap > ��ϵ��ַ </td>
      <td nowrap >
			  <input name ="5_=_contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
     </td>      
     </tr>
     <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
           <td nowrap > �ͻ����� </td>
      <td nowrap >
			  <select name="6_=_grade_code" id="grade_code" size="1" onChange="grade.value=this.options[this.selectedIndex].text">
			  	<%if(grade_code==null || grade_code.equals("") || request.getParameter("grade").equals("") || request.getParameter("grade")==null){%>
			  	 <option value="" selected>--���пͻ�����--</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
				</wtc:qoption>			  	 
			  	<%}else {%>
      	 	 	<option value="" >--���пͻ�����--</option>			  	
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode where accept_code<>'<%=grade_code%>' order by accept_code</wtc:sql>
				</wtc:qoption>      	 			
      	 	<%}%>

        </select>
				<input name="grade" type="hidden" value="<%=request.getParameter("grade")%>"> 

		  </td> 
		  <td nowrap > ��ϵ�绰 </td>
      <td nowrap >
			  <input name ="7_=_contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td> 
		  <td nowrap > ���к��� </td>
      <td nowrap >
			  <input name ="8_=_caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		  <td nowrap > �ͻ������ </td>
      <td nowrap >
      	 <select name="9_=_statisfy_code" id="statisfy_code" size="1" onChange="statisfy.value=this.options[this.selectedIndex].text">
      	 	<%if(statisfy_code==null || statisfy_code.equals("") || request.getParameter("statisfy")==null || request.getParameter("statisfy").equals("")){%>
      	 	<option value="" selected >--���������--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>      	 	
      	 	<%}else {%>
      	 	 	<option value="" >--���������--</option>      	 	
      	 			<option value="<%=statisfy_code%>" selected >
      	 				<%=request.getParameter("statisfy")%>
      	 			</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1' and satisfy_code<>'<%=statisfy_code%>'</wtc:sql>
				  </wtc:qoption>      	 			
      	 	<%}%>
        </select> 
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>"> 
		  </td> 
    </tr>
     <!-- THE FOURTH LINE OF THE CONTENT -->
     <tr >
      <td nowrap > �ͻ����� </td>
      <td nowrap >
			  <input name ="10_=_cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td> 
		  <td nowrap > ������� </td>
      <td nowrap >
			  <input name ="11_=_fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		  <td nowrap > ����ʽ </td>
      <td nowrap >
		  <select name="16_=_acceptid" id="acceptid" size="1" onChange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	  <option value="" selected>--��������ʽ--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				  </wtc:qoption>		  	
		  	<%}else {%>
		  	  <option value="" >--��������ʽ--</option>
          <option value="<%=acceptid%>" selected ><%=request.getParameter("accid")%></option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE where accept_code<>'<%=acceptid%>'</wtc:sql>
				  </wtc:qoption>          
      	 	<%}%>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>"> 
		  </td> 
		  <td nowrap > ����ʱ�� </td>
      <td nowrap >
			  ><input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:6.3em" value="<%=(accept_long_begin==null)?"":accept_long_begin%>" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:6.3em"  value="<%=(accept_long_end==null)?"":accept_long_end%>" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>    
    </tr>
    <!-- THE FIFTH LINE OF THE CONTENT -->
     <tr >
      <td nowrap > �ͻ����� </td>
      <td nowrap >
			 <select id="region_code" name="1_=_region_code" size="1" onChange="region.value=this.options[this.selectedIndex].text">
			 	<%if(region_code==null || "".equals(region_code)|| request.getParameter("region")==null || request.getParameter("region").equals("")){%>
			 	<option value="" selected>--���пͻ�����--</option>
				   <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				   </wtc:qoption>			 	
			 	<%}else {%>
      	 	 	<option value="" >--���пͻ�����--</option>			 	
      	 		<option value="<%=region_code%>" selected ><%=request.getParameter("region")%></option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				     <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=region_code%>' order by region_code</wtc:sql>
				    </wtc:qoption>      	 		
      	 <%}%>
        </select>
        <input name="region" type="hidden" value="<%=request.getParameter("region")%>">
      </td>
      <td nowrap > ���к��� </td>
      <td >
<input name ="12_=_callee_phone" type="text" id="callee_phone"  value="<%=(callee_phone==null)?"":callee_phone%>" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			
      </td>
            <td nowrap > �һ��� </td>
      <td nowrap >
        <select name="15_=_staffHangup" id="staffHangup" size="1" onChange="hangup.value=this.options[this.selectedIndex].text">
        	<%if(staffHangup==null|| staffHangup.equals("")||request.getParameter("hangup").equals("") || request.getParameter("hangup")==null){%>
        	   <option value="" selected>ȫ��</option>
				      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				       <wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup order by hangup_code</wtc:sql>
				      </wtc:qoption>        	
        	<%}else {%>
      	 	 	<option value="" >ȫ��</option>        		
      	 		<option value="<%=staffHangup%>" selected ><%=request.getParameter("hangup")%></option>
				     <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				      <wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup  where hangup_code<>'<%=staffHangup%>' order by hangup_code</wtc:sql>
				     </wtc:qoption>      	 			
      	 	<%}%>
        </select>
        <input name="hangup" type="hidden" value="<%=request.getParameter("hangup")%>">
      </td>
      <td nowrap >���ܶ��� </td>
      <td colspan="8" nowrap >
        <select id="skill_quence" name="14_=_skill_quence" size="1" onChange="skill.value=this.options[this.selectedIndex].text">
        	<%if(skill_quence==null || skill_quence.equals("")|| request.getParameter("skill")==null || request.getParameter("skill").equals("")){%>
        	<option value="" selected>--���м��ܶ���--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>        	
        	<%}else {%>
           <option value="" >--���м��ܶ���--</option>
      	 			<option value="<%=skill_quence%>" selected >
      	 				<%=request.getParameter("skill")%>
      	 			</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue where skill_queue_id<>'<%=skill_quence%>' </wtc:sql>
				  </wtc:qoption>      	 	 	
      	 	 <%}%>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>
        <!-- THE SIXTH LINE OF THE CONTENT -->
    <tr>
		  <td nowrap > ת�湤�� </td>
      <td nowrap >
			  <input name ="18_=_t2.kf_login_no" type="text" id="kf_login_no"  maxlength="6"  value="<%=(kf_login_no==null)?"":kf_login_no%>" onKeyUp="value=value.replace(/[^kf\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))">
		  </td>  
		  <td nowrap > ת��IP </td>
      <td nowrap >
			  <input name ="19_=_t2.bak2" type="text" id="ipAddr"  value="<%=(ipAddr==null)?"":ipAddr%>" >
		  </td> 
		  <td colspan="4">&nbsp;</td> 		    
    </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
       <td colspan="8" align="center" id="footer" style="width:420px" nowrap >
        <!--zhengjiang 20091004 ��ѯ�����û�λ��-->
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput()">
       <input name="clear" type="button"  id="clear" value="����" onClick="clearValue()">
        <!--input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>-->
       <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
                     <!--<input name="exportAll" type="button"  id="add" value="����ȫ��" onClick="showExpWin('all')">-->
      
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" colspan="16">
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
        <!--modify hucw 20100829<a>����ѡ��</a>-->
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
  <!--  
  </table>
      <table  cellSpacing="0" >
  -->    
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter"  value="">
			  <input type="hidden" name="sqlWhere" value="">
			  
          <tr >
            <th align="center" class="blue" width="10%" nowrap > ���� </th>
            <th align="center" class="blue" width="9%" nowrap > ��ˮ�� </th>
            <th align="center" class="blue" width="6%" nowrap > �ͻ����� </th>
            <th align="center" class="blue" width="6%" nowrap > �ͻ����� </th>
            <th align="center" class="blue" width="6%" nowrap > ������� </th>
            <th align="center" class="blue" width="6%" nowrap > ���к��� </th>
            <th align="center" class="blue" width="6%" nowrap > ���к��� </th>
            <th align="center" class="blue" width="7%" nowrap > ����ʱ�� </th>
            <th align="center" class="blue" width="6%" nowrap > ����ʱ�� </th>
            <th align="center" class="blue" width="6%" nowrap > ������ </th>
            <th align="center" class="blue" width="10%" nowrap > �һ��� </th>
            <th align="center" class="blue" width="6%" nowrap > �Ƿ��ʼ� </th>
            <th align="center" class="blue" width="6%" nowrap > �ͻ������ </th>
            <th align="center" class="blue" width="10%" nowrap > ����ԭ�� </th>
            <th align="center" class="blue" width="6%" nowrap > ת�湤�� </th>
            <th align="center" class="blue" width="10%" nowrap > ת��IP </th>            
          </tr>


           <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
           
         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr>
      <td align="center" class="<%=tdClass%>" nowrap ><img style="cursor:hand" onClick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle"></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>

    </tr>
      <% } %>
  <!--    
  </table>  
  <table  cellspacing="0">
  -->
    <tr >
      <td class="blue"  align="right" colspan="16"><!--width="720"-->
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
        <!--modify hucw 20100829<a>����ѡ��</a>-->
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
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=����>GO</font>        
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


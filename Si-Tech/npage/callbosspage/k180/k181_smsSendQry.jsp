<!--
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
-->
<%
  /*
   * ����: ���ŷ��Ͳ�ѯ
�� * �汾: 1.0
�� * ����: 2008/10/30
�� * ����: hanjc 
�� * ��Ȩ: sitech
   * �޸ļ�¼: liujied 20090914
   *         1.�ͷ��Ķ��ſ��ΪWCOMMONSHORTMSGTX
   *         2.���Ӳ�ѯ����Ϊ:and dx_op_code like 'K%' or dx_op_code like 'k%'
   *         3.���ͷ����ſ��Ļ�sms_push_rec_log 20090930
   *         4.���β�����ť
   * modify by yinzx 20091118 sql �Ż�
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
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
        public String[]  returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();
        StringBuffer bufferPara = new StringBuffer();
 
		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
    String[] bingd= {"",""};
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
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%'||:v"
				+ objs[1].toString().replace('.','a') + "||'%%' ");
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " :v"
				+ objs[1].toString().replace('.','a') + "  ");
 
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
		}
     bingd[0]=buffer.toString();
     bingd[1]=bufferPara.toString();
        return bingd;
}
%>

<%!

  public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%
//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
    String opCode="K181";
    String opName="ý���ѯ-���ŷ��Ͳ�ѯ";
     /*midify by yinzx 20091113 ������ѯ�����滻*/
 		String myParams=request.getParameter("para");     
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }

     String sqlStr = "select to_char(serial_no),send_login_no,user_phone,to_char(insert_time,'yyyy-MM-dd hh24:mi:ss'),send_content from sms_push_rec_log";
     String strCountSql="select to_char(count(*)) count  from sms_push_rec_log";
     String strDateSql="";
     String strOrderSql=" order by insert_time desc ";
     String strAcceptLogSql=""; 


    String start_date           =  request.getParameter("start_date");                 
    String end_date             =  request.getParameter("end_date");                   
    String user_phone           =  request.getParameter("0_=_user_phone");             
    String serial_no            =  request.getParameter("1_=_serial_no");               
    String pre_call_cause_id    =  request.getParameter("2_=_pre_call_cause_id");   
    String out_gateway_id   =  request.getParameter("3_=_out_gateway_id"); 
    String send_login_no    =  request.getParameter("4_=_send_login_no"); 
    String send_content     = request.getParameter("5_like_send_content");  
    String con_id            =  request.getParameter("con_id");    


    String[][] dataRows = new String[][]{};
    String[] strbind= {"",""};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp="";
    String action = request.getParameter("myaction");
    //String[] strHead= {"��ˮ��","�û�����","�·�ʱ��","�·�URL��ַ","����ID","��������","��������"};
	String[] strHead= {"��ˮ��","��½����","�û�����","����ʱ��","��������"};
	  String expFlag = request.getParameter("exp"); 
    ///////��ѯ��������
    String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
      strDateSql=" where 1=1 and  insert_time>=to_date( :start_date ,'yyyymmdd hh24:mi:ss')  and insert_time <=to_date( :end_date ,'yyyymmdd hh24:mi:ss') ";
    	myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();
    	}
      strbind=returnSql(request);
    	myParams+=strbind[1];          
    	sqlFilter=strDateSql+strbind[0];
    }
%>	
			
<%	if ("doLoad".equals(action)) {

		HashMap pMap=new HashMap();
				pMap.put("start_date", start_date);
				pMap.put("end_date", end_date);
				pMap.put("user_phone", user_phone);
				pMap.put("serial_no",serial_no);
				pMap.put("pre_call_cause_id", pre_call_cause_id);
				pMap.put("out_gateway_id", out_gateway_id);
				pMap.put("send_login_no", send_login_no);
				pMap.put("send_content", send_content);
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K181_strCountSql",pMap)).intValue();



        sqlStr+=sqlFilter+strOrderSql; 
        sqlTemp = strCountSql+sqlFilter;
        System.out.println("sqlTemp="+sqlTemp);
     
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
		
		
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
 		System.out.println("querySql="+querySql);
		
		List queryList =(List)KFEjbClient.queryForList("query_K181_sqlStr",pMap);     
    	dataRows = getArrayFromListMap(queryList ,1,6);  
		
                
                if(con_id!=null){
   //��¼��ͻ��Ӵ���־
   strAcceptLogSql="insert into dbcalladm.wloginopr (login_accept,op_code,org_code,op_time,op_date,phone_no,login_no,contact_id,flag,contact_flag) values(SEQ_WLOGINOPR.NEXTVAL,:v1,:v2,sysdate,to_char(sysdate,'yyyymmdd'),:v3,:v4,:v5,'I','Y')&&"+opCode+"^"+orgCode+"^"+user_phone+"^"+loginNo+"^"+con_id;
   List sqlList=new ArrayList();
   String[] sqlArr = new String[]{};
   sqlList.add(strAcceptLogSql);
   sqlArr = (String[])sqlList.toArray(new String[0]);
   String outnum = String.valueOf(sqlArr.length + 1);      
    %>
   <wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
   <% 
     }
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
				width: 14.6em;
				font-size: 1em;
		}	
  </style>	
<title>���ŷ��Ͳ�ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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
function getCallListen(id){
var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
//window.open("k170_getCallListen.jsp?flag_id="+id);
}
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
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

    }else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯ�����ڵļ�¼"); 
    	   sitechform.end_date.focus(); 	
    }else{
	    	if(document.sitechform.serial_no.value!=""){
	    		var seiral_no = document.sitechform.serial_no.value;
	    		if(isNaN(seiral_no)){
	    			showTip(document.sitechform.serial_no,"��ˮ��ȫ�����������"); 
	    	   	sitechform.serial_no.focus(); 
	    	   	return false;	
	    	  }
	    	}
	    hiddenTip(document.sitechform.start_date);
	    hiddenTip(document.sitechform.end_date);
	    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
	    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
	    submitMe('0');
    }
}
function submitMe(flag){
   window.sitechform.myaction.value="doLoad";
    if(flag=='0'){
		 var vCon_id='';
		 var objSwap=window.top.document.getElementById('contactId');
		if(objSwap!=null&&objSwap!=null!=''){
			vCon_id=objSwap.value;
		}
       window.sitechform.action="k181_smsSendQry.jsp?con_id="+vCon_id;
		}else{
			 window.sitechform.action="k181_smsSendQry.jsp";
		}
   window.sitechform.method='post';
   window.sitechform.submit(); 
}
//=========================================================================
// LOAD PAGES.
//=========================================================================
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
  window.location="k181_smsSendQry.jsp";
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/k181_smsSendQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}


function showInNewWin(serial_no){
window.open("k180_showSmsSendQry.jsp?serial_no="+serial_no,'����¼��Ϣ','scrollbars=yes,height=768, width=1024');
}

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
	 window.sitechform.end_date.value="<%=end_date%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   
   window.sitechform.user_phone.value="<%=user_phone%>";
   window.sitechform.serial_no.value="<%=serial_no%>";
   window.sitechform.out_gateway_id.value="<%=out_gateway_id%>";
   window.sitechform.send_login_no.value="<%=send_login_no%>";
   window.sitechform.send_content.value="<%=send_content%>";
   window.sitechform.para.value="<%=myParams%>";
}

//���д򿪴���
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

function getLoginNo(){
  openWinMid('k180_getLoginNo.jsp','���Ų�ѯ',240,320);
}

//��������
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	  window.sitechform.para.value="<%=myParams%>";
		openWinMid('k181_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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

function showMsg(msg){
	openWinMid('k181_showMsg.jsp?msg='+msg+'&titlename=����','ѡ�񵼳���',160,320);
}
</script>
</head>


<body>
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table" style="width: 100%;">
		<table cellspacing="0" >
    <tr><td colspan='6' ><div class="title"><div id="title_zi">���ŷ��Ͳ�ѯ</div></div></td></tr>
   	   <input type="hidden" name="dataRows" value="<%=dataRows%>">
        <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?"":start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > �û����� </td>
      <td >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
				<input id="user_phone"  maxlength="15" name="0_=_user_phone" type="text" onkeyup="value=value.replace(/[^\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" value=<%=(user_phone==null)?"":user_phone%> >

      </td>
		  <td > ϵͳ��ˮ�� </td>
      <td >
      <!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
			  <input name ="1_=_serial_no" type="text" id="serial_no" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value="<%=(serial_no==null)?"":serial_no%>">
      </td> 
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 

		  <td > ���͹���</td>
      <td >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			 <input id="send_login_no" name="4_=_send_login_no" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(send_login_no==null)?"":send_login_no%>">
			 <img onclick="getLoginNo()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" >
		  </td> 
		  
		  <td > ��������</td>
      <td >
			 <input id="send_content" name="5_like_send_content" value="<%=(send_content==null)?"":send_content%>">
		  </td> 
   </tr>
   <tr>
		  <td > ����ID</td>
      <td >
			 <input id="out_gateway_id" name="3_=_out_gateway_id" value="<%=(out_gateway_id==null)?"":out_gateway_id%>">
		  </td> 
		  <td > &nbsp;</td>
      <td colspan="3">
      	 &nbsp;
		  </td> 
   </tr>
    <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 ��ѯ�����û�λ��--> 
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
			 <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
			 <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
      </td>
    </tr>
		</table>    
	</div>
	
	
  <div id="Operation_Table">	
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" colspan="5">
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
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
      <tr >
       <script>
       	var tempBool ='flase';
//if(checkRole(K181A_RolesArr)==true){	
//           document.write('<th align="center" class="blue" width="15%" > ���� </th>');	
//    		tempBool='true';
//    	}
        </script>
        <!--
            <th align="center" class="blue" width="10%" > ��ˮ�� </th>
            <th align="center" class="blue" width="10%" > ���͹��� </th>
            <th align="center" class="blue" width="10%" > �û����� </th>
            <th align="center" class="blue" width="10%" > �·�ʱ�� </th>
            <th align="center" class="blue" width="10%" > �·�URL��ַ </th>
            <th align="center" class="blue" width="10%" > ����ID </th>
            <th align="center" class="blue" width="10%" > �������� </th>
            <th align="center" class="blue" width="10%" > �������� </th>
         -->
            <th align="center" class="blue" width="10%" > ��ˮ��</th>
            <th align="center" class="blue" width="10%" > ���͹���</th>
            <th align="center" class="blue" width="10%" > �û�����</th>
            <th align="center" class="blue" width="10%" > ����ʱ��</th>
            <th align="center" class="blue" width="10%" > ��������</th>
          </tr>
          <% for (int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           if((i+1)%2==1){
             tdClass="grey";
            } 
           %>
	    <tr>
      <script>
      
                //if(tempBool=='true'){
      		//document.write('<td align="center" class="<%=tdClass%>"  >');
                //}
                //if(checkRole(K181A_RolesArr)==true){
      			
                //document.write('<img onclick="showInNewWin(\'<%=dataRows[i][0]%>\');return false;" alt="�鿴" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  align="absmiddle">');
             
                //}
                // if(tempBool=='true'){
      		//document.write('</td>');
                //}
      </script>
      <!--
      <td align="center" class="<%=tdClass%>"  >
       <img onclick="showInNewWin('<%=dataRows[i][0]%>');return false;" alt="�鿴" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  align="absmiddle">
      </td>
      -->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <!--         
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
       --><!--         
<td align="center" class="<%=tdClass%>" <%if(dataRows[i][0].length()>30){out.print("onClick=\"showMsg('"+dataRows[i][0]+"')\" style=\"cursor:hand\"");}%> ><%=(dataRows[i][0].length()!=0)?(dataRows[i][0].length()>30?dataRows[i][0].substring(0,15)+"...":dataRows[i][0]):"&nbsp;"%></td> 
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      -->
    </tr>
      <% } %>
      
    <tr >
      <td class="blue"  align="right" colspan="5">
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ȡ¼�������ѯ
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update yinzx 20090826 �޸Ľ�ɫ  
   * modify by yinxz 20091117 sql �Ż�
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%!
//����Excel
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "��ȡ¼�������ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3]};
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
    String opCode="K17C";
    String opName="�ۺϲ�ѯ-��ȡ¼�������ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	      /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams=request.getParameter("para"); 
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
    String beginTime    =  request.getParameter("beginTime");        //��ʼʱ��
    String endTime      =  request.getParameter("endTime");          //����ʱ��
    String logNo        =  request.getParameter("logNo");            //����
    String sysNo        =  request.getParameter("sysNo");            //��ˮ��
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	      
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"��ˮ��","����","ʱ��","�ļ�·��","�Ӵ���ˮ��"};
		String sqlFilter = request.getParameter("sqlFilter");

    if(sqlFilter==null || sqlFilter.trim().length()==0){
   	 if(beginTime!=null &&!beginTime.trim().equals("")&& endTime!=null&& !endTime.trim().equals("")){
       sqlFilter = " where listentime > to_date(:beginTime,'yyyyMMdd hh24:mi:ss') and listentime <  to_date(:endTime,'yyyyMMdd hh24:mi:ss')";
       myParams="beginTime="+beginTime.trim()+",endTime="+endTime.trim();
       //modified by liujied 20090921
       //sqlFilter += " and t1.kf_login_no = t2.kf_login_no(+) ";
       if(logNo!=null && !logNo.trim().equals("")){
          sqlFilter = sqlFilter+" and login_no = :logNo ";
          myParams+=",logNo="+logNo.trim();
       }
       if(sysNo!=null && !sysNo.trim().equals("")){
          sqlFilter = sqlFilter+" and contact_id =:sysNo ";
          myParams+=",sysNo="+sysNo.trim();
       }
     }
    }
    
    
  /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
	/*
	 *�Ƿ��ǻ���Ա update by hanjc 20090719
        *01120O04Ϊ��ѵ��ɫid,01120O0EΪ�ʼ��ɫid,011202Ϊ�ͻ��绰Ӫҵ����01120O02����ͨ��ϯ
        *01120O02011202��01120201120O02�ǿͻ��绰Ӫҵ������ͨ��ϯ������ɫ��ƴ��
        *����Աֻ�пͻ��绰Ӫҵ������ͨ��ϯ������ɫ,��01120O02011202��01120201120O02��������С�鳤��
	 */
	/* modify by yinzx 20090826 ����ɽ������д�Ľ��ң�����д����ɫ��Ϣ ���Ը��죬������ʱ����
      //add by hanjc 20090719 �жϵ�ǰ�����Ƿ��ǻ���Ա��
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		isCommonLogin="Y";	
         }
       } 
   *//*add by yinzx 090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
    
    if ("doLoad".equals(action)) {
       String sqlTemp = "select to_char(count(*)) count  from dlistenrecord t1,dloginmsgrelation t2  "+sqlFilter;
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
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
        //modified by liujied 20090921
        sqlStr = "select serial_no,login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        //sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="5" scope="end"/>	
<% 
					dataRows=queryList;
   } 
   
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
        //String sqlTemp = "select to_char(count(*)) count from dlistenrecord t "+sqlFilter;
        String sqlTemp = "select to_char(count(*)) count  from dlistenrecord t1,dloginmsgrelation t2"+sqlFilter;
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
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
        //sqlStr = "select serial_no,kf_login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));

%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="5" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
        //sqlStr = "select serial_no,kf_login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="6" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
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
<title>��ȡ¼�������ѯ</title>
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
				$(this).css("color", "#159ee4");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

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
    }else if(document.sitechform.endTime.value.substring(0,6)>document.sitechform.beginTime.value.substring(0,6)){
		     showTip(document.sitechform.endTime,"ֻ�ܲ�ѯһ�����ڵļ�¼"); 
    	   sitechform.endTime.focus(); 	
    }  
  else if(document.sitechform.logNo.value == ""&&document.sitechform.sysNo.value==""){
		showTip(document.sitechform.logNo,"���ŽӴ���ˮ�Ų���ͬʱΪ�գ������ѡ�������");
		sitechform.logNo.focus();
    }    
    else {
    	
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    hiddenTip(document.sitechform.logNo);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    doSubmit();
    }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k1714_listenRecInfoQry.jsp";
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
     window.location="k1714_listenRecInfoQry.jsp";
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
   window.sitechform.action="k1714_listenRecInfoQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }


//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1714_listenRecInfoQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
	window.sitechform.logNo.value="<%=logNo%>";
	window.sitechform.sysNo.value="<%=sysNo%>";
	window.sitechform.para.value="<%=myParams%>";
}
/**	
function getCallListen(id){
	if(id==''){
		return;
		}
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
}
*/

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

/**	*/
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    	}else{
	    		//alert("����ʧ��!");
	    		return false;
	    	}
	    }
	 } 
 
 function doLisenRecord(filepath,contact_id)
{
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		   window.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}		
function checkCallListen(id,staffno){
		if(id==''){
		return;
		}
		if('<%=isCommonLogin%>'=='Y'){
			if('<%=kf_longin_no%>'!=staffno){
			  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
			  return;
		  }
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
openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
}

//��������
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	  window.sitechform.para.value="<%=myParams%>";
		openWinMid('k1714_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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
	<div id="Operation_Table">
		<table cellspacing="0">
    <tr><td colspan='4' ><div class="title"><div id="title_zi">��ȡ¼�������ѯ</div></div></td></tr>
     <tr >
	    <td > ��ʼʱ�� </td>
	    <td >
				<input id="beginTime" name="beginTime" type="text"  value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	    </td>
     <td > ���� </td>
	    <td >
	    <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name="logNo" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(logNo==null)?"":logNo%>>
			  <font color="orange">*</font>
	    </td>
	   	
		</tr>
		   <tr >
     <td > ����ʱ�� </td>
	    <td>
			  <input name ="endTime" type="text" id="endTime"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td> 
		  <td> �Ӵ���ˮ��</td>
	    <td>
	    <!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
			  <input name ="sysNo" type="text" id="sysNo" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value=<%=(sysNo==null)?"":sysNo%>>
           <font color="orange">*</font>
		  </td>  
	   </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="4" align="center" id="footer" style="width:50em">
       <!--zhengjiang 20091004 ��ѯ�����û�λ��--> 
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput()">
       <input name="clear" type="button"  id="clear" value="����" onClick="clearValue()">
        <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>  
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
		<table  cellspacing="0">
    <tr >
      <td style="color:#0256B8" align="left" colspan="4">
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
  </table>
      <table  cellSpacing="0" >
        <input type="hidden" name="sqlFilter"  value="">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
			  
          <tr >
        <script>
       	var tempBool ='flase';
      	if(checkRole(K17CA_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" > ���� </th>');	
      		tempBool='true';
      	}
        </script>  
            <!--<th align="center" class="blue" width="30%" > ��ˮ�� </th> -->
            <th align="center" class="blue" width="30%" > �Ӵ���ˮ�� </th>
            <th align="center" class="blue" width="15%" > ���� </th>
            <th align="center" class="blue" width="20%" > ʱ�� </th>
            <th align="center" class="blue" width="30%" > �ļ�·�� </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr >
			<%}else{%>
	   <tr  >
	<%}%>
	      <script>
      	if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K17CA_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][4]%>\',\'<%=dataRows[i][1]%>\');return false;" alt="��ȡ����" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--
      <td align="center" class="<%=tdClass%>"  >
         <img onclick="doLisenRecord('<%=i%>','<%=dataRows[i][4]%>')" alt="��ȡ����" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
      </td>
      -->
      <!--<td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td> -->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <input type="hidden"  id="<%=i%>" value="<%=dataRows[i][3]%>">  
    </tr>
      <% } %>
    <tr >
      <td style="color:#0256B8" align="right" colspan="4">
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


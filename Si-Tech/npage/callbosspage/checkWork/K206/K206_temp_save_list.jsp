
<%
  /*
   * ����: ��ʱ���濼������б�
�� * �汾: 1.0.0
�� * ����: 2008/12/12
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K206";
	String opName = "��ʱ���濼������б�";
%>

<%@page contentType="text/html;charset=GBK"%>
<!--modify by zhengjiang 20090927 public_title_ajax.jsp��Ϊpublic_title_name.jsp-->
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
//String evterno = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));
String evterno = WtcUtil.repNull((String)session.getAttribute("workNo"));
String [][] queryList = new String[][]{};
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
%>
<%
//�����ж�һ���Ƿ��н����������ִ�в�ѯ����������Ч�ʡ�
String sqlCount = "select to_char(count(*)) from dqcinfo t1 where t1.flag='0' and t1.evterno='" + evterno
				 + "' and t1.is_del != 'Y' ";
myParams = "evterno=" + evterno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
<wtc:param value="<%=sqlCount%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="countList" scope="end"/>
<%
if(countList.length>0&&Integer.parseInt(countList[0][0])>0){
/*---------------�����ʱ���濼������б�ʼ-------------------*/
    String sqlStr = "select "          
                   +"t1.serialnum,     " //��ˮ��
                   +"t1.recordernum,   " //������ˮ��
                   +"t1.staffno,       " //���칤��
                   +"t3.object_name,   " //�������
                   +"t4.name,          " //��������
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ쿪ʼʱ�� 
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ����ʱ��
                   +"to_char(t1.score),         " //�ܵ÷� 
                   +"t1.objectid,         " //�������ID 
                   +"t1.contentid,         " //��������ID
                   +"t1.outplanflag         " //�ƻ��ڡ����ʼ��ʶ                   
                   +"from dqcinfo t1,dqcobject t3,dqccheckcontect t4 ";
		String strJoinSql = " where t1.flag='0' and t1.evterno=:evterno " 
											+ " and t1.is_del != 'Y' "  
	                    + " and t1.objectid=t3.object_id(+) "                                                   
                      + " and t1.contentid=t4.contect_id(+) " 
                      + " and t1.objectid=t4.object_id(+) " ;
    String strOrderSql = " order by t1.starttime desc ";
    myParams = "evterno=" + evterno;
    sqlStr += strJoinSql;
    sqlStr += strOrderSql;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryTempList" scope="end"/>
<%
  queryList=queryTempList;
}
/*---------------�����ʱ���濼������б����-------------------*/
%>

<html>
<head>
<title>��ʱ���濼������б�</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<!--modify by zhengjiang 20090927
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
-->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
/**
  *
  *Ϊ������ֵ
  *
  */
function getCheckItem(serialnum,object_id,content_id,isOutPlanflag){
    window.sitechform.content_id.value=content_id;
    window.sitechform.object_id.value=object_id;
    window.sitechform.serialnum.value=serialnum;
    window.sitechform.isOutPlanflag.value=isOutPlanflag;
}

//�ж��Ƿ�ѡ���˿�����
function doSubmitCheck(){
		var radio_check_content=document.getElementsByName("check_content");
		var flag="false";
		for(var i=0;i<radio_check_content.length;i++){
			  if(radio_check_content[i].checked==true)
			   {
			      doSubmit();
			      flag="true";
			      break;
			   }     
		}
		if(flag=="false"){
				similarMSNPop("��ѡ����ʱ���������");
		}
}

function doSubmit(){
		var planflag=window.sitechform.isOutPlanflag.value;
		var content_id=window.sitechform.content_id.value;
		var object_id=window.sitechform.object_id.value;
		var serialnum=window.sitechform.serialnum.value;
		var isOutPlanflag=window.sitechform.isOutPlanflag.value;	
		//updated by tangsong 20100525 ��������������
		//var  path="../callbosspage/checkWork/K214/K214_modify_plan_qc_main.jsp";
		var  path="../callbosspage/checkWork/K214/K214_modify_plan_qc_form.jsp";
		path = path + "?content_id=" + content_id;
		path = path + "&object_id=" + object_id
		path = path + "&serialnum=" + serialnum;
		path = path + "&isOutPlanflag=" + isOutPlanflag;
		path = path + "&isAdjust=K206";  
		path = path + "&staffno=" + "<%=(queryList.length>0)?queryList[0][2]:""%>";  
		if(isOutPlanflag=='1'){
				path = path + "&opCode=K206&opName=�ʼ�������-����ˮ�ʼ�";
		}else{
				path = path + "&opCode=K206&opName=�ʼ�������-�ƻ����ʼ�";
		}
		var opCode='<%=opCode%>';	
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		var tabId = opCode+serialnum;
		
		//zengzq start 090520
		//����ѡ����ͬһʱ��ֻ�ܴ�һ���ʼ�������ڣ��ƻ��ڣ��ƻ��⣬��ʱ���棬�޸ģ����˴��ڣ�
		/*var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K206' == partElement){
								similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");
						return false;
				}
		}
		*/
		//zengzq end 
		
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
			  parent.parent.addTab(true,tabId,'�ʼ����',path);
		}else{
				similarMSNPop("����ˮ�ʼ촰���Ѵ򿪣�");
		}
		return true;
}

//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ

/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
function changeColor(color,obj,rdo){
	document.getElementById(rdo).click();
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
<form  name="sitechform">
<!--
<%@ include file="/npage/include/header.jsp"%>
-->

<!--modify by zhengjiang 20090927 ����<div id="title_zi"></div> -->

<!--table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
		<td id="footer"  align="right">
			<div class="title"><div id="title_zi">��ʱ���濼�����</div></div>
		</td>
</tr>
</table-->

<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
			<td id="footer"  align="right" colspan='9'>
				<div class="title"><div id="title_zi">��ʱ���濼�����</div></div>
			</td>
			</tr>
      <tr>
        <th class="blue" nowrap >ѡ��        </th>      
        <th class="blue" nowrap >��ˮ��</th>
        <th class="blue" nowrap >������ˮ��</th>
        <th class="blue" nowrap >���칤��    </th>
        <th class="blue" nowrap >�������    </th>
        <th class="blue" nowrap >��������    </th>
        <th class="blue" nowrap >�ʼ쿪ʼʱ��</th>
        <th class="blue" nowrap >�ʼ����ʱ��</th>
        <th class="blue" nowrap >�ܵ÷�      </th>
      </tr>               
                          
<%
			String tdClass="blue";
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){
%>
	      <tr onClick="changeColor('<%=tdClass%>',this,'rdo<%=i%>');" >
	        <td class="<%=tdClass%>" nowrap ><input type="radio" name="check_content" id="rdo<%=i%>" onclick="getCheckItem('<%=queryList[i][0]%>','<%=queryList[i][8]%>','<%=queryList[i][9]%>','<%=queryList[i][10]%>');" value=""/></td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][0]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][1]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][2]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][3]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][4]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][5]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][6]%>&nbsp;</td>
	        <td class="<%=tdClass%>" nowrap ><%=queryList[i][7]%>&nbsp;</td>        
      	</tr>
<%
      	}
     }
%>
      </table>
    <br>
    </td>
  </tr>
  <tr>
  <td colspan="8" align="right" id="footer" style="width:420px">
   <input name="add" type="button"  id="add" class="b_foot" value="ȷ��" onClick="doSubmitCheck();return false;">
   <input name="cancle" type="button"  id="cancle"  class="b_foot" value="ˢ��" onClick="history.go(0);">
  </td>
</tr>
</table>
</div>
<input type="hidden" name="content_id"    value="">
<input type="hidden" name="object_id"     value="">
<input type="hidden" name="serialnum"     value="">
<input type="hidden" name="isOutPlanflag" value="">
</FORM>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</BODY>
</HTML>
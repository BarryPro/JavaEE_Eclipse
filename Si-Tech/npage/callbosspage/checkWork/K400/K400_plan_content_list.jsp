<%

  /*
   * ����: ����ˮ�����ʼ�->ѡ���ʼ�ƻ�
�� * �汾: 1.0.0
�� * ����: 
�� * ����: 
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opName = "����ˮ�����Զ�����";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
	
	String plan_id         = WtcUtil.repNull(request.getParameter("plan_id"));
	//String serialnum       = WtcUtil.repNull(request.getParameter("serialnum"));
	//String login_no        = request.getParameter("staffno");
  //modified by liujied 20090925
	//String check_login_no  = (String)session.getAttribute("kfWorkNo");
  String check_login_no  = (String)session.getAttribute("workNo");//��Ϊboss����
	String sqlStr          = "";
	if(plan_id == null || plan_id.equals("")){
		  //����SQL����Ѿ�������Ȩ��У�� check_kind = '0'��ʶΪ�Զ������ƻ�
		  sqlStr = "select distinct (select a.name from dqccheckcontect a where trim(a.object_id) = trim(t1.object_id) and trim(a.contect_id) = trim(t1.content_id)), " +
		           "(select b.object_name from dqcobject b where trim(b.object_id) = trim(t1.object_id)), " +
		           "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag|| '_' ||t1.bqcgrouptype,t1.plan_id " + 
		           "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
		           "where trim(t1.object_id) = trim(t4.object_id) and trim(t1.content_id) = trim(t4.contect_id) and trim(t1.plan_id) = trim(t2.plan_id) and trim(t1.plan_id) = trim(t3.plan_id) and " +
		           "trim(t3.check_login_no) = :check_login_no and t1.check_kind = '0' and " +
		           "sysdate >= t1.begin_date and sysdate <= t1.end_date order by trim(t1.plan_id)";
		  myParams = "check_login_no="+check_login_no.trim() ;
	   
	}else{
		//����SQL����Ѿ�������Ȩ��У��         	
	    sqlStr = "select distinct (select a.name from dqccheckcontect a where trim(a.object_id) = trim(t1.object_id) and trim(a.contect_id) = trim(t1.content_id)), " +
	             "(select b.object_name from dqcobject b where trim(b.object_id) = trim(t1.object_id)), " +
	             "t4.source_id, to_number(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag|| '_' ||t1.bqcgrouptype,t1.plan_id " + 
	             "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
	             "where trim(t1.object_id) = trim(t4.object_id) and trim(t1.content_id) = trim(t4.contect_id) and trim(t1.plan_id) = trim(t2.plan_id) and trim(t1.plan_id) = trim(t3.plan_id) and " +
	             "trim(t3.check_login_no) = :check_login_no and trim(t1.plan_id) = :plan_id and t1.check_kind = '0' and " +
	             "sysdate >= t1.begin_date and sysdate <= t1.end_date order by trim(t1.plan_id)";    
	    myParams = "check_login_no="+check_login_no.trim()+",plan_id="+plan_id.trim();
}
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="9">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>

<html>
<head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
	function getReturnNum(plan_id,object_id,content_id_checked,group_flag,bqcgrouptype){
			var objectvalue = document.getElementById('object_value');
			var contentvalue = document.getElementById('content_value');
			var qc_objectvalue = objectvalue.innerText;
			var qc_contentvalue= contentvalue.innerText;
		
			var time     = new Date();
			var height = 150;
			var width  = 380;
			var top    = (screen.availHeight - height)/2;
			var left   = (screen.availWidth - width)/2;
			var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
			window.open('K400_get_number.jsp?time=' + time+'&plan_id='+plan_id+'&object_id='+object_id+'&group_flag='+group_flag+'&bqcgrouptype='+bqcgrouptype+'&content_id_checked='+content_id_checked+'&qc_objectvalue='+qc_objectvalue+'&qc_contentvalue='+qc_contentvalue, '', param);
	}

function goto(){
		var content_ids = document.getElementsByName("check_content");
		var content_id_checked = "";
		var object_id = "";
		var plan_id = "";
		var group_flag = "";
		var bqcgrouptype = "0"; //���ƻ����������� 0 Ϊ��ͨ���ű����� 1Ϊ��ˮ������
		//var tabId = opCode+serialnum;

		for(var i = 0; i < content_ids.length; i++){
				if(content_ids[i].checked){
						content_id_checked = content_ids[i].value;
				}
		}
		
		if(content_id_checked == ""){
				similarMSNPop("��ѡ��һ������ݣ�");
				return false;
		}
		//zengzq start 090520
		//����ѡ����ͬһʱ��ֻ�ܴ�һ���ʼ�������ڣ��ƻ��ڣ��ƻ��⣬��ʱ���棬�޸ģ����˴��ڣ�
		var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K216' == partElement){
								similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");   
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");
						return false;
				}
		}
		//zengzq end 
		
		var arr = content_id_checked.split('_');
		object_id = arr[0];
		content_id_checked = arr[1];
		plan_id = arr[2];
		group_flag = arr[3];
		bqcgrouptype = arr[4];
		getReturnNum(plan_id,object_id,content_id_checked,group_flag,bqcgrouptype);
}

</script>

</head>

<body>
<form  name="formbar">
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">ѡ��</td>
        <td class="blue">��������</td>
        <td class="blue">�ʼ�������</td>
        <td class="blue">����������Դ</td>
        <td class="blue">Ȩ��</td>
        <td class="blue">�Ƿ��Զ���ȡ</td>
        <td class="blue">��ʽ</td>
      </tr>

<%
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){
%>
      <tr>
        <td class="blue"><input type="radio" name="check_content" <%if(i==0){out.println("checked");}%> value="<%=queryList[i][6]%>"/></td>
        <td class="blue" id="object_value"><%=queryList[i][0]%>&nbsp;</td>
        <td class="blue" id="content_value"><%=queryList[i][1]%>&nbsp;</td>
        <td class="blue">
<%
        	if(queryList[i][2].equals("0")){
        	  	out.println("ͨ����¼");	
        	  }else if(queryList[i][2].equals("1")){
        	  	out.println("������¼");
        	  }else if(queryList[i][2].equals("2")){
        	  	out.println("�ʼ���");
        	  }else if(queryList[i][2].equals("3")){
        	  	out.println("ͳ������");
        	  }
%>&nbsp;        
        &nbsp;</td>
        <td class="blue"><%=queryList[i][3]%>&nbsp;</td>
        <td class="blue">
<%
			if(queryList[i][4].equals("Y")){out.println("��");}else{out.println("��");}
%>
        &nbsp;
        </td>
        <td class="blue"><%=queryList[i][5]%>&nbsp;</td>
      </tr>
<%
      }
     }
%>
      </table>
    </div>
    <br/>
    </td>
  </tr>
  <tr>
  	<td>
  	</td>
</tr>
</table>

    <div id="Operation_Table">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="goto();" type="button" class="b_foot" value="ȷ��">
				<input name="back" onClick="window.history.go(0);" type="button" class="b_foot" value="ˢ��">

			</td>
		</tr>
	</table>
</div>
</form>
</body>
</html>
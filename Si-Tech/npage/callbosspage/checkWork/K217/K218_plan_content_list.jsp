<%
  /*
   * ����: ����ˮ�����ʼ�->ѡ���ʼ�ƻ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
  * modify yinzx 20100505:
  * 1.���ε������js ����ͷ�ļ�public_title_name.jsp
  * 2.�Ż�sql ʹ������ 
  * 3.qcCount   tempQcCount �ƺ�û��
�� */
%>
<%
	String opCode = "K218";
	String opName = "����ˮ�����ʼ�";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
	public String getCurrDateStr(String str) {
		if(str.equals("")){
			return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		}else{
			java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
			return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		}
	}
%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String plan_id         = WtcUtil.repNull(request.getParameter("plan_id"));
	String serialnum       = WtcUtil.repNull(request.getParameter("serialnum"));
	String flag       		 = WtcUtil.repNull(request.getParameter("flag"));
	String start_date      = WtcUtil.repNull(request.getParameter("start_date"));
	String login_no        = request.getParameter("staffno");
        //modified by liujied 20090925
        //String check_login_no  = (String)session.getAttribute("kfWorkNo");
        String check_login_no  = (String)session.getAttribute("workNo");
	String sqlStr = "";
	/* modify by yinzx  �Ż�sql ��� ȥ��trim  ʹ������  20100505*/
	if(plan_id == null || plan_id.equals("")){
		  //����SQL����Ѿ�������Ȩ��У�� check_kind = '1'��ʶΪ���Զ������ƻ�
	 /* sqlStr = "select (select a.name from dqccheckcontect a where trim(a.object_id) = trim(t1.object_id) and trim(a.contect_id) = trim(t1.content_id)), " +
		           "(select b.object_name from dqcobject b where trim(b.object_id) = trim(t1.object_id)), " +
		           "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id,t1.group_flag " + 
		           "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
		           "where trim(t1.object_id) = trim(t4.object_id) and trim(t1.content_id) = trim(t4.contect_id) and trim(t1.plan_id) = trim(t2.plan_id) and trim(t1.plan_id) = trim(t3.plan_id) and trim(t2.login_no) = :login_no and " +
		           "trim(t3.check_login_no) =:check_login_no and t1.check_kind = '1' and " +
		           "sysdate >= t1.begin_date and sysdate <= t1.end_date order by trim(t1.plan_id)";  */
		           
		           sqlStr = "select t4.name , " +
		           "(select b.object_name from dqcobject b where b.object_id = t1.object_id), " +
		           "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id,t1.group_flag " + 
		           "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
		           "where t1.object_id = t4.object_id and t1.content_id = t4.contect_id and t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t2.login_no = :login_no and " +
		           "t3.check_login_no =:check_login_no and t1.check_kind = '1' and " +
		           "sysdate >= t1.begin_date and sysdate <= t1.end_date order by t1.plan_id";
		           
		 myParams = "login_no="+login_no.trim()+",check_login_no="+check_login_no.trim();
	   
	}else{
		//����SQL����Ѿ�������Ȩ��У��         	
	  /*sqlStr = "select (select a.name from dqccheckcontect a where trim(a.object_id) = trim(t1.object_id) and trim(a.contect_id) = trim(t1.content_id)), " +
	             "(select b.object_name from dqcobject b where trim(b.object_id) = trim(t1.object_id)), " +
	             "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id,t1.group_flag " + 
	             "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
	             "where trim(t1.object_id) = trim(t4.object_id) and trim(t1.content_id) = trim(t4.contect_id) and trim(t1.plan_id) = trim(t2.plan_id) and trim(t1.plan_id) = trim(t3.plan_id) and trim(t2.login_no) = :login_no and " +
	             "trim(t3.check_login_no) =:check_login_no and trim(t1.plan_id) = :plan_id and t1.check_kind = '1' and " +
	             "sysdate >= t1.begin_date and sysdate <= t1.end_date order by trim(t1.plan_id)";   */
	             
	             sqlStr = "select t4.name, " +
	             "(select b.object_name from dqcobject b where  b.object_id = t1.object_id), " +
	             "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id,t1.group_flag " + 
	             "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
	             "where t1.object_id = t4.object_id and t1.content_id = t4.contect_id and t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t2.login_no = :login_no and " +
	             "t3.check_login_no =:check_login_no and t1.plan_id = :plan_id and t1.check_kind = '1' and " +
	             "sysdate >= t1.begin_date and sysdate <= t1.end_date order by t1.plan_id";   
	             
	    myParams = "login_no="+login_no.trim()+",check_login_no="+check_login_no.trim()+",plan_id="+plan_id.trim();
	}

%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>
	<!-- qcCount   tempQcCount  �ϴ���  guozw ȷ�� �����ε�   ���� ̫��  �ȸɵ�    -->
<html>
<head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script>
	
	//zengzq add start ���ж��ˣ����˿����ж�
	//�ʼ�ǰ�ж��Ƿ��ѱ��ʼ��
			//flag 0:�ƻ����ʼ� 1:�ƻ����ʼ�
			function checkIsQc(serialnum,flag,staffno){
				var content_ids = document.getElementsByName("check_content");
				var content_id_checked = "";
				var plan_id = "";
				var group_flag = "";
				
				for(var i = 0; i < content_ids.length; i++){
						if(content_ids[i].checked){
								content_id_checked = content_ids[i].value;
						}
				}
				if(content_id_checked == ""){
						similarMSNPop("��ѡ��һ������ݣ�");
						return false;
				}
				var arr1 = content_id_checked.split('_');
				plan_id = arr1[2];
				group_flag = arr1[3];
		
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","���ڽ������ʼ�У�飬���Ժ�......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",'<%=start_date%>');
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);
			  mypacket.data.add("plan_id",plan_id);
			  mypacket.data.add("group_flag",group_flag);
			  core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
			}
			
			function doProcess(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var checkList = packet.data.findValueByName("checkList");
				var isOutPlanflag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");
				
			  if(parseInt(checkList)<1){
			    goto();
				}else{
					rdShowMessageDialog("����ˮ�Ѿ����й��ʼ죬�����ظ����У�");
				}
			}
	//zengzq add finished
function goto(){
		var content_ids = document.getElementsByName("check_content");
		var content_id_checked = "";
		var object_id = "";
		var plan_id = "";
		var group_flag = "";
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
		/*
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
		*/
		//zengzq end 
		
		var arr = content_id_checked.split('_');
		object_id = arr[0];
		content_id_checked = arr[1];
		plan_id = arr[2];
		group_flag = arr[3];
		document.formbar.plan_id.value = plan_id;
		document.formbar.group_flag.value = group_flag;
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K217/K217_checkTimes_rpc.jsp","���ڽ��мƻ���ֵУ�飬���Ժ�......");
		mypacket.data.add("plan_id",plan_id);
	  mypacket.data.add("object_id",object_id);
	  mypacket.data.add("content_id_checked",content_id_checked);
	  mypacket.data.add("staffno",'<%=login_no%>');
	  core.ajax.sendPacket(mypacket,doProcessGetTimes,true);
		mypacket=null;
}

function doProcessGetTimes(packet){
		var toCheck = packet.data.findValueByName("toCheck");
		var object_id = packet.data.findValueByName("object_id");
		var content_id = packet.data.findValueByName("content_id");
		
	  if(parseInt(toCheck)>0){
	  		similarMSNPop("�Բ��𣬵�ǰ�ʼ�ƻ��Ѵ���������");  
		}else{
				openQcTab(object_id,content_id);
		}
}

function openQcTab(object_id,content_id_checked){
		var objectvalue = document.getElementById('object_value');
		var contentvalue = document.getElementById('content_value');
		var qc_objectvalue = objectvalue.innerText;
		var qc_contentvalue= contentvalue.innerText;
		var serialnum='<%=serialnum%>';
		var opCode='<%=opCode%>';	
		var plan_id = document.formbar.plan_id.value;
		var group_flag = document.formbar.group_flag.value;
		var tabId = opCode+serialnum;
		var path = '/npage/callbosspage/checkWork/K217/K217_out_plan_qc_form.jsp?serialnum=' + '<%=serialnum%>'+'&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&object_id='+object_id+'&opCode=K218&opName=����ˮ�ʼ�&content_id=' + content_id_checked +'&isOutPlanflag=0&staffno=<%=login_no%>&plan_id='+plan_id+'&group_flag='+group_flag+'&tabId='+tabId;
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		
		
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
		    parent.parent.addTab(true,tabId,'����ˮ�ʼ�',path);
		    parent.parent.removeTab(serialnum+0);
		    
		}else{
				similarMSNPop("����ˮ�ʼ촰���Ѵ򿪣�");
		}
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
        	  }else if(queryList[i][1].equals("1")){
        	  	out.println("������¼");
        	  }else if(queryList[i][1].equals("2")){
        	  	out.println("�ʼ���");
        	  }else if(queryList[i][1].equals("3")){
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
				<input name="confirm" onClick="checkIsQc('<%=serialnum%>','<%=flag%>','<%=login_no%>');" type="button" class="b_foot" value="ȷ��">
				<input name="back" onClick="window.history.go(0);" type="button" class="b_foot" value="ˢ��">

			</td>
		</tr>
	</table>
</div>
<input type='hidden' name='plan_id' id='plan_id' value='<%=(queryList.length>0)?queryList[0][7]:""%>'>
<input type='hidden' name='group_flag' id='group_flag' value='1'>
</form>
</body>
</html>
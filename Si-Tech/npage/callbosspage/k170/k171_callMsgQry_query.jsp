
<%
  /*
   * ����: ������Ϣ��ѯ
�� * �汾: 1.0
�� * ����: 2008/10/14
�� * ����: donglei
�� * ��Ȩ: sitech
   * update: libin 2009/04/27 �ͻ�����
   * update yinzx 20090826 �޸Ľ�ɫ
 ��*/
 %>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>

<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<html>
<head>
<style>
	img{
				cursor:hand;
		}

	input{
		height: 1.6em;
		line-height: 1.6em;
		width: 10em;
		font-size: 1em;
	}
</style>
<title>������Ϣ��ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}



%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
  /*modify by yinzx 0923 */
	String kf_longin_no = (String) session.getAttribute("workNo");

    /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
  //added by tangsong 20100406
	if (powerCode == null) {
		powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
	String isCommonLogin2="N";
	/*
	 *�Ƿ��ǻ���Ա update by hanjc 20090719
        *01120O04Ϊ��ѵ��ɫid,01120O0EΪ�ʼ��ɫid,011202Ϊ�ͻ��绰Ӫҵ����01120O02����ͨ��ϯ
        *01120O02011202��01120201120O02�ǿͻ��绰Ӫҵ������ͨ��ϯ������ɫ��ƴ��
        *����Աֻ�пͻ��绰Ӫҵ������ͨ��ϯ������ɫ,��01120O02011202��01120201120O02��������С�鳤��
        *01120201120O0G��01120O0G011202ΪС���Ž�ɫidƴ��
	 */
	 /* modify by yinzx 20090826 ����ɽ������д�Ľ��ң�����д����ɫ��Ϣ ���Ը��죬������ʱ����
      //add by hanjc 20090719 �жϵ�ǰ�����Ƿ�����ͨ��ϯ������Ƿ���ͨ��ϯ����ѯ��������Ĭ��Ϊ�ա�
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)||"01120201120O0G".equals(tempVal)||"01120O0G011202".equals(tempVal)){
		        isCommonLogin2="Y";
         }
       }
   */
   for(int i = 0; i < powerCodeArr.length; i++){
		if(XZZ_ID.equals(powerCodeArr[i]) ){
			isCommonLogin2="Y";
		}
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin2="Y";
			}
		}
	}	
%>


<script language="javascript">
    //���д򿪴���
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //ת����ҳ�ĵ�ַ;
		  //var name; //��ҳ���ƣ���Ϊ;
		  //var iWidth; //�������ڵĿ��;
		  //var iHeight; //�������ڵĸ߶�;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}

function getLoginNo(){
  openWinMid('k170_getLoginNo.jsp','���Ų�ѯ',240,400);
}

$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
			$("a").hover(function(){
				$(this).css("color", "orange");
			}, function(){
				$(this).css("color", "#159ee4");
			});
		}
	);

//��������
function showExpWin(flag){
	 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 document.sitechform.month_interval.value = month_interval;
  openWinMid('k171_expSelect.jsp?flag='+flag,'expSelect',340,320);
}

//�ж�stratDate,endDate���������,0ͬ�·�,1���һ����
function getMonths(startDate,endDate){
 number = 0;
 yearToMonth = (endDate.getFullYear() - startDate.getFullYear()) * 12;
 number += yearToMonth;
 monthToMonth = endDate.getMonth() - startDate.getMonth();
 number += monthToMonth;

 return number;
}

function submitInputCheck(orderColumn, orderCode){
	 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 document.sitechform.month_interval.value = month_interval;
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"��ʼʱ�䲻��Ϊ��");
    	   sitechform.start_date.focus();

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��");
    	   sitechform.end_date.focus();

    }else if("Y"=="<%=isCommonLogin2 %>" && (document.getElementById("caller_phone").value == "") && (document.getElementById("contact_id").value == "") && (document.getElementById("accept_login_no").value == "") && (document.getElementById("accept_phone").value == "")){

    		 	showTip(document.getElementById("accept_login_no"),"����ɸѡ����");


    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
    	   sitechform.end_date.focus();

    }else if(month_interval > 1){
    		 showTip(document.sitechform.end_date,"ֻ�ܲ�ѯ2�����ڵļ�¼");
    		 sitechform.end_date.focus();
  	}
    /*common by hucw,20100915,ʵ�ֿ��²�ѯ���ܣ���ֻ�ܿ�һ����
    else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯһ�����ڵļ�¼");
    	   sitechform.end_date.focus();
    }*/else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"����ʱ���Ҳ�ֵ����������ֵ");
    	   sitechform.accept_long_end.focus();
    }
    else
    {
				hiddenTip(document.sitechform.start_date);
				hiddenTip(document.sitechform.end_date);
				hiddenTip(document.sitechform.accept_long_end);
				hiddenTip(document.getElementById('contact_id'));
				hiddenTip(document.getElementById('accept_login_no'));
				hiddenTip(document.getElementById('accept_phone'));
				//added by tangsong 20100531 ����������
				//begin
				window.sitechform.orderColumn.value=orderColumn;
				window.sitechform.orderCode.value=orderCode;
				//end
				submitMe('0','0','0');
    	}
}

function changeCheckBoxStatus(){
	var checkBox= document.getElementById("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	if(checkBox.checked==true){
		window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value="Y";
	}
}

/*zengzq 20100125 ����submitMe���������Ӳ��� isFirstQry,��Ϊ0����Ϊ��ѯ����Ϊ1 ��Ϊ�����һҳ����һҳ����ת��*/
function submitMe(flag,isFirstQry,rCount){
		//updated by tansong 20101221 ����ʹ�����ֲ�
		/*
		//zengzq 20100125 ��ѯ���δ����ʱ�������ڵ�����ҳ���ڵ�
		parent.resultFrame.hiddenOperate();
		*/

		//zengzq 20100125 ����ǵ����һҳ�ȣ���ֱ�ӽ����������ݷ��� isFirstQryΪ1���־Ϊ�����һҳ�Ƚ��еĲ�ѯ��rowCount��ʾ��ѯ�������--�����һҳ��
   	//flagΪ0����¼�ͻ��Ӵ���־
   	if(flag=='0'){
		 	var vCon_id='';
		 	var objSwap=window.top.document.getElementById('contactId');
			if(objSwap!=null&&objSwap!=null!=''){
				vCon_id=objSwap.value;
			}
      window.sitechform.action="result.jsp?con_id="+vCon_id+"&isFirstQry="+isFirstQry+"&rCount="+rCount;
		}else{
			window.sitechform.action="result.jsp?isFirstQry="+isFirstQry+"&rCount="+rCount;
		}
   window.sitechform.method='post';
   window.sitechform.target = 'resultFrame';
   window.sitechform.submit();
}
function changeSize(typeA){

	var row;
	//ȫ��ͼʱ
	if(document.getElementById('show_content_btn').style.display=='none')
		row = 290;
	else
		row = 165;
				if(typeA==1){
					parent.frames['frameset110'].rows=''+row+',*';
				}else if(typeA==2){
					parent.frames['frameset110'].rows='290,*';
				}else if(3==typeA){
					parent.frames['frameset110'].rows='320,*';
				}else{
					parent.frames['frameset110'].rows='290,*';
			  }
			}
			
	function search1(){	
	   $.ajax({
			type: "post",
			url: "K171_callMsgQry_quence.jsp",
			data: "skill_quence_choose="+document.sitechform.skill_quence_choose.value,
			success: function(data){
				$("#skill_quence").empty();
				$("#skill_quence").append(data);
			}
		});  

	}

</script>
</head>

<body>
<form id=sitechform name=sitechform>
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="doLoad">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 �������� -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="" />
	<input type="hidden" name="orderCode" id="orderCode" value="" />
	<div id="Operation_Table" style="width:100%">
		<table cellspacing="0">
		<div class="title">
			<div id="title_zi">������Ϣ</div>
			<div style='float:right;width:70px'>
			<a id='show_content_btn' onclick="showContent()" style="cursor:pointer">����&gt;&gt;</a>
			<a id='hide_content_btn' onclick="hideContent()" style='display:none;cursor:pointer'>����&lt;&lt;</a>
			</div>
		</div>

    <tr >
      <td  nowrap > ��ʼʱ�� </td>
      <td  nowrap >
			  <input  id="start_date" name ="start_date" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" onchange="changeSize(1)">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td  nowrap > Ա������ </td>
      <td  nowrap >
			 <select style="width:10em" id="staffcity" name="staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].value">
			 	<!-- value Ϊ�գ���ѯʱ���Զ����Դ�����-->

			 	<option value="" selected>--����Ա������--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_name , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
			  <font color="red">*</font>
      </td>
      <td  nowrap > ��ˮ�� </td>
      <td  nowrap >
      <!--zhengjiang 20091010���value=value.replace(/[^a-zA-Z\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input style="width:12em" id="contact_id" name="contact_id" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text" value="">
				<font color="red">*</font>
      </td>
    </tr>
    <tr >
      <td  nowrap > ����ʱ�� </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(3);" onchange="changeSize(1);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);changeSize(3);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		    <input id = "month_interval" name="month_interval" type="hidden"/>
		  </td>
	  	<td  nowrap > ������ </td>
      <td  nowrap >
			  <!--input name ="2_=_accept_kf_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this)"  value="<%="Y".equals(isCommonLogin2) ? kf_longin_no:"" %>" -->
			  <!--zhengjiang 20091010 ����value=value.replace(/[^kf\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%="Y".equals(isCommonLogin2) ? kf_longin_no:"" %>">
		    <img onclick="getLoginNo()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" >
		    <font color="red">*</font>
		  </td>
	  	<td  nowrap > ������� </td>
      <td  nowrap >
			  <input name ="accept_phone"  maxlength="15" type="text" id="accept_phone"  value="" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" >
		   <font color="red">*</font>
		  </td>

     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
      <td  nowrap > �ͻ����� </td>
      <td  nowrap >
			  <select style="width:10em" name="usertype" id="grade_code" size="1" onchange="grade.value=this.options[this.selectedIndex].value">

			  <option value="" selected>--���пͻ�����--</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
					<wtc:sql>select user_class_id , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
					</wtc:qoption>
        </select>
				<input name="grade" type="hidden" value="">
		  </td>
	  	<td  nowrap > ��ϵ�绰 </td>
      <td nowrap  >
			  <input name ="contact_phone" type="text" id="contact_phone"  value="">
		  </td>
	  	<td  nowrap > ���к��� </td>
      <td  nowrap >
			  <input name ="caller_phone" type="text" id="caller_phone"  value="" "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>
     </tr>
	<tbody id='hidenSection' style="display:none">
    <!-- THE THIRD LINE OF THE CONTENT hide section-->
    <tr >
     <td  nowrap > �ͻ����� </td>
      <td  nowrap >
			  <input name ="cust_name" type="text" id="cust_name"  value="">
		  </td>
		 <td  nowrap > ������� </td>
     <td  nowrap >
			  <input name ="fax_no" type="text" id="fax_no"  value="">
		 </td>
		 <td  nowrap > ����ʽ </td>
     <td  nowrap >
		  <select style="width:10em" name="acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].value">
		  	  <option value="" selected>--��������ʽ--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="accid" type="hidden" value="">
		  </td>
    </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
    <td  nowrap > �ͻ����� </td>
      <td  nowrap >
			 <select style="width:10em" id="region_code" name="region_code" size="1" onchange="region.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--���пͻ�����--</option>
				   <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				   </wtc:qoption>

        </select>
        <input name="region" type="hidden" value="">
      </td>
     <td  nowrap >���к��� </td>
      <td >
<input name ="callee_phone" type="text" id="callee_phone"  value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">

      </td>
     <td  nowrap > �һ��� </td>
      <td  nowrap >
        <select style="width:10em" name="staffHangup" id="staffHangup" size="1" onchange="hangup.value=this.options[this.selectedIndex].value">
                  <!-- add by jiyk 2012-06-14 -->
        	   <option value="" selected>ȫ��</option>
				     <option value="0" >�û�</option>
				     <option value="1" >����Ա</option>
				      <option value="3" >������֤ʧ���Զ��ͷ�</option>
				       <option value="4" >תIVR�һ�</option>
				        <option value="5">����</option> 
				        <option value="6">ת���йһ�</option>


        </select>
        <input name="hangup" type="hidden" value="">
      </td>

    </tr>
        <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
     <td  nowrap > ¼����ȡ��־ </td>
     <td  nowrap >
				<%
					//updated by tangsong 20100603 ��ͨ����Ա����ѡ��¼����ȡ��־
					boolean isHWY = false;
					for(int i = 0; i < powerCodeArr.length; i++){
						for(int j = 0; j < HUAWUYUAN_ID.length; j++){
							if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
								isHWY = true;
								break;
							}
						}
					}
					if (!isHWY) {
				%>
        <select style="width:10em" id="listen_flag" name="listen_flag" size="1" onchange="listen.value=this.options[this.selectedIndex].value">
        	<option value="" selected>ȫ��</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
					<wtc:sql>select listen_flag_code , listen_flag_code|| '-->' ||listen_flag_name from SLISTENFLAG</wtc:sql>
					</wtc:qoption>
        </select>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
				<%
					} else {
				%>
        <select style="width:10em" id="listen_flag" name="listen_flag" size="1" disabled>
        	<option value="" selected>ȫ��</option>
        </select>
				<%
					}
				%>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
      	</td>
     		<td  nowrap > ����ʱ�� </td>
      	<td >
			  >=<input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:5.5em" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <=<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:5.5em"  value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  	</td>
	      <td  nowrap > �ͻ������ </td>
	      <td >
      	 <select style="width:10em" name="statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].value">

      	 	<option value="all" selected >--���������--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>

        </select>
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>">
		  	</td>
    	</tr>
    <tr>
    <td  nowrap > �����ʼ� </td>
      <td  nowrap >
			  <input name="mail_address" type="text" maxlength="80"  id="mail_address"  value="">
      </td>
    <td  nowrap > ��ϵ��ַ </td>
      <td >
			  <input name ="contact_address" type="text" id="contact_address"  value="">
      </td>
     <td  nowrap > �ѽ���������֤ </td>
      <td  nowrap >
			  <input name ="VERTIFY_PASSWD_FLAG_ISNOT_NULL" type="checkbox"  id="VERTIFY_PASSWD_FLAG_ISNOT_NULL" onClick="changeCheckBoxStatus();" value="">
      </td>
    </tr>
    <tr>
    	<td  nowrap >���ܶ���ɸѡ</td>
    	 <td >
    	<input name ="skill_quence_choose" type="text" id="skill_quence_choose"  value="">
    	<input name="searchE" type="button"  id="searchE" value="��ѯ" style="width:3em" onClick="search1();">
    	</td >
      <td  nowrap >���ܶ��� </td>
      <td colspan="3" nowrap >
        <select style="width:30em" id="skill_quence" name="skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].value">
        	<option value="" selected>--���м��ܶ���--</option>
        	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				  <wtc:sql>select skill_queud_name , skill_queue_id ||'-->' || skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>
	 <tr >

    </tr>
    </tbody>
    <tr >
      <td colspan="6" align="center" id="footer" style="width:600px">

       <!--zhengjiang 20091004 ��ѯ�����û�λ��-->
       <input name="search" type="button" class="b_foot" id="search" value="��ѯ" onClick="submitInputCheck('','');">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="����">
       <input name="export" type="button" class="b_foot"  id="search" value="����" onClick="showExpWin('cur');"%>
       <input name="exportAll" type="button" class="b_foot"  id="add" value="����ȫ��" onClick="showExpWin('all');"%>
       <script>
       if(checkRole(K171M_RolesArr)==true){//p20130227 ¼������Ȩ�޿��� ���������޸� K171M_RolesArr
             		document.write('<input name="downloadAll" type="button" class="b_foot"  id="downloadAll" value="����¼��" onClick="parent.frames[\'resultFrame\'].download()"/>');
       }
       </script>
      </td>
    </tr>
		</table>
	</div>
	</form>
</body>

<script>

	function hideContent(){
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		document.getElementById('hidenSection').style.display='none';
		//$("#hidenSection").slideUp("fast");
		parent.frames['frameset110'].rows='165,*';
	}
	function showContent(){
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		document.getElementById('hidenSection').style.display='block';
		//$("#hidenSection").slideDown("fast");
		parent.frames['frameset110'].rows='290,*';
	}


</script>

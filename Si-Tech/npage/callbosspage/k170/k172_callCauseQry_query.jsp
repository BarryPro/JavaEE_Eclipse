<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ����ԭ���ѯ
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����: donglei
�� * ��Ȩ: sitech
   * update: fangyuan ��ʽ���� 20091006
   *
 ��*/
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.Calendar"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>

<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<%

     /*midify by yinzx 20091113 ������ѯ�����滻*/
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	/*String kf_longin_no  = (String) session.getAttribute("kfWorkNo");
	/modify wangyong 20090923 �޸�Ϊboss������Ϣ*/
	String kf_longin_no  = (String) session.getAttribute("workNo");
	String isCommonLogin2 = "N";

	/*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	//String  powerCode = (String)session.getAttribute("powerCode");
	//String[]  powerCodeArr = powerCode.split(",");

    //+++���Դ���begin����106��kfaa06�������ͨ��ϯ��ɫ����4366��kfaa12������ʼ�Ա��ɫ
	String  powerCode      = (String)session.getAttribute("powerCodekf");
	//added by tangsong 20100406
	if (powerCode == null) {
		powerCode = "";
	}
	String[] tempPowerCode = powerCode.split(",");
	String[]  powerCodeArr = new String[tempPowerCode.length + 1];
	powerCodeArr           = powerCode.split(",");
//added by liujied
        System.out.println("kf_longin_no"+kf_longin_no);
	if(kf_longin_no.equals("106")){
		powerCodeArr[powerCodeArr.length-1] = "0100020H";
	}else if(kf_longin_no.equals("4366")){
		powerCodeArr[powerCodeArr.length-1] = "0100020I";
	}
	//+++���Դ���end����106��kfaa06�������ͨ��ϯ��ɫ����4366��kfaa12������ʼ�Ա��ɫ
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
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>


		<script language="javascript">
			function changeCheckBoxStatus(){
				var causeCheckBox= document.getElementById("cause_id_is_null");
				if(causeCheckBox.checked==true){
						window.sitechform.cause_id_is_null.value="checked";
				} else if (causeCheckBox.checked==false){
						window.sitechform.cause_id_is_null.value="";
					}
			}

			$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");

			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
			});
		}
	);

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

			//��������
			function showExpWin(flag){
				 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
				 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
				 var month_interval = getMonths(startDate,endDate);
				 document.sitechform.month_interval.value = month_interval;
				openWinMid('k172_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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

			function submitInputCheck(){
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
			    }else if("Y" == "<%=isCommonLogin2 %>" && (document.getElementById("caller_phone").value == "") && (document.getElementById("contact_id").value == "") && (document.getElementById("accept_login_no").value == "") && (document.getElementById("accept_phone").value == "")){
    		 	     showTip(document.getElementById("accept_login_no"),"����ɸѡ����");
          }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
					     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
			    	   sitechform.end_date.focus();
			    }else if(month_interval > 1){
			    		 showTip(document.sitechform.end_date,"ֻ�ܲ�ѯ2�����ڵļ�¼");
			    		 sitechform.end_date.focus();
  				}
  				/*comment by hucw,20100915,ʵ�ֿ��²�ѯ����
  					else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
					     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯһ�����ڵļ�¼");
			    	   sitechform.end_date.focus();

			    }*/else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
					     showTip(document.sitechform.accept_long_end,"ͨ��ʱ���Ҳ�ֵ����������ֵ");
			    	   sitechform.accept_long_end.focus();

			    }else if(document.getElementById("cause_id_is_null").checked==true&&window.sitechform.show_CauseName.value!=""){
					     showTip(document.sitechform.show_CauseName,"����ԭ�������ԭ��Ϊ�ղ���ͬʱѡ��");
					     sitechform.show_CauseName.focus();
				  }
			    else{
			      hiddenTip(document.sitechform.start_date);
			      hiddenTip(document.sitechform.end_date);
			      hiddenTip(document.sitechform.accept_long_end);
			      hiddenTip(document.sitechform.show_CauseName);
			      hiddenTip(document.getElementById('accept_login_no'));
			      submitMe('0','0','0');
			    }
			}

			/*zengzq 20100125 ����submitMe���������Ӳ��� isFirstQry,��Ϊ0����Ϊ��ѯ����Ϊ1 ��Ϊ�����һҳ����һҳ����ת��*/
			function submitMe(flag,isFirstQry,rCount){
				 //updated by tansong 20101221 ����ʹ�����ֲ�
				 /*
				 //zengzq 20100125 ��ѯ���δ����ʱ�������ڵ�����ҳ���ڵ�
				 parent.resultFrame2.hiddenOperate();
				 */

				 //zengzq 20100125 ����ǵ����һҳ�ȣ���ֱ�ӽ����������ݷ��� isFirstQryΪ1���־Ϊ�����һҳ�Ƚ��еĲ�ѯ��rowCount��ʾ��ѯ�������--�����һҳ��
			    if(flag=='0'){
					 var vCon_id='';
					 var objSwap=window.top.document.getElementById('contactId');
					if(objSwap!=null&&objSwap!=''){
						vCon_id=objSwap.value;
					}
			       window.sitechform.action="result_cause.jsp?con_id="+vCon_id+"&isFirstQry="+isFirstQry+"&rCount="+rCount;;
					}else{
						 window.sitechform.action="result_cause.jsp?isFirstQry="+isFirstQry+"&rCount="+rCount;
					}
			   window.sitechform.method='post';
			   window.sitechform.target = 'resultFrame2';
			   window.sitechform.submit();
			}

			//չ������ԭ����
			function showCallCauseTree(strflag){
			  openWinMid("k174_callCauseSelectTree.jsp?flag="+strflag,'ѡ������ԭ��',500, 400);
			}

			function changeSize(typeA){
				var row;
				//ȫ��ͼʱ
				if(document.getElementById('show_content_btn').style.display=='none')
					row = 225;
				else
					row = 175;
				if(typeA==1){
					parent.frames['frameset120'].rows=''+row+',*';
				}else if(typeA==2){
					parent.frames['frameset120'].rows='295,*';
				}else if(3 == typeA){
					parent.frames['frameset120'].rows='325,*';
				}else{
					parent.frames['frameset120'].rows='295,*';
			  }
			}
		</script>
	</head>


<body>
<form id=sitechform name=sitechform>
		<input type="hidden" name="page" value="">
		<input type="hidden" name="sqlFilter" value="">
		<input type="hidden" name="sqlWhere" value="">
		<div id="Operation_Table">
			<table cellspacing="0" width="100%">
			<div class="title">
				<div id="title_zi">����ԭ��</div>
				<div style='float:right;width:70px'>
				<a id='show_content_btn' onclick="showContent()" style="cursor:pointer;color:#159ee4;">����>></a>
				<a id='hide_content_btn' onclick="hideContent()" style='display:none;cursor:pointer;color:#159ee4;'>����<<</a>
			</div>
		</div>

    <!-- THE FIRST LINE OF THE CONTENT -->

      <tr >
      <td  nowrap > ��ʼʱ�� </td>
      <td  nowrap >
		<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);" onchange="changeSize(1);"  value="<%=getCurrDateStr("00:00:00")%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>

      <td   nowrap > ��ˮ�� </td>
      <td  nowrap >
      <!--zhengjiang 20091010���value=value.replace(/[^a-zA-Z\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input id="contact_id" name="contact_id" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text"   value="">
      </td>
      <td   nowrap > ������� </td>
      <td  nowrap >
			  <input name ="accept_phone"  maxlength="15" type="text" id="accept_phone"  value="" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
     </td>

    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td   nowrap > ����ʱ�� </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text" value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(3);" onchange="changeSize(1);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(3);hiddenTip(document.sitechform.end_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		    <input id = "month_interval" name="month_interval" type="hidden"/>
		  </td>
	  <td   nowrap > ������ </td>
      <td >
      <!--zhengjiang 20091010 ����value=value.replace(/[^kf\d]/g,'');��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<% if("Y".equals(isCommonLogin2)){out.println(kf_longin_no);} %>">

		  </td>
	    <td nowrap > ���к��� </td>
      <td >
			  <input name ="caller_phone" type="text" id="caller_phone"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  value="">
		  </td>
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
        <tr >
      <td   nowrap > ����ԭ�� </td>
      <td  nowrap >
      	<input name="showCauseName"  id="show_CauseName"  readOnly="true" type="text" value="">
		  <img onclick="showCallCauseTree('0');"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
		  </td>
	  <td   nowrap > ����ʽ </td>
      <td >
		  <select name="acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].value">

		  	<option value="" selected>--��������ʽ--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>

        </select>
        <input name="accid" type="hidden" value="">

		  </td>
	  <td  nowrap > �ͻ�Ʒ�� </td>
      <td nowrap >
			 	<select name="sm_code" id="sm_code" size="1" onchange="brand.value=this.options[this.selectedIndex].value">
			 		<!--zhengjiang 20091010 �޸�sql����allow_flag='Y' and sm_code in ('dn','z1','gn')��Ϊallow_flag = '1' and sm_code in ('dn','cb','gn','z0','hn')-->
			 		<option value="" selected>--����Ʒ��--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select distinct sm_code , '-->' ||sm_name from ssmcode where allow_flag = '1' and sm_code in ('dn','cb','gn','z0','zn','hl')</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="brand" type="hidden" value="">
		  </td>

     </tr>
    <tbody id='hidenSection' style="display:none">
    <tr>
	  <td  nowrap > Ա������ </td>
      <td nowrap >
			 <select id="staffcity" name="staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--����Ա������--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="oper" type="hidden" value="">
     </td>
      <td  nowrap > ͨ��ʱ�� </td>
      <td>
			 &gt
			 <input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:5.5em;height:1.2em;padding:1px" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			 &lt;
			 <input name ="accept_long_end" type="text" id="accept_long_end"  maxlength="5" style="width:5.5em;height:1.2em;padding:1px" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" >
		  </td>
	  <td  nowrap > �ͻ����� </td>
      <td >
			 <select id="region_code" name="region_code" size="1" onchange="region.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--���пͻ�����--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="region" type="hidden" value="">
        <input name ="call_cause_id" type="hidden" id="call_cause_id"  value="">
      </td>
		</tr>

     <tr>
	  <td  nowrap > �ͻ������ </td>
      <td nowrap >
      	 <select name="statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].value">

      	 	<option value="all" selected >--���������--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>

        </select>
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>">
		  </td>
      <td  nowrap > ����ԭ��Ϊ�� </td>
      <td nowrap >
			  <input name ="cause_id_is_null" type="checkbox" id="cause_id_is_null" onClick="changeCheckBoxStatus();" value="">
		  </td>
		  <td colspan="6"  nowrap >&nbsp;</td>
		</tr>
    </tbody>
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px" nowrap >
      <!--zhengjiang 20091004 ��ѯ�����û�λ��-->
       <input name="search" type="button" class="b_foot"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="����">
			 <input name="export" type="button" class="b_foot"  id="search" value="����" onClick="showExpWin('cur');">
       <input name="exportAll" type="button" class="b_foot"  id="add" value="����ȫ��" onClick="showExpWin('all');">

      </td>
    </tr>
		</table>
	</div>
</form>
</body>
</html>

<script>

	function hideContent(){
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		//$("#hidenSection").slideUp("fast");
		document.getElementById('hidenSection').style.display='none';
		parent.frames['frameset120'].rows='175,*';
	}
	function showContent(){
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		document.getElementById('hidenSection').style.display='block';
		//$("#hidenSection").slideDown("fast");
		parent.frames['frameset120'].rows='225,*';
	}



</script>

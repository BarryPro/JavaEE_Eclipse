<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���ŷ���
�� * �汾: 1.0
�� * ����: 2008/11/1
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  �޸Ĵ��룺
   * ����������ǿ
   * ʱ�䣺2009/04/11
   * �޸����ݣ��޸��˱��е�form������ȫ������getElementById
   * update yinzx 20090827 �޸� 1.�����ļ���������  2.�޸ķ���
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
    //String caphone = (String)session.getAttribute("capn");
    //String caphone = (String)request.getParameter("acceptPhoneNo");
    String opCode="K083";
    String opName="���ŷ���";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
	  String msg_content = (String)request.getParameter("msg_content");
	  
	  String action = (String)request.getParameter("myaction");
	  String isFirstIn = (String)request.getParameter("isFirstIn");//�Ƿ��ǵ�һ�ν��롣N����Y����
	  
	  String scucc_flag = (String)request.getParameter("flag");
	  String user_phone = WtcUtil.repNull(request.getParameter("user_phone"));
	  System.out.println("\n\n=1=scucc_flag==\n"+scucc_flag);
	  if(scucc_flag==null){
	    scucc_flag="";
	  }
	  System.out.println("\n\n=2=scucc_flag==\n"+scucc_flag);

  	/*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090425*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  	String isLeader="N";	
	/*
	 *�Ƿ���ֵ�ྭ�� ���Ի�����[0100020L] ����������[01120O0A]��   ����ʱ��һ��
	 */
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<ZBJL_ID.length; j++)
		if(ZBJL_ID[j].equals(powerCodeArr[i])){
			isLeader="Y";	
		}
	}	  
	  
%>

<html>
<head>
<title>���ŷ���</title>
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

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
//�򿪶���Ԥ���崰��
function addMsgModel(){
	openWinMid("K083_main.jsp",'�Զ������',650,850);
}

function sendMsg(){
	
	/*
	if(getLen(document.sitechform.msg_content.value)>320){
		rdShowMessageDialog('������������ܳ���160������,����320���ַ���');
		return;
	}
	*/
	//kangxq ��������������޸�Ϊ160���֣�320���ַ�
	//�����������ݣ�����Ϊ700�ֽ�
	/*modify by yinzx �޸��Ϊ500���ַ�*/
	if(getLen(document.getElementById('msg_content').value)>255){
		rdShowMessageDialog('������������ܳ���128������,����255���ַ���');
		return;
	}
	
   if( document.getElementById('user_phone').value == ""){
	  	rdShowMessageDialog('���ͺ��벻��Ϊ�գ������ѡ�������!');
		  return;
    }
    //document.sitechform.msg_content.value == ""
	 if(document.getElementById("msg_content").value == ""){
	  	rdShowMessageDialog('�������ݲ���Ϊ�գ������ѡ�������!');
		  return;
    }
	
    sendSubmit();
    
}

function encodeMsg(){
	var msg_content = document.getElementById('msg_content').value;
	msg_content = msg_content.replace(/\+/g,"%2B");
	return msg_content;
}	

//rpc���÷���

function sendSubmit(){
	//alert('send msg');
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K083/K083_msgSend_rpc.jsp","���ڷ��Ͷ��ţ����Ժ�......");
	mypacket.data.add("user_phone",document.getElementById('user_phone').value);
	var str = window.top.document.getElementById('contactId').value;
	mypacket.data.add("msg_content",encodeMsg());
	mypacket.data.add("con_id",str);
	core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket = null;
}	

function doProcess(packet){
	var retCode = packet.data.findValueByName("scucc_flag");
			//alert(retCode);
	if(retCode=="1"){
    //window.document.getElementById('flag').value="1";
	 rdShowMessageDialog("���ͳɹ���",2); 
	 //chengh 20090417�����û���Ӧ���ŷ��ͺ����ݱ��棬�������ա�
	 document.getElementById('user_phone').value="";   
	}else if(retCode=="0"){
    //window.document.getElementById('flag').value="0";
		rdShowMessageDialog("����ʧ�ܣ�");    
	}
	 // var user_phone=window.sitechform.user_phone.value;
	  //window.sitechform.action="K083_msgSend.jsp?user_phone="+user_phone;
    //window.sitechform.method='post';
   // window.sitechform.submit();
}

/**�ж϶��ŵĳ��ȡ�
   *һ����ĸ���ֵȱ�ʾһ������
   *һ�����ֱ�ʾ��������
   */
function getLen(str) 
{ 
var len=0; 

if(str != null && str.length>0){

   for(var i=0;i<str.length;i++){ 
    char = str.charCodeAt(i); 
    if(!(char>255)){ 
     len = len + 1; 
    }else { 
     len = len + 2; 
    } 
   } 
}
return len;
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

		function g(o){
			return document.getElementById(o);
		}
		function HoverLi(n){
			window.frames['iframe0'+n].location.reload();
			for(var i=1;i<=1;i++)
			{
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
			}
			g('tbc_0'+n).className='dis';
			g('tb_'+n).className='hovertab';
			
		}
		
				//�ж϶��������ͷ��Ͷ�������
		function onCharsChange(varField){ 
			var leftChars = getLeftChars(varField);
			var num = 1;
	      if ( leftChars >= 0){
					document.getElementById('charsmonitor').value=leftChars;
					if(parseInt(leftChars%70)==0){
						num = leftChars/70;
					}else{
						num = parseInt(leftChars/70)+1;
					}
					
					document.getElementById('sendnum').value = num;
					return true;   
        }
    }

    function getLeftChars(varField)   {  
      var i = 0;   
      var counter = 0;
      var leftchars = varField.value.length;            
      return (leftchars);   
    }
    
    
function checkcontent(){
  window.document.getElementById('user_phone').value=window.document.getElementById('user_phone').value.replace(/[^\d|^,]/g,'');
}
function loadMany(){
	openWinMid("K083_loadMany.jsp",'��������',250,550);
	//window.open("K083_loadMany.jsp");
}
</script>

		<style>
		.content_02
		{
			font-size:12px;
		}
		#tabtit
		{
			height:23px;
			padding:0px 0 0 12px;
		} 
		#tabtit ul
		{
			height:23px;
			position:absolute;
		} 
		#tabtit ul li
		{
			float:left;
			margin-right:2px;
			display:inline;
			text-align:center;
			padding-top:7px;
			cursor:pointer;
			height:22px;
			width:100px;
		}
		#tabtit .normaltab
		{
			color:#3161b1;
			background:url(../../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
			height:23px;
		}
		#tabtit .hovertab 
		{ 
			color:#3161b1;
			background:url(../../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
			height:24px;
		}
		.dis
		{
			display:block;
			border-top:1px solid #6c90ca;
			background:#fff url(../../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
			padding:8px 12px;
		}
		.undis
		{
			display:none;
		}
		.content_02 .dis li
		{
			line-height:1.8em;
			padding-left:12px;
		}
		#msg{
		width:180px;
		height:120px;
		position:absolute;
		right:0px;
		bottom:0px;
		z-index:2;
		border:1px solid #555;
		background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
		font-size:12px;
		}
		#msgTitle{
		height:16px;
		padding:8px 0px 0px 10px;
		border-bottom:2px solid #b3f9ff;
		position:relative;
		}
		#msgContent{
		padding:10px;
		height:1%;
		color:#555;
		}
		#msgImg{
		position:absolute;
		right:5px;
		top:5px;
		z-index:10;
		width:10px;
		height:10px;
    }
  </style>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body onload=''>

	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title" style="height: 32px;"><div id="title_zi">
		���ͺ��� &nbsp;<input name="user_phone" id="user_phone"  onkeyup="checkcontent();" type="text" value="" size="15">
		<font color=''>&nbsp;&nbsp;�����������","����!��(151****9107,135****6697)</font>&nbsp;
			<!--update by songjia 20100902-->
			<input name="clearnum" type="button"  id="clearnum"  style='height:25px' value="�������" onClick="document.getElementById('user_phone').value='';">  
			<!--end-->
		</div>
		
		</div>
		<table cellspacing="0">
		</table>   
    <table cellspacing="0" cellpadding="0">
    <table id="particularinfo" width="100%" border="0" cellpadding="0" cellspacing="0" >
    	<tr><td width='35%' height="100%">
			��<input name=charsmonitor style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>�ַ�  ��<input name=sendnum style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>�η���<br />
			<textarea name="msg_content" id="msg_content"  style="width:100%;word-break:break-all"  rows="20" title='�������250�����ֻ�500���ַ�' onpaste="return onCharsChange(this);" onkeyup="return onCharsChange(this);"></textArea>
							    </td>
							<!--   modify by yinzx 20090827   
							  <td valign="top">
							    	<div class="content_02" width="100%">
										<div id="tabtit" width="100%">
											<ul>
												
												<li id="tb_1" class="normaltab" onclick="HoverLi(1);" nowrap>
													Ԥ�������
												</li>
											</ul>
										</div>
										<div class="undis" id="tbc_01" width="100%">
											<iframe id="iframe01" style="height:90%" name="framePreconcerted" src="K083_ifram_preconcert.jsp" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>

										</div>
							    </td> -->
      </tr>
		</table>
		 

		<p id="footer"><input name="send" type="button"  id="send" value="ִ��" onClick="sendMsg()">
			<%if("cddd".equals(isLeader)){%>
			<input name="addMsgModel" type="button"  id="addMsgModel" value="�Զ�����Ű�" onClick="addMsgModel()"/>
			<%}%>
		 		 
		</p>
<input type="hidden" id="myaction" name="myaction" value="">
<input type="hidden" id="isFirstIn" name="isFirstIn" value="N">
<input type="hidden" id="flag" name="flag" value="">
	</div>
</div>

<script>
	// by fangyuan 20090420 ���ŷ��ʹ�������롣
	getCaller();
	function getCaller(){
		var phonenum = window.top.document.getElementById('acceptPhoneNo').value;
		var callNo="";
		if(window.top.cCcommonTool.getOp_code()=='K025')
		{
			callNo = window.top.cCcommonTool.getCalled();	
		}
		else
		{
			callNo = window.top.cCcommonTool.getCaller();
		}
		//��ǰû�д������������
		if(callNo==""){
			callNo = phonenum;
		}else{
			if(phonenum!=""&&callNo != phonenum){
					callNo = phonenum;
			}	
		}
		document.getElementById('user_phone').value=callNo;
	}
</script>

<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>


<%
  /*
   * ����: ���β���
�� * �汾: 1.1.0
�� * ����: 
�� * ����: 
�� * ��Ȩ: 
   * update: libin ���β����޸�
   *         chengh ���β����޸� 20090318
�� */
%>



<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>���β���</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="<%=request.getContextPath() %>/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/sitechcallcenter.js"></script>
	<style type="text/css">
	#get_rest_title{
	text-align: left;
	height: 25px;
	width: 100%;
	float: left;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FFFFFF;
    }
	</style>	
	<script type="text/javascript">
	
	function rest(){
	    /*
	     *��Ҫ���ֻ��������jsǰ�˵�У��
	     */
	     var rest_time = '';
	     var radios = document.getElementsByName('rest_time');
	     for(var i = 0; i < radios.length; i++){
	        if(radios[i].checked){
	        	rest_time = radios[i].value;
	        }
	     }
		//window.opener.cCcommonTool.getRest(rest_time);
		window.opener.exeRest(rest_time);
		//window.close();
	}
	</script>
  </head>
  
  <body>
 <!-- <div class="groupItem" id="div1_show"><div id="get_rest_title">���β���</div>
	</div> -->
	<form name="sitechform" method="post">
	<div class="layer_content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue" height="25px" align="right">
						�绰���룺
						</td>
						<td>
							<input type="text" name="secondDial" value="" onKeyup="timeCall(this.value);">
						</td>
					</tr>
					<tr>
						<td class="blue" height="25px" align="right">
							<input type="checkbox" name="secondDialnow" value="1" onclick="checkedbox()" checked >
						</td>
						<td>��������</td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="ȷ��" onclick="submitConfig()">
							<input class="b_foot" name="cancel" type="button" onclick="goaway();" value="ȡ��" >
						</td>
					</tr>
				</table>
   </div>
	</form>
</body>
</html>
<script language="javascript">
document.sitechform.secondDial.focus();
//ѡ�и�ѡ���۽��������  by chengh 2009-03-18
function submitConfig()
{
	/**
var returnvalue="";
//alert(document.getElementById("secondDialnow").checked);
if(document.getElementById("secondDialnow").checked)
returnvalue="1";
//alert(document.getElementById("secondDial").value+"isnowsend"+returnvalue); 
window.returnValue=document.getElementById("secondDial").value+"isnowsend"+returnvalue; 
 **/
//�������β��Ŷ���
  var tf = document.sitechform.secondDialnow;
	//�����绰�����ı�����
  var tv = document.sitechform.secondDial.value;
  if(tv==""){
  	window.opener.similarMSNPop("������绰��");
  	return false;
  }else{
  	if(tf.checked){
     window.opener.cCcommonTool.AgentSendDTMF(tv);//�������β����¼�  
     window.close();	
    }else{
    	window.opener.cCcommonTool.AgentSendDTMF(tv);//�������β����¼�
    	document.sitechform.secondDial.value = "";
    	return false;
    }
  } 
}

function goaway()
{
window.returnValue="cancel";   
window.close();
}

//ʵ�����û�ѡ�񼴲�����ʱ���������ı���ʵʱ�¼�  by libin 2009-03-16
//ʵ�����û�ѡ�񼴲�����ʱ���������ı���ʵʱ�¼�  by chengh 2009-03-18
//ѡ�и�ѡ���۽��������  by chengh 2009-03-18
function timeCall(value){
	//������������checkbox����
	var tf = document.sitechform.secondDialnow;
	//�����绰�����ı�����
	var tv = document.sitechform.secondDial.value;
	var rs = tv.replace(new RegExp('#', 'g'), '');
	var ts = rs.split("*");
	var flag = true;
	for(var i = 0; i < ts.length; i++){
		if(isNaN(ts[i])){
			flag = false;
			break;
		}
	}
	if(tf.checked){
		//document.sitechform.secondDial.focus();
		if(flag){//�ж��Ƿ����ֻ���*
			var num = tv.substring(tv.length-1);
		  window.opener.cCcommonTool.AgentSendDTMF(num);
	  }else{
	  	//window.opener.rdShowMessageDialog("����������",1);
			window.opener.similarMSNPop("���������ֻ�*��#�ַ�");
      document.sitechform.secondDial.value=tv.substring(0,tv.length-1);
      //return false;
	    
	  }
  }
	
}
//ѡ�и�ѡ���۽��������  by chengh 2009-03-18
function checkedbox (){
	document.sitechform.secondDial.focus();
		var tf = document.sitechform.secondDialnow;
		if(!tf.checked){
	     document.sitechform.secondDial.value="";
	  }
}
</script>
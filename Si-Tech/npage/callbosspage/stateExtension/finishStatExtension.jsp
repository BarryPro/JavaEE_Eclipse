<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
  <head>
	<title>����̬�ӳ�</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="<%=request.getContextPath() %>/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/sitechcallcenter.js"></script>
	<style type="text/css">
	#get_rest_title{
	text-align: left;
	height: 20px;
	width: 100%;
	float: left;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FFFFFF;
    }
	</style>	

  </head>
	<BODY>
	<!--form name="form1" method="post" action=""-->
			<!--<div class="groupItem" id="div1_show">
		<div class="itemHeader"><div id="get_rest_title">����̬�ӳ�</div>-->
	</div>
			<div class="layer_content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue" height="25px">
							��ʱ����
						</td>
						<td>
							<div  id="totalTime" align="top"></div>
						</td>
					</tr>
					<tr>
						<td class="blue" height="25px">
							����ʱ����
						</td>
						<td>
						  <div  id="usedTime" ></div>
						</td>
					</tr>
					<tr>
						<td class="blue" height="25px">
							�ӳ�ʱ����
						</td>
						<td>
							 <input type="text" name="extandTime" size="10"><font class="orange">*</font>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" height="40px" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="ȷ��"
								onclick="sub1ExtendTime()">
							<input class="b_foot" name="cancel" type="button"
								onclick="window.close();" value="ȡ��">
						</td>
					</tr>
				</table>
			</div>
		<!--/form-->
	</BODY>
</HTML>

<script type="text/javascript">
	usedTime.innerHTML = window.opener.wnowsll;
	var allTime=window.opener.document.getElementById("beforeTime").value;
	if(allTime==''){
		totalTime.innerHTML="20";
	}else{
		totalTime.innerHTML=allTime;	
	}
 function sub1ExtendTime()
 {
 	//alert('111');
   var extendTime=document.getElementById("extandTime").value;
   var tTime=eval(document.getElementById("totalTime").innerHTML);
   var usedTime=document.getElementById("usedTime").innerHTML;
   //alert('222');
   //alert('usedTime--'+usedTime);
    if(!(/^(\d)+$/.test(extendTime))){
      //rdShowMessageDialog("ֻ����������,����������!",1);
      window.opener.similarMSNPop("ֻ����������,����������!"); 
		  document.getElementById("extandTime").value="";
		  document.getElementById("extandTime").focus();
		  return false;
    }
    if(parseInt(extendTime)>120){
    	//rdShowMessageDialog("�ӳ�ʱ���ܳ���120��,����������!",1);
    	 window.opener.similarMSNPop("�ӳ�ʱ���ܳ���120��,����������!"); 
    	document.getElementById("extandTime").value="";
		  document.getElementById("extandTime").focus();
		  return false;
    } 
   //fangyuan ��¼���κϼ�ʱ��,������ֵ
   var tempAllTime = parseInt(tTime)+parseInt(extendTime);
   if(tempAllTime>120){
   	   window.opener.similarMSNPop("�ۼ�ʱ������120��,�������ӳ�!"); 
   	   return false;
   }else{
        var arrTime = usedTime.split(':');
        var i_minute = parseInt(arrTime[1]);
        //modified by liujied,added Number mathod
        var i_secs = parseInt(new Number(arrTime[2]));
   	 //alert('i_minute= '+i_minute+' i_secs= '+i_secs);
     var i_usedTime;
     if(i_minute>0){
     	  i_usedTime = 60*i_minute+i_secs;
     }else{
     		i_usedTime = i_secs;
     }
     //alert('i_usedTime= '+i_usedTime);
	   //�����µ��ӳ�ʱ�䲢����
	   var newTime =parseInt(tTime)-parseInt(i_usedTime)+parseInt(extendTime);
	   //alert(tTime+' '+usedTime+' '+extendTime+' '+newTime);
	   window.opener.subExtendTime(newTime);
	   window.opener.document.getElementById("beforeTime").value = tempAllTime;
   }
   window.close();
 }	
 var h_extendIntev;
 // fangyuan 200900316 ʵʱ��������ʱ�䡣
 function refreshUsedTime(){
 	if(window.opener.g_usedSecs==0){
 		//var temp = document.getElementById('usedTime').innerHTML;
 		//document.getElementById('usedTime').innerHTML =eval(temp)+1;
 		//ֹͣInterval
 		clearInterval(h_extendIntev);
 		window.close();
 		return false;	
 	}else{
 		document.getElementById('usedTime').innerHTML = window.opener.wnowsll; 	
	}
 }
 h_extendIntev = setInterval(refreshUsedTime,1000);

</script>

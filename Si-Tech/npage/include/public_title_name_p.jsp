<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    /* BEGIN : add by qidp for ϵͳ���� @ 2010-04-19 */
    String versonType = WtcUtil.repNull((String)session.getAttribute("versonType"));    // ҳ���ܰ汾:: normal:��ͨ��;simple:���ٰ�.
    System.out.println("$ versonType = "+versonType);
    
    String cssPath = "default";
    if(!"simple".equals(versonType)){
        cssPath = WtcUtil.repNull((String)session.getAttribute("cssPath"));  // ϵͳƤ��
    }
    System.out.println("$ css path is : "+cssPath);
    /* END : add by qidp */
%>

<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script type="text/javascript" src="/njs/si/common.js"></script>
<script type="text/javascript" src="/njs/si/framework.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="/njs/si/validate_class.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/calendar.js"></script>
<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css" />

<%
	String g_CustId = request.getParameter("gCustId");
	//String opName = WtcUtil.repNull(request.getParameter("opName"));
	//String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String tabcloseId = WtcUtil.repNull(request.getParameter("closeId"));
	
	
	String paramValue_zhaz="N";
	
	String activePhone  = (String)request.getParameter("activePhone");
	String appCnttFlag  = (String)application.getAttribute("appCnttFlag");//�Ӵ�ƽ̨״̬
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//ҵ��ʼʱ��
	
	System.out.println("liubo    tabcloseId==="+tabcloseId);
	
%>
<!--ȡ���ò���-->
<wtc:pubselect name="sPubSelect" outnum="1" retval="retVal00" retCode="retCode00" retMsg="retMsg00">
	<wtc:sql>
		select param_value from ssysctrlparam where param_id='6'
	</wtc:sql>
</wtc:pubselect>
<wtc:array id="paramResult" property="retVal00" scope="end"/>
<%if(paramResult.length > 0){
	paramValue_zhaz = paramResult[0][0];
}%>

<script language="javascript">
var oldClose = window.close;
window.close=function()
{
	//�����Ͷ���
	if((typeof parent.removeTab )=="function")
	{
		 removeCurrentTab();
	}
	else //����
	{
		oldClose();
	}
}

$(document).ready(function() {		
    //�����ύ�ȴ�Ч��
		var formNum = document.forms.length;
		for(i=0;i<formNum;i++){
			var oldSubmit;
			var form=document.forms[i];
			if(form != null && form != 'undefined'){
				//����submit����
				form.oldSubmit = form.submit;
				//����submit������ʵ������
				form.submit = function (){
		            //�����ύЧ��
		            loading();
		            //��ԭ�������ύ
			    	form.oldSubmit();
				}
			}
		}
});

function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet,doNext);
	packet =null;
	
	if("<%=tabcloseId%>"!="")
	{
			 parent.removeTab('<%=tabcloseId%>');
	}
}

function doNext(packet)
{
	  var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg");   
	  if(retCode=="0")
	  {
	  	var sData = packet.data.findValueByName("sData"); 
	  	parent.parent.$("#carNavigate").html(sData);
	  	//alert(sData);
	  	
	  	var custOrderId = packet.data.findValueByName("custOrderId"); 
	  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
	  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
	  	var servOrderId = packet.data.findValueByName("servOrderId"); 
	  	var status = packet.data.findValueByName("status"); 
	  	var funciton_code = packet.data.findValueByName("funciton_code"); 
	  	var funciton_name = packet.data.findValueByName("funciton_name"); 
	  	var pageUrl = packet.data.findValueByName("pageUrl"); 
	  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
	  	var num = packet.data.findValueByName("num"); 
	  	var offerId = packet.data.findValueByName("offerId"); 
	  	var offerName = packet.data.findValueByName("offerName"); 
	  	var phoneNo = packet.data.findValueByName("phoneNo"); 
	  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
	  	var prtFlag = packet.data.findValueByName("prtFlag"); 
	  	var servBusiId = packet.data.findValueByName("servBusiId"); 
	    var validVal = packet.data.findValueByName("validVal"); 
	  	var openWay = packet.data.findValueByName("openWay"); 
	  	var closeId=orderArrayId+servOrderId;
	  	var funciton_add = packet.data.findValueByName("funciton_add"); 
	  	//alert(orderArrayId);
	  	if("<%=paramValue_zhaz%>" == "Y"){
		  	parent.parent.checkHasBill(funciton_code);
		  	if(parent.parent.hasBill == "N"){
			   		rdShowMessageDialog("������δ��������,���ܽ���ҵ�����!",0);
			   		return false;
			   }
			   if(parent.parent.todayHasBill == "Y"){
			   		rdShowMessageDialog("�������Ѿ��������,���ܽ���ҵ�����!",0);
			   		return false;
			   }
	  	}
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	
	  	var mydate = new Date();
	  	var opBeginTime=mydate.getTime();
	  	
	  	var path=pageUrl+"?gCustId=<%=g_CustId%>"
	  							+"&opCode="+funciton_code
	  						  +"&opName="+funciton_name
	  							+"&offerSrvId="+offerSrvId
	  							+"&num="+num
	  							+"&offerId="+offerId
	  							+"&offerName="+offerName
	  							+"&phoneNo="+phoneNo
	  							+"&sitechPhoneNo="+sitechPhoneNo
	  							+"&orderArrayId="+orderArrayId
	  							+"&custOrderId="+custOrderId
	  							+"&custOrderNo="+custOrderNo
	  							+"&servOrderId="+servOrderId
	  							+"&closeId="+funciton_code
	  							+"&servBusiId="+servBusiId
	  							+"&prtFlag="+prtFlag
	  							+"&opBeginTime="+opBeginTime
	  							+"&opcodeadd="+funciton_add;
	  				
	  	 //alert('closeId=='+closeId);										
		   //alert('path=='+path);

  try{
  		//alert("==wanghfa== openWay = " + openWay + ",validVal = " + validVal);
  	//	alert("public"+"======"+openWay+"|"+funciton_code+"|"+funciton_name+"|"+path+"|"+validVal);
				 parent.parent.L(openWay,funciton_code,funciton_name,path,validVal);
			}catch(e){
				
				 parent.L(openWay,funciton_code,funciton_name,path,validVal);
			}
			 //location.href=path;
	  }else
	  {
	  		alert("��������ʧ��!");
	  }  
}
</SCRIPT>	
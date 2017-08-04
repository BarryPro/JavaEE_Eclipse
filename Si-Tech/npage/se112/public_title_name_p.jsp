<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String paramValue_zhaz="N";
%>
<!--取配置参数-->
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

function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet,doNext);
	packet =null;
	
	if("<%=opCode%>"!="")
	{
			 parent.removeTab('<%=opCode%>');
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
	  	
	  	//alert(orderArrayId);
	  	//alert("3333333");
	  	if("<%=paramValue_zhaz%>" == "Y"){
		  	parent.parent.checkHasBill(funciton_code);
		  	if(parent.parent.hasBill == "N"){
			   		rdShowMessageDialog("您昨天未进行轧帐,不能进行业务操作!",0);
			   		return false;
			   }
			   if(parent.parent.todayHasBill == "Y"){
			   		rdShowMessageDialog("您今天已经轧帐完成,不能进行业务操作!",0);
			   		return false;
			   }
	  	}
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	
	  	var mydate = new Date();
	  	var opBeginTime=mydate.getTime();
	  	var path=pageUrl+"?gCustId=<%=gCustId%>"
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
	  							+"&v_smCode=<%=v_smCode%>"
	  							+"&opcodeadd=<%=opCode%>";
	  				
	  	 //alert('closeId=='+closeId);										
		 //alert('path=='+path);

  try{
				 parent.parent.L(openWay,funciton_code,funciton_name,path,validVal);
			}catch(e){
				 parent.L(openWay,funciton_code,funciton_name,path,validVal);
			}
			 //location.href=path;
	  }else
	  {
	  		alert("操作导航失败!");
	  }  
}
</SCRIPT>	
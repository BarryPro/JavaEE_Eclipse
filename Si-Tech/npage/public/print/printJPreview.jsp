<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String SphoneNo = request.getParameter("SphoneNo");
	String EphoneNo = request.getParameter("EphoneNo");
	String billType = request.getParameter("billType");
	String login_accept=request.getParameter("login_accept");
	String servOrderId=request.getParameter("servOrderId");

	//SphoneNo=SphoneNo.substring(0,7)+"xxxx";
	SphoneNo="xxxxxxxxxxx";
%>
<html>
<head>
<style>
	#d1{
		width:210px;
		
		background-color:#eeeeee;
		z-index:0;
	}
</style>
<script>

onload=function(){
	doPreview();

}
//预览
function doPreview(){
	var packet = new AJAXPacket("fPubSaveSubPrint.jsp","正在打开，请稍候......");
	packet.data.add("retType","preview");
	packet.data.add("phoneNo",'<%=SphoneNo%>');
	packet.data.add("billType",'<%=billType%>');
	packet.data.add("login_accept",'<%=login_accept%>');
	packet.data.add("servOrderId",'<%=servOrderId%>');
	core.ajax.sendPacket(packet);
	packet=null;	
}

function doProcess(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("errCode"); 
	var retMessage = packet.data.findValueByName("errMsg");

	if(retType == "preview"){
		if(retCode=="000000"){
			//var d1=document.all.d1;
			//var pixsize=10;//字体大小
			var impResultArr = packet.data.findValueByName("impResultArr");
			var plusResultArr = packet.data.findValueByName("plusResultArr");
			var d1=document.all.d1;
			d1.style.width=210*3
			//d1.style.height=297*3
			//-----------画内容--------------
			for(var i=0;i<impResultArr.length;i++){
				var top=parseInt(impResultArr[i][2])*3;
				var left=parseInt(impResultArr[i][3])*3;
				var fontsize=impResultArr[i][4];
				var style="position:absolute;top:"+top+";left:"+left+";font-size:"+fontsize+";background-color:;";
				if(impResultArr[i][1]=="6"){
					d1.innerHTML+="<hr style='"+style+" width=500'>";
				}else{
					d1.innerHTML+="<div style='"+style+"'>"+impResultArr[i][10]+"</div>"
				}
			}
			//--------------画头--------------
			for(var i=0;i<plusResultArr.length;i++){
				var top=parseInt(plusResultArr[i][2])*3;
				var left=parseInt(plusResultArr[i][3])*3;
				var fontsize=parseInt(plusResultArr[i][4])+2;
				var style="position:absolute;top:"+top+";left:"+left+";font-size:"+fontsize+";";
				if(plusResultArr[i][1]=="6"){
					d1.innerHTML+="<hr style='"+style+" width=300;'>";
				}else{
					d1.innerHTML+="<div style='"+style+"'>"+plusResultArr[i][10]+"</div>"
				}
			}
		}
		else{
			rdShowMessageDialog("错误代码："+retCode+"错误信息："+retMessage);
			window.close();
		}
	}

}


</script>

</head>
<body>
	<div id="d1" style="">

	</div>

</body>




</html>
<%
/********************
*version v3.0
*������: si-tech
*
*fengss
*1104,1238��ģ��ʹ�ù��ĵ����Ի���
*
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	opCode="q046";
	String phoneNo=request.getParameter("phoneNo");
	String billType="2";
	String login_accept=request.getParameter("login_accept");
	String serverOrderId=request.getParameter("serverOrderId");
	

	String org_code = (String)session.getAttribute("orgCode");
	String region_code=org_code.substring(0,2);

%>
<html>
<head>
<script>
function doPrint(){

	var print_Packet = new AJAXPacket("fPubSavePrint.jsp","���ڴ�ӡ�����Ժ�......");
	print_Packet.data.add("retType","print");
	print_Packet.data.add("opCode",'<%=opCode%>');
	print_Packet.data.add("phoneNo",'<%=phoneNo%>');
	print_Packet.data.add("billType",'<%=billType%>');
	print_Packet.data.add("login_accept",'<%=login_accept%>');
	print_Packet.data.add("arrayOrderId",'<%=serverOrderId%>');
	print_Packet.data.add("region_code",'<%=region_code%>');
	core.ajax.sendPacket(print_Packet);
	print_Packet=null;	
}

function doNoPrint(){
	window.close();
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("errCode"); 
	var retMessage = packet.data.findValueByName("errMsg");	
	var fColor = 0*65536+0*256+0;  
	self.status="";
	
	if((retCode).trim()==""){
		rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
		return false;
	}

	if(retType == "print"){
		if(retCode=="000000"){	 
				var index=0;
				var pageSize=225;
				var impResultArr = packet.data.findValueByName("impResultArr");
				var plusResultArr = packet.data.findValueByName("plusResultArr");
				alert(impResultArr);
				var num = impResultArr.length;   //������  
				var page=(parseInt(maxNum(impResultArr)/pageSize))+1;
				
				try{
					for(var j=0;j<page;j++){
						printctrl.Setup(0);
						printctrl.StartPrint();
						printctrl.PageStart();
						var x,y;
						//��ӡͷβ
						for(i=0;i<plusResultArr.length;i++){
							x=parseInt(plusResultArr[i][3]);
							y=parseInt(plusResultArr[i][2]);

							if(plusResultArr[i][1]=="6"){
								//alert(plusResultArr[i][4]);
								var rect="";
								rect+=x+","+y+","+(190)+","+y+",|";
								printctrl.PrintLines(rect,
									0, //��ɫ
									plusResultArr[i][4],//�ߴ�
									0 //������
								);
							}else{
								if(plusResultArr[i][6]=="Y"){
									printctrl.PrintText(x,y,plusResultArr[i][12],plusResultArr[i][4],fColor,10,plusResultArr[i][10]);
								}else{
									printctrl.PrintText(x,y,plusResultArr[i][12],plusResultArr[i][4],fColor,10,plusResultArr[i][10]);
								}
								
							}
						}
						
						//��ӡ����

						var lastIndex=index;
						for(i=index;i<impResultArr.length && ((impResultArr[i][2]-impResultArr[lastIndex+1][2])+47)<pageSize;i++){
							index=i;
							x=parseInt(impResultArr[i][3]);
							y=parseInt(impResultArr[i][2]);
							if(j!=0){
								y=y-parseInt(impResultArr[lastIndex][2])+60;//�����У�����ÿҳ�ĵ�һ��
							}
							if(impResultArr[i][1]=="6"){
								var rect=x+","+y+","+(190)+","+y+",|";
								printctrl.PrintLines(rect,
									0, //��ɫ
									impResultArr[i][4],//�ߴ�
									0 //������
								);
							}else{
								if(impResultArr[i][6]=="Y"){
									impResultArr[i][6]=10;
								}else{
									impResultArr[i][6]=1;
								}
								printctrl.PrintText(x,y,impResultArr[i][12],impResultArr[i][4],fColor,impResultArr[i][6],impResultArr[i][10]);
							}

						}	
						printctrl.PageEnd();
						printctrl.StopPrint();
						window.close();

					}
				}catch(e){
					alert(e.message);
				}
			}else{
				rdShowMessageDialog("������룺"+retCode+"������Ϣ��"+retMessage);

				window.close(); 
			}

	}
	if(retType == "noprint"){
		if(retCode!="000000"){
			rdShowMessageDialog("������룺"+retCode+"������Ϣ��"+retMessage);	
		}

		window.close();
	}
}

</script>



</head>
<body>
<div id="operation">
<form>
	<div id="operation_button">
		<input type="button" class="b_foot" value="��Ʊ����" onclick="doPrint()">
		<input type="button" class="b_foot" value="����ӡ" onclick="doNoPrint()">
	</div>
</form>

</div>
</body>


</html>
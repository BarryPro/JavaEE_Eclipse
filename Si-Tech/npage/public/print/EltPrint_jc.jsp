<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
/********************
*version v3.0
*������: si-tech
*
*update:ZZ@2008-10-13 ҳ�����,�޸���ʽ
*1104,1238��ģ��ʹ�ù��ĵ����Ի���
*
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
%>
<HEAD>
<TITLE>��ӡ</TITLE>

</HEAD>
<%@ include file="splitStr_q046.jsp" %>

<% 
System.out.println("------------------------------------EltPrint_jc.jsp------------------------------------------------");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code=org_code.substring(0,2);
	String retArray[]=null;//���ؽ������

	String accept=request.getParameter("accept");
	String servOrderId=request.getParameter("servOrderId");
	String DlgMsg = request.getParameter("DlgMsg");
	String countNum=request.getParameter("countNum");
	String regionCode=request.getParameter("regionCode");
	String orderArrayId=request.getParameter("orderArrayId");//���񶨵���
	String printInfo = request.getParameter("printInfo");
	System.out.println("---------------------printInfo---------------------"+printInfo);
	String pType = request.getParameter("pType");
	String billType = request.getParameter("billType");
	System.out.println("----------------------pType----------------------"+pType);
  System.out.println("----------------------billType----------------------"+billType);
	String serverName="";
	if(billType.equals("1")){
		serverName="sCtOEltCreat";
	}else if(billType.equals("2") || billType.equals("3")){
		serverName="sCtOBillCrt";
	}
	String SphoneNo = request.getParameter("SphoneNo");
	String EphoneNo = request.getParameter("EphoneNo");
	String submitCfm = request.getParameter("submitCfm");
	
	String mode_code = request.getParameter("mode_code");  //�ʷѴ��� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String fav_code = request.getParameter("fav_code");    //�ط����� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String area_code = request.getParameter("area_code");  //С������ ���û��ֵ ǰ̨�������ľ����ַ��� null

	String[] mode_list = null;
	String[] fav_list  = null;
	String[] area_list = new String[1];
	if(mode_code!="null"){
		mode_list = mode_code.split("~");
	}else{
		mode_list=new String[0];
	}
	System.out.println("------------------mode_code---------------------"+mode_code);
	
	if(fav_code!="null"){
		fav_list = fav_code.split("\\|");
	}else{
		fav_list=new String[0];
	}
	if(area_code!="null"){
		area_list[0] = area_code;
	}
	System.out.println("------------------fav_code---------------------"+fav_code);
	System.out.println("------------------area_code---------------------"+area_code);
	System.out.println( mode_list[0]+"        "+fav_list[0]+"         "+area_list[0]+"       ####BBB");
	
	String login_accept=accept;
	String disabledFlag="";
	
	String classsql="";
	if(billType.equals("1")){
		classsql="select print_content_desc,class_code from sprintmodeldet where bill_type=1 and print_model_id=1";
	}else{
		classsql="select  print_content_desc,class_code from  sPrintModelDet WHERE print_model_id='8' AND bill_type='2'";
	}
	
	System.out.println("classsql|||||||||"+classsql);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2">
			<wtc:sql><%=classsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="1">
			<wtc:sql>
				select region_name from sregioncode where region_code='?'
			</wtc:sql>
			<wtc:param value="<%=org_code.substring(0,2)%>" />
		</wtc:pubselect>
		<wtc:array id="c1" scope="end" />
<%
		HashMap hm=new HashMap();
		
		System.out.println("-------------------result.length------------------------"+result.length);
		for(int i=0;i<result.length;i++){
			//System.out.println("-------------------------------------------"+result[i][0]+"     "+result[i][1]);
			hm.put(result[i][0],result[i][1]);
		}
		String [][] retInfo=null;
		System.out.println("----------------billType-------------"+billType);
		if(billType.equals("1")){
			retInfo=getParamIn(c1[0][0],orderArrayId,printInfo,work_name,hm);	
		}else{
			retInfo=getParamInForBill(c1[0][0],printInfo,work_no,work_name,hm);		
		}

System.out.println("��������--------------------------------------------"+billType);
System.out.println("--"+opCode+"    "+ billType+"    "+ work_no+"    "+ login_accept+"    "+  SphoneNo+"  end");

		UType uBasicInfo=new UType();
			uBasicInfo.setUe("STRING",opCode);
			
			uBasicInfo.setUe("LONG",billType);
			uBasicInfo.setUe("STRING",work_no);
			if(billType.equals("1")){
				uBasicInfo.setUe("LONG","0");
			}else{
				uBasicInfo.setUe("LONG",login_accept);
			}
			
			uBasicInfo.setUe("STRING",SphoneNo);
			
			uBasicInfo.setUe("STRING",orderArrayId);
			uBasicInfo.setUe("INT",countNum);
			uBasicInfo.setUe("STRING",regionCode);
			
		UType uClassInfos=new UType();
			UType uClassInfo=null;
			for(int i=0;i<retInfo[0].length;i++){
				uClassInfo=new UType();
				
				if(retInfo[0][i]==null) retInfo[0][i] ="";
				
				uClassInfo.setUe("STRING",retInfo[0][i]);//�����
				uClassInfo.setUe("STRING",retInfo[1][i]);//�����
				uClassInfo.setUe("STRING",retInfo[2][i]);//��ֵ
				uClassInfo.setUe("STRING",retInfo[3][i]);//����
				uClassInfos.setUe(uClassInfo);
				uClassInfo=null;
				System.out.println(retInfo[0][i]+"      "+retInfo[1][i]+"     "+retInfo[2][i]+"     "+retInfo[3][i]+"          ####AAA");
			}
				
		UType uModeInfos=new UType();//�ײʹ���
		UType uFuncInfos=new UType();//�ط�����
		UType uAreaInfos=new UType();//С������
		UType uModeInfo=null;
		UType uFuncInfo=null;
		UType uAreaInfo=null;
		
		System.out.println("--------------------mode_list.length------------------"+mode_list);
		for(int i=0;i<mode_list.length;i++){
			
			if(mode_list[i]!=null){
			uModeInfo=new UType();
			uModeInfo.setUe("STRING",mode_list[i]);
			uModeInfos.setUe(uModeInfo);
			uModeInfo=null;
			}
			
			if(fav_list[i]!=null){
			uFuncInfo=new UType();
			uFuncInfo.setUe("STRING",fav_list[i]);
			uFuncInfos.setUe(uFuncInfo);
			uFuncInfo=null;
			}
			
			if(area_list[0]!=null){
			uAreaInfo=new UType();
			uAreaInfo.setUe("STRING",area_list[0]);
			uAreaInfos.setUe(uAreaInfo);
			uAreaInfo=null;
			}
			System.out.println("i|"+i+"     "+mode_list[i]+"        "+fav_list[i]+"         "+area_list[0]+"       ####BBB");
		}
		
%>


	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
		<wtc:uparam value="<%=uClassInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uModeInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uFuncInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uAreaInfos%>" type="UTYPE"/>
	</wtc:utype>



<%


	retMsg=retVal.getValue(1);
	retCode=retVal.getValue(0);
	
	System.out.println("-------------------retCode---------------------"+retCode);
	System.out.println("-------------------retMsg----------------------"+retMsg);
	
	if(!retCode.equals("0")){
		
		if(retCode.equals("7451608414396048229")){
%>
			<script>
				rdShowMessageDialog("�㽫���з�Ʊ����");
			</script>
<%		}else{%>
			<script>
				disabledFlag="disabled";
				<%if(billType.equals("1")){%>
				rdShowMessageDialog("�洢����");
				window.close();
				<%}%>
			</script>
<%		}
	}else{

	login_accept=retVal.getValue("2.0");
	retArray=new String[retVal.getSize("2")-1];
	for(int i=1;i<retVal.getSize("2");i++){
		retArray[i-1]=retVal.getValue("2."+i);
		//System.out.println("value="+retArray[i-1]);
	}
%>
	<script>
		window.returnValue=<%=retVal.getValue("2.0")%>;
		if("<%=billType%>"=="1" && "<%=pType%>"=="Y"){
			window.close();
		}
	</script>
<%
	}
%>
<SCRIPT type="text/javascript">

function controlDisplay(){
	if(load2()){
		document.all.display1.style.display="";
		document.all.display2.style.display="none";
	}else{
		window.setTimeout(controlDisplay,100);
	}
	
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
	
	if(retType == "subprint"){
		if(retCode=="000000"){
			var impResultArr = packet.data.findValueByName("impResultArr");
			var num = impResultArr.length;   //������  
			var page=Math.ceil((num/10));//ÿҳ45��  ���ڹ���ͷ������������ֽ�ϴ���ͬһ�У���ȥ2�С�
			var x = 0;
			for(var j=0;j<page;j++){
				try{
				//��ӡ��ʼ��
					printctrl.Setup(0);
					printctrl.StartPrint();
					printctrl.PageStart();
					for(var i=j*45;i<(j+1)*45;i++){
						if(i<num){
							if(impResultArr[i][6]=="N"){
							impResultArr[i][6]=0;
						}else{
							impResultArr[i][6]=5;
						}
	          printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
						}
					}
					printctrl.PageEnd();
					printctrl.StopPrint();
					window.close();
				}catch(e){
					alert(e.message);
				}finally{}
			}
			document.spubPrint.getElementById("message")="δ��ӡ�����ϲ���ӡ�ɹ���";	
		}else{
			rdShowMessageDialog("������룺"+retCode+"������Ϣ��"+retMessage);
			window.close(); 
		}
	
	}

	if(retType == "print"){
		if(retCode=="000000"){	 
				var index=0;
				var pageSize=225;
				var impResultArr = packet.data.findValueByName("impResultArr");
				var plusResultArr = packet.data.findValueByName("plusResultArr");
				var num = impResultArr.length;   //������  
				var page=(parseInt(maxNum(impResultArr)/pageSize))+1;
				
				try{
					for(var j=0;j<page;j++){
						printctrl.Setup(0);
						printctrl.StartPrint();
						printctrl.PageStart();
						var x,y;
				 
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

function maxNum(arr){
	var max=0;
	for(var i=0;i<arr.length;i++){
		if(parseInt(arr[i][2])>max){
			max=parseInt(arr[i][2]);
		}
	}
	return max;
}
function load2(){
	var ret=true;
	try{
		document.all.printctrl.Setup(0);
	}catch(e){
		ret=false;
	}finally{
		return ret;
	}
}

//�����ӡ
function doPrint()
{	
	
	var print_Packet = new AJAXPacket("fPubSavePrint.jsp","���ڴ�ӡ�����Ժ�......");
	print_Packet.data.add("retType","print");
	print_Packet.data.add("opCode",'<%=opCode%>');
	print_Packet.data.add("phoneNo",'<%=SphoneNo%>');
	print_Packet.data.add("billType",'<%=billType%>');
	print_Packet.data.add("login_accept",'<%=login_accept%>');
	print_Packet.data.add("arrayOrderId",'<%=orderArrayId%>');
	print_Packet.data.add("region_code",'<%=region_code%>');
	core.ajax.sendPacket(print_Packet);
	print_Packet=null;	 	
	
}
//�ϲ���ӡ
function doSubPrint()
{	
	//if(!load()) return;
	//���úϲ���ӡ����	
	var subprint_Packet = new AJAXPacket("fPubSaveSubPrint.jsp","���ڴ�ӡ�����Ժ�......");
	subprint_Packet.data.add("retType","subprint");
	subprint_Packet.data.add("phoneNo",'<%=SphoneNo%>');
	subprint_Packet.data.add("billType",'<%=billType%>');
	subprint_Packet.data.add("login_accept",'<%=login_accept%>');
	subprint_Packet.data.add("servOrderId",'<%=orderArrayId%>');
	core.ajax.sendPacket(subprint_Packet);
	subprint_Packet=null;	 		
}
//����ӡ
function doNOPrint()
{
	var noprint_Packet = new AJAXPacket("fPubSaveNoPrint.jsp","���ڴ�ӡ�����Ժ�......");
	noprint_Packet.data.add("retType","noprint");
	noprint_Packet.data.add("phoneNo",'<%=SphoneNo%>');
	noprint_Packet.data.add("opCode",'<%=opCode%>');
	noprint_Packet.data.add("billType",'<%=billType%>');
	noprint_Packet.data.add("login_accept",'<%=login_accept%>');
	noprint_Packet.data.add("arrayOrderId",'<%=orderArrayId%>');
	core.ajax.sendPacket(noprint_Packet);
	noprint_Packet=null;	 
}

//Ԥ��
function doPreview(){
	var property="dialogWidth=650px;dialogHeight=800px;resizable=yes;scroll=yes;";
	var path="printPreview.jsp?";

	path+="SphoneNo="+"<%=SphoneNo%>";
	path+="&opCode="+"<%=opCode%>";
	path+="&billType="+"<%=billType%>";
	path+="&login_accept="+"<%=login_accept%>";
	path+="&orderArrayId="+"<%=orderArrayId%>";
	path+="&EphoneNo="+"<%=EphoneNo%>";
	window.showModalDialog(path,"print_preview",property);
}



function doSub()
{
	window.close();
}

</SCRIPT>
<!--**************************************************************************************-->
<%if(!billType.equals("1") || !pType.equals("Y")){%>
<body>
<FORM method=post name="spubPrint">
<div class="popup" >
	<!--div class="popup_qu" id="rdImage" align=center-->
<div class="popup_zi orange"><center><%=DlgMsg%></center><div>
<div id="display2"  style="display:">
	<center><font color=red>��ӡ�ؼ�������....</font>
		<%if(pType.equals("N")&&(billType.equals("1"))){%>
		<input class="b_foot_long"  onclick="doPreview()" type="button"  value="��ӡԤ��" <%=disabledFlag%>>
		<%}%>
		<input class="b_foot" name=commit onClick="doNOPrint()"  type=button value="����ӡ">
	</center>
</div>
<div id="display1" style="display:none">
	<div >
	    <div align="center">
		<%if(pType.equals("Y")){%> 

			<input class="b_foot_long" name=back onClick="doSub()"  type=button value="��ӡ�洢">
		<%}else if(pType.equals("N")){%>
			<input class="b_foot" name=commit onClick="doPrint()"  <%=disabledFlag%> type=button value="��ӡ">
			<%if(billType.equals("1")){%>
			<input class="b_foot_long"  onclick="doPreview()" type="button"  value="��ӡԤ��" <%=disabledFlag%>>
			<%}%>
		<%}%>
		<%if(billType.equals("1")){%>
			<input class="b_foot" name=commit onclick="doSub()" type=button value="����ӡ">
		<%}else{%>
			<input class="b_foot" name=commit onClick="doNOPrint()"  type=button value="����ӡ">
		<%}%>
		<br>
	    </div>
	</div>
</div>
</div>

</FORM>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>

</BODY>
<script>
controlDisplay();//������ʾ,ע�⣺��Ҫ�ı�λ�á�
</script>
</HTML>    
<%}%>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String opCode =  request.getParameter("opCode");
  String opName =  request.getParameter("opName");
  String parentPhone = request.getParameter("parentPhone");
  String operPhoneNo = request.getParameter("operPhoneNo");
  String famChg =  request.getParameter("myJSONText");
  String loginAccept = request.getParameter("printAccept");
  String famlicodes = request.getParameter("famlicodes") == null? " ":request.getParameter("famlicodes");
  
  String innetFeeHidd = request.getParameter("innetFeeHidd") == null? "0":request.getParameter("innetFeeHidd");
  String innetrateHidd = request.getParameter("innetrateHidd") == null? " ":request.getParameter("innetrateHidd");
  String innetRateFeeHidd = request.getParameter("innetRateFeeHidd") == null? " ":request.getParameter("innetRateFeeHidd");
  String innetFeeLeftHidd = request.getParameter("innetFeeLeftHidd") == null? " ":request.getParameter("innetFeeLeftHidd");
  
	//hejwa add �Ҹ���ͥ��ת��g794�ı�־  
	String carFlag = ""; //Ϊ�˲�Ӱ����������ҵ�����ת����
  String familyCode = request.getParameter("familyCode") == null? "":request.getParameter("familyCode");
  if("XFJT".equals(familyCode)&&"e281".equals(opCode)){
  	//�Ҹ���ͥ����Ĵ�����ͥ
  	carFlag = "carFlag";
  }
  /* ��ȡ��Ʊ��Ϣ */
  String custName =  request.getParameter("custName");
  String homeEasyVal =  request.getParameter("homeEasyHide") == null? "0":request.getParameter("homeEasyHide");
  String brandAndResVal =  request.getParameter("brandAndResHide");
  String homeEasyPhoneVal =  request.getParameter("homeEasyPhoneHide");
  String imeiVal =  request.getParameter("imeiHide");
  String prepayFee =  request.getParameter("prepayFeeHide") == null? "0":request.getParameter("prepayFeeHide");
  String baseFeeHidd2 =  request.getParameter("baseFeeHidd2") == null? "0":request.getParameter("baseFeeHidd2");//������
  if(prepayFee.length() == 0){
  	prepayFee = "0";
  }
  if(baseFeeHidd2.length() == 0){
  	baseFeeHidd2 = "0";
  }
  double v_totalFee =  Double.parseDouble(prepayFee) + Double.parseDouble(baseFeeHidd2);
  v_totalFee = (double) Math.round(v_totalFee*100)/100;  //��������
  String totalFee =  Double.toString(v_totalFee);
  String v_membRoleId = request.getParameter("v_membRoleId");//�����Ա����
  System.out.println("##############################fe280Cfm.jsp start [" + famChg + "]");
  System.out.println("########## ��Ʊ #########fe280Cfm.jsp--------- start [" + prepayFee + " , " + baseFeeHidd2 + "="+totalFee);
%>
	<wtc:utype name="sE280Cfm" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=famChg%>" type="STRING"/>  
	</wtc:utype>
<%
	String retCode = retVal.getValue(0);
	String retMsg = retVal.getValue(1);
	retMsg = retMsg.replaceAll(System.getProperty("line.separator")," ");
	if("0".equals(retCode) || "000000".equals(retCode)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>�ύ�ɹ���");
			if("<%=famlicodes%>" == "XFJT" && "<%=opCode%>" == "e281"){
				rdShowMessageDialog("��ͥ�����ɹ����뵽g794ҳ������Ҹ���ͥӪ������");
			}
			if('<%=opCode%>' == 'e285') {
				<% if(famlicodes.equals("QQSY") || famlicodes.equals("QQWY") 
							|| famlicodes.equals("KDJT")
							|| famlicodes.equals("QWJT")  || famlicodes.equals("TXJT") || famlicodes.equals("TSJT") || famlicodes.equals("PYJT")|| famlicodes.equals("RHJT")) {%>
			  <%}else {%>
			  	rdShowMessageDialog("�뵽�ɷѽ���Ϊ�ͻ�����Ԥ��15Ԫ���ѣ��Ա�֧���˾�ͨҵ��ʹ�÷��á�");
			  	<%}%>		
			}
		</script>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" 
			 outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(totalFee,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//��д���
		System.out.println("~~~~~~~~~~~~chinaFee " + chinaFee);
%>
		<script language="JavaScript">
			function printBill(){
				rdShowMessageDialog("��ӡ��Ʊ");
				var infoStr="";
				
				infoStr+="<%=work_no%>  <%=work_name%>"+"       <%=opName%>"+"|";//����
				infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=custName%>'+"|";//�û�����
				infoStr+=" "+"|";//����
				infoStr+='<%=parentPhone%>'+"|";//�ƶ�̨��
				infoStr+=" "+"|";//8Э�����
				infoStr+=" "+"|";//9֧Ʊ��
				infoStr+="<%=chinaFee%>"+"|";//10�ϼƽ��(��д)
				infoStr+="<%=WtcUtil.formatNumber(totalFee,2)%>"+"|";//11Сд
				if("<%=imeiVal%>".trim() == ""){
					infoStr += "�˿�ϼƣ�<%=WtcUtil.formatNumber(totalFee,2)%>Ԫ " + "|";
				}else{
					infoStr+="��ע�������Ҹ���ͥ�ײʹ���������˾�ͨ�̻���һ������2�״�������1��ң��������" 
									+"~" + "�˾�ͨ�̻���Ʒ���ͺţ�<%=brandAndResVal%>"
									+"~" + "�˾�ͨ�̻����룺<%=homeEasyPhoneVal%>"
									+"~" + "IMEI�룺<%=imeiVal%>" + "|";
				}
				infoStr+="<%=custName%>"+"|";//��Ʊ��
				infoStr+=" "+"|";//�տ���
			//	infoStr+="IMEI�룺<%=imeiVal%>"+"|";
				infoStr+=" "+"|";
				
				var dirtPage="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";
				location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage+"&op_code=<%=opCode%>&loginAccept=<%=loginAccept%>";
			}
				function goback(){
			//hejwa add 2014��2��14��8:47:59 ��ת�����ﳵ��g794ģ�� ��־  
				location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";
				
			}
			
		function printBillNEW(){
		rdShowMessageDialog("��ӡ��Ʊ��");
	  var printInfo="";
    var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=work_no%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",""); //�ͻ�����
 		$(billArgsObj).attr("10006","<%=opName%>"); //ҵ�����
 		//$(billArgsObj).attr("10008","<%=parentPhone%>"); //�û�����
 		$(billArgsObj).attr("10008","<%=v_membRoleId%>"); //�û����룺����Ϊ�������
 		$(billArgsObj).attr("10015", "<%=innetFeeHidd%>"); //���η�Ʊ���(Сд)��
 		$(billArgsObj).attr("10016", "<%=innetFeeHidd%>"); //��д���ϼ�
 		$(billArgsObj).attr("10036","<%=opCode%>"); //��������	
 		$(billArgsObj).attr("10030","<%=loginAccept%>"); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10065", ""); //����˺�
 		$(billArgsObj).attr("10066", "<%=innetFeeHidd%>"); //��װ��
 		$(billArgsObj).attr("10067", "0"); //����ײ�Ԥ���
 		$(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
 		$(billArgsObj).attr("10031","<%=work_name%>");//��Ʊ��
 		$(billArgsObj).attr("10062","<%=innetrateHidd%>");	//˰��
		$(billArgsObj).attr("10063","<%=innetRateFeeHidd%>");	//˰��	
		$(billArgsObj).attr("10071","8");//ģ���
		$(billArgsObj).attr("10079","1");
		$(billArgsObj).attr("10080", "<%=innetFeeLeftHidd%>"); //ȥ˰���
		
		
    var path ="";
		path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";

	
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = path + "&infoStr="+printInfo+"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
	  location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";

}

			if(("<%=famlicodes%>"=="HEJT" || "<%=famlicodes%>"=="HJTA" || "<%=famlicodes%>"=="HJTB") && ("<%=opCode%>"=="e855" || "<%=opCode%>"=="i088")){//�ͼ�ͥ����Ʒ���+��ͥ��ǩ
			    if("<%=innetFeeHidd%>"=="0") {
			    	goback();
			    }else {
			      printBillNEW();
			    }
			    
			}
			var printBillFlag = "<%=homeEasyVal%>";
			if(printBillFlag == "1"){
				printBill();
			}else{
				goback();
			}
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>�ύʧ�ܣ�" + "<%=retCode%>," + "<%=retMsg%>");
			location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%>";
		</script>

<%
	}
%>

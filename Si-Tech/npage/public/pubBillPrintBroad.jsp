<%
/********************
 *������: si-tech
 *��ͨ��Ʊ
 *create by ningtn @ 20111026
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String org_code =(String)session.getAttribute("orgCode");
	    String regionCode = org_code.substring(0,2);
	    String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	    String infoStr = request.getParameter("infoStr");
	    String opCode = request.getParameter("opCode");
	    String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));
	    String sql_select_bill = "";
	    String broad_no = oneTok(infoStr,8);
	    if(broad_no.indexOf("yd")==0){  //�ж�ǰ��λ�Ƿ�Ϊyd ���Ϊyd ���ƶ���Ʊ��ȡ��Ʊ����
	    	sql_select_bill = "select to_char(S_INVOICE_NUMBER) from WLOGININVOICE where LOGIN_NO = :workNo";
	    }else{
	  		sql_select_bill = "select to_char(S_INVOICE_NUMBER) from tt_WLOGININVOICE where LOGIN_NO = :workNo";
	  	}
	    System.out.println("sql_select_bill==="+sql_select_bill);
		//liujian 2012-8-17 13:51:18 ���ӷ�Ʊ���
		//String sql_select_bill = "select to_char(S_INVOICE_NUMBER) from tt_WLOGININVOICE where LOGIN_NO = :workNo";
		String srv_params_bill = "workNo=" + work_no_bill;
		String bill_number = "";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_bill%>"  
			retcode="retBillNumCode" retmsg="retBillNumMsg" outnum="2">
		<wtc:param value="<%=sql_select_bill%>"/>
		<wtc:param value="<%=srv_params_bill%>"/>
	</wtc:service>
	<wtc:array id="billNumRst" scope="end" />
<%
	if(retBillNumCode.equals("000000")) {
		if(billNumRst.length>0){
		
			bill_number = billNumRst[0][0];
			System.out.println(" bill_number="+bill_number);
%>
		<script>
			var wlHref = window.location.href;
			$(function(){
				if(confirm('��Ʊ������<%=billNumRst[0][0]%>���Ƿ��ӡ�վݣ�')==1){
					doPrint();
				}else {
					if(wlHref.indexOf('f9130_print.jsp')!=-1) {
						if(parent.g_activateTab == undefined){
							var l_activateTab = "";
							var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
							for(var i=0; i<lis.length; i++){
								if(lis[i].className == "current"){
									l_activateTab = lis[i].id;
									break;		        
								} 
							}
							parent.removeTab(l_activateTab);
					     }else{
							parent.removeTab(parent.g_activateTab); 
					     }
					}else {
						window.close();
					}
					
				}
			});
		</script>
<%
		}			
	else
		{
			System.out.println(" ��ȡ[bill_number]ʧ��");
		}
	}else {
%>
		<script>
			alert("��ȡ��Ʊ����ʧ�ܣ�");
			if(parent.g_activateTab == undefined){
				var l_activateTab = "";
				var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
				for(var i=0; i<lis.length; i++){
					if(lis[i].className == "current"){
						l_activateTab = lis[i].id;
						break;		        
					} 
				}
				parent.removeTab(l_activateTab);
		     }else{
				parent.removeTab(parent.g_activateTab); 
		     }
		</script>
<%
	}
%>	
<html>
	<head>
<%
	
    System.out.println("---liujian---opCode="+ opCode);
	System.out.println("----------- pubBillPrintBroad.jsp --------- start -----");
	System.out.println("----------- liujian --------- phoneNo= -----" + phoneNo);
	int ran=0;
	java.util.Random r = new java.util.Random();
	ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if((ran+"").length()<4){
		ran = ran+ran1;
	}
	int key = 99999;
	int realKey = ran ^ key;
	
	String sqlss ="";
	if(opCode!=null && !opCode.equals("") && opCode.equals("e083") && opCode.equals("b544")) {
		sqlss = " select * from dcustmsghis where phone_no ='"+phoneNo+"'";
	} else {
	    sqlss = " select * from dcustmsg where phone_no ='"+phoneNo+"'";
	}
	String id_no="";
	if(phoneNo != null && phoneNo != "") {
	

	
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
				<wtc:sql><%=sqlss%></wtc:sql>
	  	</wtc:pubselect>
	  	<wtc:array id="result1111" scope="end"/>
	<%
			  if(retCode11.equals("000000")){
			  	if(result1111 != null && result1111.length > 0){
						id_no=result1111[0][0];
					}
			  }else {
			  	//out.println("ȥidʧ���˰���");
			  }
	}
	 String money = oneTok(infoStr,10);
	  double d = Double.parseDouble(money);
	  String moneyRMB = toRMB(d);
	//��Ʊ���ӻ����������
	String[] inParas0 = new String[40];
	inParas0[0] = realKey+"";  
	inParas0[1] = loginAccept; //��ˮ
	inParas0[2] = opCode; //opCode
	inParas0[3] = workNo; // ����Ա
	inParas0[4] = oneTok(infoStr,1)+""+oneTok(infoStr,2)+""+oneTok(infoStr,3); // ����
	inParas0[5] = phoneNo;//phoneNo
	inParas0[6] = id_no;//id_no 
	inParas0[7] = "";//sm_name
	inParas0[8] = realKey+"";  
	inParas0[9] = loginAccept; //��ˮ
	inParas0[10] = opCode; //opCode
	inParas0[11] = workNo; // ����Ա
	inParas0[12] = oneTok(infoStr,1)+""+oneTok(infoStr,2)+""+oneTok(infoStr,3); // ����
	inParas0[13] = oneTok(infoStr,12); //ҵ������
	inParas0[14] = oneTok(infoStr,5); //�ͻ����� 
	inParas0[15] = oneTok(infoStr,8); //����˺�
	inParas0[16] = oneTok(infoStr,9); //֧Ʊ���� 
	inParas0[17] = moneyRMB;//�ϼƽ��(��д)
	inParas0[18] = oneTok(infoStr,11);//Сд 
	String busiStr=oneTok(infoStr,13);//��Ŀ
	int numCount = getTokNums(busiStr);
	for(int i=0;i<numCount;i++) {
	   inParas0[19+i] = oneTok(busiStr,'~',i+1);  //ҵ����Ŀ
	}
	String _temp = oneTok(infoStr,14);
	if( _temp != null && !_temp.equals("") && (oneTok(infoStr,13).equals("BX") || oneTok(infoStr,13).equals("BY"))) {
		inParas0[26] = oneTok(infoStr,15);
		inParas0[27] = oneTok(infoStr,16);
		inParas0[28] = oneTok(infoStr,17);
		inParas0[29] = oneTok(infoStr,18);
		inParas0[30] = oneTok(infoStr,19);
		inParas0[31] = oneTok(infoStr,20);
		inParas0[32] = oneTok(infoStr,21);
		inParas0[33] = oneTok(infoStr,22);
		inParas0[34] = oneTok(infoStr,23);
		inParas0[35] = oneTok(infoStr,24);
		inParas0[36] = oneTok(infoStr,25);
		inParas0[37] = oneTok(infoStr,26);
	}
%>

<%!
	/**���ַ�������tok�ֽ�ȡֵ**/
	String oneTok(String strIn,char tok,int locIn)throws Exception {
		String  temStr=strIn;
		try{
			if(strIn.charAt(0)==tok) {
				temStr=strIn.substring(1,strIn.length());
			}
			if(strIn.charAt(strIn.length()-1)==tok) {
				temStr=temStr.substring(0,temStr.length()-1);
			}
			int temLoc;
			int temLen;
			for(int ii=0;ii<locIn-1;ii++){
				temLen=temStr.length();
				temLoc=temStr.indexOf(tok);
				temStr=temStr.substring(temLoc+1,temLen);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	
		if(temStr.indexOf(tok)==-1){
			return temStr;
		}else{
			return temStr.substring(0,temStr.indexOf(tok));
		}
	}
	
	public String oneTok(String str,int loc){
		String temStr="";
		temStr=str;
		if(str.charAt(0)=='|') temStr=str.substring(1,str.length());
		if(str.charAt((str.length())-1)=='|')  temStr=temStr.substring(0,(temStr.length()-1));
		int temLoc;
		int temLen;
		for(int ii=0;ii<loc-1;ii++)  {
			temLen=temStr.length();
			temLoc=temStr.indexOf("|");
			temStr=temStr.substring(temLoc+1,temLen);
		}
		if(temStr.indexOf("|")==-1) {
			return temStr;
		} else {
			return temStr.substring(0,temStr.indexOf("|"));
		}
	}
	
	/**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	public int getTokNums(String str){
		String temStr="";
		temStr=str;
		if(str.charAt(0)=='~') temStr=str.substring(1,str.length());
		if(str.charAt((str.length())-1)=='~') temStr=temStr.substring(0,(temStr.length()-1));
		
		int temLen;
		int temNum=1;
		int temLoc;
		while(temStr.indexOf("~")!=-1) {	
			temLen=temStr.length();
			temLoc=temStr.indexOf("~");
			temStr=temStr.substring(temLoc+1,temLen);
			temNum++;
		}
		return temNum;
	}
	
	public String toRMB(double money) {
		char[] s1 = { '��', 'Ҽ', '��', '��', '��', '��', '½', '��', '��', '��' };
		char[] s4 = { '��', '��', 'Ԫ', 'ʰ', '��', 'Ǫ', '��', 'ʰ', '��', 'Ǫ', '��',
				'ʰ', '��', 'Ǫ', '��' };
		String str = String.valueOf(Math.round(money * 100 + 0.00001));
		String result = "";

		for (int i = 0; i < str.length(); i++) {
			int n = str.charAt(str.length() - 1 - i) - '0';
			result = s1[n] + "" + s4[i] + result;
		}
		result = result.replaceAll("��Ǫ", "��");
		result = result.replaceAll("���", "��");
		result = result.replaceAll("��ʰ", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("��Ԫ", "Ԫ");
		result = result.replaceAll("���", "��");
		result = result.replaceAll("���", "��");

		result = result.replaceAll("����", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("����", "��");
		result = result.replaceAll("��Ԫ", "Ԫ");
		result = result.replaceAll("����", "��");

		result = result.replaceAll("��$", "");
		result = result.replaceAll("Ԫ$", "Ԫ��");
		result = result.replaceAll("��$", "����");

		return result;
	}
%>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
  
 
%>
<script type="text/javascript">
	
	function chineseNumber(num) {
		if(parseFloat(num)<=0.01) return "��Բ��";
		if (isNaN(num) || num > Math.pow(10, 12)) return "";
		var cn = "��Ҽ��������½��ƾ�";
		var unit = new Array("ʰ��Ǫ", "�ֽ�");
		var unit1= new Array("����", "");
		var numArray = num.toString().split(".");
		var start = new Array(numArray[0].length-1, 2);
		
		function toChinese(num, index) {
			var num = num.replace(/\d/g, function ($1){return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1)})
			return num;
		}
		
		for (var i=0; i<numArray.length; i++)
		{
			var tmp = "";
			for (var j=0; j*4<numArray[i].length; j++)
			{
				var strIndex = numArray[i].length-(j+1)*4;
				var str = numArray[i].substring(strIndex, strIndex+4);
				var start = i ? 2 : str.length-1;
				var tmp1 = toChinese(str, i);
				tmp1 = tmp1.replace(/(��.)+/g, "��").replace(/��+$/, "");
				tmp1 = tmp1.replace(/^Ҽʰ/, "ʰ");
				tmp = (tmp1+unit1[i].charAt(j-1)) + tmp;
			}
			numArray[i] = tmp ;
		}
		
		numArray[1] = numArray[1] ? numArray[1] : "";
		numArray[0] = numArray[0] ? numArray[0]+"Բ" : numArray[0], numArray[1] = numArray[1].replace(/^��+/, "");
		numArray[1] = numArray[1].match(/��/) ? numArray[1] : numArray[1]+"��";
		return numArray[0]+numArray[1];
	}
	/**���ַ�������tok�ֽ�ȡֵ**/
	function oneTok(str,tok,loc){
		var temStr=str;
		if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
		var temLoc;
		var temLen;
		for (ii=0;ii<loc-1;ii++) {
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
		}
		if (temStr.indexOf(tok)==-1) {
			return temStr;
		} else {
			return temStr.substring(0,temStr.indexOf(tok));
		}
	}
	
	/**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	function getTokNums(str,tok){
		var temStr=str;
		if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
		var temLen;
		var temNum=1;
		while(temStr.indexOf(tok)!=-1) {	
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
			temNum++;
		}
		return temNum;
	}
	
	function normalPrint() {
		/*
			Ŀǰ��ͨ��Ʊ��Ҫ��ӡ������
			1����		2����		3����		4��������ˮ��
			5���û�����		6���绰��������ʱΪ�գ�
			7���绰���루�̻����룬��ʱΪ�գ�	8����ͷ���루��ͨ����˺ţ�	9��֧Ʊ����
			10�������ܶ��д��		11���������Сд��
			12��ҵ������
			13����Ŀ����ע����
		*/
		var infoStr="<%=infoStr%>";
		try{
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			printctrl.Print(67,6,9, 1, "���η�Ʊ���룺<%=bill_number%>");
			//��ӡ��ʼ
			printctrl.Print(20,9,9,0,oneTok(infoStr,"|",1)+"��");
			printctrl.Print(25,9,9,0,oneTok(infoStr,"|",2)+"��");
			printctrl.Print(28,9,9,0,oneTok(infoStr,"|",3)+"��");
			printctrl.Print(50,9,9,0,"�ʵ�ͨ��ҵ");
			printctrl.Print(13,11,9,0, "��α�룺<%=ran%>");
			printctrl.Print(13,12,9,0, "��    �ţ�<%=workNo%>");
			printctrl.Print(33,12,9,0, "������ˮ��" + oneTok(infoStr,"|",4));
			printctrl.Print(53,12,9,0, "ҵ�����ƣ�" + oneTok(infoStr,"|",12));
			printctrl.Print(13,13,9,0, "�ͻ����ƣ�"+oneTok(infoStr,"|",5));
			printctrl.Print(13,14,9,0, "����˺ţ�"+oneTok(infoStr,"|",8));
			printctrl.Print(53,14,9,0, "֧Ʊ���룺"+oneTok(infoStr,"|",9));
			
			printctrl.Print(13,16,9,0, "�ϼƽ�(��д)"+"<%=moneyRMB%>");
			printctrl.Print(53,16,9,0, "(Сд)"+"��"+oneTok(infoStr,"|",11)+"Ԫ��");
										
			printctrl.Print(13,18,9,0, "(��Ŀ)");
			var busiStr=oneTok(infoStr,"|",13);//��Ŀ����~�ָ�
			var row = 0;
			for(var i=0;i<getTokNums(busiStr,"~");i++) {
				printctrl.Print(13,19+row,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				row ++;
			}
			
			var payType =oneTok(infoStr,"|",14);
			if (payType=="BX"||payType=="BY") {
				printctrl.Print(13, 25, 9, 0, "�̻����ƣ���Ӣ��)��"+oneTok(infoStr,"|",20));
				printctrl.Print(13, 26, 9, 0, "���׿��ţ����Σ��� "+oneTok(infoStr,"|",21));
				printctrl.Print(43, 26, 9, 0, "�̻����룺"+oneTok(infoStr,"|",22));
				printctrl.Print(69, 26, 9, 0, "���κţ�"+oneTok(infoStr,"|",23));
				printctrl.Print(13, 27, 9, 0, "�����кţ�"+oneTok(infoStr,"|",24));
				printctrl.Print(43, 27, 9, 0, "�ն˱��룺"+oneTok(infoStr,"|",25));
				printctrl.Print(69, 27, 9, 0, "��Ȩ�ţ�"+oneTok(infoStr,"|",26));
				printctrl.Print(13, 28, 9, 0, "��Ӧ����ʱ�䣺"+oneTok(infoStr,"|",27));
				printctrl.Print(43, 28, 9, 0, "�ο��ţ�"+oneTok(infoStr,"|",28));
				printctrl.Print(69, 28, 9, 0, "��ˮ�ţ�"+oneTok(infoStr,"|",29));
				printctrl.Print(13, 29, 9, 0, "�յ��кţ�"+oneTok(infoStr,"|",30));
				printctrl.Print(60, 29, 9, 0, "ǩ�֣�");
			}
			/********tianyang add at 20090928 for POS�ɷ�����****end*******/
			//��ӡ����
			printctrl.PageEnd();
			printctrl.StopPrint();
		}catch(e) {
			alert("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!");
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function printCommit() {
		if ("<%=submitCfm%>" == "submitCfm") {
			normalPrint();
		}
	}
	function doPrint() {
		var infoStr = "<%=infoStr%>";
		var inDbPacket = new AJAXPacket("pubBillPrint_broad_ajaxInDb.jsp","���ڽ��з�Ʊ��⣬���Ժ�......");
		inDbPacket.data.add("inParams0", "<%=inParas0[0]%>");
		inDbPacket.data.add("inParams1", "<%=inParas0[1]%>");
		inDbPacket.data.add("inParams2", "<%=inParas0[2]%>");
		inDbPacket.data.add("inParams3", "<%=inParas0[3]%>");
		inDbPacket.data.add("inParams4", "<%=inParas0[4]%>");	
		inDbPacket.data.add("inParams5", "<%=inParas0[5]%>");
		inDbPacket.data.add("inParams6", "<%=inParas0[6]%>");
		inDbPacket.data.add("inParams7", "<%=inParas0[7]%>");
		inDbPacket.data.add("inParams8", "<%=inParas0[8]%>");
		inDbPacket.data.add("inParams9", "<%=inParas0[9]%>");
		inDbPacket.data.add("inParams10", "<%=inParas0[10]%>");
		inDbPacket.data.add("inParams11", "<%=inParas0[11]%>");	
		inDbPacket.data.add("inParams12", "<%=inParas0[12]%>");
		inDbPacket.data.add("inParams13", "<%=inParas0[13]%>");
		inDbPacket.data.add("inParams14", "<%=inParas0[14]%>");
		inDbPacket.data.add("inParams15", "<%=inParas0[15]%>");
		inDbPacket.data.add("inParams16", "<%=inParas0[16]%>");
		inDbPacket.data.add("inParams17", "<%=inParas0[17]%>");
		inDbPacket.data.add("inParams18", "<%=inParas0[18]%>");	
		inDbPacket.data.add("numCount", "<%=numCount%>");	
	<%
		for(int i=0;i<numCount;i++) {
	%>
		  inDbPacket.data.add("inParams<%=19+i%>", "<%=inParas0[19+i]%>");
	<%
		}
		if( _temp != null && !_temp.equals("") && (oneTok(infoStr,13).equals("BX") || oneTok(infoStr,13).equals("BY"))) {
	%>
			inDbPacket.data.add("bxy", "bxy");
			inDbPacket.data.add("inParams26", "<%=inParas0[26]%>");	
			inDbPacket.data.add("inParams27", "<%=inParas0[27]%>");	
			inDbPacket.data.add("inParams28", "<%=inParas0[28]%>");		
			inDbPacket.data.add("inParams29", "<%=inParas0[29]%>");	
			inDbPacket.data.add("inParams30", "<%=inParas0[30]%>");	
			inDbPacket.data.add("inParams31", "<%=inParas0[31]%>");	
			inDbPacket.data.add("inParams32", "<%=inParas0[32]%>");		
			inDbPacket.data.add("inParams33", "<%=inParas0[33]%>");	
			inDbPacket.data.add("inParams34", "<%=inParas0[34]%>");	
			inDbPacket.data.add("inParams35", "<%=inParas0[35]%>");	
			inDbPacket.data.add("inParams36", "<%=inParas0[36]%>");		
			inDbPacket.data.add("inParams37", "<%=inParas0[37]%>");	
	<%	
		}
	%>
		core.ajax.sendPacket(inDbPacket, printIt);
		inDbPacket = null;	
	}
	function  printIt(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if (retCode != "000000" && retCode != "0") {
			alert("e005PrintInDB��Ʊ���ʧ�ܣ�"+retCode+"��"+retMsg+"������ϵ����Ա�Ϳ�����Ա��");
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
			return false;
		} else {
			alert("���ӷ�Ʊ���ɹ�.");
			printCommit();	
		}	
	}
</script>	
	</head>
	<body>
	</body>
<!-------�����ӡ�ؼ�---------->
<OBJECT
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
	codebase="/ocx/printatl.dll#version=1,0,0,1"
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>
</html>




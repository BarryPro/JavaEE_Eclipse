<%
/********************
 *������: si-tech
 *create by wanghfa @ 20110725
 ********************/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ include file="/npage/public/publicPrintBillNum.jsp" %>


<HTML>
<HEAD>
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
%>

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
	//Billing�ṩȡ���������
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int key = 99999;
	int realKey = 0;
	if (request.getParameter("realKey") == null) {
		realKey = ran ^ key;
	} else {
		realKey = Integer.parseInt(request.getParameter("realKey"));
	}
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== ���ȡrealKey = " + realKey);
	
	String billType    = "2";	//��Ʊ
	String workNo      = (String)session.getAttribute("workNo");
	String workName    = (String)session.getAttribute("workName");
	String regionCode  = ((String)session.getAttribute("orgCode")).substring(0,2);
	String printMethod = request.getParameter("printMethod") == null ? "1" : request.getParameter("printMethod");
	String feeName     = request.getParameter("feeName") == null ? "�ϼƽ��" : request.getParameter("feeName");
	System.out.println("------------------feeName--------------------------"+feeName);
	String dlgMsg      = request.getParameter("dlgMsg") == null ? "" : request.getParameter("dlgMsg");
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	String infoStr = request.getParameter("infoStr");
	String opCode = request.getParameter("opCode");
	String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));

	String loginAccept = request.getParameter("loginAccept");
	String pBillDate = new String();
	if (request.getParameter("pBillDate") == null) {
		pBillDate = oneTok(infoStr,4)+""+oneTok(infoStr,5)+""+oneTok(infoStr,6);
	} else {
		pBillDate = request.getParameter("pBillDate");
	}
	String pBillPhone = new String();
	if (request.getParameter("pBillPhone") == null) {
		pBillPhone = oneTok(infoStr,9);
	} else {
		pBillPhone = request.getParameter("pBillPhone");
	}
	

	
	
	String sqlIdNo ="select * from dcustmsg where phone_no ='"+pBillPhone+"'";
	String idNo="";
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sqlIdNo = " + sqlIdNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeIdNo" retmsg="retMsgIdNo">
		<wtc:sql><%=sqlIdNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultIdNo" scope="end"/>
<%
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== dlgMsg = " + dlgMsg);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== infoStr = " + infoStr);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== opCode = " + opCode);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== submitCfm = " + submitCfm);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== loginAccept = " + loginAccept);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== pBillDate = " + pBillDate);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== workNo = " + workNo);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== idNo = " + idNo);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== pBillPhone = " + pBillPhone);
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sPubSelect retCodeIdNo = " + retCodeIdNo);
	if(retCodeIdNo.equals("000000") && resultIdNo.length > 0){
		idNo=resultIdNo[0][0];
  }else {
	}
%>
<SCRIPT type=text/javascript>
	
	if("<%=bill_number%>"==""){//��Ʊ����Ϊ�ս�ֹ��ӡ
			window.close();
	}
		
	if ("<%=submitCfm%>" == "submit") {
		//doInDb();
	}
	
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
	
	function doInDb() {
		var inDbPacket = new AJAXPacket("pubBillPrint_ajaxInDb.jsp","���ڽ��з�Ʊ��⣬���Ժ�......");
		inDbPacket.data.add("inParams0", "<%=realKey%>");							//�����
		inDbPacket.data.add("inParams1", "<%=loginAccept%>");					//ҵ����ˮ
		inDbPacket.data.add("inParams2", "<%=opCode%>");								//opCode
		inDbPacket.data.add("inParams3", "<%=workNo%>");								//����
		inDbPacket.data.add("inParams4", "<%=pBillDate%>");	//������
		inDbPacket.data.add("inParams5", "<%=pBillPhone%>");		//�ƶ�����
		inDbPacket.data.add("inParams6", "<%=idNo%>");									//�û�idNo
		inDbPacket.data.add("inParams7", "0");		//����Ʊ���
		<%
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
			for (int num=1; num<=13; num++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== oneTok(infoStr,"+num+") = " + oneTok(infoStr, num));
				if (num == 12) {
				%>
					inDbPacket.data.add("inParams<%=num+7%>", chineseNumber("<%=oneTok(infoStr, num)%>"));
				<%
				} else {
				%>
					inDbPacket.data.add("inParams<%=num+7%>", "<%=oneTok(infoStr, num)%>");
				<%
				}
			}
			String busiStr = oneTok(infoStr,14);
			int posLength = getTokNums(busiStr);
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== posLength = " + posLength);
			for (int i=1;i<=posLength;i++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== oneTok(busiStr,"+i+") = " + oneTok(busiStr,'~',i));
			%>
				inDbPacket.data.add("inParams<%=20+i%>", "<%=oneTok(busiStr,'~',i)%>");	//ѭ����ӡ��Ϣ
			<%
			}
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j < " + (infoStr.split("\\|").length - 14));
			for (int j = 1;j <= (infoStr.split("\\|").length - 14); j ++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== " + oneTok(infoStr,14+j));
			%>
				inDbPacket.data.add("inParams<%=posLength+20+j%>", "<%=oneTok(infoStr,14+j)%>");
			<%
			}
		%>
		inDbPacket.data.add("inParamsNo", "<%=infoStr.split("\\|").length + posLength + 7%>");
		core.ajax.sendPacket(inDbPacket, doPrint);
		inDbPacket = null;
	}
	
	function doPrint(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if ("<%=submitCfm%>" == "submit") {
			window.close();
			return;
		}
		
		if (retCode != "000000") {
			if (retCode == "") {
				rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
			} else {
				rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.", 0);
			}
			window.close();
			return false;
		} else if ("<%=printMethod%>" == "1") {
			normalPrint();
		} else if ("<%=printMethod%>" == "2") { 
			printAsParams();
		}
	}
	
	function normalPrint() {
		
		var infoStr="<%=infoStr%>";
		try {
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
						printctrl.DrawImage(localPath,8,10,40,18);//��������
					<%
				}
			%>
			var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
			var fontType = "����";//����
			var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	 		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",4)+oneTok(infoStr,"|",5)+oneTok(infoStr,"|",6));
	 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ʵ�ͨ��ҵ");
			printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���η�Ʊ���룺<%=bill_number%>");
	 		
			printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺<%=ran%>");	//��Ʊ��α��

			printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�"+oneTok(infoStr,"|",1));//����
			printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"������ˮ��"+oneTok(infoStr,"|",2));//��ˮ
			printctrl.PrintEx(100,rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"ҵ�����ƣ�"+oneTok(infoStr,"|",3));//ҵ������

			
			printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͻ����ƣ�"+oneTok(infoStr,"|",7));//�û�����
			printctrl.PrintEx(100, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�"+oneTok(infoStr,"|",8));//����
			
			printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ֻ����룺"+oneTok(infoStr,"|",9));//�ƶ�����
			printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Э����룺"+oneTok(infoStr,"|",10));//Э�����
			printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"֧Ʊ���룺"+oneTok(infoStr,"|",11));//֧Ʊ����
			
			printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"<%=feeName%>��(��д)"+oneTok(infoStr,"|",12));//�ϼƽ��(��д)
			printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(Сд)"+oneTok(infoStr,"|",13));//���(Сд)
			
			printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(��Ŀ)");//��Ŀ
			
			var imei_temp = oneTok(infoStr,"|",17);
			if( imei_temp != null && imei_temp != "") {
			//	printctrl.print(20,17,9,0,imei_temp);//IMEINo
				printctrl.PrintEx(20, rowInit + 8, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,imei_temp);
			}
			var busiStr=oneTok(infoStr,"|",14);
			var row = 0;
			for(var i=0;i<getTokNums(busiStr,"~");i++) {
				if (i % 2 == 0) {
					printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				//	printctrl.Print(20,18+row,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				} else if (i % 2 == 1) {
					printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				//	printctrl.Print(50,18+row,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
					row ++;
				}
			}
			
			
			
//		printctrl.Print(10,32,9,9,oneTok(infoStr,"|",15)); //����Ա
//		printctrl.Print(35,32,9,9,oneTok(infoStr,"|",16));//�տ�Ա 
//		printctrl.Print(66,12,10,0,oneTok(infoStr,"|",17));//imei���������
//		printctrl.Print(35,31,9,9,oneTok(infoStr,"|",18));//�Ƿ����������Ʒ� 

			/********tianyang add at 20090928 for POS�ɷ�����****start*****/
			var payType = oneTok(infoStr,"|",19);
			if (payType=="BX"||payType=="BY") {
				printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����ƣ���Ӣ��)��"+oneTok(infoStr,"|",20));
				
				printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���׿��ţ����Σ��� "+oneTok(infoStr,"|",21));
				printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����룺"+oneTok(infoStr,"|",22));
				printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���κţ�"+oneTok(infoStr,"|",23));
				
				printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�����кţ�"+oneTok(infoStr,"|",24));
				printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ն˱��룺"+oneTok(infoStr,"|",25));
				printctrl.PrintEx(100, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ȩ�ţ�"+oneTok(infoStr,"|",26));
				
				printctrl.PrintEx(13, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ӧ����ʱ�䣺"+oneTok(infoStr,"|",27));
				printctrl.PrintEx(62, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ο��ţ�"+oneTok(infoStr,"|",28));
				printctrl.PrintEx(100, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��ˮ�ţ�"+oneTok(infoStr,"|",29));
				
				printctrl.PrintEx(13, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�յ��кţ�"+oneTok(infoStr,"|",30));
				printctrl.PrintEx(62, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "ǩ�֣�");
			}
			/********tianyang add at 20090928 for POS�ɷ�����****end*******/
			printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ʊ��" +��oneTok(infoStr,"|",15)); //����Ա
			printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�տ" +  oneTok(infoStr,"|",16)); //�տ�Ա 
			printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ˣ�");
			 
			//��ӡ����
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
			//alert(e.printstacktrace());	//wanghfa �����޸�
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function printAsParams() {
		var chPos = -1;
		var chPos1 = -1;
		var tempObj = new Array(5);
		var tempObj1 = new Array(5);
		
		var strLen,strLen1,fontSize,fontStyle;
		var infoStr="<%=infoStr%>";
		var printFlag=false;

		strLen = infoStr.length;
		if(strLen>0) printFlag=true;
		
		try {
			printctrl.Setup(0);
			printctrl.StartPrint();
			if(printFlag==true) printctrl.PageStart();
			while(strLen > 0) {
				for(var i=0;i<5;i++) {
				chPos = infoStr.indexOf("|");
				tempObj[i] = infoStr.substring(0,chPos);
				infoStr = infoStr.substring(chPos + 1);
				}
				printctrl.Print(1*tempObj[0],1*tempObj[1],1*tempObj[2],1*tempObj[3],tempObj[4]);
				strLen = infoStr.length;
			}
			if(printFlag==true) {
				printctrl.PageEnd();
			}
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		} finally {
			window.close();
		}
	}
</SCRIPT>
</HEAD>
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>��Ʊ��ӡ</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
			<div class="popup_ok" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=dlgMsg%></div>
		  </div>

	    <div align="center">
			<%
				if(!submitCfm.equals("Single")) {
				%>
					<input class="b_foot" name=commit onClick="doInDb()" type=button value="��ӡ">
					<input class="b_foot" name=back onClick="window.close()" type=button value="��һ��">
				<%
				} else {
				%>
					<input class="b_foot" name=commit onClick="doInDb()" type=button value="ȷ��">&nbsp;
				<%
				}
			%>
	    </div>
	    <br>   
	 </div>
</FORM>
</BODY>
<!-------�����ӡ�ؼ�---------->
<OBJECT
	classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
	codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>
</HTML>    

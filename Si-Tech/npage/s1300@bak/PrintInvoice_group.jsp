<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	//20100528 liuxmc ��ӷ�Ʊ��α��
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey��"+realKey);
		String bill_type = "2";
	// 20090421 liyan �����Ż�����Ҫ�󣬽���ע�ֶδ�ӡ��ʼ�и���Ϊ5.
	  String ifRed = request.getParameter("ifRed");
    String contractno = request.getParameter("contractno");
    String workNo = request.getParameter("workno");
    String payAccept = request.getParameter("payAccept");
    String total_date = request.getParameter("total_date");
    String op_code = "d340";
    String smphoneNo = request.getParameter("phoneNo");
    System.out.println("phoneNo==="+smphoneNo);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String groupId = (String)session.getAttribute("groupId");
		//xl add for chengll����
		//String prtFlag = request.getParameter("prtFlag");
		//String jtcpmc = request.getParameter("jtcpmc");
		//String check_seq =  request.getParameter("check_seq");
		//String s_flag =  request.getParameter("s_flag");
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA check_seq is "+check_seq);

		//xl add ��Ʊ����
		int i_count_cwt=0;
		String check_seq = request.getParameter("ocpy_begin_no");
		//��Ʊ���� ��qidxȡ��
		String s_invoice_code = request.getParameter("s_invoice_code");
		String s_flag = "N";//Ĭ�϶����°淢Ʊ ��Ҫ�ֶ���ӡlogo ��ʱ����г���ȷ��
		String bill_code = request.getParameter("bill_code");
		String s_yyt_name="";
    String printNote = "0";
 		String sm_name  =request.getParameter("s_sm_name");
  	String s_sm_code =request.getParameter("s_sm_code");
		String s_id_no=request.getParameter("s_id_no");
		String phoneNo = smphoneNo;
		//xl add backnote
    String backnote = request.getParameter("backnote");
    int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }

    String print_note = "0";

    String smop_code = request.getParameter("opCode");
    System.out.println("smop_code=" + smop_code);
    if (smop_code == null || smop_code == "") {
        smop_code = "0000";
    }
    if (smop_code.equals("1302") ||smop_code.equals("d340") ) {
    //    String smSql = "select decode(sm_code,'zn','������','gn','ȫ��ͨ','dn','���еش�') from dcustmsg where phone_no= '" + smphoneNo + "' and substr(run_code,2,1)<'a'";


		//xl add ������֯�ڵ��ѯӪҵ������
		String[] inParam_yyt = new String[2];
		inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
		inParam_yyt[1]="s_group_id="+groupId;
	 
		//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +"a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;

	
%>

	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
		
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam_idno[0]%>"/>
		<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
<%
		if(yyt_name_arr!=null&&yyt_name_arr.length>0)
		{
			s_yyt_name = yyt_name_arr[0][0];
		}
	
			if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
      }

        if (printNote.equals("0")) {
            print_note = "0";
        } else {
           // print_note = request.getParameter("print_note");
		    print_note = "0";
        }
		
    }
	/*xl Ϊd340����returnPage */
	
	//huxl ����ͨ		
	String returnPage ="";
	if(smop_code.equals("d340")){
		returnPage = "s1300_group.jsp";
		//xl add �ж��Ƿ��ǳ���ͨ i_count_cwt
		String[] inParam_cwt = new String[2];
		inParam_cwt[0]="SELECT to_char(count(1)) FROM dproductorderdet b, dproductcharacter c WHERE c.character_number = '1109037709'  AND c.character_value = '451002'  AND c.product_order_id = b.product_order_id and b.id_no=:s_id_no";
		inParam_cwt[1]="s_id_no="+s_id_no;
		%>
		<wtc:service name="TlsPubSelCrm"  outnum="1">
			<wtc:param value="<%=inParam_cwt[0]%>"/>
			<wtc:param value="<%=inParam_cwt[1]%>"/>
		</wtc:service>
		<wtc:array id="s_cwt" scope="end" />
		<%
		if(s_cwt.length>0)
		{
			i_count_cwt=Integer.parseInt(s_cwt[0][0]);	
		}
		//end of �ж�
	}
	else{
		returnPage =  "s1300.jsp";
	}
    
    if (request.getParameter("returnPage") != null) {
        returnPage = request.getParameter("returnPage");
    }

    String printtype = "0";
    if (request.getParameter("printtype") != null) {
        printtype = request.getParameter("printtype");
    }


    String year = total_date.substring(0, 4);
    String month = total_date.substring(4, 6);
    String day = total_date.substring(6, 8);

    String[] inParas = new String[4];
    inParas[0] = workNo;
    inParas[1] = contractno;
    inParas[2] = total_date;
    inParas[3] = payAccept;
		String s_pay_note="";
    //CallRemoteResultValue value = viewBean.callService("1", org_code.substring(0, 2), "s1300Print", "17", inParas);
%>

	<wtc:service name="s1300Print" routerKey="phone" routerValue="<%=smphoneNo%>" outnum="33" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
		
<%
		
		
		String return_code = "999999";
		String temp[]=new String[10];
		String info=new String();
		int record=0;
		if(result!=null&&result.length>0){
			 return_code = result[0][0];
		
			
		   
		   
		}
	 
    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	System.out.println("return_code===="+return_code);
    if (return_code.equals("000000")) {

    		if(result!=null&&result.length>0){
		    		phoneNo = result[0][5].trim();
		        if (phoneNo.equals("99999999999")){
		            phoneNo = "";
		        }
	
		   int length1=result[0][16].length();
			 if(length1>0)
			 {
			 int size=60;
			 System.out.println("-------------------------"+result[0][16].length());
			 info=result[0][16].trim();
			 System.out.println("-------------------------"+result[0][16]);
			 record=length1/size;
			 System.out.println("-------------------------"+record);
			 for(int j=0;j<=record;j++)
			 {
			 if(info.length()>=size)
			 {
			 temp[j]=info.substring(0,size);
		   info=info.substring(size);
		   }
		   else
		   temp[j]=info;
		   System.out.println("-------------------------"+j+"  "+temp[j]);
		   
		   
		  
		   }
		   }
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
 function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//�����С
		var fontType = "����";//����
		var fontStrongInit = 0;//�����ϸ
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc ��ӷ�Ʊ��α��*/
		<%
			/*
			if(s_flag.equals("O"))
			{
				%>
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%
			}*/
		%>
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
		printctrl.DrawImage(localPath,8,10,40,18);//��������
        printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		printctrl.Print(115, 10, 9, 0, "���η�Ʊ����:<%=check_seq%>"); 
        /*******************************************/
        //printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

		//printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=result[0][1]%>");
        //printctrl.Print(72, 13, 9, 0, "������ˮ��<%=result[0][15]%>");
		printctrl.Print(13, 12, 9, 0, "�ͻ�����:<%=result[0][4]%>");
		printctrl.Print(13, 13, 9, 0, "ҵ�����:<%=result[0][2]%>");
		<%
			if(i_count_cwt>0)
			{
				%>
					printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ��:��������");	
				<%
			}
			else
			{
				%>
					printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ��:<%=sm_name%>");
				<%
			}	
		%>
		

		printctrl.Print(13, 15, 9, 0, "�û����룺<%=phoneNo%>");	
		printctrl.Print(48, 15, 9, 0, "Э����룺<%=result[0][6]%>");
		printctrl.Print(82, 15, 9, 0, "��������:<%=year+month%>");
		printctrl.Print(115, 15, 9, 0, "��ͬ��:");

		printctrl.Print(115, 16, 9, 0, "֧Ʊ��:<%=result[0][7]%>");
		printctrl.Print(115, 17, 9, 0, "����ͳ������: <%=result[0][6]%>");
		//printctrl.Print(16, 18, 9, 0, "ͨ�ŷ���Ѻϼ�:");
		printctrl.Print(16, 18, 9, 0, "���η�Ʊ���:(Сд)��<%=result[0][9].trim()%> ��д���ϼ�:<%=result[0][8]%>");
		printctrl.Print(16, 20, 9, 0, "<%=result[0][11]%>");//��ע 
		printctrl.Print(16, 21, 9, 0, "<%=result[0][12]%>");//��ע 
		printctrl.Print(16, 22, 9, 0, "<%=result[0][13]%>");//��ע 
		printctrl.Print(16, 23, 9, 0, "<%=result[0][14]%>");//��ע
		//printctrl.Print(16, 22, 9, 0, "��ע1"<br>"��ע2"<br>");//��ע 
		//xl add for �ﲩ��
		<%
				System.out.println("cccccccccccccccccccccccccccccccccccccccccccccc test print here backnote is "+backnote);
				if(backnote!=null && (!backnote.equals("")))
				{
					%>
						printctrl.Print(16, 11, 9, 0, "<%=backnote%>");//��ע
					<%
				}
		%>
		//end of �ﲩ��
		//hanfeng
		printctrl.Print(16, 24, 9, 0, "ע�⣺�����ѿ��ߵķ�Ʊ���ҹ�˾�����ṩ�½ᷢƱ����ֵ˰ר�÷�Ʊ��");//��ע
		
		     /********tianyang add at 20090928 for POS�ɷ�����****start*****/
     /* result[0][17] Ϊ "1"  ��pos�ɷ�(����) */
     <%if (result[0][17] != null && result[0][17].equals("1")) {%>
	     		printctrl.Print(13, 25, 9, 9, "<%=result[0][18].trim()%>");/*�̻����ƣ���Ӣ��)*/
				printctrl.Print(13, 26, 9, 9, "<%=result[0][29].trim()%>");/*���׿��ţ����Σ�*/
				printctrl.Print(72, 26, 9, 9, "<%=result[0][19].trim()%>");/*�̻�����*/
				printctrl.Print(115, 26, 9, 9, "<%=result[0][24].trim()%>");/*���κ�*/
				printctrl.Print(13, 27, 9, 9, "<%=result[0][21].trim()%>");/*�����к�*/
				printctrl.Print(72, 27, 9, 9, "<%=result[0][20].trim()%>");/*�ն˱���*/
				printctrl.Print(115, 27, 9, 9, "<%=result[0][27].trim()%>");/*��Ȩ��*/
				printctrl.Print(13, 28, 9, 9, "<%=result[0][25].trim()%>");/*��Ӧ����ʱ��*/
				printctrl.Print(72, 28, 9, 9, "<%=result[0][26].trim()%>");/*�ο���*/
				printctrl.Print(115, 28, 9, 9, "<%=result[0][28].trim()%>");/*��ˮ��*/
				printctrl.Print(13, 29, 9, 9, "<%=result[0][22].trim()%>");/*�յ��к�*/
				printctrl.Print(115, 29, 9, 9, "ǩ�֣�");
     <%}%>
     /********tianyang add at 20090928 for POS�ɷ�����****end*******/
 
		
		//xl add ��Ʊ��                    �տ                     ���ˣ�
		printctrl.Print(13, 30, 9, 0, "��ˮ�ţ�<%=result[0][15]%>");
		printctrl.Print(54, 30, 9, 0, "��Ʊ�ˣ�<%=workname%>");
		printctrl.Print(85, 30, 9, 0, "���ţ�<%=workNo%>");
		printctrl.Print(110, 30, 9, 0, "Ӫҵ����<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
    }

    function ifprint()
    {
      //alert(1);
        printInvoice();
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	
	//��Ʊ���ӻ����������
	//inParas0[0] = realKey+"";
		String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = result[0][15];//��ˮ
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = total_date;//û����
		inParas0[4] = phoneNo;
		inParas0[5] = s_id_no;//id_no ֻ������� ʵ�ڲ����ڳ������Լ�ȡһ��
		inParas0[6] = result[0][6];//contract_no
		 
		inParas0[7] = realKey+"";//��α��
		System.out.println("=============sm_name====================="+sm_name);
		//xl add ��ƱԤռ״̬������ begin
		//��Ʊ���� ��Ʊ��� ���� group_id ��ע ��Ʊ���� 
		inParas0[8] = check_seq;//��Ʊ����;
		inParas0[9] = bill_code;//��Ʊ����;
		inParas0[10] =s_sm_code;//Ʒ��
		inParas0[11] = result[0][9];//Сд���
		inParas0[12] = result[0][8];//��д���
		inParas0[13] = s_pay_note ;
		
		//���νɷѽ�� ����ÿ����Ŷ���ɶ
		//xl add ��ƱԤռ״̬������ end


		//inParas0[14] ="1";//��Ʊ��ӡ
		inParas0[14] = "";//��ֵ˰��
		inParas0[15] = "0";//��ֵ˰��
		inParas0[16] = "0";//��ֵ˰��
		inParas0[17] = "0";//��ӡ����
		inParas0[18] = result[0][4];//cust_name
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//ͨ�û��� 
		 

		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result2 = new String[][]{};
		//��ӡ��ʱ�� ����ˮ����״̬ Ԥռ�ĸ���Ϊ�Ѵ�ӡ
%>		
		<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
			<wtc:param value="<%=inParas0[0]%>"/>
			<wtc:param value="<%=inParas0[1]%>"/>
			<wtc:param value="<%=inParas0[2]%>"/>
			<wtc:param value="<%=inParas0[3]%>"/>
			<wtc:param value="<%=inParas0[4]%>"/>
			<wtc:param value="<%=inParas0[5]%>"/>
			<wtc:param value="<%=inParas0[6]%>"/>
			<wtc:param value="<%=inParas0[7]%>"/>
			<wtc:param value="<%=inParas0[8]%>"/>
			<wtc:param value="<%=inParas0[9]%>"/>
			<wtc:param value="<%=inParas0[10]%>"/>
			<wtc:param value="<%=inParas0[11]%>"/>
			<wtc:param value="<%=inParas0[12]%>"/>
			<wtc:param value="<%=inParas0[13]%>"/>
			<wtc:param value="<%=inParas0[14]%>"/>
			<wtc:param value="<%=inParas0[15]%>"/>
			<wtc:param value="<%=inParas0[16]%>"/>
			<wtc:param value="<%=inParas0[17]%>"/>
			<wtc:param value="<%=inParas0[18]%>"/>
			<wtc:param value="<%=inParas0[19]%>"/>
			<wtc:param value="<%=inParas0[20]%>"/>
			<wtc:param value="<%=inParas0[21]%>"/>
			<wtc:param value="<%=inParas0[22]%>"/>
			<wtc:param value="<%=inParas0[23]%>"/>
			<wtc:param value="<%=inParas0[24]%>"/>
			<wtc:param value="<%=inParas0[25]%>"/>
			<wtc:param value="<%=inParas0[26]%>"/>
			<wtc:param value="<%=inParas0[27]%>"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
		System.out.println("====ִ�� szg12InDB ����=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,�������"+"<%=result2[0][0]%>"+",����ԭ��:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,szg12InDB_pt���񷵻ؽ��Ϊ��.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
			
		//////////////////////////////////////////////
				}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("��Ʊ��ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.�������:"+"<%=return_code%>"+"<br>��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {//s1300Print�������ʧ��
%>
		<script language="JavaScript">
		    rdShowMessageDialog("s1300Print��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>

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
		System.out.println("EEEEEEEEEEEEEEEEEEEE realKey��"+realKey);
		
		String bill_type = "2";
	/////////////////////////////////
		String groupId = (String)session.getAttribute("groupId");
	// 20090421 liyan �����Ż�����Ҫ�󣬽���ע�ֶδ�ӡ��ʼ�и���Ϊ5.
    String contractno = request.getParameter("contractno");
    String workNo = request.getParameter("workno");
    String payAccept = request.getParameter("payAccept");
    String total_date = request.getParameter("total_date");
    String op_code = "1302";
    String smphoneNo = request.getParameter("phoneNo");
    System.out.println("aaaaaaaaaaaaaaaaaaffffffffffffffffff  add testfaaaaaaaaaafffffffffffffffffffffffffffffffff  phoneNo==="+smphoneNo);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String s_sm_name = request.getParameter("s_sm_name");;
    String s_sm_code = request.getParameter("s_sm_code");
    String printNote = "0";
    String ifRed="2";
	String bill_code = request.getParameter("bill_code");
    int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }
    //·��
	String regionCode = org_code.substring(0,2);

    String print_note = "0";
	
	//xl add ��Ʊ����
	String id_no = request.getParameter("id_no");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");

    String smop_code = "g574";//request.getParameter("opCode");
    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA smop_code=" + smop_code);
    String sm_name = "";
    if (smop_code == null || smop_code == "") {
        smop_code = "0000";
    }
 
	//xl add ����10648�Ŷ�ȡid_no �� phone_no
	String s_id_no="";
	String s_phone_old="";
	String[] inParam = new String[2];
	inParam[0] ="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and  a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
	inParam[1] = "s_contract_no="+contractno;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
<%
	if(sm_name_arr.length>0)
	{
		s_id_no=sm_name_arr[0][0];
		s_phone_old=sm_name_arr[0][1];
	}
 
	/*xl Ϊ1303����returnPage */
	String returnPage ="";
	if(smop_code.equals("1303")){
		returnPage = "s1300_6.jsp";
	}
	else{
		returnPage =  "g574_1.jsp";
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
    		String phoneNo = "";
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
			if(s_flag.equals("O"))
			{
				%>
					//printctrl.Print(12, 9, 51, 20, "�ϰ�")
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					//printctrl.Print(12, 9, 51, 20, "�°�");
					//getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					//printctrl.DrawImage(localPath,300,120,560,190);
					//printctrl.DrawImage(localPath,21,10,43,16);//��������
					//printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%
			}
		%>
		printctrl.DrawImage(localPath,8,10,40,18);//��������
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
        printctrl.Print(20, 10, 9, 0, "<%=year+month+day%>");
		printctrl.Print(85, 10, 9, 0, "�ʵ�ͨ��ҵ");
		printctrl.Print(110,10, 9, 0, "���η�Ʊ���룺<%=check_seq%>");
        /*******************************************/
        printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

		printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=result[0][1]%>");
        printctrl.Print(72, 13, 9, 0, "������ˮ��<%=result[0][15]%>");
 

    <%if (printtype.equals("0")) {%>
        printctrl.Print(115, 13, 9, 0, "ҵ�����ƣ�<%=result[0][2]%>");
    <%} else {%>
        printctrl.Print(115, 13, 9, 0, "ҵ�����ƣ�����<%=result[0][2]%>");
    <%}%>

     

        printctrl.Print(13, 14, 9, 0, "�ͻ����ƣ�<%=result[0][4]%>");
		printctrl.Print(115, 14, 9, 0, "��    �ţ�");   
    <%if (!print_note.equals("0")) {%>
        printctrl.Print(13, 15, 9, 0, "<%=print_note%>--�ɷ�");
    <%}%>

        printctrl.Print(13, 15, 9, 0, "���������룺<%=smphoneNo%>");

        printctrl.Print(50, 15, 9, 0, "<%=sm_name%>");
        printctrl.Print(72, 15, 9, 0, "Э����룺<%=result[0][6]%>");
        printctrl.Print(115, 15, 9, 0, "֧Ʊ���룺<%=result[0][7]%>");

        printctrl.Print(13, 16, 9, 0, "�ϼƽ�(��д)<%=result[0][8]%>");
        printctrl.Print(115, 16, 9, 0, "(Сд)��<%=result[0][9].trim()%>");
		
        printctrl.Print(13, 17, 9, 0, "(��Ŀ)");
        printctrl.Print(13, 19, 9, 0, "<%=result[0][11]%>");
        printctrl.Print(13, 20, 9, 0, "<%=result[0][12]%>");
        printctrl.Print(13, 21, 9, 0, "<%=result[0][13]%>");
        printctrl.Print(13, 22, 9, 0, "<%=result[0][14]%>");
		<%
		 if(length1>0){
       for(int i=0;i<=record;i++)
        {
        %>
        printctrl.Print(13, "<%=(i*1.5+23.5)%>", 10, 0, "<%=temp[i]%>");
        <%
        if(i==record){
        %>
         //printctrl.Print(13,"<%=(i+29)%>", 9, 0, "<%=workname%>");
        <%
        }
        }
        }
      else{
        %>
        //printctrl.Print(13,29, 9, 0, "<%=workname%>");
        <%}	
		%>

     /********tianyang add at 20090928 for POS�ɷ�����****start*****/
     /* result[0][17] Ϊ "1"  ��pos�ɷ�(����) */
     <%if (result[0][17] != null && result[0][17].equals("1")) {%>
	     		printctrl.Print(13, 25, 9, 9, "<%=result[0][18].trim()%>");/*�̻����ƣ���Ӣ��)*/
				printctrl.Print(13, 26, 9, 9, "<%=result[0][29].trim()%>");/*���׿��ţ����Σ�*/
				printctrl.Print(73, 26, 9, 9, "<%=result[0][19].trim()%>");/*�̻�����*/
				printctrl.Print(119, 26, 9, 9, "<%=result[0][24].trim()%>");/*���κ�*/
				printctrl.Print(13, 27, 9, 9, "<%=result[0][21].trim()%>");/*�����к�*/
				printctrl.Print(73, 27, 9, 9, "<%=result[0][20].trim()%>");/*�ն˱���*/
				printctrl.Print(119, 27, 9, 9, "<%=result[0][27].trim()%>");/*��Ȩ��*/
				printctrl.Print(13, 28, 9, 9, "<%=result[0][25].trim()%>");/*��Ӧ����ʱ��*/
				printctrl.Print(73, 28, 9, 9, "<%=result[0][26].trim()%>");/*�ο���*/
				printctrl.Print(119, 28, 9, 9, "<%=result[0][28].trim()%>");/*��ˮ��*/
				printctrl.Print(13, 29, 9, 9, "<%=result[0][22].trim()%>");/*�յ��к�*/
				printctrl.Print(119, 29, 9, 9, "ǩ�֣�");
     <%}%>
     /********tianyang add at 20090928 for POS�ɷ�����****end*******/

				//ZLC���� ��֤��Ϣ
		
		//xl add ��Ʊ��                    �տ                     ���ˣ�
		printctrl.Print(13, 30, 9, 0, "��Ʊ��<%=workname%>");
		printctrl.Print(37, 30, 9, 0, "�տ");
		printctrl.Print(60, 30, 9, 0, "���ˣ�");
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
	
		String[] inParas0 = new String[28];
		//inParas0[0] = realKey+"";
		inParas0[0] = result[0][15];//��ˮ
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = "";//û����
		inParas0[4] = s_phone_old;
		inParas0[5] = s_id_no;//id_no ֻ������� ʵ�ڲ����ڳ������Լ�ȡһ��
		inParas0[6] = contractno;//contract_no
		 
		inParas0[7] = "";//֧Ʊ����
		System.out.println("=============sm_name====================="+sm_name);
		//xl add ��ƱԤռ״̬������ begin
		//��Ʊ���� ��Ʊ��� ���� group_id ��ע ��Ʊ���� 
		inParas0[8] = check_seq;//��Ʊ����;
		inParas0[9] = bill_code;//��Ʊ����;
		inParas0[10] =s_sm_code;//Ʒ��
		inParas0[11] = "";//Сд���
		inParas0[12] = "";//��д���
		inParas0[13] = "" ;
		inParas0[14] ="1"; 
		inParas0[15] = ""; 
		inParas0[16] = "0"; 
		inParas0[17] = "0"; 
		inParas0[18] = "0"; 
		inParas0[19] = ""; 
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//ͨ�û��� 
		String[][] result2 = new String[][]{};
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
			System.out.println("====ִ�� s1300PrintInDB ����=======");
			if(RetResult.length > 0)
			{
				result2 = RetResult;
				if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
				{
					%>
						<script language="JavaScript">
							rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
							document.location.replace("<%=returnPage%>");
						</script>
			<%			
				}
				
			}
			else if(RetResult == null || RetResult.length == 0){
	%>
						<script language="JavaScript">
							rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
							document.location.replace("<%=returnPage%>");
						</script>
	<%			
			}
	
	
	//liuxmc add  ��Ʊ���ӻ����������

				}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("��Ʊ��ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.<br>��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {
%>
		<script language="JavaScript">
		    rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>

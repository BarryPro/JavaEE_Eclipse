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
	
		String ims_flag = WtcUtil.repNull(request.getParameter("ims_flag"));
		String  userName= request.getParameter("userName");
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
	String nopass = (String)session.getAttribute("password");
	// 20090421 liyan �����Ż�����Ҫ�󣬽���ע�ֶδ�ӡ��ʼ�и���Ϊ5.
	  String ifRed = request.getParameter("ifRed");
   
    String workNo = request.getParameter("workno");
    String payAccept = request.getParameter("payAccept");
    String total_date = request.getParameter("total_date");
    String op_code = request.getParameter("opCode");
    String smphoneNo = request.getParameter("phoneNo");
    System.out.println("phoneNo==="+smphoneNo);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String printNote = "0";
		String groupId = (String)session.getAttribute("groupId");
	  String sm_name = request.getParameter("s_sm_name");
    String s_sm_code=request.getParameter("s_sm_code");
		String s_id_no=request.getParameter("s_id_no");
		String returnPage =request.getParameter("returnPage");

    int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }
    //·��
	String regionCode = org_code.substring(0,2);

    String print_note = "0";
	int i_count_cwt=0;
	//xl add ��Ʊ����
	String check_seq = request.getParameter("ocpy_begin_no");
	//��Ʊ���� ��qidxȡ��
	String s_invoice_code = request.getParameter("s_invoice_code");
	String sj_flag = request.getParameter("sj_flag");//Y��ӡ�վ� Nȡ����ӡ�վ�
	String s_flag = "N";//Ĭ�϶����°淢Ʊ ��Ҫ�ֶ���ӡlogo ��ʱ����г���ȷ��
	String bill_code = request.getParameter("bill_code");

    String smop_code = request.getParameter("opCode");
    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA smop_code=" + smop_code);
    if (smop_code == null || smop_code == "") {
        smop_code = "0000";
    }

	//xl add ������֯�ڵ��ѯӪҵ������
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	String s_yyt_name="";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}



	String[] inParam = new String[2];
	inParam[0] ="select a.sm_code,b.sm_name,to_char(a.id_no) from dcustmsg a,ssmcode b where phone_no=: smphoneNo  and substr(run_code,2,1)<'a' and b.region_code=:s_region_code and a.sm_code = b.sm_code ";
	inParam[1] = "smphoneNo="+smphoneNo+",s_region_code="+regionCode;
	
	String payMoney = request.getParameter("payMoney");
	
%>
	<wtc:service name="TlsPubSelBoss"  outnum="3">
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
<%
		if(sm_name_arr!=null&&sm_name_arr.length>0)
		{
			if(sm_name==null||s_sm_code==null||"".equals(sm_name)||"".equals(s_sm_code)){
			    sm_name = sm_name_arr[0][1];
					s_sm_code = sm_name_arr[0][0];
			}
			if(s_id_no==null||"".equals(s_id_no)){
					s_id_no =sm_name_arr[0][2];
			}
			
    }
 
    
	/*xl Ϊ1303����returnPage */

	if(smop_code.equals("1303")){
		returnPage = "s1300_6.jsp";
	}else if(smop_code.equals("b301")){
		returnPage =  "b301.jsp";
	}
	else if(smop_code.equals("d340"))
	{
		returnPage =  "s1300_group.jsp";
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
	String contractno = WtcUtil.repNull(request.getParameter("contractno"));
	String id_no = request.getParameter("id_no");
    String year = total_date.substring(0, 4);
    String month = total_date.substring(4, 6);
    String day = total_date.substring(6, 8);

    String[] inParas = new String[4];
    inParas[0] = workNo;
    inParas[1] = contractno;
    inParas[2] = total_date;
    inParas[3] = payAccept;
	String s_pay_note="";
    String s_xmmc = WtcUtil.repNull(request.getParameter("s_xmmc"));
	String xmdw = WtcUtil.repNull(request.getParameter("xmdw"));
	String ggxh = WtcUtil.repNull(request.getParameter("ggxh"));
	String xmsl = WtcUtil.repNull(request.getParameter("xmsl"));
	String xmdj = WtcUtil.repNull(request.getParameter("xmdj"));
	String hsbz = WtcUtil.repNull(request.getParameter("hsbz"));
	String sl = WtcUtil.repNull(request.getParameter("sl"));
	String se = WtcUtil.repNull(request.getParameter("se"));
	String chbz = WtcUtil.repNull(request.getParameter("chbz"));
	String old_accept = WtcUtil.repNull(request.getParameter("old_accept"));
	String old_ym = WtcUtil.repNull(request.getParameter("old_ym"));
	
	String s_hjbhsje = WtcUtil.repNull(request.getParameter("s_hjbhsje"));
	String hjse = WtcUtil.repNull(request.getParameter("hjse"));
	//���� ���վݵ�����ֵ������λ�ȡ ������
	String[] inPara_sj = new String[29];
	inPara_sj[0]=payAccept;
	inPara_sj[1]="01";
	inPara_sj[2]=op_code;
	inPara_sj[3]=workNo;
	inPara_sj[4]=nopass;
	inPara_sj[5]=smphoneNo;
	inPara_sj[6]="";
	inPara_sj[7]="��ӡ�վ�";
	inPara_sj[8]="";
	inPara_sj[9]=id_no;
	inPara_sj[10]=s_sm_code;
	inPara_sj[11]="r";
	inPara_sj[12]="";
	inPara_sj[13]="";
	inPara_sj[14]=s_xmmc;
	inPara_sj[15]=xmdw;
	inPara_sj[16]=ggxh;
	inPara_sj[17]=xmsl;
	inPara_sj[18]=hsbz;
	inPara_sj[19]=payMoney;
	inPara_sj[20]=sl;
	inPara_sj[21]=se;//˰�� ˰�� ɶ�ĵõ�hanfengȷ��
	inPara_sj[22]=chbz;
	inPara_sj[23]="";
	inPara_sj[24]="";
	inPara_sj[25]=contractno;
	inPara_sj[26]=payMoney;
	inPara_sj[27]=s_hjbhsje;//˰�� ˰���ȷ��
	inPara_sj[28]=hjse;
%>
<!--xl add ����qidxȡ����ƱԤռ�Ľӿ� ��Ϊ��ӡ�վ�Ҳ��Ԥռһ����¼ begin-->
<wtc:service name="bs_sEInvCancel" routerKey="region" routerValue="<%=regionCode%>"  outnum="8" >
		<wtc:param value="<%=inPara_sj[0]%>"/>
		<wtc:param value="<%=inPara_sj[1]%>"/>
		<wtc:param value="<%=inPara_sj[2]%>"/>
		<wtc:param value="<%=inPara_sj[3]%>"/>
		<wtc:param value="<%=inPara_sj[4]%>"/>
		<wtc:param value="<%=inPara_sj[5]%>"/>
		<wtc:param value="<%=inPara_sj[6]%>"/>
		<wtc:param value="<%=inPara_sj[7]%>"/>
		<wtc:param value="<%=inPara_sj[8]%>"/>
		<wtc:param value="<%=inPara_sj[9]%>"/>
		<wtc:param value="<%=inPara_sj[10]%>"/>
		<wtc:param value="<%=inPara_sj[11]%>"/>
		<wtc:param value="<%=inPara_sj[12]%>"/>
		<wtc:param value="<%=inPara_sj[13]%>"/>
		<wtc:param value="<%=inPara_sj[14]%>"/>
		<wtc:param value="<%=inPara_sj[15]%>"/>
		<wtc:param value="<%=inPara_sj[16]%>"/>
		<wtc:param value="<%=inPara_sj[17]%>"/>
		<wtc:param value="<%=inPara_sj[18]%>"/>
		<wtc:param value="<%=inPara_sj[19]%>"/>
		<wtc:param value="<%=inPara_sj[20]%>"/>
		<wtc:param value="<%=inPara_sj[21]%>"/>
		<wtc:param value="<%=inPara_sj[22]%>"/>
		<wtc:param value="<%=inPara_sj[23]%>"/>
		<wtc:param value="<%=inPara_sj[24]%>"/>
		<wtc:param value="<%=inPara_sj[25]%>"/>
		<wtc:param value="<%=inPara_sj[26]%>"/>
		<wtc:param value="<%=inPara_sj[27]%>"/>
		<wtc:param value="<%=inPara_sj[28]%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa bill_cancel is "+bill_cancel+" and bill_cancel.length is "+bill_cancel.length);
		//s_code=bill_cancel[0][1];//sqlͨ��
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			s_flag="0";//���óɹ�
			bill_code =bill_cancel[0][6];
			//s_note="��Ʊȡ��ִ�гɹ�";
			// ԭ�߼� begin
			%>
			<wtc:service name="s1300Print" routerKey="phone" routerValue="<%=smphoneNo%>" outnum="33" >
				<wtc:param value="<%=inParas[0]%>"/>
				<wtc:param value="<%=inParas[1]%>"/>
				<wtc:param value="<%=inParas[2]%>"/>
				<wtc:param value="<%=inParas[3]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
				
		<%
				
				//wtc:service name="s1300Print"  �˷����ɶ�����̹��ã������ǽɷѣ�1300�����еķ���
				String return_code = "999999";
				String temp[]=new String[10];
				String info=new String();
				int record=0;
				if(result!=null&&result.length>0){
					 return_code = result[0][0];
					 
				}
				return_code="000000";
			String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
			System.out.println("return_code===="+return_code);
			if (return_code.equals("000000")) {
					String phoneNo = "";
					s_pay_note ="���η�Ʊ���:(Сд)��"+result[0][9].trim()+",��д���ϼ�:"+result[0][8]+"���ɽ�:"+"<p>"+result[0][11]+"<p>"+result[0][12]+"<p>"+result[0][13];
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
						<%
					}
					if(s_flag.equals("N"))
					{
						%>
							printctrl.DrawImage(localPath,8,10,40,18);//��������
		 
						<%
					}
				%>

				//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
				printctrl.DrawImage(localPath,8,10,40,18);//��������
				printctrl.Print(50, 6, 9, 0, "�������ƶ����޹�˾�ɷ��վ�");
				printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		 
				/*******************************************/
				//printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

				//printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=result[0][1]%>");
				//printctrl.Print(72, 13, 9, 0, "������ˮ��<%=result[0][15]%>");
				<%
					if(ims_flag=="1" ||ims_flag.equals("1"))
					{
						%>
							printctrl.Print(13, 12, 9, 0, "�ͻ�����:<%=userName.trim()%>");
						<%
					}
					else
					{
						%>
							printctrl.Print(13, 12, 9, 0, "�ͻ�����:<%=result[0][4].trim()%>");	
						<%
					}
				%>
				 




				printctrl.Print(13, 13, 9, 0, "ҵ�����:<%=result[0][2]%>");
				<%
					if(i_count_cwt>0)
					{
					%>
					printctrl.Print(125, 13, 9, 0, "�ͻ�Ʒ��:��������");	
					<%
					}
					else
					{
						%>
						printctrl.Print(125, 13, 9, 0, "�ͻ�Ʒ��:<%=sm_name%>");	
						<%
					}
				%>

				printctrl.Print(13, 15, 9, 0, "�û����룺<%=phoneNo%>");	
				printctrl.Print(48, 15, 9, 0, "Э����룺<%=result[0][6]%>");
				printctrl.Print(82, 15, 9, 0, "��������:<%=year+month%>");
				printctrl.Print(115, 15, 9, 0, "��ͬ��:");

				printctrl.Print(115, 16, 9, 0, "֧Ʊ��:<%=result[0][7]%>");
				printctrl.Print(115, 17, 9, 0, "����ͳ������:");//ֻ��opcode=d340��
				printctrl.Print(16, 18, 9, 0, "ͨ�ŷ���Ѻϼ�:");
				printctrl.Print(16, 19, 9, 0, "���η�Ʊ���:(Сд)��<%=result[0][9].trim()%> ��д���ϼ�:<%=result[0][8]%>");
					<%
					if(smop_code.equals("1310")||smop_code.equals("1362"))
					{
					%>
						printctrl.Print(16, 20, 9, 0, "[�˷�]");
		 
					<%
					}
					%>

				printctrl.Print(16, 21, 9, 0, "<%=result[0][11]%>");//��ע 
				printctrl.Print(16, 22, 9, 0, "<%=result[0][12]%>");//��ע 
				printctrl.Print(16, 23, 9, 0, "<%=result[0][13]%>");//��ע 

				
				/********tianyang add at 20090928 for POS�ɷ�����****start*****/
			 /* result[0][17] Ϊ "1"  ��pos�ɷ�(����) */
			 <%if (result[0][17] != null && result[0][17].equals("1")) {%>
						printctrl.Print(16, 27, 8, 0, "<%=result[0][18].trim()%>");/*�̻����ƣ���Ӣ��)*/
						printctrl.Print(16, 28, 8, 0, "<%=result[0][29].trim()%>");/*���׿��ţ����Σ�*/
						printctrl.Print(73, 28, 8, 0, "<%=result[0][19].trim()%>");/*�̻�����*/
						printctrl.Print(119, 28, 8, 0, "<%=result[0][24].trim()%>");/*���κ�*/
						printctrl.Print(16, 29, 8, 0, "<%=result[0][21].trim()%>");/*�����к�*/
						printctrl.Print(73, 29, 8, 0, "<%=result[0][20].trim()%>");/*�ն˱���*/
						printctrl.Print(119, 29, 8, 0, "<%=result[0][27].trim()%>");/*��Ȩ��*/
						printctrl.Print(13, 30, 8, 0, "<%=result[0][25].trim()%>");/*��Ӧ����ʱ��*/
						printctrl.Print(73, 30, 8, 0, "<%=result[0][26].trim()%>");/*�ο���*/
						printctrl.Print(119, 30, 8, 0, "<%=result[0][28].trim()%>");/*��ˮ��*/
						printctrl.Print(13, 31, 8, 0, "<%=result[0][22].trim()%>");/*�յ��к�*/
						printctrl.Print(119, 31, 8, 0, "ǩ�֣�");
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
			    var sj_flag = "<%=sj_flag%>";
			//	alert("sj_flag is "+sj_flag);
				if(sj_flag=="Y")
				{
				//	alert("����ӡ");
					printInvoice();
					document.location.replace("<%=returnPage%>");
				}
				else
				{
				//	alert("������ӡ");
					document.location.replace("<%=returnPage%>");
				}
				
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
						}else{
		%>
							<script language="JavaScript">
								rdShowMessageDialog("�վݴ�ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.�������:"+"<%=return_code%>!",0);
								document.location.replace("<%=returnPage%>");
							</script>
		<%
						}
				} else {//s1300Print�������ʧ��
		%>
				<script language="JavaScript">
					rdShowMessageDialog("s1300Print ��ӡ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'",0);
					document.location.replace("<%=returnPage%>");
				</script>
		<%
			}
			 
			// end ԭ�߼�
		}
		else
		{
			s_flag="1";
			%>
			<script language="JavaScript">
				rdShowMessageDialog("��ƱԤռʧ��!",0);
				document.location.replace("<%=returnPage%>");
			</script>
			<%
			//s_note=bill_cancel[0][1];
		}
		
	}
	else
	{
		s_flag="1";//sql�����쳣
		//s_note="��Ʊȡ��ִ���쳣";
	}
	%>
<!--end of ����qidxȡ��Ԥռ�ӿ�-->
 

	
 

<%
  /*
   * ����:�һ���Ʊ1321
   * �汾: 1.0
   * ����: 2009/1/16
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%@ page import="java.text.*" %>
<script language="javascript">
		
	</script>
<%
	String groupId = (String)session.getAttribute("groupId");
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

	String opCode = "1321";
	String opName = "�վݶһ������ѷ�Ʊ ";
	MoneyUtil mon = new MoneyUtil();
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = (String)request.getParameter("phoneNo");
	
	String i_contract_no = request.getParameter("contract_no");
	String i_year_month = request.getParameter("year_month");
	String i_year_month_end = request.getParameter("year_month_end");
	String i_begin_ym = request.getParameter("begin_ym");
	String i_begin_ym_end =request.getParameter("begin_ym_end");
	String nopass = (String)session.getAttribute("password");
	// xl add for ��Ʊ���� begin
	String check_seq="";//request.getParameter("check_seq");
	String s_flag =  "";//request.getParameter("s_flag"); 
	long ll =0;// Long.parseLong(check_seq)+1; 
	
	String str = "";//ll+"";
	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS ll is "+ll+" and str is "+str);

	//xl add 
	String d_pay = request.getParameter("d_pay");
	String wpay_yikaiju = request.getParameter("wpay_yikaiju");


	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";//bill_accept
	String i_login_accept = "";
	String loginAccept="";

	String d1 ="";
	%>
	 
 
	
<%	
   
	String return_code = "0";
	boolean canPrint = false;
    boolean canPrint2 = false;
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8);
	
 

	String[] inParas = new String[6];
	inParas[0] = i_contract_no;
	inParas[1] = i_year_month;
	inParas[2] = i_year_month_end;
	inParas[3] = i_begin_ym;
	inParas[4] = i_begin_ym_end;
	inParas[5] =workno;
 
   //System.out.println("-------------------------zss--------------------------"+ inParas[5]);
   
    //retList = impl.callFXService("s1322Init", inParas, "16");
%>
	<wtc:service name="s1322Init" routerKey="region" routerValue="<%=regionCode%>" outnum="18" retcode="retCode1" retmsg="retMsg1">
		<wtc:params value="<%=inParas%>"/>
	</wtc:service>
	<wtc:array id="out_result0" start="0" length="1" scope="end"/>
	<wtc:array id="out_result1" start="1" length="1" scope="end"/>
	<wtc:array id="out_result2" start="3" length="1" scope="end"/>
	<wtc:array id="out_result3" start="4" length="1" scope="end"/>
	<wtc:array id="out_result4" start="5" length="1" scope="end"/>
	<wtc:array id="out_result5" start="5" length="1" scope="end"/>
	<wtc:array id="out_result6" start="6" length="1" scope="end"/>
	<wtc:array id="out_result7" start="7" length="1" scope="end"/>
	<wtc:array id="out_result8" start="8" length="1" scope="end"/>
	<wtc:array id="out_result9" start="9" length="1" scope="end"/>
	<wtc:array id="out_result10" start="10" length="1" scope="end"/>
	<wtc:array id="out_result11" start="11" length="1" scope="end"/>
	<wtc:array id="out_result12" start="12" length="1" scope="end"/>
	<wtc:array id="out_result13" start="13" length="1" scope="end"/>
	<wtc:array id="out_result14" start="14" length="1" scope="end"/>
	<wtc:array id="out_result15" start="15" length="1" scope="end"/>
	<wtc:array id="out_result16" start="16" length="2" scope="end"/>
<%
	if (out_result0.length!=0) {
	   //out_result0 = (String[][])retList.get(0);     
	   return_code = out_result0[0][0];
	}
        
  if (retCode1.equals("000000")) {
        canPrint = true;
	 }	 	 
%>

<%if (!canPrint) {%>
   <script language="JavaScript">
     rdShowMessageDialog("<%=retMsg1%>! ");
     window.location="s1321_2.jsp";
   </script>
<% } else {%>
<SCRIPT language="JavaScript">
<!--
function ifprint(){
	//alert("out_result15 is "+"<%=out_result15[0][0]%>"+" and out_result14 is "+"<%=out_result14[0][0]%>");
	//��15�������� SUCCESS
	printInDB();
 }

<%
    ///liuxmc add  ��Ʊ���ӻ���������� ��ʼ
%>
    function printInDB(){
<%
      String i_paymoney = request.getParameter("paymoney");
      double yingsou = 0.00;  
      double i_money_small =  Double.parseDouble(i_paymoney) - yingsou;
	  String s_money_small	= "";
      
    	String[] inParas0 = new String[15];
			inParas0[0] = realKey+"";
			inParas0[1] = loginAccept;
			inParas0[2] = opCode;
	    inParas0[3] = workno;
	    inParas0[4] = dateStr;
	    inParas0[5] = out_result8[0][0].trim();//�������
	    inParas0[6] = out_result9[0][0].trim();
	    String sm_name="";
	    if(sm_name == null || sm_name.trim().length() == 0){
	    	sm_name = "Ʒ�ƣ�";
	    }
	    inParas0[7] = sm_name;
	    inParas0[8] = mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
	    inParas0[9] = out_result12[0][0].trim();
	    inParas0[10] = out_result15[0][0].trim();
	    inParas0[11] = mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
		inParas0[12] = "�Żݣ�"+out_result3[0][0]+" ʵ�գ�"+out_result6[0][0];
		inParas0[13] = "ӪҵԱ������" + workname;
		inParas0[14] = out_result3[0][0].trim();
%>
		 
		try {
         <%	
         
         
         //String[][] result0 = new String[][]{};
         //String[][] result1 = new String[][]{};
         //String[][] result2 = new String[][]{};
         String cust_name = out_result7[0][0];
         System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCc out_result6.length is "+out_result6.length);
         for (int i=0;i<out_result6.length;i++) {
 
//����ϵͳ��ˮ
	String sql_accept = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
	%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
			<wtc:sql><%=sql_accept%></wtc:sql>
			</wtc:pubselect>
	<wtc:array id="count1_new" scope="end" />	
	<%
		 
		if(count1_new.length>0)
		{
			i_login_accept = count1_new[0][0].trim();
			inParas0[1]=i_login_accept;
		}
			loginAccept=i_login_accept;
           yingsou += Double.parseDouble(out_result6[i][0]);
           String i_contract = request.getParameter("contract");
           String i_year = request.getParameter("year");
           String i_accept = request.getParameter("accept");
           String i_work_no = request.getParameter("work_no");
           
		   double d_money_small =  Double.parseDouble(i_paymoney) - yingsou;
		   s_money_small=""+d_money_small;
	       d1 =(new DecimalFormat("0.00")).format(Double.parseDouble(s_money_small) );
          //�����������µ���ϸ
           if(i==0){ 
           inParas = new String[6];
           inParas[0] = i_contract;
           inParas[1] = out_result1[i][0];
           inParas[2] = i_work_no;
           inParas[3] = i_accept;
           inParas[4] = i_year;
           inParas[5] = nopass;
		   System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! here?");
         }else{ 
           inParas = new String[6];
           inParas[0] = i_contract;
           inParas[1] = out_result1[i][0];
           inParas[2] = i_work_no;
           inParas[3] = "";
           inParas[4] = i_year;
           inParas[5] = nopass;
		   System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! there~~~");
         }
           System.out.println("inParas[0] is "+i_contract+" inParas[1] is "+out_result1[i][0]+" inParas[2] is "+i_work_no+" inParas[3] is "+i_accept+" inParas[4] is "+i_year +" inParas[5] is "+nopass);
         	 
           //retList = impl.callFXService("s1322Cfm", inParas, "5");
         %>
         	<wtc:service name="s1322Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode2" retmsg="retMsg2">
         		<wtc:param value="<%=inParas[0]%>"/>
				<wtc:param value="<%=inParas[1]%>"/>
				<wtc:param value="<%=inParas[2]%>"/>
				<wtc:param value="<%=inParas[3]%>"/>
				<wtc:param value="<%=inParas[4]%>"/>
				<wtc:param value="<%=inParas[5]%>"/>
         	</wtc:service>
         	<wtc:array id="result0"  start="0" length="1" scope="end"/>
         	<wtc:array id="result1"  start="1" length="1" scope="end"/>
         	<wtc:array id="result2"  start="2" length="1" scope="end"/>
         	<wtc:array id="result3"  start="3" length="1" scope="end"/>
         	
         <%
         System.out.print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+retCode1);
         	String return_code2 = retCode2;
         	String return_msg2  = retMsg2;
			String i_money=mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
			
         	if (return_code2.equals("000000")||return_code2.equals("0")) {
         	    canPrint2 = true;
				%>
				//window.location="s1321_2printNew.jsp?contract_no="+"<%=i_contract_no%>"+"&year_month="+"<%=i_year_month%>"+"&year_month_end="+"<%=i_year_month_end%>"+"&begin_ym="+"<%=i_begin_ym%>"+"&begin_ym_end="+"<%=i_begin_ym_end%>"+"&phoneNo="+"<%=phoneNo%>"+"&i_money="+"<%=i_money%>"+"&cust_name="+"<%=cust_name%>"+"&i_money_small="+"<%=i_money_small%>"+"&check_seq="+"<%=str%>"+"&s_flag="+"<%=s_flag%>"+"&wpay_yikaiju="+"<%=wpay_yikaiju%>"+"&d_pay="+"<%=d_pay%>";
				<%
         	}
         	if (!canPrint2) {%>
         	    
         	     rdShowMessageDialog("��ӡʧ��! ,����ԭ��"+"<%=return_msg2%>");
         	     window.location="s1321_2.jsp";
         	 return false;
         	<%
         		
         	}
			else
			{%>
				   <!--xl add ��ƱԤռ-->
					<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="8" >
							 
							<wtc:param value="<%=loginAccept%>"/>
							<wtc:param value="<%=opCode%>"/>
							<wtc:param value="<%=workno%>"/>
							<wtc:param value=""/><!--op_time-->
							<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value="0"/><!--id_no-->
							<wtc:param value="<%=i_contract_no%>"/>
							<wtc:param value=""/><!--s_check_num-->
							<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
							<wtc:param value=""/><!--��Ʊ���� ��-->
							<wtc:param value=""/><!--sm_code-->
							<wtc:param value="<%=out_result6[i][0].trim()%>"/><!--Сд���-->
							<wtc:param value=""/><!--��д���-->
							<wtc:param value=""/><!--��ע-->
						 
							<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/><!--����-->
							<wtc:param value="<%=cust_name%>"/><!--����ģ�-->
							<wtc:param value="0"/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value="<%=regionCode%>"/>
							<wtc:param value="<%=groupId%>"/>	
							<wtc:param value="3"/>
					</wtc:service>
					<wtc:array id="bill_opy" scope="end"/> 	
					<%
						if(bill_opy!=null&&bill_opy.length>0)
						{
							return_flag=bill_opy[0][0];
							if(return_flag.equals("000000"))
							{
								 ocpy_begin_no=bill_opy[0][2];
								 ocpy_end_no=bill_opy[0][3];
								 ocpy_num=bill_opy[0][4];
								 res_code=bill_opy[0][5];
								 bill_code=bill_opy[0][6];
								 bill_accept=bill_opy[0][7];
								  
							}
							else
							{
								return_note=bill_opy[0][1];
								%>
									<script language="javascript">
										alert("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
										history.go(-1);
									</script>
								<%
							}
						}
					%>
					if(rdShowConfirmDialog("��ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ��Ʊ?")==1)
					{
						//alert("1 ����ִ��");
					}
					else
					{
						alert("����ȡ���ӿ� ȡ��Ԥռ");
						return false;
					}
				   <%
				   
				   out.println("printctrl.Setup(0)");
				   out.println("printctrl.StartPrint()");
				   out.println("printctrl.PageStart()");
					 
					   //new begin
					%>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%
				   
				   out.println("printctrl.Print(20, 7, 9, 0,'"+year+month+day+"')");
				   out.println("printctrl.Print(85, 7, 9, 0,'�ʵ�ͨ��ҵ')");	
				   out.println("printctrl.Print(110,7, 9, 0,'��Ʊ����:"+ocpy_begin_no+"')");
				   
				   out.println("printctrl.Print(13, 9, 9, 0,'"+"��α�룺"+ran+"')");

				   out.println("printctrl.Print(13, 10, 9, 0,'"+"��    �ţ�"+i_work_no+"')");
				   out.println("printctrl.Print(72, 10, 9, 0,'"+"������ˮ��"+loginAccept+"')");
				   out.println("printctrl.Print(115, 10, 9, 0,'ҵ�����ƣ��վݶһ������ѷ�Ʊ')");	
				 
				   out.println("printctrl.Print(13, 11, 9, 0,'�ͻ����ƣ�"+out_result7[0][0]+"')");	
				   out.println("printctrl.Print(115, 11, 9, 0,'��    �ţ�')");	
			 
				   out.println("printctrl.Print(13, 12, 9, 0,'�ֻ����룺"+out_result8[0][0]+"')");
				   out.println("printctrl.Print(72, 12, 9, 0,'Э����룺"+out_result9[0][0]+"')");
				   out.println("printctrl.Print(115, 12, 9, 0,'֧Ʊ���룺')");
				  
				   out.println("printctrl.Print(13, 13, 9, 0,'�ϼƽ�(��д)"+mon.NumToRMBStr(Double.parseDouble(out_result6[i][0]))+"')");
				   out.println("printctrl.Print(115, 13, 9, 0,'(Сд)��"+out_result6[i][0].trim()+"')");
				   out.println("printctrl.Print(13, 14, 9, 0,'(��Ŀ)')");
				   //add
				   out.println("printctrl.Print(13, 15, 9, 0,'"+result3[0][0]+"')");
				 
				   out.println("printctrl.Print(13, 16, 9, 0,'Ӧ�գ�')");
					// add 1
					int rownumber = 13; //������
					int colnumber = 17; //������
					ArrayList r1 = new ArrayList();
				   ArrayList r2 = new ArrayList();
				   
				 
				   for (int j = 0; j < result1.length; j++) {
					   if (!(result2[j][0].trim()).equals("0.00")) {
						  r1.add(result1[j][0]);
						  r2.add(result2[j][0]);
					  } 
				   }
				   
				   if (!(out_result4[i][0].trim()).equals("0.00")) {
					   r1.add("���ɽ�");
					   r2.add(out_result4[i][0]);
				   }
				 
				   if (!(out_result5[i][0].trim()).equals("0.00")) {
					   r1.add("��������");
					   r2.add(out_result5[i][0]);
				   }
				   
				   for (int j = 0; j < r1.size(); j++) {
					  out.println("printctrl.Print("+rownumber+","+colnumber+",9,0,'"+((String)r1.get(j)).trim()+": "+((String)r2.get(j)).trim()+"')");
					 rownumber += 45;
					   
					 if (j%3 == 2) {
						colnumber += 1;
						rownumber = 13;
					 }
				   }
		   
				   out.println("printctrl.Print(13,"+(colnumber+2)+",9,0,'"+"�Żݣ�" + out_result3[i][0] +"')");
				   out.println("printctrl.Print(13,"+(colnumber+4)+",9,0,'"+"ʵ�գ�"+ out_result6[i][0] +"')");
					// end add 1
				 
				   out.println("printctrl.Print(13, 25, 9, 0,'��Ʊ��"+workname+"')");
				   out.println("printctrl.Print(37, 25, 9, 0,'�տ')");
				   out.println("printctrl.Print(60, 25, 9, 0,'���ˣ�')");	
				   //new end
				   out.println("printctrl.PageEnd()");
				   out.println("printctrl.StopPrint()");
			}
			//xl add
			%>
			//alert("�ڼ��Σ�");
				<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:param value="<%=loginAccept%>"/>
						<wtc:param value="1321"/>
						<wtc:param value="<%=workno%>"/>
						<wtc:param value=" "/>
						<wtc:param value="<%=phoneNo%>"/>
						<wtc:param value="0"/> 
						<wtc:param value="<%=i_contract_no%>"/> 
						<wtc:param value=""/>
						<wtc:param value="<%=ocpy_begin_no%>"/>
						<wtc:param value="<%=bill_code%>"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=out_result6[i][0].trim()%>"/>
						<wtc:param value="<%=mon.NumToRMBStr(Double.parseDouble(out_result6[i][0]))%>"/>
						<wtc:param value="1321��Ʊ�һ�"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value=""/> 
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=groupId%>"/>
						<wtc:param value="3"/>
						<wtc:param value="0"/>
					</wtc:service>
					<wtc:array id="RetResult" scope="end"/>	
					<%
					String returnPage="s1321_3.jsp";
					String[][] result2_in_db = new String[][]{};
					System.out.println("====ִ�� s1300PrintInDB ����=======");
					if(RetResult.length > 0)
					{
						result2_in_db = RetResult;
						if((result2_in_db[0][0]!="000000")&&!result2_in_db[0][0].equals("000000"))
						{
							%>
							 
									rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
									document.location.replace("<%=returnPage%>");
							 
					<%			
						}
						
					}
					else if(RetResult == null || RetResult.length == 0){
			%>
								 
									rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
									document.location.replace("<%=returnPage%>");
			 
			<%			
					}
						
					//////////////////////////////////////////////
				else{
			%> 
									rdShowMessageDialog("��Ʊ��ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.<br>��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
									document.location.replace("<%=returnPage%>");
							 
			<%
					}
					 
			 
						//xl add ���ӻ���� end

				//end of ��� sinvoiceInDB
			//end of ���ѷ�Ʊѭ��
         }

		 //����ϵͳ��ˮ
		String sql_accept1 = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
		%>
		<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
				<wtc:sql><%=sql_accept1%></wtc:sql>
				</wtc:pubselect>
		<wtc:array id="count1_new1" scope="end" />	
		<%
			 
			if(count1_new1.length>0)
			{
				i_login_accept = count1_new1[0][0].trim();
		 
			}
			 //��ӡʣ���
		%>
		
		 <!--xl add ��ƱԤռ-->
					<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="8" >
							 
							<wtc:param value="<%=loginAccept%>"/>
							<wtc:param value="<%=opCode%>"/>
							<wtc:param value="<%=workno%>"/>
							<wtc:param value=""/><!--op_time-->
							<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value="0"/><!--id_no-->
							<wtc:param value="<%=i_contract_no%>"/>
							<wtc:param value=""/><!--s_check_num-->
							<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
							<wtc:param value=""/><!--��Ʊ���� ��-->
							<wtc:param value=""/><!--sm_code-->
							<wtc:param value="<%=d1%>"/><!--Сд���-->
							<wtc:param value=""/><!--��д���-->
							<wtc:param value=""/><!--��ע-->
						 
							<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/><!--����-->
							<wtc:param value="<%=cust_name%>"/><!--����ģ�-->
							<wtc:param value="0"/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value="<%=regionCode%>"/>
							<wtc:param value="<%=groupId%>"/>	
							<wtc:param value="3"/>
						 
					</wtc:service>
					<wtc:array id="bill_opy" scope="end"/> 	
					<%
						if(bill_opy!=null&&bill_opy.length>0)
						{
							return_flag=bill_opy[0][0];
							if(return_flag.equals("000000"))
							{
								 ocpy_begin_no=bill_opy[0][2];
								 ocpy_end_no=bill_opy[0][3];
								 ocpy_num=bill_opy[0][4];
								 res_code=bill_opy[0][5];
								 bill_code=bill_opy[0][6];
								 bill_accept=bill_opy[0][7];
								  
							}
							else
							{
								return_note=bill_opy[0][1];
								%>
									<script language="javascript">
										alert("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
										history.go(-1);
									</script>
								<%
							}
						}
					%>
					if(rdShowConfirmDialog("ʣ�෢Ʊ�ĵ�ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ��Ʊ?")==1)
					{
						alert("1 ����ִ��");
					}
					else
					{
						alert("����ȡ���ӿ� ȡ��Ԥռ");
						return false;
					}
				    <%
					out.println("printctrl.Setup(0)");
					out.println("printctrl.StartPrint()");
					out.println("printctrl.PageStart()");
			 
				  %>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%

				  out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
				  out.println("printctrl.Print(85, 10, 9, 0,'�ʵ�ͨ��ҵ')");
				  out.println("printctrl.Print(110, 8, 9, 0,'��Ʊ����:"+ocpy_begin_no+"')"); 		
					

				  out.println("printctrl.Print(13, 10, 9, 0,'"+"��    �ţ�"+workno+"')");
				  out.println("printctrl.Print(72, 10, 9, 0,'"+"������ˮ��"+i_login_accept+"')");
				  out.println("printctrl.Print(1115, 10, 9, 0,'ҵ�����ƣ��վݶһ������ѷ�Ʊ')");

				 
				  out.println("printctrl.Print(13, 11, 9, 0,'�ͻ����ƣ�"+ cust_name +"')");	
				  out.println("printctrl.Print(115, 11, 9, 0,'��    �ţ�')");	
			 
				  out.println("printctrl.Print(13, 12, 9, 0,'�ֻ����룺"+phoneNo+"')");
				  out.println("printctrl.Print(72, 12, 9, 0,'Э����룺"+i_contract_no+"')");
				  out.println("printctrl.Print(115, 12, 9, 0,'֧Ʊ���룺')");
				  
				  out.println("printctrl.Print(13, 13, 9, 0,'�ϼƽ�(��д)"+mon.NumToRMBStr(Double.parseDouble(d1))+"')");
				  
				  out.println("printctrl.Print(115, 13, 9, 0,'(Сд)��"+d1+"')");
				  out.println("printctrl.Print(13, 14, 9, 0,'(��Ŀ)')");
				  out.println("printctrl.Print(13, 15, 9, 0,'����Ʊʱ����Ʊ')");
				  
				  //xl add Ӫ����
			 
				  out.println("printctrl.Print(13, 25, 9, 0,'��Ʊ��"+workname+"')");
				  out.println("printctrl.Print(32, 25, 9, 0,'�տ')");
				  out.println("printctrl.Print(60, 25, 9, 0,'���ˣ�')");
				// end
			
				out.println("printctrl.PageEnd()");
				out.println("printctrl.StopPrint()");
					
					//��������
					%>
					<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:param value="<%=loginAccept%>"/>
						<wtc:param value="1321"/>
						<wtc:param value="<%=workno%>"/>
						<wtc:param value=" "/>
						<wtc:param value="<%=phoneNo%>"/>
						<wtc:param value="0"/> 
						<wtc:param value="<%=i_contract_no%>"/> 
						<wtc:param value=""/>
						<wtc:param value="<%=ocpy_begin_no%>"/>
						<wtc:param value="<%=bill_code%>"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=d1%>"/>
						<wtc:param value=""/>
						<wtc:param value="1321��Ʊ�һ�"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value=""/> 
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=groupId%>"/>
						<wtc:param value="3"/>
						<wtc:param value="0"/>
					</wtc:service>
					<wtc:array id="RetResult" scope="end"/>	
					<%
					String returnPage="s1321_3.jsp";
					String[][] result2_in_db = new String[][]{};
					System.out.println("====ִ�� s1300PrintInDB ����=======");
					if(RetResult.length > 0)
					{
						result2_in_db = RetResult;
						if((result2_in_db[0][0]!="000000")&&!result2_in_db[0][0].equals("000000"))
						{
							%>
							 
									rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
									document.location.replace("<%=returnPage%>");
							 
					<%			
						}
						
					}
					else if(RetResult == null || RetResult.length == 0){
			%>
								 
									rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
									document.location.replace("<%=returnPage%>");
			 
			<%			
					}
						
					//////////////////////////////////////////////
				else{
			%> 
									rdShowMessageDialog("��Ʊ��ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.<br>��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
									document.location.replace("<%=returnPage%>");
							 
			<%
					}
					 
			 
						//xl add ���ӻ���� end
				%>
	
					rdShowMessageDialog("��ӡ�ɹ�!");
					document.location.replace("s1321_1.jsp");
         } catch(e) {
         } finally {
         }
		
		 
         
         }
 
		 
	<%
 
 

 	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1
		+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept
		+"&pageActivePhone="+i_contract_no+"&opBeginTime="+opBeginTime+"&contactId="+i_contract_no+"&contactType=acc";
	System.out.println(url);
%>
	<jsp:include page="<%=url%>" flush="true" />
-->

</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>

<% } 
 
%>
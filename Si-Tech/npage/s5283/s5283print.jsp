	 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-22 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	String regionCode = (String)session.getAttribute("regCode"); 
	
	String total_date = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String total_date2 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
	String agt_phone = request.getParameter("agt_phone");
	String acceptStr = request.getParameter("acceptStr");
%>
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	String loginAccept = seq;
    String cust_phone = request.getParameter("cust_phone");
	String print_ym = request.getParameter("print_ym");
	String begin_date = request.getParameter("begin_date");
	String end_date = request.getParameter("end_date");
	String print_type = request.getParameter("print_type");
	String sel_type = request.getParameter("sel_type");
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	//SPubCallSvrImpl co=new SPubCallSvrImpl();
	String sm_name=" ";
	String smSql = "select decode(sm_code,'zn','������','gn','ȫ��ͨ','dn','���еش�') from dcustmsg where phone_no= '"  + agt_phone + "' and substr(run_code,2,1)<'a'";
	//ArrayList arrsm = co.sPubSelect("1", smSql);
	%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:sql><%=smSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="sm_name_arr" scope="end" />	
	<%
 	//String[][] sm_name_arr= (String[][])arrsm.get(0);
 	if(sm_name_arr!=null&&sm_name_arr.length>0){
 		sm_name=sm_name_arr[0][0];
 	}
	String returnPage = "s5283.jsp";    
 	if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}
	
	String workno=(String)session.getAttribute("workNo");    //���� 
    String workname =(String)session.getAttribute("workName");//��������  
	String org_code =  (String)session.getAttribute("orgCode");
		
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	String[] inParas = new String[9];
	inParas[0] = workno;
	inParas[1] = acceptStr;
	inParas[2] = agt_phone;
	inParas[3] = cust_phone;
	inParas[4] = print_ym;
	inParas[5] = begin_date;
	inParas[6] = end_date;
	inParas[7] = print_type;
	inParas[8] = sel_type;
	int [] lens ={1,16};
  System.out.println("-------------------------------"+cust_phone);
 	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) ,  "s5283Cfm","17", lens , inParas);
 	%>
 	<wtc:service name="sInvoiceMinDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
		<wtc:param value="<%=workno%>"/>		
	</wtc:service>	
	<wtc:array id="result_new"  scope="end"/>
	<%
	//xl add for gaoap����
	String[][] result1Size  = null ;
	String return_code2="";
	String error_msg2 ="";
	String page_num = "";
	if(result_new!=null&&result_new.length>0){
		int lengths = result_new.length;
		result1Size=result_new;
		return_code2 = result1Size[0][0];
		//error_msg2 = result1Size[0][1];
		error_msg2 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code2));
		page_num = result1Size[0][2];
		//����ȡ������������˭�Ƚ�?result_new.length
		System.out.println("return_code="+return_code2+"  error_msg:"+error_msg2+" and size is "+page_num);
		//xl ����gaoap���� ��page_num �� result_new.length���бȽ�
		if( lengths > Integer.parseInt(page_num) )
		{
			%>
				 <script language="JavaScript">
					rdShowMessageDialog("���յ���Ŀ�����Ѿ�¼��ķ�Ʊ��Ŀ����¼���㹻���������ķ�Ʊ����!",0);
					document.location.replace("s5283.jsp");
				 </script>
			<%
		}
	}
	else
	{
		%>
			<script language="JavaScript">
					rdShowMessageDialog("����sInvoiceMinDB����ʧ��",0);
					//document.location.replace("<%=returnPage%>");
			 </script>
		<%
	}
	
	%>	
	 
		 

 	<wtc:service name="s5283Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="17" >
		<wtc:params value="<%=inParas%>"/>		
	</wtc:service>	
	<wtc:array id="result5238" start="0" length="1" scope="end"/>
	<wtc:array id="result5238_1" start="1" length="16" scope="end"/>	
	
 	<%
 	String url = "/npage/contact/onceCnttInfo.jsp?opCode=5283&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName=������ӡ��Ʊ&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+cust_phone+"&opBeginTime="+opBeginTime+"&contactId="+agt_phone+"&contactType=user";
 	System.out.println("url================"+url);
 	System.out.println("result5238================"+result5238.length);
 	System.out.println("result5238_1================"+result5238_1.length);
 	//ArrayList list  = value.getList();
 	String[][] result  = null ;
 	String[][] result1  = null ;
	String return_code="";
	String error_msg ="";
	//result = (String[][])list.get(0);
	//result1=(String[][])list.get(1);
	if(result5238!=null&&result5238.length>0){
		result=result5238;
		return_code = result[0][0];
		error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
		System.out.println("return_code="+return_code+"  error_msg:"+error_msg);
	}
	if(result5238_1!=null&&result5238_1.length>0){
		result1=result5238_1;
	}
	
	//return_code = result[0][0];
	
%>
<html>
	<body>
		<OBJECT
		classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
		codebase="/ocx/printatl.dll#version=1,0,0,1"
		id="printctrl"
		style="DISPLAY: none"
		VIEWASTEXT
		>
		</OBJECT>
	</body>
</html>
<SCRIPT language="JavaScript">
<%

//System.out.println("result1.length=====================:"+result1.length);

if(return_code.equals("000000")){
	if(result1!=null&&result1.length>0){
		int i=0;
		for(i = 0; i < result1.length; i++)
		{
				System.out.println("in for!");
		%>
				//alert("��"+<%=i+1%>+"��");
		    	printctrl.Setup(0) ;
				printctrl.StartPrint();
				printctrl.PageStart();
				// new begin
				printctrl.Print(20, 10, 9, 0, "<%=result1[i][2].substring(0,4)%>"+"<%=result1[i][2].substring(4,6)%>"+"<%=result1[i][2].substring(6,8)%>");
				printctrl.Print(50, 10, 9, 0, "�ʵ�ͨ��ҵ");
				printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

				printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=workno%>");

				printctrl.Print(42, 13, 9, 0, "������ˮ��<%=result1[i][14]%>");
				printctrl.Print(65, 13, 9, 0, "ҵ�����ƣ�<%=result1[i][1]%>");
				printctrl.Print(13, 14, 9, 0, "�ͻ����ƣ�<%=result1[i][3]%>");
				printctrl.Print(65, 14, 9, 0, "��    �ţ�"); 
				printctrl.Print(13, 15, 9, 0, "�ֻ����룺<%=result1[i][4]%>");
				printctrl.Print(33, 15, 9, 0, "Ʒ�ƣ�<%=result1[i][6]%>");
				printctrl.Print(42, 15, 9, 0, "Э����룺<%=result1[i][5]%>");
				printctrl.Print(65, 15, 9, 0, "֧Ʊ���룺");

				printctrl.Print(13, 16, 9, 0, "�ϼƽ�(��д)<%=result1[i][7]%>");
				printctrl.Print(65, 16, 9, 0, "(Сд)��<%=result1[i][8].trim()%>");
				
				printctrl.Print(13, 17, 9, 0, "(��Ŀ)");
				printctrl.Print(13, 19, 9, 0, "<%=result1[i][9]%>");
				printctrl.Print(13, 20, 9, 0, "<%=result1[i][10]%>");
				printctrl.Print(13, 21, 9, 0, "<%=result1[i][11]%>");
				printctrl.Print(13, 22, 9, 0, "<%=result1[i][12]%>");
				printctrl.Print(13, 23, 9, 0, "<%=result1[i][13]%>");

				printctrl.Print(13, 30, 10, 0, "��Ʊ��<%=workname%>");
				printctrl.Print(37, 30, 10, 0, "�տ");
				printctrl.Print(65, 30, 10, 0, "���ˣ�");
				// new end
				 
		 		printctrl.PageEnd() ;
				printctrl.StopPrint() ; 
				
			<%
			  }
			%>
			rdShowMessageDialog("������ӡ��Ʊ�ɹ�,��ӡ������"+<%=i%>+"��",2);
			document.location.replace("<%=returnPage%>");
		<%
		}
		else{
		%>
			rdShowMessageDialog("��ӡʧ�ܣ�û���ҵ����������ĽɷѼ�¼��",0);
			document.location.replace("<%=returnPage%>");
		<%
		}
}
else
{
%>
 <script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
 <script language="JavaScript">
		rdShowMessageDialog("��Ʊ��ӡ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��",0);
		document.location.replace("<%=returnPage%>");
 </script>
<%
	}
%>
</script>
<jsp:include page="<%=url%>" flush="true" />
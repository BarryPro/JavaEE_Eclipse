<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	  String opCode = "1240";
	  String opName = "��ת����";	
	  
	  request.setCharacterEncoding("GBK");
		String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
		String loginAccept=WtcUtil.repNull(request.getParameter("loginAccept"));
		String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
		String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
		String user_id=WtcUtil.repNull(request.getParameter("user_id"));
		String next_no=WtcUtil.repNull(request.getParameter("next_no"));
	  String op_type=WtcUtil.repNull(request.getParameter("s_optype"));
		String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	 	String callType=WtcUtil.repNull(request.getParameter("callType"));
	 	
	 	System.out.println("callType:" + callType);
	 	
		String work_no = (String)session.getAttribute("workNo");
		String loginName = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String op_code = "1240";
		String nopass = (String)session.getAttribute("password");
		String iUserPwd = "";  /*��������*/
		String iChnSource = "01"; /*������ʶ*/
 		String paraStr[]=new String[16];
		paraStr[0]=loginAccept;		//��ˮ(�������룬������������ڷ�����ȡ��ˮ)    
		paraStr[1]=iChnSource;		/*������ʶ*/                   
		paraStr[2]=op_code;			//���ܴ���                                                       
		paraStr[3]=work_no;			//��������                                                       
		paraStr[4]=nopass;		//�������ܵĹ������� 
		paraStr[5]=srv_no;			//�û��ֻ����� 
		paraStr[6]=iUserPwd;			/*��������*/                                          
		paraStr[7]=org_code;			//�������Ź���                                                                                             
		paraStr[8]=op_type;		    //��������(1_����, 0_	ȡ��)                                      
		paraStr[9]=callType;		//�������()                                                     
		paraStr[10]=next_no;		//��ת����                                                           
		paraStr[11]=WtcUtil.repNull(request.getParameter("oriHandFee"));			//Ӧ��           
		paraStr[12]=WtcUtil.repNull(request.getParameter("t_handFee"));			//ʵ��                
		paraStr[13]=WtcUtil.repNull(request.getParameter("t_sys_remark"));		//ϵͳ��ע           
		paraStr[14]=WtcUtil.repSpac(request.getParameter("t_op_remark")); 			//�û���ע                                  
		paraStr[15]=request.getRemoteAddr();			//IP��ַ    
	
	  //String [] fg=im1210.callService("s1240Cfm",paraStr,"1","phone",srv_no);
%>
		<wtc:service name="s1240Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="16" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>	
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/>
		<wtc:param value="<%=paraStr[12]%>"/>	
		<wtc:param value="<%=paraStr[13]%>"/>						
	  <wtc:param value="<%=paraStr[14]%>"/>	
		<wtc:param value="<%=paraStr[15]%>"/>										
		</wtc:service>
		<wtc:array id="s1240CfmArr" scope="end"/>
<%  
	  System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String cnttLoginAccept = s1240CfmArr.length>0?s1240CfmArr[0][0]:"";
		String cnttActivePhone = srv_no;
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+srv_no+"&contactType=user";
	  System.out.println("--------------url----:"+url);		
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
	 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	  System.out.println("Double.parseDouble" + Double.parseDouble(((paraStr[11].trim().equals(""))?("0"):(paraStr[11]))));
%>

<%	 	
		String retCode= retCode1;
		String retMsg = retMsg1;
    if(Integer.parseInt(retCode)==0||Integer.parseInt(retCode)==000000){
	 	  if(Double.parseDouble(((paraStr[11].trim().equals(""))?("0"):(paraStr[11])))<0.01){
%>
        <script>
	     		rdShowMessageDialog("�û�<%=cust_name%>(<%=srv_no%>)����ɹ���",2);  
         	location="s1240Main.jsp?activePhone=<%=srv_no%>";
	    	</script>
<%
	  }else{
%>
        <script>
		     		rdShowMessageDialog("�û�<%=cust_name%>(<%=srv_no%>)��תҵ�����ɹ������潫��ӡ��Ʊ��");
	 		 			var infoStr="";
	     		 infoStr+="<%=ic_no%>"+"|";
         	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+="<%=srv_no%>"+"|";
			     infoStr+=" "+"|";
			     infoStr+="<%=cust_name%>"+"|";
			     infoStr+="<%=cust_addr%>"+"|";
		   		 infoStr+="�ֽ�"+"|";
		       infoStr+="<%=paraStr[11]%>"+"|";

	         infoStr+="��ת *�����ѣ�"+"<%=paraStr[11]%>"+"*��ˮ�ţ�"+"<%=cnttLoginAccept%>"+"|";
		       location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=s1240Login.jsp&activePhone=<%=srv_no%>";
	    </script>
<%
	  }
   }else{
%>
     <script>
		   rdShowMessageDialog('����<%=retMsg%>��'+'<%=retCode%>�������²�����');
		   location="s1240Main.jsp?activePhone=<%=srv_no%>";
		 </script>
<%
   }
%>

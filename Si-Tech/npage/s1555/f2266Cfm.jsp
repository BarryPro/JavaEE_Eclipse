<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-03 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
  String opCode = "2266";
  String opName = "";
	    
	String work_no = (String) session.getAttribute("workNo");
	String work_name = (String) session.getAttribute("workName");
	String org_code = (String) session.getAttribute("orgCode");
	String pass = (String) session.getAttribute("password");

	String strOpCode = request.getParameter("opcode");//�ֻ�����
	String stream=WtcUtil.repNull(request.getParameter("printAccept"));
	String thework_no=work_no;
	String themob=request.getParameter("phone_no");
	String theop_code=strOpCode;
	String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
	System.out.println("stream="+stream+"thework_no="+thework_no+"themob="+themob+"theop_code="+theop_code);
	System.out.println("printcount="+request.getParameter("printcount"));
	String moreKindsOfCard = WtcUtil.repNull((String)request.getParameter("moreKindsOfCard"));//diling add for һ��������ж��ֿ���ʶ@2012/11/1 
	System.out.println("---diling----moreKindsOfCard="+moreKindsOfCard);
%>

<%	
	System.out.println("opcode="+strOpCode);

	String strServName = "";
	String strReturnMsg = "";
	String strReturnErrMsg = "";
	String paraAray[] = new String[14];
	paraAray[0] = work_no;//����
	paraAray[1] = pass;//��������
	paraAray[2] = strOpCode;//��������
	paraAray[3] = request.getParameter("phone_no");//�ֻ�����
	paraAray[4] = request.getParameter("awardcode");//�������
	paraAray[5] = request.getParameter("awarddetailcode");//С�����
	paraAray[6] = request.getParameter("awardId");//��Ʒ����
	paraAray[7] = request.getParameter("payAccept");//������Ʒ��ˮ
	System.out.println("12="+request.getParameter("payAccept"));
	paraAray[8] = request.getParameter("opNote");//��ע
	paraAray[9] = request.getParameter("checkLoginAcceptnew");//У��Ĳ�����ˮ
	paraAray[10] = request.getParameter("rescode_sum_new");//������/�������콱����
	paraAray[11] = request.getParameter("printAccept");//ϵͳ������ˮ
	paraAray[12] = request.getParameter("card_no");
	/* �¾ɰ��ʾ��ΪԤԼ���� */
	paraAray[13] = request.getParameter("oldnewFlag")==null? "" : request.getParameter("oldnewFlag");
	
	
	System.out.println("--diling---paraAray[3]="+paraAray[3]+"--paraAray[4]="+paraAray[4]);
	System.out.println("--diling---paraAray[5]="+paraAray[5]+"--paraAray[6]="+paraAray[6]);
	System.out.println("--diling---paraAray[7]="+paraAray[7]+"--paraAray[8]="+paraAray[8]);
	System.out.println("--diling---paraAray[9]="+paraAray[9]+"--paraAray[10]="+paraAray[10]);
	System.out.println("--diling---paraAray[11]="+paraAray[11]);
	System.out.println("--diling---paraAray[12]="+paraAray[12]);
	System.out.println("--diling---paraAray[13]="+paraAray[13]);
	
	 String kazhehao="";
  String kazhefuhao="";
  
      if("moreKindsOfCard".equals(moreKindsOfCard)){
        paraAray[12] = request.getParameter("card_no");
      }else{
        if(paraAray[12].indexOf(",") != -1) {  
          String[] tmpCardNoss =paraAray[12].split(",");
          System.out.println(tmpCardNoss.length+"---wanghys---");
          
          for(int i=0; i<tmpCardNoss.length; i++){
            if(i==0 && i==tmpCardNoss.length-1) {
              kazhefuhao="";
            }else {
              if(i == tmpCardNoss.length-1) {
              kazhefuhao="";
              }else {
              	kazhefuhao=",";
              }
            }
            kazhehao+=tmpCardNoss[i]+kazhefuhao;
            System.out.println(tmpCardNoss[i]+"---wanghys---");
          }
          paraAray[12]="";
        }
      }
  			
			System.out.println(kazhehao+"---wanghys---");
%>
 
<%
  if (strOpCode.equals("2249")){	
		strServName = "s2266Reg";
		strReturnMsg="����Ʒͳһ����ԤԼ�Ǽǳɹ�";
		strReturnErrMsg = "����Ʒͳһ����ԤԼ�Ǽ�ʧ��";
		opName="����Ʒͳһ����ԤԼ�Ǽ�";
	}else if (strOpCode.equals("2266")){
		strServName = "s2266Cfm";
		strReturnMsg="����Ʒͳһ�����ɹ�";
		strReturnErrMsg = "����Ʒͳһ����ʧ��";
		opName="����Ʒͳһ����";
	}else{
		strServName = "s2266Cfm";
		strReturnMsg="����Ʒͳһ���������ɹ�";
		strReturnErrMsg = "����Ʒͳһ��������ʧ��";
		opName="����Ʒͳһ��������";
	}
	
	//String[] ret= impl.callService(strServName,paraAray,"2","phone",request.getParameter("phone_no"));
	
	
		System.out.println("--diling--33333333333333333333-paraAray[12]="+paraAray[12]);
%>
		<wtc:service name="<%=strServName%>" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
			<%
			if (strOpCode.equals("2266")){
			%>
			<wtc:param value="<%=kazhehao%>"/>
			<%}%>
		</wtc:service>
<%  
    int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String loginAccept = stream;//����δ������ˮ,�����ÿ�
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode
		+"&retCodeForCntt="+retCode
		+"&opName="+opName
		+"&workNo="+work_no
		+"&loginAccept="+loginAccept
		+"&pageActivePhone="+cnttActivePhone
		+"&opBeginTime="+opBeginTime
		+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	/*zhangyan ����
	errCode = 0;*/
	System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");	
	if (errCode == 0 )
	{
	
 	    String statisLoginAccept =  loginAccept; /*��ˮ*/
		String statisOpCode=strOpCode;
		String statisPhoneNo= cnttActivePhone;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan2266~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("2266") )
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}		
	
	
%>
			<script language="JavaScript">
			   rdShowMessageDialog("<%=strReturnMsg%>",2);
			   location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>   
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%}%>

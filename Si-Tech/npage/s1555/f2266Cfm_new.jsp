<%
    /********************
     version v2.0
     ������: si-tech
     update by wanglma 20110530
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "";

    String work_no = (String) session.getAttribute("workNo");
    String pass = (String) session.getAttribute("password");
    
    String strOpCode = request.getParameter("opcode");
    
    String stream=WtcUtil.repNull(request.getParameter("printAccept"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
    String moreKindsOfCard = WtcUtil.repNull((String)request.getParameter("moreKindsOfCard"));//diling add for һ��������ж��ֿ���ʶ@2012/11/1 
	String strServName = "";
	String strReturnMsg = "";
	String strReturnErrMsg = "";
	String paraAray[] = new String[17];
	paraAray[0] = work_no;//����
	paraAray[1] = pass;//��������
	paraAray[2] = strOpCode;//��������
	paraAray[3] = request.getParameter("phone_no");//�ֻ�����
	paraAray[4] = request.getParameter("AwardCodeArr");//�������
	paraAray[5] = request.getParameter("DetailCodeArr");//С�����
	paraAray[6] = request.getParameter("ResCodeArr");//��Ʒ����
	paraAray[7] = request.getParameter("OldAcceptArr");//������Ʒ��ˮ
	paraAray[8] = request.getParameter("OpNoteArr");//��ע
	paraAray[9] = request.getParameter("TotallineNum");//����������
	paraAray[10] = request.getParameter("ResCodeSumArr");//�콱����
	paraAray[11] = request.getParameter("CardNoArr");//����
	paraAray[12] = request.getParameter("LoginAccept");//ϵͳ������ˮ
	paraAray[13]=request.getParameter("CardNam");//huangrong add �������ƶ�����ͨ������
	paraAray[14]=request.getParameter("studentNo");//wanglma add ѧ��֤��
	paraAray[15]=request.getParameter("oldnewFlagArr");
	paraAray[16]=request.getParameter("packageFlagArr");
	
	/*20121022 gaopeng ������� ���ߵ��ӿ����� ����û��ڡ�Ӫ��ִ��(e177)���콱��Ҫ�е����� ���Ϊ�ò���*/
	String televCard=(String)request.getParameter("iTelevCard");//���ߵ��ӿ�����
	
    for(int i=0;i<paraAray.length;i++)
    {
        System.out.println("paraAray["+i+"]="+paraAray[i]);
    }
	for (int i=0;i<paraAray.length;i++)
	{
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}

  String kazhehao="";
  String kazhefuhao="";
  String[] kazhehaosi= paraAray[11].split("#");
  
      if("moreKindsOfCard".equals(moreKindsOfCard)){
        	paraAray[11] = request.getParameter("CardNoArr");//����
      }else{
        if(kazhehaosi[0].indexOf(",") != -1) {  
          String[] tmpCardNoss =kazhehaosi[0].split(",");
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
          paraAray[11]="";
        
        }
      }
  			
			System.out.println(kazhehao+"---wanghys---");
			

%>

<%
	System.out.println("@zhangyan~~~~~strOpCode"+strOpCode);
  if (strOpCode.equals("2249")){
		strServName = "s2266RegNew";
		strReturnMsg="����Ʒͳһ����ԤԼ�Ǽǳɹ�";
		strReturnErrMsg = "����Ʒͳһ����ԤԼ�Ǽ�ʧ��";
		opName="����Ʒͳһ����ԤԼ�Ǽ�";
	}else if (strOpCode.equals("2266")){
		strServName = "s2266CfmNew";
		strReturnMsg="����Ʒͳһ�����ɹ�";
		strReturnErrMsg = "����Ʒͳһ����ʧ��";
		opName="����Ʒͳһ����";
	}else if(strOpCode.equals("2279")){
		strServName = "s2266CfmBack";
		strReturnMsg="����Ʒͳһ���������ɹ�";
		strReturnErrMsg = "����Ʒͳһ��������ʧ��";
		opName="����Ʒͳһ��������";
	}
	
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
  <!--begin huangrong add ����Ԥ�����ƶ�����ͨ��-->
  <%
  if(strOpCode.equals("2266")   )
  {
  %>
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=kazhehao%>"/>
    <wtc:param value="<%=televCard%>"/>
  <%
  }
  %>
    <!--end huangrong add ����Ԥ�����ƶ�����ͨ��-->
		</wtc:service>
<%
    int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String loginAccept = stream;//����δ������ˮ,�����ÿ�
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode
	+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no
	+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone
	+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
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
    	System.out.println("@zhangyan2266new~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("2266") || statisOpCode.equals("2279") )
		{
		%>
		
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "�°����Ʒͳһ����";
	String strReturnMsg = "�°����Ʒͳһ�����ɹ�";
	String strReturnErrMsg = "�°����Ʒͳһ����ʧ��";
  String work_no = (String) session.getAttribute("workNo");
  String pass = (String) session.getAttribute("password");
  String strOpCode = request.getParameter("opcode");
  String stream=WtcUtil.repNull(request.getParameter("printAccept"));
  String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
  /***begin  add by diling for ���ڴ��칫˾�����������ߵ��ӻ���������ͻ�����ʾ @2011/11/9 ***/
  String televisionCardFlag = WtcUtil.repNull(request.getParameter("televisionCardFlag")); //���ߵ��ӿ����ű�ʶ
  String televisionCardNo = WtcUtil.repNull(request.getParameter("televisionCardNo"));  //���ߵ��ӿ�����
  System.out.println("---------6842----------televisionCardFlag="+televisionCardFlag);
  System.out.println("---------6842----------televisionCardNo="+televisionCardNo);
  /***end add by diling ***/
  String kazhehao="";
  String kazhefuhao="";

	String[] paraArray = new String[7];
	paraArray[0] = WtcUtil.repNull(request.getParameter("LoginAccept")); //ϵͳ������ˮ
	paraArray[1] = "sitech";                               // ������ʶ
	paraArray[2] = strOpCode;                              // opcode
	paraArray[3] = work_no;                                // ����
	paraArray[4] = pass;                                   // ��������
	paraArray[5] = request.getParameter("phone_no");       // �ֻ�����
	paraArray[6] = request.getParameter("con_user_passwd");// �û�����
	for(int i=0;i<paraArray.length;i++){
      System.out.println("�콱ȷ����� paraArray["+i+"]="+(paraArray[i]==null?"δȡ��ֵ":paraArray[i]));
  }

	/*************������¼ ����******************/
	String[] paraArray_7  = request.getParameter("awardSeqI").split("%");    // �н���ˮ
	String[] paraArray_8  = request.getParameter("projectCodeI").split("%"); // Ӫ�������� ��ά��Ϊ0
	String[] paraArray_9  = request.getParameter("gradeCodeI").split("%");   // Ӫ�����ȼ� ��ά��Ϊ''
	String[] paraArray_10 = request.getParameter("packageCodeI").split("%"); // ������

	String[] paraArray_11 = new String[paraArray_7.length];   // ��ʼ����
	String[] paraArray_12 = new String[paraArray_7.length];   // ��������
	String tmpCardNo      = request.getParameter("cardNoI");
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+tmpCardNo);
	//06739080048073000-06739080048073009%NO
	if(!"NO".equals(tmpCardNo)){ //�������˿���
	
			if(tmpCardNo.indexOf(",") != -1) {  
				String[] tmpCardNoss =tmpCardNo.split(",");
				System.out.println(tmpCardNoss.length+"liyangs");
				
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
				System.out.println(tmpCardNoss[i]+"liyangs");
				
				
				}
			paraArray_11[0] = "";
			paraArray_12[0] = "";

			}
			
		else {
		String[] cardNo =tmpCardNo.split("%");
		for(int i=0;i<cardNo.length;i++){
			if(cardNo[i] == null || "".equals(cardNo[i])){continue;}
			if("NO".equals(cardNo[i])){
				paraArray_11[i] = "";
				paraArray_12[i] = "";
			}else{
				paraArray_11[i] = (cardNo[i].split("-"))[0];
				paraArray_12[i] = (cardNo[i].split("-"))[1];
			}
		}
		}
	}else{
			paraArray_11[0] = "";
			paraArray_12[0] = "";
	}
	String[] paraArray_13 = request.getParameter("awardNoteI").split("%");   // ��ע
	/*************������¼ ����******************/
	System.out.println("paraArray[7]�н���ˮ="+(request.getParameter("awardSeqI")==null?"δȡ��ֵ":request.getParameter("awardSeqI")));
	System.out.println("paraArray[8]Ӫ��������="+(request.getParameter("projectCodeI")==null?"δȡ��ֵ":request.getParameter("projectCodeI")));
	System.out.println("paraArray[9]Ӫ�����ȼ�="+(request.getParameter("gradeCodeI")==null?"δȡ��ֵ":request.getParameter("gradeCodeI")));
	System.out.println("paraArray[10]������="+(request.getParameter("packageCodeI")==null?"δȡ��ֵ":request.getParameter("packageCodeI")));
	System.out.println("paraArray[11]����="+tmpCardNo);
	System.out.println("paraArray[13]note="+(request.getParameter("awardNoteI")==null?"δȡ��ֵ":request.getParameter("awardNoteI")));
	System.out.println(kazhehao+"liyangs");
	for(int i=0;i<paraArray_11.length;i++){
		System.out.println("[]"+paraArray_11[i]);
	}

%>
		<wtc:service name="s6842Cfm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
		<wtc:param  value="<%=paraArray[0]%>"/>
		<wtc:param  value="<%=paraArray[1]%>"/>
		<wtc:param  value="<%=paraArray[2]%>"/>
		<wtc:param  value="<%=paraArray[3]%>"/>
		<wtc:param  value="<%=paraArray[4]%>"/>
		<wtc:param  value="<%=paraArray[5]%>"/>
		<wtc:param  value="<%=paraArray[6]%>"/>
		<wtc:params value="<%=paraArray_7  %>"/>
		<wtc:params value="<%=paraArray_8  %>"/>
		<wtc:params value="<%=paraArray_9  %>"/>
		<wtc:params value="<%=paraArray_10 %>"/>
		<wtc:params value="<%=paraArray_11 %>"/>
    <wtc:params value="<%=paraArray_12 %>"/>
    <wtc:params value="<%=paraArray_13 %>"/>
        <%
            /***begin  add by diling for ���ڴ��칫˾�����������ߵ��ӻ���������ͻ�����ʾ @2011/11/9 ***/
            if("279652".equals(televisionCardFlag)){
        %>
                <wtc:param  value="<%=televisionCardNo%>"/>
        <%
            System.out.println("���ӿ�����="+televisionCardNo);
            }else{
        %>
                <wtc:param  value=""/>
        <%
            System.out.println("���ӿ�����--��--="+televisionCardNo);
            }
            /***end add by diling ***/ 
        %>
        <wtc:param value="<%=kazhehao %>"/>
		</wtc:service>
<%
  int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String loginAccept = stream;//����δ������ˮ,�����ÿ�
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
	if (errCode == 0 )
	{
%>
		<script language="JavaScript">
		   rdShowMessageDialog("<%=strReturnMsg%>",2);
		   location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
			location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
		</script>
<%}%>

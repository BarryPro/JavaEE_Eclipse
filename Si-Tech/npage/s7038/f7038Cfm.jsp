<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-06 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
		String cnttOpCode = "7143";
	  String cnttOpName = "�����ӡ";	
		String work_no = (String)session.getAttribute("workNo");
		String acceptStr=request.getParameter("acceptStr");
		String phone_no=request.getParameter("phone_no");
		String opCode=request.getParameter("opCode");
		String idNo=request.getParameter("idNo");
		String strHasEval = request.getParameter("haseval");//�Ƿ����û���������� 
		String strEvalCode = request.getParameter("evalcode");//�û���������۴��� 
		System.out.println("strHasEval="+strHasEval);
		System.out.println("strEvalCode="+strEvalCode);	
		
		String paraAray[] = new String[5];
		paraAray[0] =phone_no;
		paraAray[1] = opCode;
	 	paraAray[2] = work_no;
		paraAray[3] = acceptStr;
		paraAray[4] = idNo;
	 	//String[] ret = impl.callService("s7143Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
		<wtc:service name="s7143Cfm" routerKey="phone" routerValue="<%=activePhone%>" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>		
<%
	System.out.println("#######################retCode:"+retCode);
	int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	
	//��¼ͳһ�Ӵ�
	//����û�з�����ˮ
	System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");	
	String loginAccept="";
	String cnttActivePhone = activePhone;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCode+"&opName="+cnttOpName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone;
	System.out.println("--------------url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
	 
	if(errCode==0){
	//���� 2008��1��3�� �޸������û��������������
	String[] retEval = new String[]{};
  if(errCode==0 && strHasEval.equals("1")){
		String strParaAray[] = new String[6];
	  strParaAray[0] = work_no; 	//0  ��������                iLoginNo  thework_no
	  strParaAray[1] = opCode; 	//1  ��������                iOpCode   theop_code
	  strParaAray[2] = phone_no; 			//2  �ƶ�����                iPhoneNo  themob                         
	  strParaAray[3] = strEvalCode; //3  ���۴���
	  strParaAray[4] = acceptStr; 			//5  ������ˮ
	  strParaAray[5] = "1"; 
	  //retEval = impl.callService("sCommEvalCfm",strParaAray,"2","phone",phone_no);
%>
		<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=activePhone%>" outnum="2" >
		<wtc:param value="<%=strParaAray[0]%>"/>
		<wtc:param value="<%=strParaAray[1]%>"/>
		<wtc:param value="<%=strParaAray[2]%>"/>
		<wtc:param value="<%=strParaAray[3]%>"/>
		<wtc:param value="<%=strParaAray[4]%>"/>
		<wtc:param value="<%=strParaAray[5]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>		
<%
			int iReturnCode = retCode==""?999999:Integer.parseInt(retCode);
	    String strReturnMsg = retCode;
    	if(iReturnCode==0){
%>
				<script language="JavaScript">
					rdShowMessageDialog("���۳ɹ�!",2);
				</script>
<%    
  		}else{
%>
				<script language="JavaScript">
					rdShowMessageDialog("����δ�ܳɹ�!");
				</script>
<%  		
  		}
	}
%>
			<script language="JavaScript">
				rdShowMessageDialog("�ϲ���ӡȷ�ϲ����ɹ���",2);
				window.location="f7038_1.jsp?activePhone=<%=activePhone%>";
			</script>
<%
%>   
	
<%
		}else{%>
				<script language="JavaScript">
						rdShowMessageDialog("�ϲ���ӡȷ�ϲ���ʧ��!<%=errMsg%>");
						window.location="f7038_1.jsp?activePhone=<%=activePhone%>";
				</script>
<%	
		}
%>

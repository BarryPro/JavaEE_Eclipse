
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "4400";
  String opName = "����VIP��������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<!--%@ page errorPage="/page/common/errorpage.jsp" %-->
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%
//�ڴ˴���ȡsession��Ϣ

%>

<%
    
String busi_type = request.getParameter("busi_type");// 
String work_no = request.getParameter("work_no");// 
String accept_no = request.getParameter("accept_no");//
String send_accept = request.getParameter("send_accept");// 
String cur_date = request.getParameter("date");// 
String phone = request.getParameter("phone");//
String cust_name = request.getParameter("cust_name");//
String pay_money = request.getParameter("pay_money");//
String chinaFee = "";
	//MyLog.debugLog("work_no="+work_no);
String firstCode=request.getParameter("tmpR1");
String secondCode=request.getParameter("tmpR2");
String secondName=request.getParameter("tmpR3");
String servContent=request.getParameter("tmpR4");
String servAmount=request.getParameter("tmpR5");
String servMark=request.getParameter("tmpR6");

String servLevel=request.getParameter("servLevel");    
String attendant= request.getParameter("attendant");  

String airportName=request.getParameter("airportName");
String airNo=request.getParameter("airNo"); 
String sumTimes=request.getParameter("sumTimes");



        
%>


<html>

<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

<body onload="ifprint();">
<form action="" name="form" method="post">
</form>
</body>
</html>
<script language="javascript">
function ifprint()
{
 printInvoice();
 rdShowMessageDialog('��ӡ�ɹ�!',2);

 window.returnValue=1;
 window.close();

}

function printInvoice()
{

    var startRow=5;
    var startCol=10;
    
  try
  { 
     //��ӡ��ʼ��  
             printctrl.Setup(0);
             printctrl.StartPrint();
             printctrl.PageStart();
             printctrl.Print(startCol+0,startRow+0,12,0,"ҵ�����<%=busi_type%>");//ҵ�����
             printctrl.Print(startCol+35,startRow+0,12,0,"����ʱ�䣺<%=cur_date.substring(0,4)%>��");//��
             printctrl.Print(startCol+52,startRow+0,12,0,"<%=cur_date.substring(4,6)%>��");//��
             printctrl.Print(startCol+57,startRow+0,12,0,"<%=cur_date.substring(6,8)%>��");//��
             
             printctrl.Print(startCol+0,startRow+3,12,0,"ҵ����ˮ��<%=accept_no%>"); //������ˮ��
            // printctrl.Print(startCol+35,startRow+3,12,0,"���𷽽�����ˮ��<%=send_accept%>"); 
             
             printctrl.Print(startCol+0,startRow+5,12,0,"�ͻ���ʶ��<%=phone%>");//�ƶ�����
             printctrl.Print(startCol+35,startRow+5,12,0,"�ͻ����ƣ�<%=cust_name%>");//�ͻ�����
             
             printctrl.Print(startCol+0,startRow+7,12,0,"���񼶱�<%=servLevel%>");        
             printctrl.Print(startCol+35,startRow+7,12,0,"�Ƿ���Ա��<%=attendant%>");  
             
            
             printctrl.Print(startCol+0,startRow+11,12,0,"�۳����֣�<%=pay_money%>");  //��<%=chinaFee%>��");//��д-���ѽ��
             printctrl.Print(startCol+35,startRow+11,12,0,"ʹ����Ѵ�����<%=sumTimes%>");
<%           int i=14;
             if(firstCode!=null && firstCode.length()>0){
		      StringTokenizer firstCodeToken = new StringTokenizer(firstCode, "|");
		      StringTokenizer secondCodeToken = new StringTokenizer(secondCode, "|");
		      StringTokenizer secondNameToken = new StringTokenizer(secondName, "|");
		      StringTokenizer servContentToken = new StringTokenizer(servContent, "|");
		      StringTokenizer servAmountToken = new StringTokenizer(servAmount, "|");
		      StringTokenizer servMarkToken = new StringTokenizer(servMark, "|");
		      
%>
		printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"һ������");
		printctrl.Print(startCol+8,startRow+<%=i%>,12,0,"��������");
		printctrl.Print(startCol+18,startRow+<%=i%>,12,0,"������Ŀ");
		printctrl.Print(startCol+43,startRow+<%=i%>,12,0,"��������");

<%	
		      i=i+2;	      
		      while (firstCodeToken.hasMoreElements()) {
			        String svcFirstCode = firstCodeToken.nextToken();
			        String svcSecondCode = secondCodeToken.nextToken();
			        String svcSecondName = secondNameToken.nextToken();
			        String svcContent = servContentToken.nextToken();
			        String svcAmount = servAmountToken.nextToken();
			        String svcMark = servMarkToken.nextToken();
%>
		printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"<%=svcFirstCode%>");
		printctrl.Print(startCol+8,startRow+<%=i%>,12,0,"<%=svcSecondCode%>");
		printctrl.Print(startCol+18,startRow+<%=i%>,12,0,"<%=svcSecondName%>");
		printctrl.Print(startCol+43,startRow+<%=i%>,12,0,"<%=svcContent%>");	
<%			        
		        	i=i+2;
		        }
		        
             }
             i=i+5;
%>             
             printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"�����ţ�<%=work_no%>");//������
             printctrl.Print(startCol+35,startRow+<%=i%>,12,0,"����ʱ�䣺<%=cur_date%>");//����ʱ��
 //��ӡ����
             printctrl.PageEnd();
             printctrl.StopPrint();

  }
  catch(e)
  {
  }
  finally
  {
  }

	return true;
}
</script>
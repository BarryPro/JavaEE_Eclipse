<% /******************** version v2.0 ������: si-tech * *update:zhanghonga@2008
          -08-19 ҳ�����,�޸���ʽ * ********************/ %> <%@page
              contentType="text/html;charset=GBK"%> <%@ include
 file="/npage/include/public_title_name.jsp" %> <%@ page import="java.text.*"%>
             <%@ page import="com.sitech.boss.pub.util.*" %> <%/* *
  ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
    ���ֱ������������ݶԴ˱���ʹ�õ����壬����;�� */ %> <% String opCode2 =
(String)request.getParameter("opCode"); if (opCode2 == null){ opCode2 = "1270";
    } %> <%! /**���������������ʽ�������Сд����**/ public static String
          formatNumber(String num, int zeroNum) { DecimalFormat form =
   (DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); StringBuffer
patBuf = new StringBuffer("0"); if(zeroNum > 0) { patBuf.append("."); for(int i
                 = 0; i < zeroNum; i++) { patBuf.append("0"); }

        }
        form.applyPattern(patBuf.toString());
        return form.format(Double.parseDouble(num)).toString();
    }
%>
<HTML>
<head>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%      
/*--------------------------------��֯s7327Cfm�Ĵ������-------------------------------*/
String thework_no = (String)session.getAttribute("workNo");                                   //��������                    0  �������� iLoginNo                          
String psw =(String)session.getAttribute("password");                                         //��������					1  �������� iLoginPwd                           
String theop_code = WtcUtil.repNull(request.getParameter("opCode"));                         //��������					2  iOpCode                                                                             //��½IP					    16 ��¼IP  iIpAddr                            										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String main_card = WtcUtil.repNull(request.getParameter("main_card"));
String mem_num = WtcUtil.repNull(request.getParameter("mem_num"));
String pay_fee = WtcUtil.repNull(request.getParameter("pay_fee"));
String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
String end_time = WtcUtil.repNull(request.getParameter("end_time"));
String op_flag = WtcUtil.repNull(request.getParameter("op_flag"));
String stream = WtcUtil.repNull(request.getParameter("stream"));       //ϵͳ��ˮ												  

/*--------------------------------��ʼ����s7969Cfm--------------------------------*/
		String paraAray[] = new String[7];			    
		paraAray[0] = main_card; //  �ҳ�����          
		paraAray[1] = mem_num; //     �����Ѻ���         
		paraAray[2] = pay_fee; //     ���ѽ��                       
		paraAray[3] = theop_code; //   op_code       
		paraAray[4] = thework_no; // ��������
		paraAray[5] = op_flag; //  ��������         
		paraAray[6] = stream; //  ��ӡ��ˮ   
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>		
		<wtc:service name="s7327Cfm" routerKey="phoneNo" routerValue="<%=main_card%>" outnum="3" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>	
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		int ret_code = 999999;	
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}
        String ret_msg = retMsg;
		System.out.println("ret_code=====222=============="+ret_code);
	
		System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		
		System.out.println("%%%%%%%������� theop_code%%%%%%%%"+theop_code);	
		System.out.println("%%%%%%%������� retCode%%%%%%%%"+retCode);	
		System.out.println("%%%%%%%������� opName2%%%%%%%%"+opName2);	
		System.out.println("%%%%%%%������� thework_no%%%%%%%%"+thework_no);	
		System.out.println("%%%%%%%������� stream%%%%%%%%"+stream);	
		System.out.println("%%%%%%%������� mem_num%%%%%%%%"+mem_num);	
			
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+mem_num+"&opBeginTime="+opBeginTime+"&contactId="+mem_num+"&contactType=user";
		System.out.println("%%%%%%%������� url%%%%%%%%"+url);	
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

/*------------------------------���ݵ��÷��񷵻ؽ������ҳ����ת------------------------------*/
%>
</script>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('�����ɹ���',2);
if("<%=returnPage%>"!="")
{
  location="<%=returnPage%>";
}
else
{
  parent.removeTab('<%=opCode2%>');
}
</script>
<%}%>



<%if(!(ret_code==0)){%>
<script language='jscript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
	history.go(-2);
</script>
<%}%>

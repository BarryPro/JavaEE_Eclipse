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
<%
	String regionCode = WtcUtil.repNull(request.getParameter("region_code"));
	String work_name = (String)session.getAttribute("workName");
	String serviceName="";
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
/*--------------------------------��֯s1270Cfm�Ĵ������-------------------------------*/
String thework_no = (String)session.getAttribute("workNo");                                   //��������                    0  �������� iLoginNo                          
String psw =(String)session.getAttribute("password");                                         //��������					1  �������� iLoginPwd                           
String theop_code = WtcUtil.repNull(request.getParameter("iOpCode"));                         //��������					2  iOpCode                                                                             //��½IP					    16 ��¼IP  iIpAddr                            										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String sale_code = WtcUtil.repNull(request.getParameter("sale_code"));
String mode_code = WtcUtil.repNull(request.getParameter("mode_code"));
String sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
String color_mode = WtcUtil.repNull(request.getParameter("color_mode"));
String next_mode = WtcUtil.repNull(request.getParameter("next_mode"));
String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
String end_time = WtcUtil.repNull(request.getParameter("end_time"));
String op_flag = WtcUtil.repNull(request.getParameter("op_flag"));
											  
%>
<%

/*--------------------------------��ʼ����s7969Cfm--------------------------------*/
		String paraAray[] = new String[12];			    
		paraAray[0] = thework_no; //0  ��������                iLoginNo  thework_no
		paraAray[1] = psw; //1  ��������                iLoginPwd psw
		paraAray[2] = theop_code; //2                          iOpCode   theop_code
		paraAray[3] = regionCode; //3
		paraAray[4] = sale_code; //4  Ӫ��������          
		paraAray[5] = sale_name; //5  Ӫ��������            
		paraAray[6] = mode_code; //6  ���ʷ�    
		paraAray[7] = color_mode; //7  �����ʷ�        
		paraAray[8] = next_mode; //8  ��һ���ʷ�        
		paraAray[9] = begin_time; //9  ��ͨʱ��    
		paraAray[10] = end_time; //10 ����ʱ��  
		paraAray[11] = op_flag; //11 ������־              
		
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>
		<wtc:service name="s7969Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" outnum="3" >
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
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&opBeginTime="+opBeginTime+"&contactType=user";
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

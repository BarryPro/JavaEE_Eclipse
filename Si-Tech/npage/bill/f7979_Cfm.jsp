<% /******************** version v2.0 开发商: si-tech * *update:zhanghonga@2008
          -08-19 页面改造,修改样式 * ********************/ %> 
<%@ page contentType="text/html;charset=GBK"%> 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %> 
<% 	
		String opCode2 =(String)request.getParameter("opCode"); 
		if (opCode2 == null){ opCode2 = "1270";} 
%> 
<%! /**这个方法是用来格式化后面的小写金额的**/ 
public static String formatNumber(String num, int zeroNum) 
{ 
	DecimalFormat form =(DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); 
	StringBuffer patBuf = new StringBuffer("0"); 
	if(zeroNum > 0) 
	{ 
		patBuf.append("."); for(int i= 0; i < zeroNum; i++) { patBuf.append("0"); }
  }
  form.applyPattern(patBuf.toString());
  return form.format(Double.parseDouble(num)).toString();
}
%>
<%
	String regionCode = WtcUtil.repNull(request.getParameter("regionCode"));
	String work_name = (String)session.getAttribute("workName");
	String thework_no = (String)session.getAttribute("workNo");                                   //操作工号                    0  操作工号 iLoginNo                          
	String psw =(String)session.getAttribute("password");                                         //工号密码					1  工号密码 iLoginPwd                           
	String ipAddr = WtcUtil.repNull(request.getParameter("ipAddr"));
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
/*--------------------------------组织sCfm的传入参数-------------------------------*/
String theop_code = WtcUtil.repNull(request.getParameter("op_code"));     //操作代码					2  iOpCode                                                                                                      										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String kin_mode = WtcUtil.repNull(request.getParameter("kin_mode"));
String NextMode = WtcUtil.repNull(request.getParameter("Next_Mode"));
String kin_nos = WtcUtil.repNull(request.getParameter("kin_nos"));											  
String stream = WtcUtil.repNull(request.getParameter("stream"));       //系统流水												  
String opNote = WtcUtil.repNull(request.getParameter("opNote"));
String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String Mode_Code = WtcUtil.repNull(request.getParameter("Mode_Code"));
%>
<%

/*--------------------------------开始调用sCfm--------------------------------*/
		String [] KinNos = kin_nos.split(",");
		for(int i=0;i<KinNos.length;i++)
		{
			System.out.println("KinNos["+i+"]="+KinNos[i]);
		}
		String paraAray[] = new String[11];	
		paraAray[0] = regionCode; // 地市代码		
		paraAray[1] = kin_mode; //  亲情资费代码     
		paraAray[2] = thework_no; //  操作工号                
		paraAray[3] = psw; //  工号密码                                     		           
		paraAray[4] = theop_code; // 操作代码    
		paraAray[5] = "(参见KinNos数组,未传此参数)"; 
		paraAray[6] = phoneNo;
		paraAray[7] = stream; //  系统流水 
		paraAray[8] = NextMode; //  到期资费 
		paraAray[9] = Mode_Code;
		paraAray[10] = opNote; //  备注     
				   		
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>
		<wtc:service name="s7979Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:params value="<%=KinNos%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>			
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		int ret_code = 999999;	
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}
        String ret_msg = retMsg;
		System.out.println("ret_code=====222=============="+ret_code);
	
		System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		System.out.println("%%%%%%%传入参数 theop_code%%%%%%%%"+theop_code);	
		System.out.println("%%%%%%%传入参数 retCode%%%%%%%%"+retCode);	
		System.out.println("%%%%%%%传入参数 opName2%%%%%%%%"+opName2);	
		System.out.println("%%%%%%%传入参数 thework_no%%%%%%%%"+thework_no);	
		System.out.println("%%%%%%%传入参数 stream%%%%%%%%"+stream);	
			
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user";
		System.out.println("%%%%%%%传入参数 url%%%%%%%%"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");

/*------------------------------依据调用服务返回结果进行页面跳转------------------------------*/
%>
</script>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('操作成功！',2);
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
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
	history.go(-2);
</script>
<%}%>

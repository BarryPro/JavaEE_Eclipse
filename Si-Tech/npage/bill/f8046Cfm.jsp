<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% 
	//ALT= //在此处读取session信息 ArrayList arr = 
	//(ArrayList)session.getAttribute("allArr"); 
	//String[][] str1 = (String[][])arr.get(0);//读取登陆信息 
	//String[][] info = (String[][])arr.get(2);//读取登陆IP，角色名称，所在部门（组合） 
	//String[][] password = (String[][])arr.get(4);//读取工号密码
	//String work_name = str1[0][2];
	//String work_name = (String)session.getAttribute("workName");
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//paraAray[1] = password[0][0];
	//paraAray[5] = info[0][2];          
		
	String paraAray[] = new String[13];

	paraAray[0] =  (String)session.getAttribute("workNo");                           //0  操作工号                iLoginNo                     //1  工号密码                iLoginPwd
	paraAray[1] = (String)session.getAttribute("password");
	paraAray[2] = request.getParameter("iOpCode");            //2                          iOpCode
	paraAray[3] = request.getParameter("phoneNo");            //3  移动号码                iPhoneNo
	paraAray[4] = request.getParameter("printAccept");        //4 打印流水                 printAccept                       //5 登录IP                   iIpAddr
	paraAray[5] = (String)session.getAttribute("ipAddr");
	paraAray[6] = request.getParameter("opNote");             //6 操作日志                 iOpNote
	paraAray[7] = request.getParameter("saleType");            //7 营销案类型              saleType
	paraAray[8] = request.getParameter("pay_phone_fee");       //8 补手机款                pay_phone_fee
	paraAray[9] = request.getParameter("pay_product_fee");     //9 补促销品款              pay_product_fee
	paraAray[10] = request.getParameter("phone_type");         //10 手机类型               phone_type
	paraAray[11] = request.getParameter("product_type");       //11 礼品类型               product_type
	paraAray[12] = request.getParameter("loginAccept");        //12 原业务流水             oldLoginAccept
	String phone_no = paraAray[3];
	String callSerName="";  //huangrong 增加callSerName 查询用户归属地市 2011-1-12
	//String service_name = "s804601Cfm";
	//String[] ret = impl.callService(service_name,paraAray,"2","phone_no",phone_no);
	//int ret_code = impl.getErrCode();
  //String ret_msg = impl.getErrMsg();
  //begin huangrong 增加判断如果营销案类型是签约优惠购机则调用服务s804602Cfm，否则调用服务s804601Cfm 2011-1-12
if(paraAray[7]=="33" || paraAray[7].equals("33")|| paraAray[7].equals("54")||paraAray[7]=="54" || paraAray[7].equals("39")||paraAray[7]=="39")
{
	callSerName="s804602Cfm";
}else
{
	callSerName="s804601Cfm";
}
System.out.println("---------------------------callSerName---------------------"+callSerName);
 //end huangrong 增加判断如果营销案类型是签约优惠购机则调用服务s804602Cfm，否则调用服务s804601Cfm 2011-1-12
%>
    <wtc:service name="<%=callSerName%>" outnum="2" routerKey="phone_no" routerValue="<%=phone_no%>">
		 <wtc:param value="<%=paraAray[0]%>" />
		 <wtc:param value="<%=paraAray[1]%>" />
		 <wtc:param value="<%=paraAray[2]%>" />
		 <wtc:param value="<%=paraAray[3]%>" />
		 <wtc:param value="<%=paraAray[4]%>" />
		 <wtc:param value="<%=paraAray[5]%>" />
		 <wtc:param value="<%=paraAray[6]%>" />
		 <wtc:param value="<%=paraAray[7]%>" />
		 <wtc:param value="<%=paraAray[8]%>" />
		 <wtc:param value="<%=paraAray[9]%>" />
		 <wtc:param value="<%=paraAray[10]%>"/>
		 <wtc:param value="<%=paraAray[11]%>"/>
		 <wtc:param value="<%=paraAray[12]%>"/>
		 </wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	System.out.println("----------hejw---------retCode-----------"+retCode);
	if((retCode.equals("000000"))&&(paraAray[2].equals("8046")))
	{
%>
<script language="javascript">
	//begin huangrong 修改
	rdShowMessageDialog("确认成功! ",2);
	window.location="f8046_index.jsp?opCode=8046&opName=营销案取消&activePhone="+<%=phone_no%>;
	//end huangrong 修改
</script>
<%
	}
	else{
%>
<script language="JavaScript">
	//begin huangrong 修改
	rdShowMessageDialog("预存话费优惠购机取消确认失败!(<%=retMsg%>",0);
	window.location="f8046_index.jsp?opCode=8046&opName=营销案取消&activePhone="+<%=phone_no%>;
	//end huangrong 修改
</script>
<%}%>


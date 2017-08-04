<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

 

<%	
	String region_code = request.getParameter("region_code");
	String opType = request.getParameter("opType");
	String feeType = request.getParameter("feeType");
	String fav_char = request.getParameter("fav_char");
	String modecode = request.getParameter("modecode");
	String fav_call = request.getParameter("fav_call");
	String fav_save1 = request.getParameter("fav_save1");
	String t_sys_remark = request.getParameter("t_sys_remark");
	
	System.out.println("region_code="+region_code);
	System.out.println("opType="+opType);
	System.out.println("feeType="+feeType);
	System.out.println("fav_char="+fav_char);
	System.out.println("modecode="+modecode);
	System.out.println("fav_call="+fav_call);
	System.out.println("fav_save1="+fav_save1);
	System.out.println("t_sys_remark="+t_sys_remark);

	String[][] result = new String[][]{};
	String work_no = (String)session.getAttribute("workNo");
	
	String paraAray[] = new String[12];   
	

	paraAray[0] = region_code; //region_code
	paraAray[1] = opType;	//opType
	paraAray[2] = feeType; //feeType
	paraAray[3] = fav_char; //fav_char	
	paraAray[4] = modecode; //modecode
	paraAray[5] = fav_call; //fav_call
	paraAray[6] = fav_save1; //fav_save1
	paraAray[7] = t_sys_remark; //t_sys_remark
	paraAray[8] = work_no ;

	%>
    <wtc:service name="sPubChgFav1860" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />								
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />	
	
	<%
	String retCode= code;
	String retMsg = msg;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	if (retCode.equals("000000"))
	{

%>

<script language="JavaScript">
	rdShowMessageDialog("套餐查询配置业务受理成功！",2);
	history.go(-1);
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("套餐查询配置业务受理失败: <%=retMsg%>",0);
	history.go(-1);
</script>
<%}%>


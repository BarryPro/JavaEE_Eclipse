<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
 //splitString()用于截取字符串，因jdk老版本没有String.split()函数
  public Vector splitString(String sign, String sourceString){
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length()==0) {return splitArrays;}
        while (i <= sourceString.length()) {
               j = sourceString.indexOf(sign, i);
               if (j < 0) {j = sourceString.length();}
               splitArrays.addElement(sourceString.substring(i, j));
               i = j + 1;
        }
        return splitArrays;
  }
%>

<%
	String opCode="1252";
	String opName="温馨家庭取消";
	String work_no =(String)session.getAttribute("workNo");    		         //工号
	String regionCode = (String)session.getAttribute("regCode");
	String org_code =(String)session.getAttribute("orgCode");				 //归属代码（机构代码）
%>

<%	
	String paraAray[] = new String[11];
	String card_type="",new_rate_code="",phoneNo="",tempStr="";
    Vector vec = new Vector();

	tempStr = request.getParameter("phoneNo");								 //手机号码
	vec = splitString("~",tempStr);
    if(vec.size()==3){
		phoneNo = (String)vec.get(0);
		card_type = (String)vec.get(1);
		new_rate_code = (String)vec.get(2);
	}

    paraAray[0] = card_type ;												//卡类型
	paraAray[1] = request.getParameter("family_code");						//家庭代码
    paraAray[2] = phoneNo.trim();											//亲情号码
	paraAray[3] = request.getParameter("main_card");						//主卡号码
	paraAray[4] = new_rate_code ;											//资费代码
	paraAray[5] = work_no;													//工号
	paraAray[6] = org_code;													//机构编码
    paraAray[7] = "1252";													//操作代码  
	paraAray[8] = request.getParameter("new_rate_code2");					//第一付卡主套餐
 	paraAray[9] = request.getParameter("opNote");							//操作备注
	paraAray[10] = request.getParameter("printAccept");						//打印流水
	System.out.println("paraAray[10]paraAray[10]paraAray[10]paraAray[10]="+paraAray[10]);

%>
	<wtc:service name="s1252Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>

<%
	String errCode = result[0][0];
	String errMsg = result[0][1];
	System.out.println("errCodeerrCodeerrCodeerrCode="+result[0][1]);
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName
			  +"&workNo="+work_no+"&loginAccept="+paraAray[10]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg
			  +"&opBeginTime="+opBeginTime; 
	if (errCode.equals("000000")||errCode.equals("0"))
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("温馨家庭取消成功!",2);
	location="f1252_login.jsp?activePhone=<%=paraAray[3]%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("温馨家庭取消失败!<br>errCode:<%=errCode%><br>errMsg:<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />
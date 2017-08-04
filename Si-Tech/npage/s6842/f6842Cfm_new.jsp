<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "新版促销品统一付奖";
	String strReturnMsg = "新版促销品统一付奖成功";
	String strReturnErrMsg = "新版促销品统一付奖失败";
  String work_no = (String) session.getAttribute("workNo");
  String pass = (String) session.getAttribute("password");
  String strOpCode = request.getParameter("opcode");
  String stream=WtcUtil.repNull(request.getParameter("printAccept"));
  String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
  /***begin  add by diling for 关于大庆公司申请利用有线电视基础费捆绑客户的请示 @2011/11/9 ***/
  String televisionCardFlag = WtcUtil.repNull(request.getParameter("televisionCardFlag")); //有线电视卡卡号标识
  String televisionCardNo = WtcUtil.repNull(request.getParameter("televisionCardNo"));  //有线电视卡卡号
  System.out.println("---------6842----------televisionCardFlag="+televisionCardFlag);
  System.out.println("---------6842----------televisionCardNo="+televisionCardNo);
  /***end add by diling ***/
  String kazhehao="";
  String kazhefuhao="";

	String[] paraArray = new String[7];
	paraArray[0] = WtcUtil.repNull(request.getParameter("LoginAccept")); //系统操作流水
	paraArray[1] = "sitech";                               // 渠道标识
	paraArray[2] = strOpCode;                              // opcode
	paraArray[3] = work_no;                                // 工号
	paraArray[4] = pass;                                   // 工号密码
	paraArray[5] = request.getParameter("phone_no");       // 手机号码
	paraArray[6] = request.getParameter("con_user_passwd");// 用户密码
	for(int i=0;i<paraArray.length;i++){
      System.out.println("领奖确认入参 paraArray["+i+"]="+(paraArray[i]==null?"未取到值":paraArray[i]));
  }

	/*************多条记录 数组******************/
	String[] paraArray_7  = request.getParameter("awardSeqI").split("%");    // 中奖流水
	String[] paraArray_8  = request.getParameter("projectCodeI").split("%"); // 营销案编码 二维码为0
	String[] paraArray_9  = request.getParameter("gradeCodeI").split("%");   // 营销案等级 二维码为''
	String[] paraArray_10 = request.getParameter("packageCodeI").split("%"); // 包代码

	String[] paraArray_11 = new String[paraArray_7.length];   // 开始卡号
	String[] paraArray_12 = new String[paraArray_7.length];   // 结束卡号
	String tmpCardNo      = request.getParameter("cardNoI");
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+tmpCardNo);
	//06739080048073000-06739080048073009%NO
	if(!"NO".equals(tmpCardNo)){ //若输入了卡号
	
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
	String[] paraArray_13 = request.getParameter("awardNoteI").split("%");   // 备注
	/*************多条记录 数组******************/
	System.out.println("paraArray[7]中奖流水="+(request.getParameter("awardSeqI")==null?"未取到值":request.getParameter("awardSeqI")));
	System.out.println("paraArray[8]营销案编码="+(request.getParameter("projectCodeI")==null?"未取到值":request.getParameter("projectCodeI")));
	System.out.println("paraArray[9]营销案等级="+(request.getParameter("gradeCodeI")==null?"未取到值":request.getParameter("gradeCodeI")));
	System.out.println("paraArray[10]包代码="+(request.getParameter("packageCodeI")==null?"未取到值":request.getParameter("packageCodeI")));
	System.out.println("paraArray[11]卡号="+tmpCardNo);
	System.out.println("paraArray[13]note="+(request.getParameter("awardNoteI")==null?"未取到值":request.getParameter("awardNoteI")));
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
            /***begin  add by diling for 关于大庆公司申请利用有线电视基础费捆绑客户的请示 @2011/11/9 ***/
            if("279652".equals(televisionCardFlag)){
        %>
                <wtc:param  value="<%=televisionCardNo%>"/>
        <%
            System.out.println("电视卡卡号="+televisionCardNo);
            }else{
        %>
                <wtc:param  value=""/>
        <%
            System.out.println("电视卡卡号--空--="+televisionCardNo);
            }
            /***end add by diling ***/ 
        %>
        <wtc:param value="<%=kazhehao %>"/>
		</wtc:service>
<%
  int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String loginAccept = stream;//服务未返回流水,所以置空
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
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

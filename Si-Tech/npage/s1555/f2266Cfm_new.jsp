<%
    /********************
     version v2.0
     开发商: si-tech
     update by wanglma 20110530
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "";

    String work_no = (String) session.getAttribute("workNo");
    String pass = (String) session.getAttribute("password");
    
    String strOpCode = request.getParameter("opcode");
    
    String stream=WtcUtil.repNull(request.getParameter("printAccept"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
    String moreKindsOfCard = WtcUtil.repNull((String)request.getParameter("moreKindsOfCard"));//diling add for 一个礼包含有多种卡标识@2012/11/1 
	String strServName = "";
	String strReturnMsg = "";
	String strReturnErrMsg = "";
	String paraAray[] = new String[17];
	paraAray[0] = work_no;//工号
	paraAray[1] = pass;//工号密码
	paraAray[2] = strOpCode;//操作代码
	paraAray[3] = request.getParameter("phone_no");//手机号码
	paraAray[4] = request.getParameter("AwardCodeArr");//大类代码
	paraAray[5] = request.getParameter("DetailCodeArr");//小类代码
	paraAray[6] = request.getParameter("ResCodeArr");//奖品代码
	paraAray[7] = request.getParameter("OldAcceptArr");//促销奖品流水
	paraAray[8] = request.getParameter("OpNoteArr");//备注
	paraAray[9] = request.getParameter("TotallineNum");//操作的行数
	paraAray[10] = request.getParameter("ResCodeSumArr");//领奖数量
	paraAray[11] = request.getParameter("CardNoArr");//卡号
	paraAray[12] = request.getParameter("LoginAccept");//系统操作流水
	paraAray[13]=request.getParameter("CardNam");//huangrong add 获赠的移动城市通卡卡号
	paraAray[14]=request.getParameter("studentNo");//wanglma add 学生证号
	paraAray[15]=request.getParameter("oldnewFlagArr");
	paraAray[16]=request.getParameter("packageFlagArr");
	
	/*20121022 gaopeng 新增入参 有线电视卡卡号 如果用户在“营销执行(e177)”领奖需要有弹出框 入参为该参数*/
	String televCard=(String)request.getParameter("iTelevCard");//有线电视卡卡号
	
    for(int i=0;i<paraAray.length;i++)
    {
        System.out.println("paraAray["+i+"]="+paraAray[i]);
    }
	for (int i=0;i<paraAray.length;i++)
	{
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}

  String kazhehao="";
  String kazhefuhao="";
  String[] kazhehaosi= paraAray[11].split("#");
  
      if("moreKindsOfCard".equals(moreKindsOfCard)){
        	paraAray[11] = request.getParameter("CardNoArr");//卡号
      }else{
        if(kazhehaosi[0].indexOf(",") != -1) {  
          String[] tmpCardNoss =kazhehaosi[0].split(",");
          System.out.println(tmpCardNoss.length+"---wanghys---");
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
            System.out.println(tmpCardNoss[i]+"---wanghys---");
          }
          paraAray[11]="";
        
        }
      }
  			
			System.out.println(kazhehao+"---wanghys---");
			

%>

<%
	System.out.println("@zhangyan~~~~~strOpCode"+strOpCode);
  if (strOpCode.equals("2249")){
		strServName = "s2266RegNew";
		strReturnMsg="促销品统一付奖预约登记成功";
		strReturnErrMsg = "促销品统一付奖预约登记失败";
		opName="促销品统一付奖预约登记";
	}else if (strOpCode.equals("2266")){
		strServName = "s2266CfmNew";
		strReturnMsg="促销品统一付奖成功";
		strReturnErrMsg = "促销品统一付奖失败";
		opName="促销品统一付奖";
	}else if(strOpCode.equals("2279")){
		strServName = "s2266CfmBack";
		strReturnMsg="促销品统一付奖冲正成功";
		strReturnErrMsg = "促销品统一付奖冲正失败";
		opName="促销品统一付奖冲正";
	}
	
%>
		<wtc:service name="<%=strServName%>" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
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
    <wtc:param value="<%=paraAray[12]%>"/>
  <!--begin huangrong add 参与预存赠移动城市通卡-->
  <%
  if(strOpCode.equals("2266")   )
  {
  %>
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=kazhehao%>"/>
    <wtc:param value="<%=televCard%>"/>
  <%
  }
  %>
    <!--end huangrong add 参与预存赠移动城市通卡-->
		</wtc:service>
<%
    int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String loginAccept = stream;//服务未返回流水,所以置空
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode
	+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no
	+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone
	+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	/*zhangyan 测试
	errCode = 0;*/
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
	if (errCode == 0 )
	{

 	    String statisLoginAccept =  loginAccept; /*流水*/
		String statisOpCode=strOpCode;
		String statisPhoneNo= cnttActivePhone;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan2266new~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("2266") || statisOpCode.equals("2279") )
		{
		%>
		
		<%	
		}		
%>
			<script language="JavaScript">
			   rdShowMessageDialog("<%=strReturnMsg%>",2);
			   location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%}%>

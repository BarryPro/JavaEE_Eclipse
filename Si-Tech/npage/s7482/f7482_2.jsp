<%
    /********************
     * @ OpCode    :  7482
     * @ OpName    :  组合营销集团成员增加
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-4-24 17:48:06
     * @ Update    :  
     ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
</body>
<%
  
  
  String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
  String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String regionCode = iOrgCode.substring(0,2);
  
  String unit_id = WtcUtil.repNull((String)request.getParameter("unit_id"));
  String smCodes = WtcUtil.repNull((String)request.getParameter("smCodes"));
  String[] smCodeArray = smCodes.split("~");
  String[] tempAccept = new String[smCodeArray.length];
  String[] tempIdNo = new String[smCodeArray.length];
  String[] tempSmCode = new String[smCodeArray.length];
  for(int i = 0;i<tempAccept.length;i++){
      tempAccept[i] = WtcUtil.repNull((String)request.getParameter("loginAccept_"+smCodeArray[i]));
      tempIdNo[i] = WtcUtil.repNull((String)request.getParameter("idNo"+smCodeArray[i]));
      tempSmCode[i] = smCodeArray[i];
  }
  String tmpR1 = WtcUtil.repNull((String)request.getParameter("tmpR1"));
  String tmpR2 = WtcUtil.repNull((String)request.getParameter("tmpR2"));
  String tmpR3 = WtcUtil.repNull((String)request.getParameter("tmpR3"));
  String tmpR4 = WtcUtil.repNull((String)request.getParameter("tmpR4"));
  String tmpR5 = WtcUtil.repNull((String)request.getParameter("tmpR5"));
  //liujian 2013-5-8 11:01:15
  String tmpR7 = WtcUtil.repNull((String)request.getParameter("tmpR7"));
  String tmpR8 = WtcUtil.repNull((String)request.getParameter("tmpR8"));
  String tmpR9 = WtcUtil.repNull((String)request.getParameter("tmpR9"));
  
  String iLoginAccept = WtcUtil.repNull((String)request.getParameter("sysAccept"));
  String packetCode = WtcUtil.repNull((String)request.getParameter("packet_code"));
  System.out.println("unit_id="+unit_id);
  System.out.println("smCodes="+smCodes);
  System.out.println("iLoginAccept="+iLoginAccept);
  System.out.println("packetCode="+packetCode);
  for(int i = 0;i<tempAccept.length;i++){
     System.out.println("liujian tempAccept["+i+"]="+tempAccept[i]);
     System.out.println("liujian tempIdNo["+i+"]="+tempIdNo[i]);
     System.out.println("liujian smCodeArray["+i+"]="+smCodeArray[i]);
  }
  

  System.out.println("#   短号     = "+tmpR1);
  System.out.println("#   手机号码 = "+tmpR2);
  System.out.println("#   客户姓名 = "+tmpR3);
  System.out.println("#   证件号码 = "+tmpR4);
  System.out.println("#   备注信息 = "+tmpR5);
  
  System.out.println("#   liujian 7482 = "+tmpR7);
  System.out.println("#   liujian 7482 = "+tmpR8);
  System.out.println("#   liujian 7482 = "+tmpR9);
  System.out.println("#   liujian 7482 smCodes= "+smCodes);
  System.out.println("#   liujian 7482 tempSmCode= "+tempSmCode);
  System.out.println("#   liujian 7482 tempAccept= "+tempAccept);
  System.out.println("#   liujian 7482 tempIdNo= "+tempIdNo);
  
  String packet_code_is_600001 = WtcUtil.repNull((String)request.getParameter("packet_code_is_600001"));
  System.out.println("hejwa-------------packet_code_is_600001------------------>"+packet_code_is_600001);
  
  
  if(!"0".equals(packet_code_is_600001)){
  	smCodes = WtcUtil.repNull((String)request.getParameter("i_600001_smCodes"));
  	
  	tempSmCode = WtcUtil.repNull((String)request.getParameter("i_600001_smCodes")).split("~");
  	tempAccept = WtcUtil.repNull((String)request.getParameter("i_600001_Accept")).split("~");
  	tempIdNo   = WtcUtil.repNull((String)request.getParameter("i_600001_idNo")).split("~");
  	
  	System.out.println("hejwa-------------smCodes------------------>"+smCodes);
  	System.out.println("hejwa-------------tempSmCode--------------->"+tempSmCode.length);
  	System.out.println("hejwa-------------tempAccept--------------->"+tempAccept.length);
  	System.out.println("hejwa-------------tempIdNo----------------->"+tempIdNo.length);
  	
 	}
  
try{
%>
<wtc:service name="s7482Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage"  outnum="2" >
	<wtc:param value="<%=workNo%>"/><!--0-->
	<wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
  <wtc:param value="<%=iIpAddr%>"/>
  <wtc:param value="<%=unit_id%>"/>
  <wtc:param value="<%=tmpR1%>"/><!--5-->
  <wtc:param value="<%=tmpR2%>"/>  
  <wtc:param value="<%=tmpR3%>"/>
  <wtc:param value="<%=tmpR4%>"/> 
  <wtc:param value="<%=tmpR5%>"/> 
  <wtc:param value="<%=smCodes%>" /><!--10-->
  <wtc:param value="<%=iLoginAccept%>" />
  <wtc:param value="<%=packetCode%>" />
  <wtc:param value="<%=tmpR7%>"/>
  <wtc:param value="<%=tmpR8%>"/> 
  <wtc:param value="<%=tmpR9%>"/> 	<!--15-->
  <wtc:params value="<%=tempSmCode%>"/>
  <wtc:params value="<%=tempAccept%>"/>
  <wtc:params value="<%=tempIdNo%>"/>
  
  	
</wtc:service>
<wtc:array id="result" scope="end" />


<%

if("000000".equals(retCode)){
            String errPhoneList = result[0][0];
            String errMsgList   = result[0][1];
        /* 成功后转到错误展示页面 */
          
        %>
            <script language='jscript'>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                
                frm.action="f7482_result.jsp";
              	frm.method="post";
              	frm.submit();
            </script>           
        <%
        }else{
            %>
            <!--wuxy alter 20100313错误信息:retMsg  -->
            <script type=text/javascript>
                rdShowMessageDialog("操作失败！<br/>错误代码：[<%=retCode%>]，错误信息:[<%=retMessage%>]",0);
                window.location="f7482_1.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s7983Cfm失败！",0);
            window.location="f7482_1.jsp";
        </script>        
        <%
        System.out.println("# return from f7482_2.jsp -> Call Service s7983Cfm Failed!");
        e.printStackTrace();
    }
    
%>
</html>
<%
/********************
    version v2.0
    开发商: si-tech
    zhouby
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

    String opCode = WtcUtil.repNull(request.getParameter("opcode"));
    String opName = WtcUtil.repNull(request.getParameter("opName"));

    String pageTitle = "在网信息";
    String fieldNum = "";
    
    String password = (String)session.getAttribute("password");	
	  String work_no = (String)session.getAttribute("workNo");
	  String ipAddr = (String)session.getAttribute("ipAddr");
	  String regionCode= (String)session.getAttribute("regCode");
	  
	  String id_iccid =WtcUtil.repNull(request.getParameter("idIccid"));
	  String idtype=WtcUtil.repNull(request.getParameter("idtype"));
	  String custnames=WtcUtil.repNull(request.getParameter("custnames"));
	  
	  if(!idtype.equals("0")) {
	  		/*custnames="";*/
	  }
	  
	  System.out.println("-----------opCode---"+opCode);
	  System.out.println("-----------id_iccid---"+id_iccid);
	  System.out.println("-----------idtype---"+idtype);
	  System.out.println("-----------custnames---"+custnames);
%>

<HTML><HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
  <%@ include file="/npage/include/header_pop.jsp" %>  
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>

  <wtc:service name="sm366Qry" outnum="6"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=id_iccid%>"/>
      <wtc:param value="<%=idtype%>"/>
      <wtc:param value=""/>
      <wtc:param value="1"/>
  </wtc:service>
  
		<wtc:array id="result22" scope="end"  start="0"  length="1"/>
		<wtc:array id="result" scope="end"  start="1"  length="1"/>
 <%
      		System.out.println(result.length+"=================result");
	      		if(retCode1.equals("000000")) {
			      		String phoneNum = "0";
			      		String broadNum = "0";
			      		String isduo = "0";
								if(result.length>0) {
									phoneNum=result[0][0];
								//	broadNum=result[0][1];
								//	isduo=result[0][2];
								}
			    		  out.print("<table cellspacing='0'><TR>");
			    		       out.print("<TD >");
			    		           out.print("<div>手机号码已开用户数:");
			    		           out.print(phoneNum);
			    		           out.print("</div>");
			    		       out.print("</TD>");
			    		       out.print("<TD >");
		    		           out.print("<div>宽带号码已开用户数:");
		    		           out.print(broadNum);
		    		           out.print("</div>");
		    		       out.print("</TD>");
		    		       out.print("<TD >");
		    		       if(isduo.equals("1")){
		    		    	   out.print("<div>此证件号码存在一证多名");
		    		       }
	    		           out.print("</div>");
	    		       out.print("</TD>");
			    		    out.print("</TR></table>");
			    		    
	    		  }else {
	    		  		
			    		  out.print("<table cellspacing='0'><TR>");
			    		       out.print("<TD >");
			    		           out.print("<div>查询在网信息失败！错误代码："+retCode1+"，错误信息："+retMsg1);
			    		           out.print("</div>");
			    		       out.print("</TD>");
			
			    		    out.print("</TR></table>");	    		  		
	    		  		
	    		  }
        		    
%>      		 

    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>

  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    

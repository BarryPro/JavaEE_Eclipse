<%
    /*************************************
    * ��  ��: �ֻ�֧��ʵ������ e629
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-2-21
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String iPhoneNo = request.getParameter("activePhone");
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
%>

<HTML>
<HEAD>
    <TITLE>�ֻ�֧��ʵ������</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
    function subInfo(){
      var myPacket = new AJAXPacket("fe629_ajax_sunInfo.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
    	myPacket.data.add("iPhoneNo","<%=iPhoneNo%>");
    	myPacket.data.add("loginNo","<%=loginNo%>");
    	myPacket.data.add("password","<%=password%>");
	    myPacket.data.add("opCode","<%=opCode%>");
    	core.ajax.sendPacket(myPacket,doSubInfo);
    	myPacket=null; 
    }
    
    function doSubInfo(packet){
        var retCode = packet.data.findValueByName("retcode");
        var retMsg = packet.data.findValueByName("retmsg");
        if(retCode!="000000"){
             rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
             window.location.href="fe629_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }else{
            rdShowMessageDialog("�ύ�ɹ���",2);
            window.location.href="fe629_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
</SCRIPT>
<form name="frme535" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">�ֻ�֧��ʵ������</div>
	        </div>
            <table cellspacing="0">
            	<tr>
            		<td class="blue"  nowrap>�ֻ�����</td>
            	    <td colspan="3">
            	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=iPhoneNo%>" size="20" readonly>
            	    </td>
            	</tr>
            	<tr>
                  <td colspan="4" align="center" id="footer">
                      <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="subInfo()" />   
                      <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                  </td>
              </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>


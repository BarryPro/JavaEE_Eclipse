<%
    /*************************************
    * ��  ��: ��ͨЭ��ǩԼ��Ϣ��ѯ e626
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
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String iPhoneNo = request.getParameter("activePhone");
    
    String  inputParsm [] = new String[8];
    inputParsm[0] = "";
    inputParsm[1] = "01";
    inputParsm[2] = opCode;
    inputParsm[3] = loginNo;
    /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 oneline */
    inputParsm[4] = password; 
    inputParsm[5] = iPhoneNo;
    inputParsm[6] = "";
    inputParsm[7] = "06";
%>  
    <wtc:service name="s9387Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="9"> 
        <wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
        <wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
    </wtc:service>  
    <wtc:array id="tempArr"  scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	
	System.out.println("errCode="+errCode);
	System.out.println("errMsg ="+errMsg);
	System.out.println("------tempArr.length ="+tempArr.length); 
	
	
	if(!(errCode.equals("000000")))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
		    removeCurrentTab();
		</script>
<%
  }else{
	    if(tempArr.length == 0){
%>
    		<script language="JavaScript">
    			rdShowMessageDialog("δ��ѯ�����û�������Ϣ��",0);
    			removeCurrentTab();
    		</script>
<%      
    	}else{
%>	
<HTML>
<HEAD>
    <TITLE>��ͨЭ��ǩԼ��Ϣ��ѯ</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
    function queryInfo(){
    		var markDiv=$("#intablediv"); 
        markDiv.empty();
        var myPacket = new AJAXPacket("fe626_ajax_queryInfo.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	    	myPacket.data.add("iPhoneNo","<%=iPhoneNo%>");
	    	myPacket.data.add("opCode","<%=opCode%>");
	    	myPacket.data.add("loginNo","<%=loginNo%>");
	    	myPacket.data.add("password","<%=password%>");
	    	myPacket.data.add("opName","<%=opName%>");
	    	core.ajax.sendPacketHtml(myPacket,doQueryInfo);
	    	myPacket=null; 
    }
    
    function doQueryInfo(data){
    		//�ҵ���ӱ���div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
    		markDiv.append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
             rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
             window.location.href="fe626_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
</SCRIPT>
<form name="frme626" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">�û���Ϣ</div>
	        </div>
            <table cellspacing="0">
            	<tr>
            		<td class="blue" nowrap>�ͻ�����</td>
            	    <td>
            	    	<input class="InputGrey" type="text" name="custName" id="custName" value="<%=tempArr[0][2]%>" size="20" readonly>
            	    </td>
            		<td class="blue" nowrap>�ֻ�����</td>
            	    <td >
            	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=iPhoneNo%>" size="20" readonly>
            	    </td>
            	</tr>
            	<tr>
            		<td class="blue"  nowrap>��������</td>
            	    <td colspan="3">
            	    	<input class="InputGrey" type="text" name="belongCode" id="belongCode" value="<%=tempArr[0][7]%>" size="20" readonly>
            	    </td>
            	</tr>
            	 <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="��ѯ" onClick="queryInfo()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>
<%
    }
}
%>

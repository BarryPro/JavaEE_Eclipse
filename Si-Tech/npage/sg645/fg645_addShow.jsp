<%
  /*
   * ����: ��Ӽ�ͥ��Ա
   * �汾: 1.0
   * ����: 2013-4-26 18:03:53
   * ����: yansca
   * ��Ȩ: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<script language=javascript>
       
    function doAddMemSubmit()
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��ͥ��Ա��Ϣ��')==1)
       {
            document.all.b_submit.disabled=true;
            document.all.b_close.disabled=true;
            frm.action="fg645_addSubmit.jsp";
            frm.submit();
       }
    }
       
   function checkPwd()
   {
   	  if(!check(frm)){
          return false;
      }
      var passWord = document.frm.passWord.value;
      var checkPwd_Packet = new AJAXPacket("/npage/s4116/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
      checkPwd_Packet.data.add("retType","checkPwd");
	    checkPwd_Packet.data.add("Pwd1",passWord);
	    checkPwd_Packet.data.add("phone_no",document.frm.phoneNo.value);
	    core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
	    checkPwd_Packet = null;
  }
  
  function doCheckPwd(packet)
 {
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	  var retMessage=packet.data.findValueByName("retMessage");
	
    self.status="";
    
    if(retType == "checkPwd") //����У��
	  {
		   if(retCode == "000000")
		  {
		      var retResult = packet.data.findValueByName("retResult");
		      if (retResult == "false") {
		    	    rdShowMessageDialog("����У��ʧ�ܣ����������룡",0);
		    	    frm.passWord.value = "";
		    	    return false;	        	
		      }
		      else
		     {
				    rdShowMessageDialog("����У��ɹ���",2);
				    document.frm.b_submit.disabled = false;
		     }
		  }
		  else
		 {
		    rdShowMessageDialog("����У�����������У�飡",0);
			  return false;
		 }
	 } 
 }	
      
</script>
<%
	String phoneNo = request.getParameter("phoneNo");
	String custId = request.getParameter("custId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
%>
<wtc:service name="sG645CheckMem" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	  <wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
<%
 if("000000".equals(retCode)){
%>

<wtc:service name="sG645QryMemInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
	  <wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
<%
    if("000000".equals(retCode)){
        if(retList.length > 0) {
%>
<form  name="frm" method="POST">
<input type="hidden" id="opCode" name ="opCode" value="<%=opCode%>" />
<input type="hidden" id="opName" name ="opName" value="<%=opName%>" />
<input type="hidden" id="masterFlag" name="masterFlag" value="retList[0][3]" />
<input type="hidden" id="userId" name ="userId" value="<%=retList[0][4]%>" />
<input type="hidden" id="homeCustId" name ="homeCustId" value="<%=custId%>" />
<div class="title">
		<div id="title_zi">��Ա��Ϣ</div>
</div>
<table cellspacing="0">
	   
     <tr>
     	    <td class="blue"> 
               <div align="left">��Ա���ƣ�</div>
          </td>
          <td> 
               <input id="custName"  name="custName" value="<%=retList[0][0]%>" readonly />
          </td>
     	    <td class="blue"> 
               <div align="left">��Ա���룺</div>
          </td>
          <td> 
               <input id="phoneNo"  name="phoneNo" value="<%=retList[0][2]%>" readonly />
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">����Ʒ�ƣ�</div>
          </td>
          <td> 
          	   <select id="smCode" name="smCode" disabled="disabled">
                  <wtc:pubselect name="sPubSelect" outnum="2" retcode="ret" retmsg="retm" routerKey="region" routerValue="<%=regionCode%>">
                          <wtc:sql>select distinct(SM_CODE),trim(SM_NAME) from sSmCode order by SM_CODE</wtc:sql>
                  </wtc:pubselect>
                  <wtc:iter id="rows" indexId="i">
                          <%if (rows[0].equals(retList[0][1])) {%>
                                <option selected="selected" value="<%=rows[0]%>">
                                	    <%=rows[0]%>---><%=rows[1]%>
                                </option>
                         <%} else {%>
                                 <option value="<%=rows[0]%>">
                                 	     <%=rows[0]%>--><%=rows[1]%>
                                 </option>
                         <%}%>
                  </wtc:iter>
               </select>
          </td>
     	     <td class="blue"> 
               <div align="left">��ͥ��ɫ��</div>
          </td>
          <td> 
               <input id="homeRole" name="homeRole" value="<%if ("0".equals(retList[0][3])) {%>��Ա<%} else {%>������<%}%>" readonly />
          </td>
     </tr>
     
     <tr>
     	    <td class="blue">����</td>
		      <td> 
			    <jsp:include page="/npage/common/pwd_1.jsp">
		          <jsp:param name="width1" value="16%"  />
		          <jsp:param name="width2" value="34%"  />
		          <jsp:param name="pname" value="passWord"  />
		          <jsp:param name="pwd" value="accountPasswd"  />
	            </jsp:include>
	        <input name="chkPass" type="button" onClick="checkPwd();" class="b_text" style="cursor:hand" id="chkPass" value=У��>
          <font class="orange">*</font>
    	</td>
     </tr>
    
     <table cellSpacing="0">
        <tr> 
          <td id="footer" >
              <input class="b_foot"  id="b_submit" name="b_submit"   onclick="doAddMemSubmit();" type="button" value="�ύ" disabled="disabled" />
			        <input class="b_foot"  id="b_close" name="b_close"    onclick="javascript:window.close();" type="button" value="�ر�" />
			    </td>
        </tr>
    </table>
</table>
</form>
<%}}}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />

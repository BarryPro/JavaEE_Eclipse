<%
  /*
   * 功能: 家庭客户信息查询
   * 版本: 1.0
   * 日期: 2013-4-30 10:54:11
   * 作者: yansca
   * 版权: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	//String finishFlag = request.getParameter("finishFlag");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
	String printAccept = ""; 
	String masterPhone = "";
%>

<form  name="frm" method="POST">

<wtc:service name="sG646CustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="23">
	  <wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>

<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />
<%
    if("000000".equals(retCode)){
        if(retList.length > 0) {
%>
<input type="hidden" id="opCode" name ="opCode" value="<%=opCode%>" />
<input type="hidden" id="opName" name ="opName" value="<%=opName%>" />
<input type="hidden" id="masterPhone" name ="masterPhone" value="<%=retList[0][10]%>" />
<input type="hidden" id="masterCustId" name ="masterCustId" value="<%=retList[0][11]%>" />
<input type="hidden" id="masterUserId" name ="masterUserId" value="<%=retList[0][12]%>" />
<input type="hidden" id="custId" name ="custId" value="<%=retList[0][13]%>" />
<input type="hidden" id="custPasswd" name ="custPasswd" value="<%=retList[0][16]%>" />
<input type="hidden" id="custStatus" name ="custStatus" value="<%=retList[0][17]%>" />
<input type="hidden" id="ownerGrade" name ="ownerGrade" value="<%=retList[0][18]%>" />
<input type="hidden" id="ownerType" name ="ownerType" value="<%=retList[0][19]%>" />
<input type="hidden" id="custAddress" name ="custAddress" value="<%=retList[0][20]%>" />
<input type="hidden" id="contactAddress" name ="contactAddress" value="<%=retList[0][21]%>" />
<input type="hidden" id="contactMailAddress" name ="contactMailAddress" value="<%=retList[0][22]%>" />
<input type="hidden" id="address" name ="address" value="<%=retList[0][20]%>" />
<input type="hidden" id="vmUserId" name ="vmUserId" value="<%=retList[0][14]%>" />
<input type="hidden" id="vmPhoneNo" name ="vmPhoneNo" value="<%=retList[0][15]%>" />
<div class="title">
		<div id="title_zi">基本信息</div>
</div>
<table cellspacing="0">
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭户主姓名：</div>
          </td>
          <td> 
               <input id="masterCustName"  name="masterCustName" value="<%=retList[0][0]%>"  readonly="readonly" class="InputGrey"/>
          </td>
     	    <td class="blue"> 
               <div align="left">家庭户主类型：</div>
          </td>
          <td> 
          	  <select id="masterIdType" name="masterIdType" disabled="disabled">
                  <wtc:pubselect name="sPubSelect" outnum="2" retcode="ret" retmsg="retm" routerKey="region" routerValue="<%=regionCode%>">
                          <wtc:sql>select trim(id_type),trim(id_name) from sIdType order by id_type</wtc:sql>
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
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭户主号码：</div>
          </td>
          <td> 
               <input id="masterIdIccid"  name="masterIdIccid" value="<%=retList[0][2]%>"  readonly="readonly" class="InputGrey"/>
          </td>
     	     <td class="blue"> 
               <div align="left">家庭户主证件地址：</div>
          </td>
          <td> 
               <input id="masterIdAdress" name="masterIdAdress" value="<%=retList[0][3]%>"  size="100" readonly="readonly" class="InputGrey"/>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭户主证件有效期：</div>
          </td>
          <td> 
               <input type="text" id="masterIdDate" name="masterIdDate"  value="<%=retList[0][4]%>" readonly="readonly" class="InputGrey"/>
          </td>
     	    <td class="blue"> 
               <div align="left">邮政编码：</div>
          </td>
          <td> 
               <input id="postNo"  name="postNo" value="<%=retList[0][5]%>" readonly="readonly" class="InputGrey" />
          </td>
     </tr>
     <tr>
     	     <td class="blue"> 
               <div align="left">联系人：</div>
          </td>
          <td> 
               <input id="contactName"  name="contactName" value="<%=retList[0][6]%>" readonly="readonly" class="InputGrey" />
          </td>
     	    <td class="blue"> 
               <div align="left">联系电话：</div>
          </td>
          <td> 
               <input id="contactPhone"  name="contactPhone" value="<%=retList[0][7]%>" readonly="readonly" class="InputGrey" />
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">传真：</div>
          </td>
          <td> 
               <input id="faxNo"  name="faxNo" value="<%=retList[0][8]%>" readonly="readonly" class="InputGrey" />
          </td>
     	    <td class="blue"> 
               <div align="left">电子邮件：</div>
          </td>
          <td> 
               <input id="email"  name="email" value="<%=retList[0][9]%>" readonly="readonly" class="InputGrey" />
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭住址：</div>
          </td>
          <td> 
               <input type="text" id="address"  name="address" value="<%=retList[0][20]%>"  readonly="readonly" class="InputGrey" />
                <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭用户ID：</div>
          </td>
          <td> 
               <input id="vmUserId"  name="vmUserId" value="<%=retList[0][14]%>" readonly="readonly" class="InputGrey" />
          </td>
     	    <td class="blue"> 
               <div align="left">家庭用户号码：</div>
          </td>
          <td> 
               <input id="vmPhoneNo"  name="vmPhoneNo" value="<%=retList[0][15]%>" readonly="readonly" class="InputGrey" />
          </td>
     </tr>

</table>
<%}}%>

</form>
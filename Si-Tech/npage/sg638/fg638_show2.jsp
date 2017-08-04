<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/02/16 关于融合套餐界面优化功能
* 作者: liangyl
* 版权: si-tech
*/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
	String phoneNo = request.getParameter("phoneNo");
	String custPassWord = request.getParameter("passWord");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");

	System.out.println("+++++++++++++++++fg638_show.jsp.phoneNo="+phoneNo);
	System.out.println("+++++++++++++++++fg638_show.jsp.custPassWord="+custPassWord);
	System.out.println("+++++++++++++++++fg638_show.jsp.workNo="+workNo);
	System.out.println("+++++++++++++++++fg638_show.jsp.passWord="+passWord);
	System.out.println("+++++++++++++++++fg638_show.jsp.groupId="+groupId);
	System.out.println("+++++++++++++++++fg638_show.jsp.regionCode="+regionCode);
%>




<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
<script language=javascript>
$(function(){
	printCommit();
})

		function native2ascii (value) 
    { 
    var nativecode = value.split (""); 
    var len = 0; 
    for ( var i = 0; i < nativecode.length; i++) 
    { 
    var code = Number (nativecode[i].charCodeAt (0)); 
    if (code > 127) 
    { 
    len ++; 
    } 
    } 
    return len; 
    } 

	     function printCommit() {
	        
	    	 $("#masterIdType").removeAttr("disabled");
	    	 $("#masterCustName").removeAttr("disabled");
	    	 $("#masterIdIccid").removeAttr("disabled");
	    	 $("#masterIdAdress").removeAttr("disabled");
	    	 $("#masterIdDate").removeAttr("disabled");
	    	 $("#contactName").removeAttr("disabled");
	    	 $("#contactPhone").removeAttr("disabled");
	    	 $("#faxNo").removeAttr("disabled");
	    	 $("#email").removeAttr("disabled");
	    	 
	    	 var address = document.all.address.value;
	    	// if(native2ascii(address) < 8){
			 //    rdShowMessageDialog("家庭住址最少需要输入8个汉字！");
			 //    setDisabled();
			 //    return false;
		    // }
	    	 

	     	if(!check(frm)){
	     		
	     		setDisabled();
                return false;
            }
	          //showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	         // if(rdShowConfirmDialog('确认要提交家庭客户开户信息吗？')==1)
            //{
                 doSubmit();
            //}else{
            //	setDisabled();
           // }
	     }
	     
	     function showPrtDlg(printType,DlgMessage,submitCfm)
       {
       	    //显示打印对话框 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // 打印类型：print 打印 subprint 合并打印 printstore 打印存储
            var billType="1";                    // 票价类型：1电子免填单、2发票、3收据
            var printStr=printInfo(printType,<%=loginAccept%>);   //调用printinfo()返回的打印内容
            var sysAccept="<%=loginAccept%>";    //流水号
            var mode_code=null;                  //资费代码
            var fav_code=null;                   //特服代码
            var area_code=null;                  //小区代码
            var opCode="<%=opCode%>";            //操作代码
            var phoneNo=frm.masterPhone.value;                      //客户电话
            
	          var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	          var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;

	          var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	          var ret=window.showModalDialog(path,printStr,prop);
	          
	          
            if(rdShowConfirmDialog('确认要提交家庭客户开户信息吗？')==1)
            {
                 doSubmit();
            }else{
            	setDisabled();
            }
       }
       
       function doSubmit()
       {
           document.all.b_print.disabled=true;
           document.all.b_clear.disabled=true;
           document.all.b_back.disabled=true;
           $("#buzhou1").css("display","");
           frm.target="buzhou1";
           frm.action="fg638_submit2.jsp";
           frm.submit();
           
       }
       
       function printInfo(printType,loginAccept)
      {
           var retInfo = "";
           if(printType == "Detail")
           {	
		        var cust_info=""; //客户信息
		        var opr_info=""; //操作信息
		        var note_info1=""; //备注1
		        var note_info2=""; //备注2
		        var note_info3=""; //备注3
		        var note_info4=""; //备注4
		
		        cust_info+="客户姓名：	"+frm.masterCustName.value+"|";
	          cust_info+="手机号码：	"+frm.masterPhone.value+"|";
	  
		        opr_info+="业务流水："+loginAccept+"|";
		        opr_info+="家庭户主姓名："+frm.masterCustName.value+"|";
		        //opr_info+="家庭户主证件号码："+frm.masterIdIccid.value+"|";//免填单去掉敏感信息
		        //opr_info+="家庭户主证件地址："+frm.masterIdAdress.value+"|";//免填单去掉敏感信息
		        //opr_info+="家庭户主证件有效期："+frm.masterIdDate.value+"|";//免填单去掉敏感信息
		        opr_info+="邮政编码："+frm.postNo.value+"|";
		        opr_info+="联系人："+frm.contactName.value+"|";
		        opr_info+="联系电话："+frm.contactPhone.value+"|";
		        opr_info+="传真："+frm.faxNo.value+"|";
		        opr_info+="电子邮件："+frm.email.value+"|";
		        opr_info+="家庭住址："+frm.address.value+"|";
		
		        note_info1+="备注：新建家庭客户|";

		        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	        }  
	        return retInfo;	
      }
       // 校验客户名称
       function checkCustName(textName)
      {
	       if(textName.value != "")
	      {
			     var m = /^[\u0391-\uFFE5]+$/;
			     var flag = m.test(textName.value);
			     if(!flag){
				   rdShowMessageDialog("只允许输入中文！");
				   reSetCustName();

			     if(textName.value.length > 6){
				     rdShowMessageDialog("只允许输入6个汉字！");
				     reSetCustName();
			     }
		       }else{
			         if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			        {
				         rdShowMessageDialog("不允许输入非法字符！");
				         textName.value = "";
	 	  		       return;
			        }
		      }
	     }
     }
     
     function reSetCustName(){/*重置客户名称*/
	       document.all.masterCustName.value="";
     }
    
    <%--  function checkPwdEasy(pwd) {
	      if(pwd == ""){
		       rdShowMessageDialog("请先输入密码！");
		        return ;
	       }
	  
	       var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
	       checkPwd_Packet.data.add("password", pwd);
	       checkPwd_Packet.data.add("phoneNo", "00000000000");
	       checkPwd_Packet.data.add("idNo", frm.masterIdIccid.value);
	       checkPwd_Packet.data.add("opCode", "<%=opCode%>");
	       checkPwd_Packet.data.add("custId", "");

	       core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	       checkPwd_Packet=null;
    } --%>

   /*  function doCheckPwdEasy(packet) {
	       var retResult = packet.data.findValueByName("retResult");
	       if (retResult == "1") {
		         rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		         document.all.custPwd.value="";
		         document.all.cfmPwd.value="";
		         return;
	       } else if (retResult == "2") {
		         rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		         document.all.custPwd.value="";
		         document.all.cfmPwd.value="";
		         return;
	       } else if (retResult == "3") {
		         rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		         document.all.custPwd.value="";
		         document.all.cfmPwd.value="";
		         return;
	       } else if (retResult == "4") {
		         rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		         document.all.custPwd.value="";
		         document.all.cfmPwd.value="";
		         return;
	       } else if (retResult == "0") {
		         //rdShowMessageDialog("校验成功！密码可用！");
	       } 
    } */
    
    function addClassForIccid(idType) {
         if (idType == '0') {
             $("#masterIdIccid").attr("v_type","idcard");
             $("#masterIdIccid").attr("maxlength","18");
         } else {
             $("#masterIdIccid").removeAttr("v_type");
             $("#masterIdIccid").removeAttr("maxlength");
         }
    }
    
    function setDisabled(){
    	$("#masterIdType").attr("disabled","disabled");
 		$("#masterCustName").attr("disabled","disabled");
 		$("#masterIdIccid").attr("disabled","disabled");
 		$("#masterIdAdress").attr("disabled","disabled");
 		$("#masterIdDate").attr("disabled","disabled");
 		$("#contactName").attr("disabled","disabled");
 		$("#contactPhone").attr("disabled","disabled");
 		$("#faxNo").attr("disabled","disabled");
 		$("#email").attr("disabled","disabled");
  }
</script>


<%-- <wtc:service name="sG638Check" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	  <wtc:param value="<%=phoneNo%>"/>
	   <wtc:param value="<%=custPassWord%>"/>
</wtc:service> --%>
<%-- <wtc:array id="retList"  scope="end"/> --%>

<wtc:service  name="sPubCustCheck"  routerKey="phone"  routerValue="<%=phoneNo%>"  outnum="5" retcode="return_code" retmsg="return_msg">
	<wtc:param  value="01"/>
	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value="<%=custPassWord%>"/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value="<%=workNo%>"/>
</wtc:service>
<wtc:array  id="nameArr"  start="0"  length="1" scope="end" />
<wtc:array  id="statArr"  start="0"  length="1" scope="end" />
<wtc:array  id="brandArr"  start="2"  length="1" scope="end" />


<%
System.out.println("+++++++++++++++++++++sG638Qry.return_code++"+return_code);   
System.out.println("+++++++++++++++++++++sG638Qry.return_msg++"+return_msg);
//return_code="000000";
if("000000".equals(return_code)){

%>

	
<wtc:service name="sG638Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retMsg="retMsg" outnum="13">
	  <wtc:param value="<%=loginAccept%>"/>
	  <wtc:param value="<%=phoneNo%>"/>
	  <wtc:param  value="<%=custPassWord%>"/>
	  <wtc:param  value="<%=workNo%>"/>
	  <wtc:param  value="<%=passWord%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
<%

if("000000".equals(retCode)){
        if(retList.length > 0) {
%>
<form  name="frm" method="POST">

<input type="hidden" id="opCode" name ="opCode" value="<%=opCode%>" />
<input type="hidden" id="opName" name ="opName" value="<%=opName%>" />
<input type="hidden" id="masterPhone" name ="masterPhone" value="<%=retList[0][10]%>" />
<input type="hidden" id="masterCustId" name ="masterCustId" value="<%=retList[0][11]%>" />
<input type="hidden" id="masterUserId" name ="masterUserId" value="<%=retList[0][12]%>" />
<input type="hidden" id="loginAccept" name ="loginAccept" value="<%=loginAccept%>" />
<input type="hidden" id="custPwd" name ="custPwd" value="<%=custPassWord%>" />
<div class="title">
		<div id="title_zi">基本信息</div>
</div>
<table cellspacing="0">
	  <%--  <tr id ="divPassword" style="display:;"> 
				   <jsp:include page="/npage/sq100/f1100_pwd.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="custPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 			<jsp:param name="pvalue" value="" />
				   </jsp:include>
     </tr> --%>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭户主姓名：</div>
          </td>
          <td> 
               <input type="text" id="masterCustName"  name="masterCustName" value="<%=retList[0][0]%>"  v_must="1" v_type="string" onkeyup="checkCustName(this);" maxlength="6" readonly disabled="disabled"/>
               <font class=orange>*&nbsp;(不超过六个汉字)</font>
          </td>
     	    <td class="blue"> 
               <div align="left">家庭户主证件类型：</div>
          </td>
          <td> 
          	  <select  id="masterIdType" name="masterIdType" onChange="addClassForIccid(this.value);" disabled="disabled" readonly>
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
               <div align="left">责任人证件号码：</div>
          </td>
          <td> 
               <input  type="text" id="masterIdIccid"  readonly  name="masterIdIccid" value="<%=retList[0][2]%>" v_must="1" <%if ("0".equals(retList[0][1])){%> v_type="string" maxlength="18" disabled="disabled" <%}else{%>maxlength="5" disabled="disabled"<%}%>/>
               <font class=orange>*</font> 
          </td>
     	     <td class="blue"> 
               <div align="left">家庭户主证件地址：</div>
          </td>
          <td> 
               <input disabled="disabled" readonly type="text" id="masterIdAdress" name="masterIdAdress" value="<%=retList[0][3]%>" v_must="1"  v_type="string"  size="60"  maxlength="60"/>
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">家庭户主证件有效期：</div>
          </td>
          <td> 
               <input disabled="disabled" readonly type="text" id="masterIdDate" name="masterIdDate"  value="<%=retList[0][4]%>" v_must="1" v_maxlength="8" />
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">邮政编码：</div>
          </td>
          <td> 
               <input type="text" id="postNo"  name="postNo" value="<%=retList[0][5]%>" v_maxlength="6" v_type="string"  />
               <!-- <font class=orange>*</font> -->
          </td>
     </tr>
     <tr>
     	     <td class="blue"> 
               <div align="left">联系人：</div>
          </td>
          <td> 
               <input type="text" id="contactName"  name="contactName" value="<%=retList[0][6]%>" v_must="1" disabled="disabled" readonly/>
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">联系电话：</div>
          </td>
          <td> 
               <input disabled="disabled" readonly type="text" id="contactPhone"  name="contactPhone" value="<%=retList[0][7]%>" v_must="1" v_type="string" />
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">传真：</div>
          </td>
          <td> 
               <input disabled="disabled" readonly type="text" id="faxNo"  name="faxNo" value="<%=retList[0][8]%>" v_type="string" />
          </td>
     	    <td class="blue"> 
               <div align="left">电子邮件：</div>
          </td>
          <td> 
               <input disabled="disabled" readonly type="text" id="email"  name="email" value="<%=retList[0][9]%>" v_type="string" />
          </td>
     </tr>
      <tr>
     	    <td class="blue"> 
               <div align="left">家庭住址：</div>
          </td>
          <td> 
               <input type="text" id="address"  name="address" value="<%=retList[0][3]%>" v_must="1"  v_type="string"  size="60"  maxlength="60" />
                <font class=orange>*</font>
          </td>
     </tr>
     
     <table cellSpacing="0">
        <tr> 
          <td id="footer" >
              <input class="b_foot"  name="b_print"  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type="button" value="确认&打印" >
			        <input class="b_foot"  name="b_clear" type="button" onClick="frm.reset();" value="清除">
			        <input class="b_foot"  name="b_back"   onclick="removeCurrentTab()" type="button" value="关闭">
			    </td>
        </tr>
    </table>
</table>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
<%}}%>

<input type="hidden" id="checkRetCode" name="checkRetCode" value="<%=return_code%>" />
<input type="hidden" id="checkRetMsg" name="checkRetMsg" value="<%=return_msg%>" />
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />	
	
<%
}else{
	
%>
<form  name="frm" method="POST">
<table>
	<input type="hidden" id="checkRetCode" name="checkRetCode" value="<%=return_code%>" />
	<input type="hidden" id="checkRetMsg" name="checkRetMsg" value="<%=return_msg%>" />
</table>
</form>
<%	
}
%>



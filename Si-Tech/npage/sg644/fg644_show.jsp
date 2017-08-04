<%
  /*
   * 功能: 家庭客户信息维护
   * 版本: 1.0
   * 日期: 2013-4-29 14:48:14
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
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<script language=javascript>
	
	    function printCommit() {
	     	    if(!check(frm)){
                return false;
            }
	          showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
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
  
            if(rdShowConfirmDialog('确认要提交家庭客户变更信息吗？')==1)
            {
                 doSubmit();
            }
       }
	
       function doSubmit()
       {
           document.all.b_print.disabled=true;
           document.all.b_back.disabled=true;
           frm.action="fg644_submit.jsp";
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
		        opr_info+="责任人姓名："+frm.masterCustName.value+"|";
		        opr_info+="责任人证件号码："+frm.masterIdIccid.value+"|";
		        opr_info+="责任人证件地址："+frm.masterIdAdress.value+"|";
		        opr_info+="责任人证件有效期："+frm.masterIdDate.value+"|";
		        opr_info+="邮政编码："+frm.postNo.value+"|";
		        opr_info+="联系人："+frm.contactName.value+"|";
		        opr_info+="联系电话："+frm.contactPhone.value+"|";
		        opr_info+="传真："+frm.faxNo.value+"|";
		        opr_info+="电子邮件："+frm.email.value+"|";
		
		        note_info1+="备注：修改家庭客户资料|";

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
     
     function addClassForIccid(idType) {
         if (idType == '0') {
             $("#masterIdIccid").attr("v_type","idcard");
             $("#masterIdIccid").attr("maxlength","18");
         } else {
             $("#masterIdIccid").removeAttr("v_type");
             $("#masterIdIccid").removeAttr("maxlength");
         }
    }
 
</script>

<wtc:service name="sG644Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="23">
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
<input type="hidden" id="loginAccept" name ="loginAccept" value="<%=loginAccept%>" />
<div class="title">
		<div id="title_zi">基本信息</div>
</div>
<table cellspacing="0">
     <tr>
     	    <td class="blue"> 
               <div align="left">责任人姓名：</div>
          </td>
          <td> 
               <input id="masterCustName"  name="masterCustName" value="<%=retList[0][0]%>"  v_must="1" v_type="string" onkeyup="checkCustName(this);" />
               <font class=orange>*&nbsp;(不超过六个汉字)</font>
          </td>
     	    <td class="blue"> 
               <div align="left">责任人证件类型：</div>
          </td>
          <td> 
          	  <select id="masterIdType" name="masterIdType" onChange="addClassForIccid(this.value);">
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
               <input type="text" id="masterIdIccid"  name="masterIdIccid" value="<%=retList[0][2]%>" v_must="1" <%if ("0".equals(retList[0][1])) {%> v_type="idcard" maxlength="18" <%}else{%>maxlength="5"<%}%>/>
               <font class=orange>*</font> 
          </td>
     	     <td class="blue"> 
               <div align="left">责任人证件地址：</div>
          </td>
          <td> 
               <input id="masterIdAdress" name="masterIdAdress" value="<%=retList[0][3]%>"   v_must="1"  v_type="string" size="60" maxlength="60"/>
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">责任人证件有效期：</div>
          </td>
          <td> 
               <input type="text" id="masterIdDate" name="masterIdDate"  value="<%=retList[0][4]%>" v_must="1" v_maxlength="8" v_type="date" />
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">邮政编码：</div>
          </td>
          <td> 
               <input id="postNo"  name="postNo" value="<%=retList[0][5]%>" v_type="zip" v_name="联系人邮编" />
          </td>
     </tr>
     <tr>
     	     <td class="blue"> 
               <div align="left">联系人：</div>
          </td>
          <td> 
               <input id="contactName"  name="contactName" value="<%=retList[0][6]%>" v_must="1" />
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">联系电话：</div>
          </td>
          <td> 
               <input id="contactPhone"  name="contactPhone" value="<%=retList[0][7]%>" v_must="1" v_type="phone" />
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">传真：</div>
          </td>
          <td> 
               <input id="faxNo"  name="faxNo" value="<%=retList[0][8]%>" v_type="phone" />
          </td>
     	    <td class="blue"> 
               <div align="left">电子邮件：</div>
          </td>
          <td> 
               <input id="email"  name="email" value="<%=retList[0][9]%>" v_type="email" />
          </td>
     </tr>
     <table cellSpacing="0">
        <tr> 
          <td id="footer" >
              <input class="b_foot"  name="b_print"  onclick="printCommit()" type="button" value="确认&打印" >
			        <input class="b_foot"  name="b_back"   onclick="removeCurrentTab()" type="button" value="关闭">
			    </td>
        </tr>
    </table>
</table>
</form>
<%}}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />

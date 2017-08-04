<%
    /*************************************
    * 功  能: 手机便民卡订购@退订 e535
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-1-11
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

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
    String printAccept="";
    printAccept = getMaxAccept();
    
    
    String  inputParsm [] = new String[8];
    inputParsm[0] = "";
    inputParsm[1] = "01";
    inputParsm[2] = opCode;
    inputParsm[3] = loginNo;
    /* liujian 安全加固修改 2012-4-6 16:18:13 oneline */
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
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
		    removeCurrentTab();
		</script>
<%
    }else{
	    if(tempArr.length == 0){
%>
    		<script language="JavaScript">
    			rdShowMessageDialog("未查询到该用户基本信息！",0);
    			removeCurrentTab();
    		</script>
<%      
    }else{
%>	
<HTML>
<HEAD>
    <TITLE>手机便民卡订购</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
    window.onload=function(){
        var opCode = "<%=opCode%>";
        if(opCode=="e535"){
            $("#phoneConvenCardOrder").attr("checked","checked");
        }else if(opCode=="e536"){
            $("#phoneConvenCardUnsubscribe").attr("checked","checked");
            $("#showMessage").css("display","");
        }
    }
    
    function printCommit()
    {
      var radios = document.getElementsByName("radiobutton");
        var radioButtonVal = "";
        for(var i=0;i<radios.length;i++){
            if(radios[i].checked){
                radioButtonVal = radios[i].value;
            }
        }
      $("#radioButtonVal").val(radioButtonVal);
    	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    	if(typeof(ret)!="undefined")
    	{
    		if((ret=="confirm"))
    		{
    			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
    			{
    				subInfo();
    			}
    		}
    		if(ret=="continueSub")
    		{
    			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
    			{
    				subInfo();
    			}
    		}
    	}
    	else
    	{
    		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
    		{
    			subInfo();
    		}
    	}
    }
    
    function showPrtDlg(printType,DlgMessage,submitCfm)
    {  //显示打印对话框 
    	var h=210;
    	var w=400;
    	var t=screen.availHeight/2-h/2;
    	var l=screen.availWidth/2-w/2;
    	var pType="subprint";
    	var billType="1";
    	var printStr = printInfo(printType);
       
    	var mode_code=null;
    	var fav_code=null;
    	var area_code=null;
    	
    	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
    	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    	var ret=window.showModalDialog(path,printStr,prop);
    	return ret;
    }
    
    function printInfo(printType)
    {
       var cust_info="";
    	 var opr_info="";
    	 var note_info1="";
    	 var note_info2="";
    	 var note_info3="";
    	 var note_info4="";
      
    	 var retInfo = ""; 
    
    	cust_info+="手机号码：   "+document.all.phoneNo.value+"|";
    	cust_info+="客户姓名：   "+document.all.custName.value+"|";
    	cust_info+="客户地址：   "+document.all.custAddr.value+"|";
    	cust_info+="证件号码：   "+document.all.icIccid.value+"|";
    	
    	opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.smCode.value+ "|";
    	
      if(document.all.radioButtonVal.value=="e535"){
        opr_info+="办理业务：便民卡业务已开通，资费2元/月。"+"  业务流水："+document.all.printAccept.value+"|";
      }else if(document.all.radioButtonVal.value=="e536"){
        opr_info+="办理业务：便民卡业务已取消。"+"  业务流水："+document.all.printAccept.value+"|";
      }

    	if(document.all.radioButtonVal.value == "e535"){
    		note_info1+="备注：工号<%=loginNo%>为<%=iPhoneNo%>用户办理便民卡业务已开通。"+"|";
      }
    	else if(document.all.radioButtonVal.value == "e536"){
    		note_info1+="备注：工号<%=loginNo%>为<%=iPhoneNo%>用户办理便民卡业务已取消。"+"|";
      }
      else{
    		note_info1+="备注："+"|";
      }
    	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    	return retInfo;
    }

    function subInfo(){
      var radioButtonVal = $("#radioButtonVal").val();
      var myPacket = new AJAXPacket("fe535_ajax_sunInfo.jsp","正在获取信息，请稍候......");
    	myPacket.data.add("radioButtonVal",radioButtonVal);
    	myPacket.data.add("iPhoneNo","<%=iPhoneNo%>");
    	myPacket.data.add("loginNo","<%=loginNo%>");
    	myPacket.data.add("password","<%=password%>");
    	core.ajax.sendPacket(myPacket,doSubInfo);
    	myPacket=null; 
    }
    
    function doSubInfo(packet){
        var retCode = packet.data.findValueByName("retcode");
        var retMsg = packet.data.findValueByName("retmsg");
        if(retCode!="000000"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fe535_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }else{
            rdShowMessageDialog("提交成功！",2);
            window.location.href="fe535_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
    
    function isUnsubscribe(obj){
       if(obj.value=="e536"){
        $("#showMessage").css("display","");
      }else{
        $("#showMessage").css("display","none");
      }
    }
</SCRIPT>
<form name="frme535" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">用户信息</div>
	        </div>
            <table cellspacing="0">
            	<tr>
            		<td class="blue" width="15%" nowrap>客户姓名</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="custName" id="custName" value="<%=tempArr[0][2]%>" size="20" readonly>
            	    </td>
            		<td class="blue" width="15%" nowrap>手机号码</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=iPhoneNo%>" size="20" readonly>
            	    </td>
            	</tr>
            	<tr>
            		<td class="blue" width="15%" nowrap>客户地址</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="custAddr" id="custAddr" value="<%=tempArr[0][3]%>" size="50" readonly>
            	    </td>
            	    <td class="blue" width="15%" nowrap>业务品牌</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="smCode" id="smCode" value="<%=tempArr[0][6]%>" size="20" readonly>
            	    </td>
            	</tr>
            	<tr>
            		<td class="blue" width="15%" nowrap>证件类型</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="icType" id="icType" value="<%=tempArr[0][4]%>" size="20" readonly>
            	    </td>
            	    <td class="blue" width="15%" nowrap>证件号码</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="icIccid" id="icIccid" value="<%=tempArr[0][5]%>" size="20" readonly>
            	    </td>
            	</tr>
            	<tr>
            		<td class="blue" width="15%" nowrap>归属地市</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="belongCode" id="belongCode" value="<%=tempArr[0][7]%>" size="20" readonly>
            	    </td>
            	    <td class="blue" width="15%" nowrap>运行状态</td>
            	    <td width="35%">
            	    	<input class="InputGrey" type="text" name="runCode" id="runCode" value="<%=tempArr[0][8]%>" size="20" readonly>
            	    </td>
            	</tr>
            </table>
        	<div class="title">
        		<div id="title_zi">选择操作条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="phoneConvenCardOrder" value="e535" onclick="isUnsubscribe(this)" />&nbsp;
                    </td>
                    <td class="blue">手机便民卡订购</td>
                    <td>
                        <input type="radio" name="radiobutton" id="phoneConvenCardUnsubscribe" value="e536" onclick="isUnsubscribe(this)" />&nbsp;
                    </td>
                    <td class="blue">手机便民卡退订</td>
                    <input type="hidden" id="radioButtonVal" name="radioButtonVal" value="" />
                    <input type="hidden" name="printAccept" value="<%=printAccept%>" >
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="printCommit()" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="location.reload();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
            <div id="showMessage" style="display:none">
            <tr>
              <font class='red'> 请留意，询问用户卡内余额是否退还。如用户选择是，应持卡至专用POS终端办理；选择否，则直接取消。 </font> 
            </tr>
          </div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>
<%
    }
}
%>

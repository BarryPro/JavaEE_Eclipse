<%
  /*
   * 功能: 家庭客户成员管理
   * 版本: 1.0
   * 日期: 2013-4-25 17:07:45
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
<script language=javascript>
	     // 添加家庭成员
	     function addMem() {
	     	  var custId = $("#custId").val();
	     	  var path = "fg645_add.jsp?opCode=<%=opCode%>&custId="+custId;
	        var retInfo = window.open(path,"addMem","height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	     }
	     // 全选
	     function checkedAll(){
			    var t = document.getElementsByName("chkButton");
			    for(var i=0; i< t.length; i++){
				     t[i].checked=document.all.allbox.checked;
			    }
	     }
	    // 删除家庭成员
	    function delMem(){
     	    var  relIds ="";
     	    var  memberPhones = "";
     	    var  memberPhone = document.getElementsByName("memberPhone");
			    var el = document.getElementsByName("chkButton");
			    for(var i=0; i<el.length; i++){
				       if(el[i].checked == true){
					         relIds = relIds + el[i].value+",";
					         memberPhones = memberPhones + memberPhone[i].value+",";
				       }
			    }
			    if(relIds.length <1){
			    	     rdShowMessageDialog("请选择要删除的成员信息!",1);
			    }else {
			    	    if(rdShowConfirmDialog('确认要删除这些成员信息吗？')==1)
                {
                	 var masterFlag = document.getElementsByName("masterFlag");
                	 for(var j=0; j<masterFlag.length; j++){
                	 	     if (el[j].checked == true && masterFlag[j].value == '1') {
                	 	         if (rdShowConfirmDialog('勾选记录中包含责任人，删除责任人信息将导致家庭解散 请确认是否进行该操作？')==1) {
                	 	         	     relIds = "";
                	 	         	     memberPhones = "";
                	 	               for(var k=0; k<el.length; k++){
					                            relIds = relIds + el[k].value+",";
					                            memberPhones = memberPhones + memberPhone[k].value+",";
			                             }
                	 	         } else {
                	 	               reutrn;
                	 	         }
                	 	     }
			             }
			             var custId = $("#custId").val();
			             // 调用打印免填单
			             showPrtDlgDel("Detail","确实要进行电子免填单打印吗？","Yes",memberPhones,relIds,custId);
				         }
			    }
     	
      }
      // 删除成员回调函数
      function doDeleteCallBack(packet){		
			    var  retCode = packet.data.findValueByName("retCode");
			    var  retMsg = packet.data.findValueByName("retMsg");
			    if(retCode =="000000"){
				         rdShowMessageDialog("删除家庭成员信息成功！",2);
				         doRefresh('NULL');
			    }else{
				         rdShowMessageDialog("删除家庭成员信息失败！错误原因："+retMsg,0);
			    }
	    }
	    // 刷新列表页面
	    function doRefresh(phoneNo) {
	        var myPacket = new AJAXPacket("fg645_show.jsp","正在获取信息，请稍候......");
	        if (phoneNo != 'NULL') {
	              myPacket.data.add("phoneNo",phoneNo);
	        } else {
	              myPacket.data.add("phoneNo",'<%=phoneNo%>');
	        }
	    	  myPacket.data.add("opCode",'<%=opCode%>');
	    	  myPacket.data.add("opName",'<%=opName%>');
		      core.ajax.sendPacketHtml(myPacket,doShowQueryInfo);
		      myPacket =null;
	    }
	    
	    function doShowQueryInfo(data){
    	  $("#showdiv").empty().append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000" && retCode!="g64502"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fg645_main.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
     }
	    // 变更成员为责任人
	    function changeMaster(relId,masterCustId,phoneNo,custId,loginAccept) {
	    	    var packet = new AJAXPacket("fg645_changeMaster.jsp");
				    packet.data.add("relId",relId);
				    packet.data.add("masterCustId",masterCustId);
				    packet.data.add("phoneNo",phoneNo);
				    packet.data.add("custId",custId);
				    packet.data.add("loginAccept",loginAccept);
				    packet.data.add("opCode","<%=opCode%>");
				    packet.data.add("opName","<%=opName%>");
					  core.ajax.sendPacket(packet,doChangeMasterCallBack);
					  packet = null; 
	    }
	    
	    // 变更成员为责任人回调函数
      function doChangeMasterCallBack(packet){		
			    var  retCode = packet.data.findValueByName("retCode");
			    var  retMsg = packet.data.findValueByName("retMsg");
			    var  phoneNo = packet.data.findValueByName("phoneNo");
			    if(retCode =="000000"){
				         rdShowMessageDialog("变更成员为责任人操作成功！",2);
				         doRefresh(phoneNo);
			    }else{
				         rdShowMessageDialog("变更成员为责任人操作失败！错误原因："+retMsg,0);
			    }
	    }
	    
	    function printCommitChange(relId,masterCustId,phoneNo,custId) {
	     	    if(!check(frm)){
                return false;
            }
	          showPrtDlgChange("Detail","确实要进行电子免填单打印吗？","Yes",relId,masterCustId,phoneNo,custId);
	     }
	     
	     function showPrtDlgChange(printType,DlgMessage,submitCfm,relId,masterCustId,MemPhoneNo,custId)
       {
       	    //显示打印对话框 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // 打印类型：print 打印 subprint 合并打印 printstore 打印存储
            var billType="1";                    // 票价类型：1电子免填单、2发票、3收据
            //生成业务流水
            <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			          routerValue="<%=regionCode%>"  id="loginAccept" />
			
            var printStr=printInfoChange(printType,<%=loginAccept%>,MemPhoneNo);   //调用printinfo()返回的打印内容
            var sysAccept="<%=loginAccept%>";    //流水号
            var mode_code=null;                  //资费代码
            var fav_code=null;                   //特服代码
            var area_code=null;                  //小区代码
            var opCode="<%=opCode%>";            //操作代码
            var phoneNo="<%=phoneNo%>";           //客户电话
            
	          var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	          var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	          var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	          var ret=window.showModalDialog(path,printStr,prop);
  
            if(rdShowConfirmDialog('确定要把该成员变更为责任人吗？')==1)
            {
                 changeMaster(relId,masterCustId,MemPhoneNo,custId,<%=loginAccept%>)
            }
       }
	
       function printInfoChange(printType,loginAccept,phoneNo)
       {
           var retInfo = "";
           if(printType == "Detail")
           {	
		        var cust_info="";  //客户信息
		        var opr_info="";   //操作信息
		        var note_info1=""; //备注1
		        var note_info2=""; //备注2
		        var note_info3=""; //备注3
		        var note_info4=""; //备注4
		
		        cust_info+="客户姓名：	"+frm.custName.value+"|";
	          cust_info+="手机号码：	"+<%=phoneNo%>+"|";
	  
		        opr_info+="业务流水："+loginAccept+"|";
		        opr_info+="业务办理名称：家庭责任人由 ["+<%=phoneNo%>+"] 变更为 ["+phoneNo+"]|";
		
		        note_info1+="备注：变更家庭责任人|";

		        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	        }  
	        return retInfo;	
       }
	    
	      function showPrtDlgDel(printType,DlgMessage,submitCfm,memberPhones,relIds,custId)
       {
       	    //显示打印对话框 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // 打印类型：print 打印 subprint 合并打印 printstore 打印存储
            var billType="1";                    // 票价类型：1电子免填单、2发票、3收据
            //生成业务流水
            <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			          routerValue="<%=regionCode%>"  id="loginAccept" />
			
            var printStr=printInfoDel(printType,<%=loginAccept%>,memberPhones);   //调用printinfo()返回的打印内容
            var sysAccept="<%=loginAccept%>";    //流水号
            var mode_code=null;                  //资费代码
            var fav_code=null;                   //特服代码
            var area_code=null;                  //小区代码
            var opCode="<%=opCode%>";            //操作代码
            var phoneNo="<%=phoneNo%>";           //客户电话
            
	          var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	          var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	          var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	          var ret=window.showModalDialog(path,printStr,prop);
            
            var packet = new AJAXPacket("fg645_delete.jsp");
				    packet.data.add("relIds",relIds);
				    packet.data.add("custId",custId);
				    packet.data.add("opCode","<%=opCode%>");
				    packet.data.add("opName","<%=opName%>");
				    packet.data.add("loginAccept","<%=loginAccept%>");
					  core.ajax.sendPacket(packet,doDeleteCallBack);
					  packet = null;
       }
	
       function printInfoDel(printType,loginAccept,memberPhones)
       {
           var retInfo = "";
           if(printType == "Detail")
           {	
           	var phoneArray = new Array();
		        var cust_info="";  //客户信息
		        var opr_info="";   //操作信息
		        var note_info1=""; //备注1
		        var note_info2=""; //备注2
		        var note_info3=""; //备注3
		        var note_info4=""; //备注4
		
		        cust_info+="客户姓名：	"+frm.custName.value+"|";
	          cust_info+="手机号码：	"+<%=phoneNo%>+"|";
	  
		        opr_info+="业务流水："+loginAccept+"|";
		        opr_info+="业务办理名称：删除以下家庭成员|";
		        phoneArray = memberPhones.split(",") ;
		        for (var i = 0; i < phoneArray.length-1; i++) {
		              opr_info+="删除成员号码："+phoneArray[i]+"|";
		        }
		
		        note_info1+="备注：删除家庭成员|";

		        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	        }  
	        return retInfo;	
       }
	    
	    
</script>

<wtc:service name="sG645Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
	  <wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value="0"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>

<form  name="frm" method="POST">
<div class="title">
		<div id="title_zi">家庭成员信息列表</div>
</div>
<table cellspacing="0">
	   <tr>
	   	    <th width="10%">
							<input name="allbox" type="checkbox"
								onClick="javaScript:checkedAll();" value="checkbox">
					</th>
					<th width="20%">责任人客户ID </th>
					<th width="20%">成员用户ID </th>
					<th width="20%">成员号码 </th>
					<th width="10%">家庭成员角色</th>
					<th width="10%">操作</th>
	   </tr>
	   <%
    if("000000".equals(retCode)){
        if(retList.length > 0) {
     %>
        <input type="hidden" id="custId" name="custId" value="<%=retList[0][4]%>" />
        <input type="hidden" id="masterCustId" name="masterCustId" value="<%=retList[0][0]%>" />
        <input type="hidden" id="custName" name="custName" value="<%=retList[0][6]%>" />
     <%
            for (int i = 0 ; i < retList.length ; i++) {
    %>
	   <tr align="center">
	   	     <td>
							<input name="chkButton" type="checkbox"
								value="<%=retList[i][5]%>" />
							<input name="masterFlag" type="hidden" value="<%=retList[i][3]%>" />
							<input name="memberPhone" type="hidden" value="<%=retList[i][2]%>" />
					 </td>
	   	     <td><%=retList[i][0]%></td>
	   	     <td><%=retList[i][1]%></td>
	   	     <td><%=retList[i][2]%></td>
	   	     <td><%if ("0".equals(retList[i][3])) {%>成员<%} else {%>责任人<%}%></td>
	   	     <td><input class="b_foot" name="b_change" onclick="printCommitChange('<%=retList[i][5]%>','<%=retList[i][0]%>','<%=retList[i][2]%>','<%=retList[0][4]%>')" type="button" value="变更为责任人" <%if ("1".equals(retList[i][3])) {%> disabled="disabled" <%}%> /> </td>
	   </tr>
	   <%}%>
	   <table cellSpacing="0">
        <tr> 
          <td id="footer" >
          	  <input class="b_foot" name="b_add" onclick="addMem()" type="button" value="增加成员" /> 
          	  <input class="b_foot" name="b_del" onclick="delMem()" type="button" value="删除成员" /> 
			    </td>
        </tr>
    </table>
	   <%}}%>
</table>
</form>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />

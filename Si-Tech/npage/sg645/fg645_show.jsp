<%
  /*
   * ����: ��ͥ�ͻ���Ա����
   * �汾: 1.0
   * ����: 2013-4-25 17:07:45
   * ����: yansca
   * ��Ȩ: si-tech
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
	     // ��Ӽ�ͥ��Ա
	     function addMem() {
	     	  var custId = $("#custId").val();
	     	  var path = "fg645_add.jsp?opCode=<%=opCode%>&custId="+custId;
	        var retInfo = window.open(path,"addMem","height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	     }
	     // ȫѡ
	     function checkedAll(){
			    var t = document.getElementsByName("chkButton");
			    for(var i=0; i< t.length; i++){
				     t[i].checked=document.all.allbox.checked;
			    }
	     }
	    // ɾ����ͥ��Ա
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
			    	     rdShowMessageDialog("��ѡ��Ҫɾ���ĳ�Ա��Ϣ!",1);
			    }else {
			    	    if(rdShowConfirmDialog('ȷ��Ҫɾ����Щ��Ա��Ϣ��')==1)
                {
                	 var masterFlag = document.getElementsByName("masterFlag");
                	 for(var j=0; j<masterFlag.length; j++){
                	 	     if (el[j].checked == true && masterFlag[j].value == '1') {
                	 	         if (rdShowConfirmDialog('��ѡ��¼�а��������ˣ�ɾ����������Ϣ�����¼�ͥ��ɢ ��ȷ���Ƿ���иò�����')==1) {
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
			             // ���ô�ӡ���
			             showPrtDlgDel("Detail","ȷʵҪ���е��������ӡ��","Yes",memberPhones,relIds,custId);
				         }
			    }
     	
      }
      // ɾ����Ա�ص�����
      function doDeleteCallBack(packet){		
			    var  retCode = packet.data.findValueByName("retCode");
			    var  retMsg = packet.data.findValueByName("retMsg");
			    if(retCode =="000000"){
				         rdShowMessageDialog("ɾ����ͥ��Ա��Ϣ�ɹ���",2);
				         doRefresh('NULL');
			    }else{
				         rdShowMessageDialog("ɾ����ͥ��Ա��Ϣʧ�ܣ�����ԭ��"+retMsg,0);
			    }
	    }
	    // ˢ���б�ҳ��
	    function doRefresh(phoneNo) {
	        var myPacket = new AJAXPacket("fg645_show.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
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
             rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
             window.location.href="fg645_main.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
     }
	    // �����ԱΪ������
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
	    
	    // �����ԱΪ�����˻ص�����
      function doChangeMasterCallBack(packet){		
			    var  retCode = packet.data.findValueByName("retCode");
			    var  retMsg = packet.data.findValueByName("retMsg");
			    var  phoneNo = packet.data.findValueByName("phoneNo");
			    if(retCode =="000000"){
				         rdShowMessageDialog("�����ԱΪ�����˲����ɹ���",2);
				         doRefresh(phoneNo);
			    }else{
				         rdShowMessageDialog("�����ԱΪ�����˲���ʧ�ܣ�����ԭ��"+retMsg,0);
			    }
	    }
	    
	    function printCommitChange(relId,masterCustId,phoneNo,custId) {
	     	    if(!check(frm)){
                return false;
            }
	          showPrtDlgChange("Detail","ȷʵҪ���е��������ӡ��","Yes",relId,masterCustId,phoneNo,custId);
	     }
	     
	     function showPrtDlgChange(printType,DlgMessage,submitCfm,relId,masterCustId,MemPhoneNo,custId)
       {
       	    //��ʾ��ӡ�Ի��� 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ printstore ��ӡ�洢
            var billType="1";                    // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
            //����ҵ����ˮ
            <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			          routerValue="<%=regionCode%>"  id="loginAccept" />
			
            var printStr=printInfoChange(printType,<%=loginAccept%>,MemPhoneNo);   //����printinfo()���صĴ�ӡ����
            var sysAccept="<%=loginAccept%>";    //��ˮ��
            var mode_code=null;                  //�ʷѴ���
            var fav_code=null;                   //�ط�����
            var area_code=null;                  //С������
            var opCode="<%=opCode%>";            //��������
            var phoneNo="<%=phoneNo%>";           //�ͻ��绰
            
	          var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	          var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	          var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	          var ret=window.showModalDialog(path,printStr,prop);
  
            if(rdShowConfirmDialog('ȷ��Ҫ�Ѹó�Ա���Ϊ��������')==1)
            {
                 changeMaster(relId,masterCustId,MemPhoneNo,custId,<%=loginAccept%>)
            }
       }
	
       function printInfoChange(printType,loginAccept,phoneNo)
       {
           var retInfo = "";
           if(printType == "Detail")
           {	
		        var cust_info="";  //�ͻ���Ϣ
		        var opr_info="";   //������Ϣ
		        var note_info1=""; //��ע1
		        var note_info2=""; //��ע2
		        var note_info3=""; //��ע3
		        var note_info4=""; //��ע4
		
		        cust_info+="�ͻ�������	"+frm.custName.value+"|";
	          cust_info+="�ֻ����룺	"+<%=phoneNo%>+"|";
	  
		        opr_info+="ҵ����ˮ��"+loginAccept+"|";
		        opr_info+="ҵ��������ƣ���ͥ�������� ["+<%=phoneNo%>+"] ���Ϊ ["+phoneNo+"]|";
		
		        note_info1+="��ע�������ͥ������|";

		        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	        }  
	        return retInfo;	
       }
	    
	      function showPrtDlgDel(printType,DlgMessage,submitCfm,memberPhones,relIds,custId)
       {
       	    //��ʾ��ӡ�Ի��� 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ printstore ��ӡ�洢
            var billType="1";                    // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
            //����ҵ����ˮ
            <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			          routerValue="<%=regionCode%>"  id="loginAccept" />
			
            var printStr=printInfoDel(printType,<%=loginAccept%>,memberPhones);   //����printinfo()���صĴ�ӡ����
            var sysAccept="<%=loginAccept%>";    //��ˮ��
            var mode_code=null;                  //�ʷѴ���
            var fav_code=null;                   //�ط�����
            var area_code=null;                  //С������
            var opCode="<%=opCode%>";            //��������
            var phoneNo="<%=phoneNo%>";           //�ͻ��绰
            
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
		        var cust_info="";  //�ͻ���Ϣ
		        var opr_info="";   //������Ϣ
		        var note_info1=""; //��ע1
		        var note_info2=""; //��ע2
		        var note_info3=""; //��ע3
		        var note_info4=""; //��ע4
		
		        cust_info+="�ͻ�������	"+frm.custName.value+"|";
	          cust_info+="�ֻ����룺	"+<%=phoneNo%>+"|";
	  
		        opr_info+="ҵ����ˮ��"+loginAccept+"|";
		        opr_info+="ҵ��������ƣ�ɾ�����¼�ͥ��Ա|";
		        phoneArray = memberPhones.split(",") ;
		        for (var i = 0; i < phoneArray.length-1; i++) {
		              opr_info+="ɾ����Ա���룺"+phoneArray[i]+"|";
		        }
		
		        note_info1+="��ע��ɾ����ͥ��Ա|";

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
		<div id="title_zi">��ͥ��Ա��Ϣ�б�</div>
</div>
<table cellspacing="0">
	   <tr>
	   	    <th width="10%">
							<input name="allbox" type="checkbox"
								onClick="javaScript:checkedAll();" value="checkbox">
					</th>
					<th width="20%">�����˿ͻ�ID </th>
					<th width="20%">��Ա�û�ID </th>
					<th width="20%">��Ա���� </th>
					<th width="10%">��ͥ��Ա��ɫ</th>
					<th width="10%">����</th>
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
	   	     <td><%if ("0".equals(retList[i][3])) {%>��Ա<%} else {%>������<%}%></td>
	   	     <td><input class="b_foot" name="b_change" onclick="printCommitChange('<%=retList[i][5]%>','<%=retList[i][0]%>','<%=retList[i][2]%>','<%=retList[0][4]%>')" type="button" value="���Ϊ������" <%if ("1".equals(retList[i][3])) {%> disabled="disabled" <%}%> /> </td>
	   </tr>
	   <%}%>
	   <table cellSpacing="0">
        <tr> 
          <td id="footer" >
          	  <input class="b_foot" name="b_add" onclick="addMem()" type="button" value="���ӳ�Ա" /> 
          	  <input class="b_foot" name="b_del" onclick="delMem()" type="button" value="ɾ����Ա" /> 
			    </td>
        </tr>
    </table>
	   <%}}%>
</table>
</form>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />

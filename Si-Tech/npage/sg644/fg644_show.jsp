<%
  /*
   * ����: ��ͥ�ͻ���Ϣά��
   * �汾: 1.0
   * ����: 2013-4-29 14:48:14
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

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<script language=javascript>
	
	    function printCommit() {
	     	    if(!check(frm)){
                return false;
            }
	          showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	     }
	     
	     function showPrtDlg(printType,DlgMessage,submitCfm)
       {
       	    //��ʾ��ӡ�Ի��� 
            var h=200;
            var w=400;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var pType = "print";                 // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ printstore ��ӡ�洢
            var billType="1";                    // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
            var printStr=printInfo(printType,<%=loginAccept%>);   //����printinfo()���صĴ�ӡ����
            var sysAccept="<%=loginAccept%>";    //��ˮ��
            var mode_code=null;                  //�ʷѴ���
            var fav_code=null;                   //�ط�����
            var area_code=null;                  //С������
            var opCode="<%=opCode%>";            //��������
            var phoneNo=frm.masterPhone.value;                      //�ͻ��绰
            
	          var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	          var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	          var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	          var ret=window.showModalDialog(path,printStr,prop);
  
            if(rdShowConfirmDialog('ȷ��Ҫ�ύ��ͥ�ͻ������Ϣ��')==1)
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
		        var cust_info=""; //�ͻ���Ϣ
		        var opr_info=""; //������Ϣ
		        var note_info1=""; //��ע1
		        var note_info2=""; //��ע2
		        var note_info3=""; //��ע3
		        var note_info4=""; //��ע4
		
		        cust_info+="�ͻ�������	"+frm.masterCustName.value+"|";
	          cust_info+="�ֻ����룺	"+frm.masterPhone.value+"|";
	  
		        opr_info+="ҵ����ˮ��"+loginAccept+"|";
		        opr_info+="������������"+frm.masterCustName.value+"|";
		        opr_info+="������֤�����룺"+frm.masterIdIccid.value+"|";
		        opr_info+="������֤����ַ��"+frm.masterIdAdress.value+"|";
		        opr_info+="������֤����Ч�ڣ�"+frm.masterIdDate.value+"|";
		        opr_info+="�������룺"+frm.postNo.value+"|";
		        opr_info+="��ϵ�ˣ�"+frm.contactName.value+"|";
		        opr_info+="��ϵ�绰��"+frm.contactPhone.value+"|";
		        opr_info+="���棺"+frm.faxNo.value+"|";
		        opr_info+="�����ʼ���"+frm.email.value+"|";
		
		        note_info1+="��ע���޸ļ�ͥ�ͻ�����|";

		        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	        }  
	        return retInfo;	
       }
       
       // У��ͻ�����
       function checkCustName(textName)
      {
	       if(textName.value != "")
	      {
			     var m = /^[\u0391-\uFFE5]+$/;
			     var flag = m.test(textName.value);
			     if(!flag){
				   rdShowMessageDialog("ֻ�����������ģ�");
				   reSetCustName();

			     if(textName.value.length > 6){
				     rdShowMessageDialog("ֻ��������6�����֣�");
				     reSetCustName();
			     }
		       }else{
			         if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			        {
				         rdShowMessageDialog("����������Ƿ��ַ���");
				         textName.value = "";
	 	  		       return;
			        }
		      }
	     }
     }
     
     function reSetCustName(){/*���ÿͻ�����*/
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
		<div id="title_zi">������Ϣ</div>
</div>
<table cellspacing="0">
     <tr>
     	    <td class="blue"> 
               <div align="left">������������</div>
          </td>
          <td> 
               <input id="masterCustName"  name="masterCustName" value="<%=retList[0][0]%>"  v_must="1" v_type="string" onkeyup="checkCustName(this);" />
               <font class=orange>*&nbsp;(��������������)</font>
          </td>
     	    <td class="blue"> 
               <div align="left">������֤�����ͣ�</div>
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
               <div align="left">������֤�����룺</div>
          </td>
          <td> 
               <input type="text" id="masterIdIccid"  name="masterIdIccid" value="<%=retList[0][2]%>" v_must="1" <%if ("0".equals(retList[0][1])) {%> v_type="idcard" maxlength="18" <%}else{%>maxlength="5"<%}%>/>
               <font class=orange>*</font> 
          </td>
     	     <td class="blue"> 
               <div align="left">������֤����ַ��</div>
          </td>
          <td> 
               <input id="masterIdAdress" name="masterIdAdress" value="<%=retList[0][3]%>"   v_must="1"  v_type="string" size="60" maxlength="60"/>
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">������֤����Ч�ڣ�</div>
          </td>
          <td> 
               <input type="text" id="masterIdDate" name="masterIdDate"  value="<%=retList[0][4]%>" v_must="1" v_maxlength="8" v_type="date" />
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">�������룺</div>
          </td>
          <td> 
               <input id="postNo"  name="postNo" value="<%=retList[0][5]%>" v_type="zip" v_name="��ϵ���ʱ�" />
          </td>
     </tr>
     <tr>
     	     <td class="blue"> 
               <div align="left">��ϵ�ˣ�</div>
          </td>
          <td> 
               <input id="contactName"  name="contactName" value="<%=retList[0][6]%>" v_must="1" />
               <font class=orange>*</font>
          </td>
     	    <td class="blue"> 
               <div align="left">��ϵ�绰��</div>
          </td>
          <td> 
               <input id="contactPhone"  name="contactPhone" value="<%=retList[0][7]%>" v_must="1" v_type="phone" />
               <font class=orange>*</font>
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">���棺</div>
          </td>
          <td> 
               <input id="faxNo"  name="faxNo" value="<%=retList[0][8]%>" v_type="phone" />
          </td>
     	    <td class="blue"> 
               <div align="left">�����ʼ���</div>
          </td>
          <td> 
               <input id="email"  name="email" value="<%=retList[0][9]%>" v_type="email" />
          </td>
     </tr>
     <table cellSpacing="0">
        <tr> 
          <td id="footer" >
              <input class="b_foot"  name="b_print"  onclick="printCommit()" type="button" value="ȷ��&��ӡ" >
			        <input class="b_foot"  name="b_back"   onclick="removeCurrentTab()" type="button" value="�ر�">
			    </td>
        </tr>
    </table>
</table>
</form>
<%}}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />

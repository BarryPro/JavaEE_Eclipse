<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  <script language="javascript">
    var ioprcode="";
    function save(){
    
  if(document.all.custname.value.trim() ==""){
  rdShowMessageDialog("����д�û�������",1);
  return false;
  }
    if(document.all.idType.value =="00"){//����֤
   		if( document.all.idIccid.value.trim().len() != 18) 	{
		  rdShowMessageDialog("���֤֤�����볤�ȱ�����18λ��");
		  return false;
		}
  }else {
  	if(document.all.idIccid.value.trim()=="") {
  			  rdShowMessageDialog("������֤�����룡");
  			   return false;
  			}
		 
  	}
  if(document.all.yhzh.value.trim() ==""){
  rdShowMessageDialog("����д�����˺ţ�",1);
  return false;
  }
  
  if(document.all.jffs.value.trim()=="0") {
  	
  }else {
  		if(document.all.RechAmount.value.trim()=="") {
  			  rdShowMessageDialog("����д��ֵ��",1);
  				return false;
  		}
  		 if(document.all.RechThreshold.value.trim()=="") {
  			  rdShowMessageDialog("����д��ֵ��",1);
  				return false;
  		}
  }
/*
      var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
          frmCfm();
        }
      }
			*/
      frmCfm();
    }
    /*
    function doProcess(packet){
      var retCode = packet.data.findValueByName("retcode");
      var retMsg = packet.data.findValueByName("retmsg");
      if(retCode == "000000"){
        rdShowMessageDialog("��������ɹ���",2);
      }else{
        rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
        return false;
      }
    }
    */
		function frmCfm(){
      frm.submit();
      return true;
    }

    function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
      var sysAccept =<%=loginAccept%>;             	//��ˮ��
      if(ioprcode=="03"){//����
        var printStr = printInfo(printType);
      }
      if(ioprcode=="04"){//ȡ��
        var printStr = printInfo1(printType);
      }		 		                      //����printinfo()���صĴ�ӡ����
      var mode_code=null;           							  //�ʷѴ���
      var fav_code=null;                				 		//�ط�����
      var area_code=null;             				 		  //С������
      var opCode="<%=opCode%>" ;                   			 	//��������
      var phoneNo="<%=activePhone%>";                  //�ͻ��绰
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
      var offerIdSelVal = $("#offerIdHiden").val();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#custname").val()+"|";
      opr_info+="ҵ�����ͣ���������GPRS��ͨ"+"|";
        
      //note_info1+="��ע���𾴵Ŀͻ����������Ĺ��ʼ��۰�̨���������������ײ��Ѿ���Ч��������ۡ����š�̨�塢�������¼��¡��������ǡ�̩��7�����Һ͵����ض���Ӫ������������ʱ����������ʹ���ƶ�����������������۷�����88Ԫ/�ձ�׼��ȡ������������98Ԫ/�ձ�׼��ȡ���ã����ղ�������������ȡ���ײͷѣ��������������Ϸ�������������ն������ֱ���ȡ������QXGJGPRS1��10086����ȡ�����ײ͡�"+"|";
      if(offerIdSelVal=="35688"){ //���ײ�
        note_info1+="��ע���𾴵Ŀͻ����������Ĺ��ʼ��۰�̨���������������ײ��Ѿ���Ч��������ۡ����š�̨�塢�������¼��¡��������ǡ�̩�����ͻ�˹̹���ձ���ӡ��ͷ��ɱ�11�����Һ͵����ض���Ӫ������������ʱ����������ʹ���ƶ���������������88Ԫ/�ձ�׼��ȡ�����ղ�������������ȡ���ײͷѣ��������������Ϸ�������������ն������ֱ���ȡ������QXGJGPRS1��10086����ȡ�����ײ͡�"+"|";
      }

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    function printInfo1(printType){
      var offerIdSelVal = $("#offerIdHiden").val();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#custname").val()+"|";
      opr_info+="ҵ�����ͣ���������GPRS��ͨȡ��"+"|";
        
      //note_info1+="��ע���𾴵Ŀͻ����������Ĺ��ʼ��۰�̨���������������ײ��Ѿ�ȡ������л�����й��ƶ���֧�֡�����KTGJGPRS1��10086�����ٴζ������ײ͡�"+"|";
      if(offerIdSelVal=="35688"){ //���ײ�
        note_info1+="��ע���𾴵Ŀͻ����������Ĺ��ʼ��۰�̨���������������ײ��Ѿ�ȡ������л�����й��ƶ���֧�֡�����KTGJGPRS1��10086�����ٴζ������ײ͡�"+"|";
      }
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
  
    

    
    function reSetTab(){
      window.location.href="fg940.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    
    function change_idType()//����֤
{   

      
    if(document.all.idType.value=="00")
    { 
    $("#iccidShowFlag").show();
     document.all.idIccid.v_type = "idcard";
    }
    else{
      $("#iccidShowFlag").hide();
      document.all.idIccid.v_type = "string";
   
  }
}
	function jiaofei() {
			    if(document.all.jffs.value=="0")
    { 
    $("#zdjf").hide();
    }
    else{
      $("#zdjf").show();
  
  }
	
	}
	
	function chenckyh() {
		  var yhzh = $("#yhzh").val();
		  var phoneNo = $("#phoneNo").val();
		  var idType = $("#idType").val();
		  var idIccid = $("#idIccid").val();
		  var custname = $("#custname").val();
		  var yhbm = $("#yhbm").val();
		  var yhzh = $("#yhzh").val();
		  var yhzhlx = $("#yhzhlx").val();
	  if(custname.trim() ==""){//����֤
	  rdShowMessageDialog("����д�û�������",1);
	  return false;
	  }
    if(idType =="00"){//����֤
   		if(idIccid.trim().len() != 18) 	{
		  rdShowMessageDialog("���֤֤�����볤�ȱ�����18λ��");
		  return false;
		  }
  }else {
  	if(idIccid.trim()=="") {
  			  rdShowMessageDialog("������֤�����룡");
  			   return false;
  			}
		 
  	}
  if(yhzh.trim() ==""){//����֤
  rdShowMessageDialog("����д�����˺ţ�",1);
  return false;
  }
        var packet = new AJAXPacket("fg940_check.jsp","���ڻ�����ݣ����Ժ�......");
      	packet.data.add("phoneNo","<%=activePhone%>");
      	packet.data.add("yhzh",yhzh);
      	packet.data.add("idType",idType);
      	packet.data.add("custname",custname);
      	packet.data.add("yhbm",yhbm);
      	packet.data.add("yhzh",yhzh);
      	packet.data.add("yhzhlx",yhzhlx);
      	packet.data.add("idIccid",idIccid);
      	packet.data.add("opCode","<%=opCode%>");
      	packet.data.add("opName","<%=opName%>");
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;
      
			
	}
function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      if(retcode != "000000"){
        rdShowMessageDialog("У�������˺�ʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
     		rdShowMessageDialog("У�������˺ųɹ�",2);
 				document.all.quchoose.disabled=false;
      }
    }

		</script>
		<body>
		  <form name="frm" method="POST" action="fg940Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="16%">�ֻ�����</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="16%">�û�����</td>
			      <td>
							<input type="text" id="custname" name="custname"   value =""/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
          <tr>
                 <td width=16% class="blue" > 
                    <div align="left">֤������</div>
                  </td>
                  <td > 
                    <select align="left" name=idType id="idType" onChange="change_idType()" width=50 index="10">
                      <%
                      
        //�õ��������
         String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_LENGTH from sIdType order by id_type";           
 %>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" /> 
 <%
 /*
      if(retCode3.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              int recordNum3 = result3.length;                  
                for(int i=0;i<recordNum3;i++){
                  //liujian 2013-5-15 9:41:05 Ĭ�ϵ�һ��ѡ��
                  if(i == 0) {
                    out.println("<option class='button' value='" + result3[i][0]  + "' selected>" + result3[i][1] + "</option>");
                  }else {
                    out.println("<option class='button' value='" + result3[i][0] + "'>"+ result3[i][0]+""+ result3[i][1] + "</option>");
                  }
                       
                }
      
       }else{
       System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
         
      }              
     */          
           
%>
										<option class='button' value='00'>�������֤</option>
										<option class='button' value='01'>��ʱ�������֤</option>
										<option class='button' value='02'>���ڲ���������δ����ͻ���</option>
										<option class='button' value='03'>�������֤��</option>
										<option class='button' value='04'>��װ�������֤��</option>
										<option class='button' value='05'>�۰ľ��������ڵ�ͨ��֤</option>
										<option class='button' value='06'>̨�����������½ͨ��֤</option>
										<option class='button' value='07'>����</option>
										<option class='button' value='99'>����֤��</option>
                    </select>
                  </td>
                   <td width=16% class="blue" > 
                    <div align="left">֤������</div>
                  </td>
                  <td > 
                    <input name="idIccid"  id="idIccid"   value=""  v_type="string"  maxlength="32"  value="" >
                    <font class=orange>*<span id="iccidShowFlag">������18λ</span></font> 
                    
                    </td>
                    </tr>
                    <tr>
                 <TD width=16% class="blue" > 
                    <div align="left">���б���</div>
                  </TD>
                  <TD >
                    <select align="left" id="yhbm" name="yhbm" onChange="reSetCustName()" width=50 index="6">
                      <option class="button" value="0004">��������</option>
                      <option class="button" value="0005">�ַ�����</option>
                    </select>
                  </TD>
                                   <TD width=16% class="blue" > 
                    <div align="left">�����˺�����</div>
                  </TD>
                  <TD >
                    <select align="left" id="yhzhlx" name="yhzhlx" onChange="reSetCustName()" width=50 index="6">
                      <option class="button" value="0">��ǿ�</option>
                    </select>
                  </TD>
                  
          </tr>
          <tr>
          	
                 <TD width=16% class="blue" > 
                    <div align="left">�����˺�</div>
                  </TD>
                  <TD >
							<input name="yhzh"  id="yhzh"   value=""  ><font class="orange">*</font>
							<input type="button"  class="b_text" value="У��" onclick="chenckyh()" >
                   
                  </TD>
                  <TD width=16% class="blue" > 
                    <div align="left">�ɷѷ�ʽ</div>
                  </TD>
                  <TD >
                    <select align="left" id="jffs" name="jffs" onChange="jiaofei()" width=50 index="6">
                      <option class="button" value="0">�����ɷ�</option>
                      <option class="button" value="1">�Զ��ɷ�</option>
                    </select>
                  </TD>
                  
         
          </tr>
          	<tr id="zdjf" style="display:none">
			      <td class="blue" width="16%">��ֵ���</td>
			      <td>
						  <input type="text" id="RechAmount" name="RechAmount"   maxlength="9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" value =""/>
			        <font class="orange">*��λΪ���֣�</font>
	          </td>
	          <td class="blue" width="16%">��ֵ</td>
			      <td>
							<input type="text" id="RechThreshold" name="RechThreshold" maxlength="9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)"  value ="" />
			        <font class="orange">*��λΪ���֣�</font>
	          </td>
		      </tr>
          
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" id="quchoose" name="quchoose" class="b_foot" value="ȷ��&��ӡ" onclick="save()" disabled/>		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" name="ioprcode"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	<input type="hidden" id="offerIdHiden" name="offerIdHiden"  value="" />
      	<input type="hidden" id="effectWayHiden" name="effectWayHiden"  value="" />
      </form>
    </body>
</html>
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

  String bp_name = "";
  String IccId = "";
  String Iccidtype="";
  String id_noss="";
  String loginNo = (String)session.getAttribute("workNo");
  String loginNoPass = (String)session.getAttribute("password");
  String ipAddrss = (String)session.getAttribute("ipAddr");  
  String beizhussdese="����phoneNo=["+activePhone+"]���в�ѯ";  


%>
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArrss" scope="end"/>
<%
    if(baseArrss!=null&&baseArrss.length>0){
    
    	if(baseArrss[0][0].equals("00")) {
          bp_name = (baseArrss[0][5]).trim();
          
          System.out.println("2266-------------------bp_name="+bp_name);

          }
    }


String  inputParsm [] = new String[8];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = activePhone;
	inputParsm[6] = "";


%>  	

	<wtc:service name="sM015Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodess" retmsg="retMsgss" outnum="5">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>

	</wtc:service>
	<wtc:array id="retarr" scope="end"/>
		<%

    if(!"000000".equals(retCodess)){
%>
      <script language=javascript>
        rdShowMessageDialog('������룺<%=retCodess%><br>������Ϣ��<%=retMsgss%>');
        window.close();
      </script>
<%
      return;
    }
 %>  
  	 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
  <script language="javascript">


    function save(){
    
 var radio1 = document.getElementsByName("opFlag");
 var opFlag="";
 var sm= new Array();
 var giftcode="";
 var giftname="";
 var liushis="";
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	   opFlag = radio1[i].value;
	   	sm =opFlag.split("<-!->");
			giftcode=sm[0];
			giftname=sm[1];
			liushis=sm[2];
	}
	
  }  		
  
    if(opFlag=="") {
						rdShowMessageDialog("��ѡ��Ҫ�������",1);
						return false;
		}
		$("#giftcode").val(giftcode);
		$("#giftname").val(giftname);
		$("#loginAccept").val(liushis);
				

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
      var sysAccept =$("#loginAccept").val();            	//��ˮ��

      var printStr = printInfo(printType);

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
			
   function printInfo(printType)
			{
				var cust_info="";  				//�ͻ���Ϣ
				var opr_info="";   				//������Ϣ
				var note_info1=""; 				//��ע1
				var note_info2=""; 				//��ע2
				var note_info3=""; 				//��ע3
				var note_info4=""; 				//��ע4
				var retInfo = "";  				//��ӡ����
				var giftnames = $("#giftname").val();
		    
				
				cust_info+="�ֻ����룺"+"<%=activePhone%>"+"|";
				cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				opr_info+="����ҵ��"+"<%=opName%>"+"  ";
				opr_info+="������ˮ��"+$("#loginAccept").val()+"  ";
				opr_info+="��Ʒ����ȡ|";
				opr_info+="��Ʒ���ƣ�"+giftnames+"    ��Ʒ������ 1 |";				
		    
		    note_info1+="��ע��|";
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}
				
		</script>
		<body>
		  <form name="frm" method="POST" action="fm015Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="16%">�ֻ�����</td>
			      <td width="34%">
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        
	          </td>
	          <td class="blue" width="16%">�û�����</td>
			      <td width="34%">
							<input type="text" id="custname" name="custname"   value ="<%=bp_name%>" readOnly  Class="InputGrey"/>
			      
	          </td>

         <tr> 
          
        </table>
        <br>
            <TABLE cellSpacing="0" >
          <tr align="center">
           
            <th></th>
              <th>��Ʒ����</th>
              <th>��Ʒ����</th>              
              <th>�Ƿ����</th>
              <th>�������</th>
           

          </tr>
        
           <%
           	for(int i=0;i<retarr.length;i++)
				  {
           %>
            <tr>
 						<td align="center"><input type="radio" name="opFlag" value="<%=retarr[i][1]%><-!-><%=retarr[i][2].trim()%><-!-><%=retarr[i][0]%>"  > </td>
 						<td><%=retarr[i][1].trim()%></td>
 						<td><%=retarr[i][2] %></td>
 						<td><%if("0".equals(retarr[i][3])){out.print("��");}else if("1".equals(retarr[i][3])){out.print("��");}%></td>
 						<td><%=retarr[i][4].trim()%></td>
 					</tr>
 					<%}
 					if(retarr.length==0) {%>
			
			<tr height='25' align='center' ><td colspan='5'>��ѯ��ϢΪ�գ�</td></tr>

	<%
	}%>
             </table>

        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" id="quchoose" name="quchoose" class="b_foot" value="ȷ��&��ӡ" onclick="save()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="giftcode" name="giftcode"   />
        <input type="hidden" id="giftname" name="giftname"   />
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" name="loginAccept" id="loginAccept" >

      </form>
    </body>
</html>
<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String kyjfz="0";
		String custname="�û����Ʋ�����";
		String IccId="";
		String IccIdaddress="";
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");
		String beizhussdese="����phoneNo=["+activePhone+"]���в�ѯ";
		String sm_codes="";

%>
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCodess" retmsg="retMsgss">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
    		
          custname = (baseArr[0][5]);
          IccId = (baseArr[0][13]);
          IccIdaddress= (baseArr[0][14]);
          sm_codes= (baseArr[0][38]);
          System.out.println("custname+++++++"+custname);        
          }
    }
    

    String sql_appregionset1 = "select band_name from band where sm_code=:smcodes ";
    String sql_appregionset2 = "smcodes="+sm_codes;
    String sm_codenames ="����Ʒ��";

 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
		if(appregionarry.length>0) {
			sm_codenames = appregionarry[0][0];
		}	
			
%>    
    
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	

	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  		
	var myPacket = new AJAXPacket("fm322Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("phone_no",$("#zr_phone").val());

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
  
  }

 function doCfm(){

  			var el = document.getElementsByTagName('input');
				var len = el.length;
				var checklength=0;
				var offeridstr ="";
				var offernamestr="";
				var sm= new Array();
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox') && (el[i].checked == true) ) {
					checklength++;

					sm =el[i].value.split("<!--!>");
					offeridstr+=sm[0]+"|";
					offernamestr+=sm[1]+"<!--!>";
					
				}
				}
				if(checklength==0) {
						rdShowMessageDialog("��ѡ��Ҫ���ߵ��ط���");
						return false;
				}
		
		$("#offeridstr").val(offeridstr);
		$("#offernamestr").val(offernamestr);
		
				
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
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
 
				function checkAll() { 
				var el = document.getElementsByTagName('input');
				var len = el.length;
				
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = true;
				}
				}
				}
				function clearAll() {
				var el = document.getElementsByTagName('input');
				var len = el.length;
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = false;
				}
				}
				}
				
				
 
  		function frmCfm(){
				document.form1.action = "fm322Cfm.jsp";
   			document.form1.submit();
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
        var printStr = printInfo(printType);
      
	 		                      //����printinfo()���صĴ�ӡ����
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
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";

       cust_info+="�ͻ�������	"+"<%=custname%>"+"|";
       cust_info+="�ֻ����룺	"+"<%=activePhone%>"+"|";
       cust_info+="֤�����룺	"+"<%=IccId%>"+"|";
       cust_info+="�ͻ���ַ��	"+"<%=IccIdaddress%>"+"|";

			opr_info+= opr_info+="ҵ������ʱ�䣺"+"<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"  �û�Ʒ�ƣ�<%=sm_codenames%>"+"|";
			opr_info+="����ҵ�񣺲�Ʒ��� "+"  "+"������ˮ��"+"<%=loginAccept%>"+"|";
			opr_info+="|";
      
      
     
 			//opr_info+="ȡ���ط�(ԤԼ��Ч)��"+tempV2n+"|";
			var offeridsss = $("#offeridstr").val();
			var offernamesss = $("#offernamestr").val();
			
			var sm11= new Array();
					sm11=offeridsss.split("|");
			var sm22= new Array();
					sm22=offernamesss.split("<!--!>");	
			var printinfostrs="";	
					
					for(var i=0;i<sm11.length-1;i++)
			  {
			  	printinfostrs+=sm11[i]+"��"+sm22[i]+"��";
			  }	
			  
			if(printinfostrs.length>0) {
				printinfostrs=printinfostrs.substring(0,(printinfostrs.length-1));	 
			}		

		   opr_info+="ȡ���ط�(24Сʱ֮����Ч)��"+printinfostrs+"|";
		


   	  note_info4+="��ע�� <%=work_no%>Ϊ�ͻ�<%=custname%>����Ʒ��� "+"|";
 
       note_info4+=""+"|";
			 note_info4+="4G��������ʾ��"+"|";
			 note_info4+="1���й��ƶ�4Gҵ����ҪTD-LTE��ʽ�ն�֧�֣�������֧��4G���ܵ�USIM������ͨ4G�����ܣ�"+"|";
			 note_info4+="2���ͻ�����ʱѡ�û����֧��4G����USIM��ʱ����ͬʱ��ͨ4G�����ܣ�"+"|";
			 note_info4+="3��4G���ٽϿ죬����ߵ�λ�ײͿ������ܸ���������Żݣ�"+"|";
			 note_info4+="4��4Gҵ�����4G���������ǵķ�Χ���ṩ���й��ƶ�����������4G����������߷���������"+"|";
 
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
    
		function querinfo(data){
				//�ҵ���ӱ���div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}

 	function resetPage(){
 		window.location.href = "fm322.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">�ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone"  value="<%=activePhone%>"   readonly />
                </div>
            </td>
         
            <td width="16%"  > 
              <div align="left" class="blue">�ͻ�����</div>
            </td>
             <td > 
            <div align="left"> 
                <input class="InputGrey" type="text"  name="custname" id="custname"  value="<%=custname%>"   readonly />
                </div>
            </td>  
         </tr>
   


		       
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="offeridstr" id="offeridstr"  />
      <input type="hidden" name="offernamestr" id="offernamestr"  />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
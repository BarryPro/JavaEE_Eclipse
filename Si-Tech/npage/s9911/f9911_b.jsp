<%
	/********************
	 version v2.0
	������: si-tech
	********************/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>


<%		
 	//String opCode = "9911";	
	//String opName = "�ֻ�����5Ԫ����������";	//header.jsp��Ҫ�Ĳ���
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
	String loginNo = (String)session.getAttribute("workNo");    //����
	String regionCode = (String)session.getAttribute("regCode"); 
 	String loginName = (String)session.getAttribute("workName");  
 	String loginPwd    = (String)session.getAttribute("password");     
%>
<%
	String retFlag="",retMsg="";
 	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	//ArrayList retList = new ArrayList();
  	String[] paraAray1 = new String[3];
	String phoneNo = request.getParameter("activePhone");
	String opcode = request.getParameter("opCode");
  	String passwordFromSer="";
  
  	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  	paraAray1[1] = opcode; 	    /* ��������   */
  	paraAray1[2] = loginNo;	    /* ��������   */

	  for(int i=0; i<paraAray1.length; i++)
	  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  	//retList = impl.callFXService("s9911Qry", paraAray1, "20","phone",phoneNo);
  %>
  	<wtc:service name="s9911Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="18" >
		<wtc:param value=" " />
		<wtc:param value="01" />
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=paraAray1[0]%>"/>
	  <wtc:param value=" " />
	</wtc:service>
	<wtc:array id="retList" scope="end"/>
 <%	  	
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  	String curlevel="",nextlevel="",text_curlevel="",text_nextlevel="",qxlevel="KTYX5";
  	String spcode="",opercode="";
  	String[][] tempArr= new String[][]{};
  	//int errCode = impl.getErrCode();
  	//String errMsg = impl.getErrMsg();
  	String errCode = retCode1;
  	String errMsg= retMsg1;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s9911Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else{
	  if(!errCode.equals("000000")){%>
  		<script language="JavaScript">
  			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
  			//history.go(-1);
  			//window.location.href="f9911_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
  			removeCurrentTab();
  		</script>
  <%}else{
  	  if(retList.length>0){
  		 // tempArr = (String[][])retList.get(2);
  		    tempArr=retList;
  		  if(!(tempArr==null)){
  		    bp_name = tempArr[0][2];//��������
  		    System.out.println(bp_name);
  		  }
  		  //tempArr = (String[][])retList.get(3);
  		  if(!(tempArr==null)){
  		    bp_add = tempArr[0][3];//�ͻ���ַ
  		  }
  		  //tempArr = (String[][])retList.get(4);
  		  if(!(tempArr==null)){
  		    cardId_type = tempArr[0][4];//֤������
  		  }
  		  //tempArr = (String[][])retList.get(5);
  		  if(!(tempArr==null)){
  		    cardId_no = tempArr[0][5];//֤������
  		  }
  		  //tempArr = (String[][])retList.get(6);
  		  if(!(tempArr==null)){
  		    sm_code = tempArr[0][6];//ҵ��Ʒ��
  		  }
  		  //tempArr = (String[][])retList.get(7);
  		  if(!(tempArr==null)){
  		    region_name = tempArr[0][7];//������
  		  }
  		  //tempArr = (String[][])retList.get(8);
  		  if(!(tempArr==null)){
  		    run_name = tempArr[0][8];//��ǰ״̬
  		  }
  		  //tempArr = (String[][])retList.get(9);
  		  if(!(tempArr==null)){
  		    vip = tempArr[0][9];//�֣ɣм���
  		  }
  		  //tempArr = (String[][])retList.get(10);
  		  if(!(tempArr==null)){
  		    posint = tempArr[0][10];//��ǰ����
  		  }
  		  //tempArr = (String[][])retList.get(11);
  		  if(!(tempArr==null)){
  		    prepay_fee = tempArr[0][11];//����Ԥ��
  		  }
  		  //tempArr = (String[][])retList.get(13);
  		  if(!(tempArr==null)){
  		    passwordFromSer = tempArr[0][13];  //����
  		  }
  		  //tempArr = (String[][])retList.get(14);
  		  if(!(tempArr==null)){
  		    curlevel = tempArr[0][14];  //��ǰ����
  		    if((!"xx".equals(curlevel)) && (!"0".equals(curlevel))){
  		  %>
  		    <script language="JavaScript">
  		      rdShowMessageDialog("�û���ǰ���д�ҵ��",1);
    	      //window.location.href="f9911_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
    	      removeCurrentTab();
  		    </script>
  		  <%  
  		    }
  		  }
  		  	  	
  		  //tempArr = (String[][])retList.get(15);
  		  if(!(tempArr==null)){
  			nextlevel = tempArr[0][15];  //����
  		  }
  		  //tempArr = (String[][])retList.get(16);
  		  if(!(tempArr==null)){
  			text_curlevel = tempArr[0][16];  //����
  		  }
  		  //tempArr = (String[][])retList.get(17);
  		  if(!(tempArr==null)){
  			text_nextlevel = tempArr[0][17];  //����
  		  }
  	  }
  	}
  }

%>

<%
	//******************�õ�����������***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println("=============================="+printAccept);
	String exeDate="";
	exeDate = getExeDate("1","1141");

%>

<html>
<head>
	<title><%=opName%></title>
	<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="../../npage/s1400/pub.js"></script> 
	<script language="JavaScript">
		<!--
		  //����Ӧ��ȫ�ֵı���
		  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
		  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
		  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
		
		  //***
		  function frmCfm(){
		 	frm.submit();
			return true;
		  }
		 //***IMEI ����У��

		 function printCommit()
		 { 
		  getAfterPrompt();
		  var cur_level = $("#cur_level").val();
		  $("#cur_level_hidden").val(cur_level);
		  
		 //��ӡ�������ύ��
		  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		  if(typeof(ret)!="undefined")
		  {
		    if((ret=="confirm"))
		    {
		      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		      {
			    frmCfm();
		      }
			}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		      {
			    frmCfm();
		      }
			}
		  }
		  else
		  {
		     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		     {
			   frmCfm();
		     }
		  }
		  return true;
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  
			var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=printAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = <%=phoneNo%>;                           //�ͻ��绰
			
			//��ʾ��ӡ�Ի��� 
			var h=180;
			var w=352;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop); 	   
			   
		}

		function printInfo(printType)
		{
      var cust_info=""; //�ͻ���Ϣ
      var opr_info=""; //������Ϣ
      var retInfo = "";  //��ӡ����
      var note_info1=""; //��ע1
      var note_info2=""; //��ע2
      var note_info3=""; //��ע3
      var note_info4=""; //��ע4 
       
      cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
      cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
      cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
      cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";
              
      opr_info+="ҵ�����ͣ�"+"<%=opName%>"+"|";
      opr_info+="�������ͣ�����"+$("#cur_level").find("option:selected").text()+"|";
      var cur_level = $("#cur_level").val();
      var monthMoney = "";
      if(cur_level=="KTYX5"){
        monthMoney = "5";
      }else if(cur_level=="KTYX20"){
        monthMoney = "20";
      } if(cur_level=="KTYX5F"){
        monthMoney = "0";
      }
      opr_info+="�𾴵Ŀͻ������ѳɹ�����139���书�ܣ��ʷ�"+monthMoney+"Ԫ/�¡�������Ӫҵ�����Ͷ���0000��10086���ݶ�����ʾ�����˶�����ѯ10086��"+"|";
      
      retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
      return retInfo;	
		}

		//-->
		function goBack(){
		  //window.location.href="f9911_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		  removeCurrentTab();
		}
	</script>
</head>
<body>
	<form name="frm" method="post" action="f9911_c.jsp" onKeyUp="chgFocus(frm)">	
		<%@ include file="/npage/include/header.jsp" %>  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
        	<table cellspacing="0">
			  <tr> 
			            <td class="blue">��������</td>
			            <td colspan="1"><%=opName%></td>
			            <td class="blue">�û�����</td>
			            <td>
					<input name="phoneNo" value="<%=phoneNo%>" type="text"  v_must=1 readonly class="InputGrey" id="phoneNo" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
		          </tr>
		          <tr> 
			            <td class="blue">�ͻ�����</td>
			            <td>
					<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
		            	    <td class="blue">֤������</td>
			            <td>
					<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
			</tr>
		        <tr style="display:none"> 
			            <td class="blue">&nbsp;</td>
			            <td>
					<input name="cust_addr" value="<%=bp_add%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="20" > 
			            </td>
			            <td class="blue">&nbsp;</td>
			            <td>
					<input name="cardId_no" value="<%=cardId_no%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" > 
			            </td>
		      </tr>
		      <tr> 
		            <td class="blue">ҵ��Ʒ��</td>
		            <td>
				<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly  class="InputGrey" id="sm_code" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		            <td class="blue">����״̬</td>
		            <td>
				<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		     </tr>
		     <tr> 
		            <td class="blue">VIP����</td>
		            <td>
				<input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey" id="vip" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		            <td class="blue">����Ԥ��</td>
		            <td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" > 
				<font class="orange">*</font>
		            </td>  
	          <tr> 
		            <td class="blue">��������</td>
		            <td>
								  <select id="cur_level" name="textqxlevel">
								    <option value="KTYX5" >��׼��</option>
								    <option value="KTYX20" >VIP��</option>
								    <option value="KTYX5F" >��׼��(��Ѱ�)</option>
								  </select>
									<font class="orange">*</font>	
			    			</td>
	            	    <td>&nbsp;</td>
	            	    <td>&nbsp;</td>	            
	          </tr>
	</table>
	<table cellspacing="0">
	          <tr> 
		            <td id="footer"> 
		                <input name="confirm"  class="b_foot_long"  type="button"  index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
		                &nbsp; 
		                <input name="back"  class="b_foot"  onClick="goBack()" type="button"  value="�ر�">
		                &nbsp; 
		           </td>
	          </tr>
        </table>
        
    	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
    	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    	<input type="hidden" name="login_accept" value="<%=printAccept%>">
    	<input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    	<input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="qx_level" value="<%=qxlevel%>" >
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<input type="hidden" name="cur_level_hidden" id="cur_level_hidden" value="" />
	<%@ include file="/npage/include/footer.jsp" %>		
</form>
</body>
</html>

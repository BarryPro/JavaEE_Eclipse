 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-08 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
  String loginNo = (String)session.getAttribute("workNo");    //���� 		   
	String regionCode = (String)session.getAttribute("regCode"); 
	String orgCode=(String)session.getAttribute("orgCode"); 
	
	String opCode = "1297";
	String opName = "12580�ƶ�����̨����";
%>
<%
  	String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��  
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String passwordFromSer="";

 	paraAray1[0] = loginNo; 		/* ��������   */
 	paraAray1[1] = phoneNo;		/* �ֻ�����   */
  	paraAray1[2] = "1297";		/* ��������   */
  	paraAray1[3] = orgCode;		/* ��������   */
	for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
	  }

  	//String[] ret = impl.callService("s1297_Valid",paraAray1,"24","phone",phoneNo);
  	%>  	
	<wtc:service name="s1297_Valid" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="24" >
		<wtc:param value=""/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraAray1[3]%>"/>	
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
	
  	<%
  	String run_code="",bp_name="",hand_fee="",should_hand_fee="",sm_code="",idNo="",cmd_right="",favourCode="",cardId_type ="", cardId_no="",contract_phone="",cust_address="",print_note="",prepay_fee="",highFlag="",belong_code="";
  	String errCode=retCode1;
  	String errMsg = retMsg1;  	
	  if(!errCode.equals("000000"))
	  {	  	
		if(!retFlag.equals("1"))
		{		 
		   retFlag = "1";
		   retMsg = "s1297_Valid��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>" + errMsg;
	    }
	  }else if(ret!=null)
	  {
	  	 
		if (errCode.equals("000000") ){
		  run_code = ret[0][8];//����״̬
	      	  bp_name = ret[0][5];//��������
	      	  hand_fee = ret[0][9];//������
		  should_hand_fee = ret[0][9];//Ӧ��������
		  sm_code = ret[0][3];//ҵ������
		  idNo = ret[0][2];//�û�id
		  cmd_right = ret[0][16];//cmd_right
		  passwordFromSer = ret[0][6];//����
		  favourCode = ret[0][17];//�������Żݴ���
		  cardId_type = ret[0][18];//֤������
		  cardId_no = ret[0][19];//֤������
		  contract_phone = ret[0][21];//��ϵ�绰
		  cust_address = ret[0][20];//��ַ
		  prepay_fee = ret[0][22];//Ԥ���
		  print_note = ret[0][13];//����
		  highFlag = ret[0][23];//�и߶˱�־
		  belong_code = ret[0][10];//����ȡ�û�����
		}else{
		  if(!retFlag.equals("1"))
		  {
		    retFlag = "1";
		    retMsg = "s1297_Valid��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>" + errMsg;
	      }
		}
	  }

	  	if(retFlag.equals("1")){  	
	  %>	 
	  	<script type="text/javascript"> 
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	  <%
	  	    return;
	  	}

	//********************����ӪҵԱ�Ż�Ȩ��*****************************//
	   //�Ż���Ϣ	 
	  String[][]  favInfo = (String[][])session.getAttribute("favInfo");
	  boolean pwrf = false;//a272 ��������֤
	  //����ӪҵԱ�Ż�Ȩ��
	  String handFee_Favourable = "readonly";        //a230  ������
	  String choiceFee_Favourable = "readonly";       //a006  ѡ�ŷ�
	  int infoLen = favInfo.length;
	  String tempStr = "";
	  for(int i=0;i<infoLen;i++)
	  {
	    tempStr = (favInfo[i][0]).trim();
	    if(tempStr.compareTo(favourCode) == 0)
	    {
	      handFee_Favourable = "";
	    }
	    if(tempStr.compareTo("a006") == 0)
	    {
	      choiceFee_Favourable = "";
	    }
		if(tempStr.compareTo("a272") == 0)
	    {
	      pwrf = true;
	    }
	  }	  
	
	//******************�õ�����������***************************//	
	  //Ѱ������
	  System.out.println("belong_code=========="+belong_code);
	  String sqlFunctionCode = "SELECT function_code||'~'||month_limit||'~'||function_type,function_code||'--'||function_name,sm_code,to_char(add_months(sysdate,12),'YYYYMM')||'01' FROM sFuncList where  region_code='"  + belong_code.substring(0,2) + "' and sm_code='" + sm_code + "' and function_name like '%1258%' ";
	  System.out.println("sqlFunctionCode=========="+sqlFunctionCode);
	  //ArrayList functionCodeArr = co.spubqry32("4",sqlFunctionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlFunctionCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="functionCodeStr" scope="end" />
<%
	 // String[][] functionCodeStr = (String[][])functionCodeArr.get(0);	
	
	  /****�õ���ӡ��ˮ****/
	  String printAccept="";
	  printAccept = getMaxAccept();
	  
%>
<html>
	<head>
	<title>12580����</title>	
	 <script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
  	<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>

	  
	<script type="text/javascript">
	  //����Ӧ��ȫ�ֵı���
	  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
	
	  var oprType_Add = "a";
	  var oprType_Upd = "u";
	  var oprType_Del = "d";
	  var oprType_Qry = "q";
	
	  onload=function()
	  {
	  	
	  }
	
	  //***
	  function frmCfm(){
	 	frm.submit();
		return true;
	  }
	  //
	  function printCommit(){
	  	getAfterPrompt();
		//У��
	    if(!checkElement(document.frm.phoneNo)) return false;
		if(!checkElement(document.frm.hand_fee)) return false;
		if(!checkElement(document.frm.begin_time)) return false;
	    if(!checkElement(document.frm.end_time)) return false;
		with(document.frm){
		  if(function_code.value==""){
		    rdShowMessageDialog("��ѡ��Ѱ������!",0);
	        function_code.focus();
			return false;
		  }
		  if(ask_type.value==""){
		    rdShowMessageDialog("��ѡ����������!",0);
	        ask_type.focus();
			return false;
		  }
		  if(bp_name.value==""){
		    rdShowMessageDialog("�������������!",0);
	        bp_name.focus();
			return false;
		  }
		  if(bp_title.value==""){
		    rdShowMessageDialog("��ѡ�������ν!",0);
	        bp_title.focus();
			return false;
		  }
		  if(eng_chi.value==""){
		    rdShowMessageDialog("��ѡ�����Ա�ʶ!",0);
	        eng_chi.focus();
			return false;
		  }
		}
	
	    if(document.frm.begin_time.value == document.frm.system_time.value){//�Ƿ��ձ�ʶ
		  document.frm.system_time_flag.value = "0";
		}else{
		  document.frm.system_time_flag.value = "1";
		}
	    //��ӡ�������ύ��
	    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	    if(typeof(ret)!="undefined")
	    {
	      if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
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
		    	var h=200;
		    	var w=410;
		     	var t=screen.availHeight/2-h/2;
		     	var l=screen.availWidth/2-w/2;
		     	
		     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);     	
	  }
	
	  function printInfo(printType)
	  {
		  var retInfo = "";
		  var sm_name = "";
	      	  if("<%=sm_code%>"=="zn"){
			sm_name="������";
		  }else if("<%=sm_code%>"=="gn"){
			sm_name = "ȫ��ͨ";
		  }else {
			sm_name="���еش�";
		  }
		  if(document.frm.ask_type.value=="02"){
			opType="����";
		  }else{
			opType="����";
		  }	
		  
		var cust_info=""; //�ͻ���Ϣ
	      	var opr_info=""; //������Ϣ
	      	var retInfo = "";  //��ӡ����
	      	var note_info1=""; //��ע1
	      	var note_info2=""; //��ע2
	      	var note_info3=""; //��ע3
	      	var note_info4=""; //��ע4 
	      	      	
	      	cust_info+="�ͻ�������   "+document.frm.bp_name.value+"|";
      		cust_info+="�ֻ����룺   "+document.frm.phoneNo.value+"|";
      		cust_info+="�ͻ���ַ��   "+"<%=cust_address%>"+"|";
      		cust_info+="֤�����룺   "+"<%=cardId_no%>"+"|";
	       
	       	opr_info+="�û�Ʒ�ƣ�"+sm_name+"      "+"����ҵ��12580�ƶ����� ����"+"|";
	      	opr_info+="������ˮ:"+"<%=printAccept%>"+"|";
		opr_info+="ҵ�����ͣ�"+opType+"      "+"��Чʱ��:"+document.frm.begin_time.value+"|";		
		note_info1+="      1���ƶ�����̨������ҵ��24Сʱ֮����Ч��ҵ����Ч��12���£���Ч���°����¼��㡣ҵ���ں��Զ�ȡ�������������������ʹ�ã������½��п������롣                    2��ҵ��δ����ǰ���û����������ƶ�����̨������ҵ��24Сʱ֮����Ч��ʣ���12580�ƶ�����̨ҵ�����ר��˲�ת��"+"|";		
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	      	return retInfo;			  
	  }
	//-->
	</script>
	<script type="text/javascript"> 
	<!--
	/************************��̬Ϊ�Ż�������ֵ  bp_flag �ط�����functionType*************************/
	function setFavourMonth(){
	  var strValue = document.frm.function_code.value;
	  var functionCodeValue = oneTokSelf(strValue,"~",1);
	  var favourMonth = oneTokSelf(strValue,"~",2);
	  var functionType = oneTokSelf(strValue,"~",3);
	  document.frm.favour_month.value = favourMonth;
	  document.frm.function_code_value.value = functionCodeValue;
	  document.frm.function_type.value = functionType;
	  if(functionCodeValue == "21" || functionCodeValue == "j0" ){
		  document.frm.bp_flag.value = "1";
	  }
	  else {
	      document.frm.bp_flag.value = "0";
	  }
	  //alert("functionCodeValue = " + functionCodeValue);
	  if(document.frm.bp_flag.value == "1")
		  document.frm.opNote.value = document.frm.phoneNo.value + "����12580����ҵ��."
	  else
		  document.frm.opNote.value = "����: " + document.frm.phoneNo.value  + ",12580����";
	
	  selectChange(null,document.frm.ask_type,null,null);
	
	}
	
	/****************���� function_code ��̬���� ask_type ������************************/
	   /****************���� function_code ��̬���� ask_type ������************************/
	 function selectChange(control, controlToPopulate, itemArray, valueArray)
	 {
	   var functionCodeValue = document.frm.function_code_value.value;
	
	   var myEle ;
	   var x ;
	   // Empty the second drop down box of any choices
	   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
	   if(functionCodeValue=="21")
	   {
	       myEle = document.createElement("option") ;
	       myEle.value = "01" ;
	       myEle.text = "01--�����շ�" ;
		   document.frm.opNote.value = "����: " + document.frm.phoneNo.value  + ",12580����";
	       controlToPopulate.add(myEle) ;
		   document.frm.end_time.value = "20500101";
		   document.frm.year_fee.value="0";
	   }else if(functionCodeValue=="j0")
	   {
			document.frm.year_fee.value="45";
			var prepay_fee = document.frm.prepay_fee.value;
			var year_fee   = document.frm.year_fee.value;
			if((year_fee-prepay_fee)>0){
				rdShowMessageDialog("��ǰ���С�ڰ�������Ƚ���!",0);
				return false;
			}
	       myEle = document.createElement("option") ;
	       myEle.value = "02" ;
	       myEle.text = "02--�����շ�" ;
		   document.frm.opNote.value = document.frm.phoneNo.value + "����12580����ҵ��" ;
			<%if (functionCodeStr.length>0){%>
				document.frm.end_time.value = "<%=functionCodeStr[0][3]%>";
			<%}%>
	       controlToPopulate.add(myEle) ;
	
	   }else
	   {
	      myEle = document.createElement("option") ;
	      myEle.value = "" ;
	      myEle.text = "--��ѡ��--" ;
	      controlToPopulate.add(myEle) ;
	   }
	 }
	//-->
	</script>
</head>
<body>
<form name="frm" method="post" action="f1297_confirm.jsp" onKeyUp="chgFocus(frm)">	
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">12580����</div>
		</div>
        <table  cellspacing="0" >
          	<tr>
            		<td class="blue">�ƶ�����</td>
	            	<td>
				<input name="phoneNo" type="text"  id="phoneNo"   value="<%=phoneNo%>" readonly>
	            	</td>
            		<td class="blue">Ѱ������</td>
            		<td>
		              <select  name="function_code"  onChange="setFavourMonth()" >
					    <option value="">--��ѡ��--</option>
		                <%for(int i = 0 ; i < functionCodeStr.length ; i ++){%>
		                <option value="<%=functionCodeStr[i][0]%>"><%=functionCodeStr[i][1]%></option>
		                <%}%>
		              </select>
			  	<font class="orange">*</font>
			</td>
          	</tr>
          	<tr>
            		<td class="blue">�Ż�����</td>
            		<td>
			  	<input name="favour_month" type="text"  id="favour_month" readonly>
			</td>
            		<td class="blue">����״̬</td>
            		<td>
			  	<input name="run_code" type="text"  id="run_code" value="<%=run_code%>" readonly >
			</td>
          	</tr>
          	<tr>
	            	<td class="blue">��������</td>
	            	<td >
				  <select size=1 name="ask_type" >
				    	<option value="">--��ѡ��--</option>
	              		  </select>
				  <font class="orange">*</font>
			</td>
	            	<td class="blue">���Ա�־</td>
	            	<td>
				  <select name="eng_chi"  >
				   	<option value="">--��ѡ��--</option>
	                		<option value="1">����</option>
	                		<option value="0">Ӣ��</option>
	              		  </select>
				  <font class="orange">*</font>
			</td>
          	</tr>
          	<tr>
		    	<td class="blue">��������</td>
            		<td>
			  	<input name="bp_name" type="text"  id="bp_name" value="<%=bp_name%>" readonly>
			  	<font class="orange">*</font>
			</td>
            		<td class="blue">������ν</td>
            		<td>
			  	<select name="bp_title"  >
			    		<option value="">--��ѡ��--</option>
                			<option value="1">����</option>
                			<option value="0">Ůʿ</option>
              			</select>
			  	<font class="orange">*</font>
			</td>
          	</tr>
		<tr>
            		<td class="blue">��Чʱ��</td>
            		<td>
			  	<input name="begin_time" value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" type="text"  id="begin_time" v_must=1 v_type="date"  onKeyPress="return isKeyNumberdot(0)" maxlength="8" readonly class="InputGrey">
			  	<font class="orange">*</font>yyyymmdd
			</td>
	            	<td class="blue">����ʱ��</td>
	            	<td>
				  <input name="end_time"   type="text"  id="end_time" v_must=1 v_type="date"  onKeyPress="return isKeyNumberdot(0)" maxlength="8" value="<%=functionCodeStr[0][3]%>" readonly class="InputGrey">
				  <font class="orange">*</font>yyyymmdd
			</td>
          	</tr>
		<tr>
	            	<td class="blue">����Ԥ���</td>
	            	<td>
				  <input name="hand_fee" type="hidden"  id="hand_fee" v_type="money"  <%=handFee_Favourable%> value="<%=hand_fee%>">
				  <input name="prepay_fee" type="text"  id="prepay_fee" v_type="money" v_must=1  value="<%=prepay_fee%>" readonly class="InputGrey">
				</td>
	            	<td class="blue" >������</td>
	            	<td>
				  <input name="year_fee" type="text"  id="year_fee" v_type="money" v_must=1  value="0" readonly class="InputGrey">
			</td>
	        </tr>
	          <tr>
		            <td height="32"  class="blue">��ע</td>
		            <td colspan="3" height="32">
		             	<input name="opNote" type="text"  id="opNote" size="60" readonly class="InputGrey">
		            </td>
	          </tr>
	          </table>
	          <table>
		          <tr>
		            	<td id="footer"> 
			                <input name="confirm" class="b_foot" type="button"  index="2" value="ȷ��" onClick="printCommit()">
			                &nbsp;
			                <input name="reset" class="b_foot" type="reset"  value="���" >
			                &nbsp;
			                <input name="back" class="b_foot" onClick="history.go(-1)" type="button"  value="����">
			                &nbsp; 
		               </td>
		          </tr>
        	</table>
  		<%@ include file="/npage/include/footer.jsp" %>
		  <input type="hidden" name="idNo" value="<%=idNo%>"><!-- �û�id -->
		  <input type="hidden" name="sm_code" value="<%=sm_code%>"><!-- ҵ������ -->
		  <input type="hidden" name="bp_flag" ><!-- bp_flag -->
		  <input type="hidden" name="function_code_value" ><!-- Ѱ������ -->
		  <input type="hidden" name="should_hand_fee" value="<%=should_hand_fee%>"><!-- Ӧ�������� -->
		  <input type="hidden" name="system_time" value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>">   <!-- ϵͳʱ�� -->
		  <input type="hidden" name="system_time_flag"  >   <!-- ����ʹ�ñ�ʶ -->
		  <input type="hidden" name="cmd_right" value="<%=cmd_right%>"><!-- cmd_right -->
		  <input type="hidden" name="function_type" ><!-- �ط����� -->
		  <input type="hidden" name="fic_no" value="000000" ><!--������룬�Ѳ���-->
		  <input type="hidden" name="choice_fee" value="0"><!--ѡ�ŷѣ��Ѳ���-->
		  <input type="hidden" name="should_choice_fee" value="0" ><!-- Ӧ��ѡ�ŷѣ��Ѳ��� -->
		  <input type="hidden" name="add_no" value="1258"><!--Ѱ�����룬�Ѳ���-->
		  <input type="hidden" name="printAccept" value="<%=printAccept%>" >
		  <input type="hidden" name="opCode" value="<%=opCode%>">
		  <input type="hidden" name="opName" value="<%=opName%>">
	</form>
	</body>
	<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
	<script language="JavaScript">
	  <%if((highFlag.trim()).equals("Y")){%>
	    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
	  <%}%>
	</script>


<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ǿ�ƿ��ػ�1246
   * �汾: 1.0
   * ����: 2008/12/23
   * ����: leimd
   * ��Ȩ: si-tech
   * update:zhangyan
  */
%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String hdpowerright =(String)session.getAttribute("powerRight");//��ɫȨ��
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String hdwork_pwd =(String)session.getAttribute("password");//��������		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//��½IP	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���	
	String regionCode = (String)session.getAttribute("regCode");
%>

<%
	String opCode="1246";
	String opName="ǿ�ƿ��ػ�";
	String phoneNo = request.getParameter("i1");
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=hdorg_code.substring(0,2)%>"  id="retListString1"/>	
<head>
<SCRIPT language="javascript">
function turnit()
{
	document.all.better.style.display="";
	document.getElementById("type_row").style.display="none";						    /*zhangyan add ǿ������ʱ,ǿ����������*/
	document.getElementById("sendmsgbtn").style.display="none";							/*zhangyan add ���Ͷ��Ű�ť����*/
}
function checkexpDays()
{
	if(document.form1.expDays.value <= 0)
    {
        rdShowMessageDialog("����ȷ��������,��������Ϊ����0�죡");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }
	if(document.form1.expDays.value > 365)
    {
        rdShowMessageDialog("����ȷ��������,�������ܳ���365�죡");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }

}

/*----------------���ô�ӡҳ�溯��---------------------*/
	function showPrtdlg1246()
	{  
		getAfterPrompt();
		
	/*����ģʽ�Ի��𣬲����û��������д���*/
		var h=105;
		var w=260;
		var t=screen.availHeight-h-20;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
		var ret=1;
		if(typeof(ret)!="undefined")
		{
			if(ret==1)                      //����Ͽ�
			{
				//senddata();                      //ͬʱ����ҳ��ƴ��
				conf();                          
			}
			else if(ret==0)                 //���ȡ��,���Ƿ��ύ
			{    
				crmsubmit();                     
			}
		}
	}	
	
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body >
<form action="" method=post name="form1"> 
	<input type="hidden" name="oret_code" value="">
	<%@ include file="/npage/include/header.jsp" %>

<%      
 	String outList[][] = new String [][]{{"0","26"}};
%>
<%
/***********************************���巵�ز���*********************************************/

	String oret_code="";              // �������               
	String oret_msg="";		          // ������Ϣ
	String oid_no="";		  		  // 0  �û�id            
	String osm_code="";		          // 1  ҵ�����ʹ���      
	String osm_name="";		          // 2  ҵ����������      
	String ocust_name="";		      // 3  �ͻ�����          
	String ouser_password="";	      // 4  �û�����          
	String orun_code="";		      // 5  ״̬����          
	String orun_name="";		      // 6  ״̬����          
	String oowner_grade="";		      // 7  �ȼ�����          
	String ograde_name="";		      // 8  �ȼ�����          
	String oowner_type="";		      // 9  �û�����          
	String oowner_typename="";	      //10  �û���������      
	String ocust_addr="";		      //11  �ͻ�סַ          
	String oid_type="";		          //12  ֤������          
	String oid_name="";		          //13  ֤������          
	String oid_iccid="";		      //14  ֤������          
	String ocard_name="";		      //15  �ͻ�������        
	String ototal_owe="";		      //16  ��ǰǷ��          
	String ototal_prepay="";          //17  ��ǰԤ��          
	String ofirst_oweconno="";	      //18  ��һ��Ƿ���ʺ�    
	String ofirst_owefee="";	      //19  ��һ��Ƿ���ʺŽ��		 
	String obak_field=""; 		      //20  �����ֶ�          
	String ocmd_code="";		      //21  �������          
	String ocmd_name="";		      //22  ��������          
	String onew_run="";		          //23  ��״̬����        
	String onew_runname="";           //24  ��״̬���� 
	String product_name="";           //25  ��Ʒ����
	
/**************************����s1246Init�����****************************/
	String iwork_no = hdword_no;                                 //��������
	String iphone_no = ReqUtil.get(request,"i1");                //�ֻ�����
	String iop_code = "1246";                                    //op_code 
	String iorg_code = hdorg_code;                               //org_code  
	String strOpRunCode = ReqUtil.get(request,"op_run_code");                //��������״̬
	String owning_fee="";
	String cfm_login = "";//����˺�
	
%>
	<wtc:service name="s1246Init" routerKey="region" routerValue="<%=regionCode%>" outnum="27" retcode="retCode" retmsg="retMsg">

		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iop_code%>"/>
		<wtc:param value="<%=iwork_no%>"/> 
		<wtc:param value="<%=hdwork_pwd%>"/>
		<wtc:param value="<%=iphone_no%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=iorg_code%>"/>
	  <wtc:param value="<%=strOpRunCode%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
		oret_code = retCode;
		oret_msg = retMsg;
		              
		System.out.println("2222:" + oret_code + ":" + oret_msg);
		

		if(!oret_code.equals("000000"))
	 	{
%>
<script language="javascript">
	rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>��",0);
	history.go(-1);
</script>
<%}else{
		oid_no  = result[0][0];                     // 0 �û�id    
		osm_code  = result[0][1];		        	// 1 ҵ�����ʹ���       
		osm_name = result[0][2];					// 2 ҵ����������       
		ocust_name = result[0][3];					// 3 �ͻ�����           
		ouser_password = result[0][4];				// 4 �û�����           
		orun_code = result[0][5];					// 5 ״̬����           
		orun_name = result[0][6];					// 6 ״̬����           
		oowner_grade = result[0][7];				// 7 �ȼ�����           
		ograde_name = result[0][8];					// 8 �ȼ�����           
		oowner_type = result[0][9];					// 9 �û�����           
		oowner_typename = result[0][10];			//10 �û���������       
		ocust_addr = result[0][11];					//11 �ͻ�סַ           
		oid_type = result[0][12];					//12 ֤������           
		oid_name = result[0][13];					//13 ֤������           
		oid_iccid = result[0][14];					//14 ֤������           
		ocard_name = result[0][15];					//15 �ͻ�������         
		ototal_owe = result[0][16];					//16 ��ǰǷ��           
		ototal_prepay = result[0][17];				//17 ��ǰԤ��           
		ofirst_oweconno  = result[0][18];			//18 ��һ��Ƿ���ʺ�     
		ofirst_owefee = result[0][19];				//19 ��һ��Ƿ���ʺŽ��	
		obak_field = result[0][20];                 //20 �����ֶ�           
		ocmd_code = result[0][21];                  //21 �������            
		ocmd_name = result[0][22];                  //22 ��������            
		onew_run = result[0][23];                   //23 ��״̬����          
		onew_runname  = result[0][24];              //24 ��״̬����
		product_name  = result[0][25];              //25 ��Ʒ����
		cfm_login  = result[0][26];              //����˺�

	/*�����ǿ�ز������߶���� zhangyan */
		System.out.println("zhangyan add  onew_runname=["+onew_runname+"]");
		System.out.println("zhangyan add onew_run= ["+onew_run+"]");

	if ("N".equals(onew_run))
	{
		System.out.println("zhangyan add  iphone_no=["+iphone_no+"]");
	%>
		<wtc:service name="bs_GetOwe" routerKey="region" routerValue="<%=regionCode%>" outnum="3" 
			retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=iphone_no%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>	
	<%
		if(!retCode1.equals("000000"))
		{
		%>
			<script language="javascript">
				rdShowMessageDialog("bs_GetOwe:<%=String.valueOf(retCode1)%>:"+"<%=retMsg1%>��",0);
				history.go(-1);
			</script>
		<%
		}
		else
		{
			owning_fee = result1[0][0];
			System.out.println("zhangyan add  owning_fee=["+owning_fee+"]");
			
		}
	}

}%>
<div class="title">
		<div id="title_zi">�ͻ�����</div>
	</div>
<input type = "hidden" name = "strOpRunCode" value = "<%=strOpRunCode%>">
<table cellspacing="0">
	<tr> 
		<td class="blue">������� </td>
		<td>
			<input name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20" v_type="mobphone" 
				 v_must=1 onBlur="if(this.value!=''){if(checkElement('i1')==false){return false;}}" 
				 Class="InputGrey" readOnly>
		</td>
		<td class="blue">�ͻ����� </td>
		<td >
			<input name="ocust_name" size="20"  value="<%=ocust_name%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue">��Ʒ����  </td>
		<td >
			<input name="product_name" size="20"  value="<%=product_name%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">�ͻ�סַ</td>
		<td >
			<input name="ocust_addr" size="20"  value="<%=ocust_addr%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr > 
		<td class="blue">֤������</td>
		<td ><input name="oid_type" value="<%=oid_name%>" size="20" Class="InputGrey" readOnly>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="oid_iccid" size="20"  value="<%=oid_iccid%>"   Class="InputGrey" readOnly >
		</td>
	</tr>
	<tr> 
		<td class="blue">״̬����</td>
		<td >
			<input name="orun_code" size="20"  value="<%=orun_code%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">״̬���� </td>
		<td >
			<input name="orun_name" size="20"  value="<%=orun_name%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<%
		String strsql = "";
		String favor_code = "";
		String hand_fee = "";

		strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
	%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:sql><%=strsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr" scope="end" />
	<%
		if(retCode.equals("000000")){
			if(handFeeArr.length>0){
				hand_fee = handFeeArr[0][0];
				favor_code = handFeeArr[0][1];				
			}
		}
	%>
	<tr >
		
			<input name="ohand_cash" v_name='������' type="hidden" size="20" maxlength=20 value="0">
			<input type="hidden" name="ishould_fee" size="20" maxlength=20 value="0" Class="InputGrey" readOnly>
		
		<td class="blue">���ػ������ </td>
		<td>
			<input name="icmd_code" value="<%=onew_runname%>" size="4" Class="InputGrey" readOnly>
			<span id=better style="DISPLAY: none">
				<input name="expDays" size="12" v_type="0_9" onChange="checkexpDays()" maxlength=20 value="1"  onblur="if(this.value!=''){if(checkElement(this)==false){return false;}}">��
			</span>
		</td>

	<td class="blue">����˺� </td>
		<td>
			<input  id="cfm_login" name="cfm_login" value="<%=cfm_login%>"   Class="InputGrey" readOnly>
		</td>
	</tr>

	<%
	/*zhangyan add ��������ǿ�ز���ҵ���ܵ����� b*/		
	%>
	<tr id =  "type_row">
		<td class="blue">ǿ������ </td>
		<td nowrap colspan = "3">
			<input type = "hidden" name = "force_type" id = "force_type" value = "">
			<select name = "force_type_sel" onchange = "show_detail()" >
				<option value = "0">---��ѡ��---</option>
				<option value = "1"> �߶� </option>
				<option value = "2"> Υ��ͣ�� </option>
				<option value = "3"> ���� </option>
				<option value = "4"> ��ʵ��ͣ�� </option>
				<option value = "5"> ������������ </option>
			</select>
			<font color = "red"> * </font>
		</td>		
	</tr>	
	<%
	/***  gaoe*/
	%>
	<tr  id = "reason_row" style ="display:none" >
		<td class="blue">ǿ��ԭ�� </td>
		<td nowrap colspan = "3">
			<textarea name = "force_reason" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr   id ="judge_row"  style ="display:none" >
		<td class="blue">ǿ���жϱ�׼ </td>
		<td nowrap colspan = "3">
			<textarea name = "force_judgement" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>			
	<tr id = "ticket_row"  style ="display:none" >
		<td class="blue">��ص��߶����ʱ�� </td>
		<td nowrap >
			<input type="text"  name = "largeticket_time" maxlength = "20" 
				size = "30" id = "largeticket_time" readonly>
			<img id = "largeticket_time_sel" onclick="WdatePicker({el:'largeticket_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
		 		src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>		
		<td class="blue">�߶���ķ��� </td>
		<td nowrap >
			<input type="text"  name = "largeticket_fee" maxlength = "10"  
				size = "30" >
			<font color = "red">*</font>
		</td>			
	</tr>		
	<tr id = "fee_row"  style ="display:none" >	
		<td class="blue">��ǰ�������</td>
		<td nowrap colspan="3">
			<input type="text"  name = "owning_fee"  id = "owning_fee"
				size = "30" value = "<%=owning_fee%>" readOnly>
			<font color = "red">*</font>
		</td>			
	</tr>		
	<%
	/*** weizhangtingji */
	%>
	<tr id = "office_row" style ="display:none" >
		<td class="blue">��Ͻ�־�</td>
		<td colspan="3">
			<input name="suboffice" size="100" maxlength = "30">
			<font color = "red">* (30��������)</font>
		</td>
	</tr>
	<tr id = "office_phone_row" style ="display:none" >
		<td class="blue">��Ͻ�־ֵ绰</td>
		<td colspan="3">
			<input name="suboffice_phone" size="100" maxlength = "30">
			<font color = "red">* (30��������)</font>
		</td>
	</tr>	
	<tr id = "doc_row" style ="display:none" >
		<td class="blue">�ļ���� </td>
		<td nowrap >
			<input type="text"  name = "document_number" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">�������� </td>
		<td nowrap >
			<input type="text"  name = "document_date"  
				v_type="date"  onblur="checkElement(this);"  size = "10"  >
			<font color = "red">*</font>
		</td>		
	</tr>	
	
	<tr id = "doc_row45" style ="display:none" >
		<td class="blue">�ļ���� </td>
		<td nowrap >
			<input type="text"  name = "document_number1" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">&nbsp; </td>
		<td class="blue">&nbsp; </td>
	</tr>	
	<tr id = "contact_row" style ="display:none" >
		<td class="blue">��ϵ������ </td>
		<td nowrap >
			<input type="text"  name = "contact_name" maxlength = "10" 
				size = "15">
			<font color = "red">*</font>
		</td>	
		<td class="blue">��ϵ�˵绰 </td>
		<td nowrap >
			<input type="text"  name = "contact_phone" maxlength = "20" 
				size = "30" >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "operator_row" style ="display:none" >
		<td class="blue">���������� </td>
		<td nowrap >
			<input type="text"  name = "operator_name" size = "15"  maxlength = "5"  ><font color = "red">*</font>
		</td>	
		<td class="blue">��������ϵ�绰 </td>
		<td nowrap >
			<input type="text"  name = "operator_phone" size = "20" maxlength = "20"   ><font color = "red">*</font>
		</td>		
	</tr>	
	<%
	/*zhangyan add ��������ǿ�ز���ҵ���ܵ����� e*/

	%>
	<!--huangrong update ����ע��ֻ�����Ժͱ�����ʽ2011-6-13-->
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="sysnote" size="60" maxlength="30">
		</td>
	</tr>

	<tr> 
		<td align=center colspan="4">
			<input class="b_foot" id = "sendmsgbtn" name="sendmsgbtn" onClick="sendMsg()"   type=button 
				value="���Ͷ���">     
			<input class="b_foot_long" name=sure  type=button value="ȷ��&��ӡ" 
				onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtdlg1246();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
		</td>
	</tr>
</table>
	   <!-----------------------------------����������----------------------------------------------->
	   <!--input type="hidden" value="<%=onew_runname%>" name="onew_runname"-->
	   <input type="hidden" name="stream" value="<%=retListString1%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="osm_code" value="<%=osm_code%>">

	   <!-------------------------------------------------------------------------------------------->
	  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

<script language="javascript">
	onload=function()
	{
		<%if(onew_runname.trim().equals("ǿ��")){%>
		turnit();
		<%}%>
		//begin huangrong add ���ñ�ע��Ϣ 2011-6-13 
		var imo_phone = '<%=ReqUtil.get(request,"i1")%>' ;	
		var onew_runname=document.all.icmd_code.value;		
		thesysnote = imo_phone + onew_runname;                        //����ϵͳ��ע			
		document.all.sysnote.value= thesysnote.trim();  
		//end huangrong add ���ñ�ע��Ϣ 2011-6-13 
	}
	/*** zhangyan add  ���Ͷ���*/
	function sendMsg()
	{
		var i1 = document.form1.i1.value;
		var force_type = document.form1.force_type.value;	
		var force_reason = document.form1.force_reason.value;     	
		var force_judgement = document.form1.force_judgement.value;            
		var largeticket_time = document.form1.largeticket_time.value;            
		var largeticket_fee = document.form1.largeticket_fee.value;            
		var suboffice = document.form1.suboffice.value;               			      
		var suboffice_phone = document.form1.suboffice_phone.value;   				       
		var document_number = document.form1.document_number.value;   
		var document_date = document.form1.document_date.value;              
		var operator_name = document.form1.operator_name.value;             
		var operator_phone = document.form1.operator_phone.value;                
		var contact_name = document.form1.contact_name.value;                  
		var contact_phone = document.form1.contact_phone.value;   
		var owning_fee=		document.form1.owning_fee.value;   
		if (!forNotNegReal(document.form1.largeticket_fee)) 
		{
			rdShowMessageDialog("����������ȷ�ĸ߶������!");
			return false;
		}	
		if(!forPhone(document.form1.operator_phone)) 
		{
			rdShowMessageDialog("����������ȷ���ֻ�����!");
			return false;	
		}			
		if ( ""==force_reason )
		{
			rdShowMessageDialog("ǿ��ԭ����Ϊ��!");
			return false;
		}
		if ( ""==force_judgement )
		{
			rdShowMessageDialog("ǿ���жϱ�׼����Ϊ��!");
			return false;
		}		
		if ( ""==largeticket_time )
		{
			rdShowMessageDialog("��ص��߶����ʱ�䲻��Ϊ��!");
			return false;
		}	
		if ( ""==largeticket_fee )
		{
			rdShowMessageDialog("��ص��߶�����ò���Ϊ��!");
			return false;
		}	 
		if ( ""==largeticket_fee )
		{
			rdShowMessageDialog("��ص��߶�����ò���Ϊ��!");
			return false;
		}	
		
		if ( ""==owning_fee )
		{
			rdShowMessageDialog("��ǰ��������Ϊ��!");
			return false;
		}	
		/*����У��*/
		if (force_judgement.len() > 512)
		{
			rdShowMessageDialog("ǿ���жϱ�׼����̫��!");
			return false;
		}
		
		if (force_reason.len() > 120)
		{
			rdShowMessageDialog("ǿ���ж�ԭ������̫��!");
			return false;
		} 
		document.form1.force_type_sel.disabled = true;
		document.form1.largeticket_time_sel.disabled = true;
		document.form1.i1.readOnly = true;
		document.form1.force_type.readOnly = true;
		document.form1.force_reason.readOnly = true;
		document.form1.force_judgement.readOnly = true;
		document.form1.largeticket_time.readOnly = true;
		document.form1.largeticket_fee.readOnly = true;
		document.form1.suboffice.readOnly = true;
		document.form1.suboffice_phone.readOnly = true;
		document.form1.document_number.readOnly = true;
		document.form1.document_date.readOnly = true;
		document.form1.operator_name.readOnly = true;
		document.form1.operator_phone.readOnly = true;
		document.form1.contact_name.readOnly = true;
		document.form1.contact_phone.readOnly = true;
		document.form1.sysnote.readOnly=true;
		document.form1.owning_fee.readOnly=true;
    	var myPacket = new AJAXPacket("f1246_sendMsg.jsp","���ڷ�����");
        myPacket.data.add("largeticket_time" , largeticket_time);
        myPacket.data.add("i1" , i1);
        myPacket.data.add("owning_fee" , owning_fee);
        core.ajax.sendPacket(myPacket);
        myPacket=null;

	}
	var  iTime = 179;																/*����ʱ��*/
	function doProcess(packet)
	{
		var retCode = packet.data.findValueByName("retCode"); 
    	var retMsg = packet.data.findValueByName("retMsg"); 

    	if ( "000000"!=retCode )
    	{
    		rdShowMessageDialog(  retCode+":"+retMsg);
    		removeCurrentTab();
    	}
    	else
    	{
    		rdShowMessageDialog("���ŷ��ͳɹ�!");
    	}
    	document.form1.sendmsgbtn.disabled = true;
		document.form1.sure.disabled = true;
       	RemainTime(); 
	}
	/*** zhangyan add ����ʱ����*/
	function RemainTime()
	{
    	if (iTime > 0)
    	{
	       	setTimeout("RemainTime()",1000);
        	iTime=iTime-1;
        	document.form1.sure.value = "("+iTime+"s)ȷ��&��ӡ";
    	}
    	else
		{
			document.form1.sure.value = "ȷ��&��ӡ";
			document.form1.sure.disabled = false;
		}

	}
	
	/*** zhangyan add ǿ����ϸ���� b*/
	function show_detail() 
	{
		var force_type_sel = document.form1.force_type_sel.value;
		document.form1.force_type.value = force_type_sel;
		var force_type = force_type_sel;
		
		document.form1.force_reason.value="";     	
		document.form1.force_judgement.value="";            
		document.form1.largeticket_time.value="";            
		document.form1.largeticket_fee.value="";            
		document.form1.suboffice.value="";               			      
		document.form1.suboffice_phone.value="";   				       
		document.form1.document_number.value="";   
		document.form1.document_number1.value="";  
		document.form1.document_date.value="";              
		document.form1.operator_name.value="";             
		document.form1.operator_phone.value="";                
		document.form1.contact_name.value="";                  
		document.form1.contact_phone.value="";             

		
		if ( 1==force_type )												    /*�߶�*/
		{
			document.form1.sendmsgbtn.disabled = false;
			document.form1.force_reason.value="�߶�";   
			document.form1.force_reason.readOnly = true;
			document.form1.sure.value = "(180s)ȷ��&��ӡ";	
			document.form1.sure.disabled = true;			
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "block";
			document.getElementById("ticket_row").style.display = "block";
			document.getElementById("fee_row").style.display = "block";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "block";
		}
		else if ( 2==force_type )											    /*Υ��ͣ��*/
		{
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.form1.sure.value = "ȷ��&��ӡ";	
			document.form1.sure.disabled = false;
						
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "block";
			document.getElementById("office_phone_row").style.display = "block";
			document.getElementById("doc_row").style.display = "block";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "block";
		}
		else if ( 3==force_type )											    /*����*/
		{
			document.form1.sure.value = "ȷ��&��ӡ";
			document.form1.sure.disabled = false;
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "block";
			
			document.getElementById("operator_row").style.display = "none";
		}else if ( 4==force_type||5==force_type )		 /*����ʵ��ͣ�����͡������������š�*/
		{
			document.form1.sure.value = "ȷ��&��ӡ";
			document.form1.sure.disabled = false;
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "block";
			document.getElementById("contact_row").style.display = "none";
			document.getElementById("operator_row").style.display = "block";
		}
		else																	/*��ѡ��*/
		{
			document.form1.sure.value = "ȷ��&��ӡ";
			document.form1.sure.disabled = false;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "none";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "none";			
		}
		
		

	}
	
/*-----------------------------ҳ����ת����-----------------------------------------------*/
	function pageSubmit(page){
		document.form1.action="<%=request.getContextPath()%>/npage/"+page;
		form1.submit();
		/*if(flag==1){
		document.form1.action="<%=request.getContextPath()%>/npage/change/f1274_3.jsp";  
		form1.submit();
		}*/
	}
/*--------------------------������У�麯��--------------------------*/	  

	function checknum(obj1,obj2)
	{
		var num2 = parseFloat(obj2.value);
		var num1 = parseFloat(obj1.value);
		
		if(num2<num1)
		{
			var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
			rdShowMessageDialog(themsg,0);
			obj1.focus();
			return false;
		}
		
		if(document.all.icmd_code.value== "ǿ��")
		{	
			var tmpDays = parseInt(document.all.expDays.value,10);
		
			if( tmpDays <= 0 || tmpDays > 365 || (document.all.expDays.value).trim().length==0)
			{
				rdShowMessageDialog("ǿ��ʱ��������ȷ��ǿ��ʱ��,ǿ��ʱ����0-365֮��!",0);
				return false;
			}
		}
		/*** zhangyan add ǿ��ҳ��У��*/
		if(document.form1.strOpRunCode.value=="N")
		{
			var force_type = document.form1.force_type.value;	
			var force_reason = document.form1.force_reason.value;     	
			var force_judgement = document.form1.force_judgement.value;            
			var largeticket_time = document.form1.largeticket_time.value;            
			var largeticket_fee = document.form1.largeticket_fee.value;            
			//document.form1.owning_fee.value;  
			var suboffice = document.form1.suboffice.value;               			      
			var suboffice_phone = document.form1.suboffice_phone.value;   				       
			var document_number = document.form1.document_number.value;   
			var document_number1 = document.form1.document_number1.value;  
			var document_date = document.form1.document_date.value;              
			var operator_name = document.form1.operator_name.value;             
			var operator_phone = document.form1.operator_phone.value;                
			var contact_name = document.form1.contact_name.value;                  
			var contact_phone = document.form1.contact_phone.value;      
			
			
			
			if (force_judgement.len() > 512)
			{
				rdShowMessageDialog("ǿ���жϱ�׼����̫��!");
				return false;
			}
		
			if ( 0==force_type )											    /*��ѡ��ʱ*/
			{
				rdShowMessageDialog("ǿ�����ͱ���ѡ��!");
				return false;
			}
			else if ( 1==force_type )										    /*�߶�*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("ǿ��ԭ����Ϊ��!");
					return false;
				}
				if ( ""==force_judgement )
				{
					rdShowMessageDialog("ǿ���жϱ�׼����Ϊ��!");
					return false;
				}		
				if ( ""==largeticket_time )
				{
					rdShowMessageDialog("��ص��߶����ʱ�䲻��Ϊ��!");
					return false;
				}	
				if ( ""==largeticket_fee )
				{
					rdShowMessageDialog("��ص��߶�����ò���Ϊ��!");
					return false;
				}			
						
			}
			else if ( 2==force_type )									 	    /*Υ��ͣ��*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("ǿ��ԭ����Ϊ��!");
					return false;
				}
				if ( ""==suboffice )
				{
					rdShowMessageDialog("��Ͻ�־� ����Ϊ��!");
					return false;
				}				
				if ( ""==suboffice_phone )
				{
					rdShowMessageDialog("��Ͻ�־���ϵ�绰 ����Ϊ��!");
					return false;
				}				
				if ( ""==document_number )
				{
					rdShowMessageDialog("�ļ���Ų���Ϊ��!");
					return false;
				}			
				if ( ""==document_date )
				{
					rdShowMessageDialog("�������ڲ���Ϊ��!");
					return false;
				}						
				if ( ""==operator_name )
				{
					rdShowMessageDialog("���������� ����Ϊ��!");
					return false;
				}		
				if ( ""==operator_phone )
				{
					rdShowMessageDialog("��������ϵ�绰 ����Ϊ��!");
					return false;
				}	

				if(  !forPhone(document.form1.operator_phone)  ) 
				{
					rdShowMessageDialog("����������ȷ���ֻ�����!");
					return false;	
				}	
							
				if (force_reason.len() > 120)
				{
					rdShowMessageDialog("Υ��ͣ����ǿ���ж�ԭ������̫��!"); 
					return false;
				} 											
			}
			else if ( 3==force_type )										    /*����*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("ǿ��ԭ����Ϊ��!");
					return false;
				}	
				
				if ( ""==contact_name )
				{
					rdShowMessageDialog("��ϵ�˲���Ϊ��!");
					return false;
				}		
				if ( ""==contact_phone )
				{
					rdShowMessageDialog("��ϵ�˵绰����Ϊ��!");
					return false;
				}	
				if (force_reason.len() > 512)
				{
					rdShowMessageDialog("ǿ���ж�ԭ������̫��!");
					return false;
				} 		
				if (contact_name.len() > 10)
				{
					rdShowMessageDialog("��ϵ�������������!");
					return false;
				} 					
				if (contact_phone.len() > 20)
				{
					rdShowMessageDialog("��ϵ�˵绰�������!");
					return false;
				} 					
			}else if ( 4==force_type||5==force_type )				 /*����ʵ��ͣ�����͡������������š�*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("ǿ��ԭ����Ϊ��!");
					return false;
				}	
				
				 if ( ""==operator_name )
				{
					rdShowMessageDialog("���������� ����Ϊ��!");
					return false;
				}		
				if ( ""==operator_phone )
				{
					rdShowMessageDialog("��������ϵ�绰 ����Ϊ��!");
					return false;
				}	
				
				if (force_reason.len() > 512)
				{
					rdShowMessageDialog("ǿ���ж�ԭ������̫��!");
					return false;
				} 		
				 
				if ( ""==document.form1.document_number1.value )
				{
					rdShowMessageDialog("�ļ���Ų���Ϊ��!");
					return false;
				}else{
					document.form1.document_number.value = document.form1.document_number1.value
				}				
			}
			
		}
		
		return true;
	} 
	
	var thesysnote = ""; //����ȫ�ֱ�����ϵͳ��ע
	
	function printInfo(printType)
	{
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
		
		var phoneNo = "<%=ReqUtil.get(request,"i1")%>";
		if("<%=cfm_login%>"!=""){
			phoneNo = "<%=cfm_login%>";
		}
		
		cust_info+="�ֻ����룺"+phoneNo+"|";
		cust_info+="�ͻ�������"+'<%=ocust_name%>'+"|";         	
		cust_info+="�ͻ���ַ��"+'<%=ocust_addr%>'+"|";
		cust_info+="֤�����룺"+'<%=oid_iccid%>'+"|";
		
		opr_info+="ҵ�����ͣ�ǿ�ƿ��ػ�"+"|";
		opr_info+="ҵ����ˮ��"+document.all.stream.value+"|";
		note_info1+="��ע: "+document.all.sysnote.value+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		
	   	return retInfo;	
	}

/*-------------------------��ӡ�����ύ������-------------------*/
	function conf()
	{ 
		var h=200;
		var w=400;
		var t=screen.availHeight/2-h/20;
		var l=screen.availWidth/2-w/2;
		
		var DlgMessage = "ȷʵҪ���е��������ӡ��?";
		var submitCfm = "Yes";
	
	   var pType="subprint";                                     // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	   var billType="1";                                         //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	   var sysAccept=document.all.stream.value;                  // ��ˮ��
	   var printStr=printInfo("Detail");                         //����printinfo()���صĴ�ӡ����
	   var mode_code=null;                                        //�ʷѴ���
	   var fav_code=null;                                         //�ط�����
	   var area_code=null;                                        //С������
	   var opCode="1246";                                         //��������
	   var phoneNo="<%=phoneNo%>"              						//�ͻ��绰
	   
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	   var ret_value=window.showModalDialog(path,printStr,prop);
		
	/**********************��ӡ����Ĳ�����֯���****************************/
		//if(ret_value == "continueSub")
		//{
			//document.all.stream.value = ;
      
			crmsubmit();
		
		//}
	
	}
	
	function crmsubmit()
	{
		if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1){
			form1.action="f1246_3.jsp";
			form1.submit();
		 }else{
			return false;
		 }
	}

 </script>

<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * ����: ���˲����������
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 200-01-08     �޸��� leimd     �޸�Ŀ��
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String opCode="6713";
	String opName="���˲�������/�������";
	String  phone_no=(String)request.getParameter("activePhone"); 
    String ip_Addr = (String)session.getAttribute("ipAddr");			//Ip��ַ
    String workno = (String)session.getAttribute("workNo");				//��������
    String workname = (String)session.getAttribute("workName");			//������
    String org_code = (String)session.getAttribute("orgCode");			//��������
    String nopass  = (String)session.getAttribute("password");			//������������
    String regionCode=(String)session.getAttribute("regCode");			//���д���
    int nextFlag=1;
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%		
	String loginAcceptOld="";			//ԭ������ˮ		
	String OpCode = "6713"  ;
	String sInOpNote="���˲������������ʼ��";
	String sOutPhoneNo    ="";         //�û��ֻ�����      
	String sOutLoginAccept="";         //��������ˮ��      
	String sOutCustId     ="";         //�ͻ�ID_NO         
	String sOutCustName   ="";         //�ͻ�����          
	String sOutSmCode     ="";         //����Ʒ�ƴ���      
	String sOutSmName     ="";         //����Ʒ������      
	String sOutProductCode="";         //����Ʒ����        
	String sOutProductName="";         //����Ʒ����        
	String sOutCRProdCode1="";         //���ò����Ʒ      
	String sOutCRProdName1="";         //���ò����Ʒ����  
	String sOutCRProdCode2="";         //ԤԼ�����Ʒ      
	String sOutCRProdName2="";         //ԤԼ�����Ʒ����  
	String sOutLoginNo    ="";         //��������          
	String sOutLoginName  ="";         //����Ա����        
	String sOutLoginTime  ="";         //����ʱ��          
	String sOutOpNote     ="";         //ԭϵͳ��ע        
	String sOutSystemNote ="";         //ԭ������ע   
	String sOutCustAddress ="";     //�û���ַ
    String sOutIdIccid     ="";     //֤������    
	   
	String action=request.getParameter("action");   

	if (action!=null&&action.equals("select"))
	{
	    phone_no = request.getParameter("phone_no");     
	    loginAcceptOld = request.getParameter("loginAcceptOld");
	   	    
//	    SPubCallSvrImpl callView = new SPubCallSvrImpl();
		String paramsIn[] = new String[6];
		paramsIn[0]=workno;             //��������         
		paramsIn[1]=nopass;             //������������     
		paramsIn[2]=OpCode;             //��������         
		paramsIn[3]=sInOpNote;          //��������         
		paramsIn[4]=phone_no;           //�û��ֻ�����     
		paramsIn[5]=loginAcceptOld;     //������ˮ
					 	
//		ArrayList acceptList = new ArrayList();
//		acceptList = callView.callFXService("s6713Init", paramsIn, "19");
%>
	<wtc:service name="s6713Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%		
		String errCode = retCode;
		String errMsg = retMsg;
      
		if(!errCode.equals("000000"))
		{
%>        
<script language='jscript'>
			rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			history.go(-1);
</script> 
<%  
		}
		if(errCode.equals("000000"))
		{
			nextFlag = 2;
	/*				
			String result2 [][] = (String[][])acceptList.get(0);
			String result3 [][] = (String[][])acceptList.get(1);
			String result4 [][] = (String[][])acceptList.get(2);
			String result5 [][]	= (String[][])acceptList.get(3);
			String result6 [][]	= (String[][])acceptList.get(4);
			String result7 [][]	= (String[][])acceptList.get(5);
			String result8 [][]	= (String[][])acceptList.get(6);
			String result9 [][]	= (String[][])acceptList.get(7);
			String result10[][]	= (String[][])acceptList.get(8);
			String result11[][] = (String[][])acceptList.get(9);
			String result12[][]	= (String[][])acceptList.get(10);
			String result13[][]	= (String[][])acceptList.get(11);
			String result14[][]	= (String[][])acceptList.get(12);
			String result15[][]	= (String[][])acceptList.get(13);
			String result16[][]	= (String[][])acceptList.get(14);
			String result17[][] = (String[][])acceptList.get(15);
			String result18[][]	= (String[][])acceptList.get(16);
			String result19[][] = (String[][])acceptList.get(17);
			String result20[][]	= (String[][])acceptList.get(18);
		*/					
			sOutPhoneNo      =result [0][0];
			sOutLoginAccept  =result [0][1];
			sOutCustId       =result [0][2];
			sOutCustName     =result [0][3];
			sOutSmCode       =result [0][4];
			sOutSmName       =result [0][5];
			sOutProductCode  =result [0][6];
			sOutProductName  =result [0][7];
			sOutCRProdCode1  =result[0][8];
			sOutCRProdName1  =result[0][9];
			sOutCRProdCode2  =result[0][10];
			sOutCRProdName2  =result[0][11];
			sOutLoginNo      =result[0][12];
			sOutLoginName    =result[0][13];
			sOutLoginTime    =result[0][14];
			sOutOpNote       =result[0][15];
			sOutSystemNote   =result[0][16]; 
			sOutCustAddress  =result[0][17];            // �û���ַ
			sOutIdIccid      =result[0][18];            // ֤������  
		}  
	}    
%>      
        
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>������BOSS-���˲�������/�������</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
        
<script language="JavaScript">
//ȷ���ύ
function refain()
{
	getAfterPrompt();
	showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
		document.form.action="f6713_2.jsp";
		document.form.submit();
		return true;
	}
  
}
//�����ֻ��ź����룬��ѯ������Ϣ
function doQuery()
{	
	if(document.form.loginAcceptOld.value=="")
	{
		rdShowMessageDialog("���������ˮ����Ϊ�գ�",0);
		return false;
	}

	if(document.form.loginAcceptOld.value.length<11)
	{
		rdShowMessageDialog("������ˮ����С��11λ��",0);
		return false;
	}
	
	document.form.action = "f6713_1.jsp?action=select&activePhone=<%=phone_no%>";
	document.form.submit(); 
}
	

function showPrtDlg(printType,DlgMessage,submitCfm)  //��ʾ��ӡ�Ի���
{	
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=loginAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="6713" ;                   			 		//��������
	var phoneNo="<%=phone_no%>";                  	 		//�ͻ��绰

	if(printStr == "failed")
	{    return false;   }
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+<%=loginAccept%>+
			"&phoneNo="+document.form.phone_no.value+
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
	
	opr_info+='<%=workname%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="֤�����룺"+document.all.sOutIdIccid.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.sOutCustAddress.value+"|";
	opr_info+="ҵ��Ʒ��:"+document.all.sm_name.value+"|";
	opr_info+="����ҵ��:"+"����ҵ�����"+"|";
	opr_info+="������ˮ:"+'<%=loginAccept%>'+"|";
	opr_info+="����ʱ��:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="��Чʱ��:"+"����"+"|";

	retInfo+=document.all.simBell.value+"|";
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}
</script>
</HEAD>
<BODY>
<FORM action="s1310_2.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���˲�������/�������</div>
	</div>
<table cellspacing="0">
	    <input type="hidden" name="opCode" value="<%=OpCode%>"> 
	    <input type="hidden" name="loginNo" value="<%=workno%>">
	    <input type="hidden" name="loginPwd" value="<%=nopass%>">
	    <input type="hidden" name="orgCode" value="<%=org_code%>">
	    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">     	 	          
	<TR>   		  	      
		<td class="blue" width="15%">�������</td>                                 
		<td width="35%">                     
			<input class="InputGrey" readOnly type="text" v_type="string" v_must=1 v_minlength=1 v_maxlength=11 name="phone_no" value="<%=phone_no%>" maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
		</td>
		<td class="blue" width="15%">������ˮ</td>  
		<td width="35%">                     
			<input <%if(nextFlag==2){%> class="InputGrey"<%} %> type="text" v_type="string" v_must=1 v_minlength=1 v_maxlength=11 name="loginAcceptOld" value="<%=sOutLoginAccept%>" maxlength="14" <%if(nextFlag==2){out.print("readonly");}%>>
			
		</td>
	</TR>
<%
	if(nextFlag==1)
	{
%>
	
	<tr>
		<td colspan="4" align="center">
			<input class="b_foot" name=sure22 type=button value="ȷ��" onClick="doQuery();" style="cursor:hand">
			<input class="b_foot" name=reset22 type=reset value="���">
			<input class="b_foot" name=close22 type=button value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
<%
	}
%>
    <%
     if(nextFlag==2)//��ѯ����
     {
    %> 
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td> 
			<input type="text" name="cust_name" class="InputGrey" readOnly value="<%=sOutCustName%>" >
			
		</td>
		<td class="blue">�ͻ�ID</td>
		<td> 
			<input type="text" name="cust_id" maxlength="6" class="InputGrey" readOnly value="<%=sOutCustId%>">
			<input type="hidden" readonly name="sOutCustAddress" class="InputGrey" value="<%=sOutCustAddress%>">
			<input type="hidden" readonly name="sOutIdIccid" class="InputGrey" value="<%=sOutIdIccid%>">
		</td>
	</tr>
	<tr> 
	<td class="blue">ҵ��Ʒ��</td>
	<td> 
		<input type="hidden" readonly name="sm_code" class="InputGrey" value="<%=sOutSmCode%>">
		<input type="text"   readonly name="sm_name" class="InputGrey" value="<%=sOutSmName%>">
		
	</td>
	<td class="blue">ԭ�����Ʒ</td>
	<td> 
		<input type="hidden" readonly name="CRProdCode1" class="InputGrey" value="<%=sOutCRProdCode1%>">
		<input type="text"   readonly name="CRProdName1" class="InputGrey" value="<%=sOutCRProdName1%>">
	</td>
	</tr>
	<tr> 
		<td class="blue">�ʷ��ײ�</td>
		<td> 
			<input type="hidden" readonly name="ProductCode" maxlength="5" class="InputGrey" value="<%=sOutProductCode%>">
			<input type="text"   readonly name="ProductName" size="30" class="InputGrey" value="<%=sOutProductName%>">
		</td>
		<td class="blue">ԤԼ�����Ʒ </td>
		<td> 
			<input type="hidden" readonly name="CRProdCode2" class="InputGrey" maxlength="20" value="<%=sOutCRProdCode2%>">
			<input type="text" readonly  name="CRProdName2" class="InputGrey" maxlength="20" value="<%=sOutCRProdName2%>">
			
		</td>
	</tr> 
	<tr> 
	<td class="blue">ԭϵͳ��ע</td>
	<td> 
		<input type="text" readonly name="sOutSystemNote" maxlength="8" class="InputGrey" value="<%=sOutSystemNote%>" size="40">
	</td>
	<td class="blue">ԭ�û���ע </td>
	<td> 
		<input type="text" readonly name="sOutOpNote" class="InputGrey" maxlength="20" value="<%=sOutOpNote%>" size="45">
	</td>
	</tr> 
            
	<tr> 
		<td class="blue">ϵͳ��ע</td>
		<td colspan="3">
			<input class="InputGrey" readonly name=sysNote size=60 maxlength="60" value="Ա��<%=workno%>����ˮ<%=sOutLoginAccept%>ҵ�����">
		</td>
		</tr>
	<tr> 
		<td class="blue">�û���ע</td>
		<td colspan="3"> 
			<input class="InputGrey" readonly name=opNote size=60 maxlength="60" value="���˲���<%if(sOutCRProdCode2.equals("")){%>����<%}else{%>���<%}%>����">
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
		<input class="b_foot" name=sure type="button" value=ȷ�� onclick="refain()">
		&nbsp;                  
		<input class="b_foot" name=clear type=reset value=��һ�� onClick="history.go(-1);">
		&nbsp;
		<input class="b_foot" name=reset type=button value=�ر� onClick="removeCurrentTab()">
		</td>
	</tr>                
	
	<%
	}//end   if(nextFlag==2)    
	%>
</table>
       <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

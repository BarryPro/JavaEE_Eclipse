<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ʒ��ȡ��ѯ1245
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>

<%
	String opCode="1245";
	String opName="��Ʒ��ȡ��ѯ";
	System.out.println(".....................phone............."+request.getParameter("i1"));
	String phoneNo = (String)request.getParameter("i1");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println(".....................phone............."+phoneNo);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-��Ϣ�㲥����Ʒ��ȡ��ѯ</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
	<%@ include file="/npage/include/header.jsp" %>

<%
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] paraAray=new String[2];
	paraAray[0]=phoneNo;
	paraAray[1]=workNo;
//	ArrayList list = impl.callFXService("s1295_Valid",paraAray,"17");
%>
	<wtc:service name="s1295_Valid" routerKey="region" routerValue="<%=regionCode%>" outnum="17" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
	<wtc:array id="res1" start="7" length="1" scope="end"/>
	<wtc:array id="res2" start="8" length="1" scope="end"/>
	<wtc:array id="res4" start="10" length="1" scope="end"/>
	<wtc:array id="res5" start="11" length="1" scope="end"/>
	<wtc:array id="res6" start="12" length="1" scope="end"/>
	<wtc:array id="res7" start="13" length="1" scope="end"/>	
	<wtc:array id="res8" start="14" length="1" scope="end"/>
	<wtc:array id="res10" start="16" length="1" scope="end"/>	
<%
if(!retCode.equals("000000")){
System.out.println("���÷���s1295_Valid in f1245_2.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
System.out.println(retCode);
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>");
				 location = "f1245_1.jsp?activePhone=<%=phoneNo%>";
			</script>
<%
}
/***********************************���巵�ز���*********************************************/
	String ret_username="";										  // �û���	
	String ret_userpwd="";										  // �û�����
	String ret_userunit="";										  // �û���λ
	String ret_prepayfee="";									  // Ԥ���
	String ret_dialcount="";									  // �㲥����
	//������ֵ��ȡ����ֵ
	ret_username=temp[0][2];
	ret_userpwd=temp[0][3];
	ret_userunit=temp[0][4];
	ret_prepayfee=temp[0][5];
	ret_dialcount=temp[0][6];
	System.out.println("ret_dialcountret_dialcountret_dialcount================"+temp[0][6]);
	System.out.println("res1.length================"+res1.length);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>

<script language="javascript">

function printCommit()//���ȷ�ϰ�ť��ֱ�ӵ�һ�������ĺ���
{   	
	if(!check(form1)) return false; 
	if(document.form1.note.value==""){
		document.form1.note.value="�ֻ�����:["+document.form1.i1.value+"]"+
	 	"�ͻ�:["+document.form1.owner_name.value+"]"+" "+"";
	}
    			
	var doc = document.form1;
	if(isNaN(doc.radio1.length)){
		doc.bz.value="0";
		if(eval("doc.gift_flag0.value")=="T"){//Ҫ��
			rdShowConfirmDialog("0-�Ѿ�ȷ�Ϲ��ˣ�"); 
			
		}
		else{
			//rdShowConfirmDialog("0-��ûȷ�ϣ�");
			showPrtDlg("Detail","ȷʵҪ���д�ӡ��","Yes");//����showPrtDlg����
		}
	}
	else{
		for(var i=0; i<doc.radio1.length; i++){
			if ( doc.radio1[i].checked){

				if(eval("doc.gift_flag"+i+".value")=="T"){
					rdShowConfirmDialog("1-�Ѿ�ȷ�Ϲ��ˣ�"); 
					break;
				}
				else{
					doc.bz.value=i;
					showPrtDlg("Detail","ȷʵҪ���д�ӡ��","Yes");
				}
			}
		}
	}
		
         
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=180;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=loginAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="1245" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+<%=loginAccept%>+
			"&phoneNo="+document.form1.i1.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
    //if(typeof(ret)!="undefined")
   {
       //if((ret=="confirm")&&(submitCfm == "Yes"))
       {
	       if(rdShowConfirmDialog("ȷ��Ҫ�ύ��")==1)
	       {
		       form1.action="f1245_cfm.jsp";
		       form1.submit();
		   }
		}		        
   }
}

function printInfo(printType)
{
   
    var cust_info="�ͻ���ַ:|";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1="��ע:|"; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
    if(printType == "Detail")
    {	
		//��ӡ�������
		//opr_info+='����ʱ��:<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="��ǰ����:1000|";
		//retInfo+=" |";
		//retInfo+=" "+"|";
		//opr_info+= "��������:|";
		opr_info+= "�ֻ�����:13900000000|";
		retInfo+=" |";

	}  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
	}
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
}
</script>
 <div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>     
<TABLE cellSpacing="0">
	<TR> 
		<TD class="blue" width="14%">�������</TD>
		<TD width="36%"> 
			<input class="InputGrey" name="i1" value="<%=phoneNo%>" size="20"  readonly>
		</TD>
		<TD class="blue" width="14%">�ͻ�����</TD>
		<TD width="36%"> 
			<input class="InputGrey" name="owner_name" size="20"  value="<%=ret_username%>"  readonly >
		</TD>
	</TR>
	<TR> 
		<TD class="blue">�ͻ���λ</TD>
		<TD> 
			<input class="InputGrey" name="owner_unit" size="45"  value="<%=ret_userunit%>" readonly>
		</TD>	
		<TD class="blue">Ԥ���</TD>
		<TD> 
			<input class="InputGrey" name="prepay_fee" size="20"  value="<%=ret_prepayfee%>" readonly>
		</TD>
	</TR>
	<TR> 
		<TD class="blue">�㲥����</TD>
		<TD colspan="3"> 
			<input class="InputGrey" name="owner_unit" size="20"  value="<%=ret_dialcount%>" readonly>
		</TD>	
	</TR>
</TABLE>
</div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">��Ʒ��Ϣ</div>
	</div>
<TABLE cellSpacing="0">
	<TR> 
		<th width="9%">&nbsp;</th>
		<th width="13%" >��������</th>
		<th width="13%" >��Ʒ����</th>
		<th width="13%" >��Ʒ���</th>
		<th width="13%" >��ȡ��־</th>
		<th width="13%" >��ȡ��ֹʱ��</th>
		<th width="13%" >����</th>
		<th width="13%" >����ʱ��</th>
	</TR>
	<% if(res1.length==0){
	%>	
		<TR>
			<TD width="9%"><input type=radio name="radio1" checked></TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >δ��ȡ</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
		</TR>
			<input name="gift_flag0" type="hidden" value="">
			<input name="login_no0" type="hidden" value="">
			<input name="present_code0" type="hidden" value="">
			<input name="end_time0" type="hidden" value="">
		
	<%}%>
	<%
	for (int j=0;j<res1.length;j++){
	%>
		<TR>
			<TD width="9%"><input type=radio name="radio1" value="<%=j%>" checked></TD>
			<TD width="13%" ><%=res2[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res4[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res5[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%if (res6[j][0].trim().equals("T")) out.print("����ȡ");else out.print("δ��ȡ");%><%=res6[j][0]%></TD>
			<TD width="13%" ><%=res7[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res8[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res10[j][0]%>&nbsp;</TD>
			
			<input name="gift_flag<%=j%>" type="hidden" value="<%=res6[j][0]%>">
			<input name="login_no<%=j%>" type="hidden" value="<%=res8[j][0]%>">
			<input name="present_code<%=j%>" type="hidden" value="<%=res1[j][0]%>">
			<input name="end_time<%=j%>" type="hidden" value="<%=res7[j][0]%>">
		</TR>
	<%
	}
	%>
</TABLE>
</div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>	  
<TABLE cellSpacing="0">
	<TR> 
		<TD class="blue">��ע</TD>
		<TD > 
			<input class="InputGrey" readOnly name="note" size="60" value="" >
		</TD>
	</TR>
	<TR> 
		<TD align="center" id="footer" colspan="2">
			<input class="b_foot" name=link type=button value="ȷ��" onclick="printCommit()">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
		</TD>
	</TR>
</TABLE>
	   <!-----------------------------------����������----------------------------------------------->
	    <input type="hidden" name="bz" value=""> 
		<%@ include file="/npage/include/footer.jsp" %>
	   </FORM>
     </BODY>
   </HTML>
   <%/*-----------------------------ȷ�ϰ�ť��javascript��-------------------------------------*/%>
   <script language="javascript">
   function pageconfirm(){
   }
   </script>
  

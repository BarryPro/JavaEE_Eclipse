<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-23 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String OpCode =opCode;
	String opName = (String)request.getParameter("opName");	
	
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	
	String org_code =(String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");
	int    nextFlag=1;
	String regionCode = (String)session.getAttribute("regCode");
    
    	String sqlStr1="";
    	
    	//String[][] retListString1 = null;
	//��ȡ����ҳ�õ�����Ϣ
    	String loginAccept = request.getParameter("login_accept");
    	String loginAcceptOld="";    
    
    	//ArrayList retList1 = new ArrayList();  
	if(loginAccept == null)
	{           
		//��ȡϵͳ��ˮ
		/*sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
		retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
		retListString1 = (String[][])retList1.get(0);
		loginAccept=retListString1[0][0];*/		
		loginAccept = getMaxAccept();
	}

	String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	
	String phone_no           ="";
	String password           ="";    
	String sOutCustId         ="";             //�ͻ�ID_NO         
	String sOutCustName       ="";             //�ͻ�����          
	String sOutSmCode         ="";             //����Ʒ�ƴ���      
	String sOutSmName         ="";             //����Ʒ������      
	String sOutProductCode    ="";             //����Ʒ����        
	String sOutProductName    ="";             //����Ʒ����        
	String sOutPrePay         ="";             //����Ԥ��          
	String sOutRunCode        ="";             //����״̬����      
	String sOutRunName        ="";             //����״̬����      
	String sOutUsingCRProdCode="";             //�Ѷ��������Ʒ    
	String sOutUsingCRProdName="";             //�Ѷ��������Ʒ����
	String sOutCustAddress    ="";             //�û���ַ
	String sOutIdIccid        ="";             //֤������
      
    	String action=request.getParameter("action");     

    if (action!=null&&action.equals("select"))
    {
        phone_no = request.getParameter("phone_no");    
        loginAcceptOld = request.getParameter("loginAcceptOld");
         
        //SPubCallSvrImpl callView = new SPubCallSvrImpl();
        String paramsIn[] = new String[6];

        paramsIn[0]=workno;                                 //��������
        paramsIn[1]=nopass;                                 //������������
        paramsIn[2]=OpCode;                                 //��������
        paramsIn[3]=phone_no;                               //�û��ֻ�����
        paramsIn[4]=loginAcceptOld;                         //������ˮ
	if(activePhone==null){
		activePhone=phone_no;
	}
        ArrayList acceptList = new ArrayList();

       // acceptList = callView.callFXService("s7962Init", paramsIn, "13");
     
 %> 	
	<wtc:service name="s7962Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 <%     

        String errCode = retCode1;
        String errMsg = retMsg1;

        if(!errCode.equals("000000"))
        {
%>
            <script language="javascript">
                rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
                history.go(-1);
            </script> 
<%
        }                   
        if(errCode.equals("000000"))
        {
            nextFlag = 2;               
           /* String result2  [][] = (String[][])acceptList.get(0);
            String result3  [][] = (String[][])acceptList.get(1);
            String result4  [][] = (String[][])acceptList.get(2);
            String result5  [][] = (String[][])acceptList.get(3);
            String result6  [][] = (String[][])acceptList.get(4);
            String result7  [][] = (String[][])acceptList.get(5);
            String result8  [][] = (String[][])acceptList.get(6);
            String result9  [][] = (String[][])acceptList.get(7);
            String result10 [][] = (String[][])acceptList.get(8);
            String result11 [][] = (String[][])acceptList.get(9);
            String result12 [][] = (String[][])acceptList.get(10);
            String result13 [][] = (String[][])acceptList.get(11);
            String result14 [][] = (String[][])acceptList.get(12);*/
            
            sOutCustId          =result[0][0];           
            sOutCustName        =result[0][1];           
            sOutSmCode          =result[0][2];           
            sOutSmName          =result[0][3];           
            sOutProductCode     =result[0][4];           
            sOutProductName     =result[0][5];           
            sOutPrePay          =result[0][6].trim();           
            sOutRunCode         =result[0][7];           
            sOutRunName         =result[0][8];           
            sOutUsingCRProdCode =result[0][9];           
            sOutUsingCRProdName =result[0][10];   
            sOutCustAddress     =result[0][11];            // �û���ַ
            sOutIdIccid         =result[0][12];            // ֤������                            
        }  
    }    
%>
        
<HTML>
<HEAD>
<TITLE>������BOSS-���������</TITLE>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript"> 
onload=function()
{    
}
//ȷ���ύ
function refain()
{   
	getAfterPrompt();
	document.all.sysNote.value = "�ֻ�["+document.all.phone_no.value.trim()+"]����������ҵ��";
	if((document.all.opNote.value.trim()).length==0)
	{
		document.all.opNote.value="<%=workno%>[<%=workname%>]"+"���ֻ�["+document.all.phone_no.value.trim()+"]���в�����ҵ�����";
	} 
	showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
		document.form.action="f7962_2.jsp";
		document.form.submit();
		return true;
	}   
}
//�����ֻ��ź����룬��ѯ������Ϣ
function doQuery()
{   
	if(!check(form)) 
		return false;  
	document.form.action = "f7962_1.jsp?action=select";
	document.form.submit();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  	
	//��ʾ��ӡ�Ի���
	//��ʾ��ӡ�Ի��� 		
	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
	var sysAccept ="<%=loginAccept%>";                       // ��ˮ��
	var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
	var mode_code=null;                        //�ʷѴ���
	var fav_code=null;                         //�ط�����
	var area_code=null;                    //С������
	var opCode =   "<%=opCode%>";                         //��������
	var phoneNo = "<%=phone_no%>";                           //�ͻ��绰		
	var h=162;
	var w=352;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    	
}
            
function printInfo(printType) 
{ 
	var istime="����";
	var isyear="������ҵ�����";

	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var retInfo = "";  //��ӡ����
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4 
	
	cust_info+="�ͻ�������   "+'<%=sOutCustName%>'+"|";
	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ���ַ��   "+document.all.sOutCustAddress.value+"|";
	cust_info+="֤�����룺   "+document.all.sOutIdIccid.value+"|";
	
	opr_info+="ҵ��Ʒ�ƣ�"+document.all.sm_name.value+"|";
	opr_info+="����ҵ��"+isyear+"|";
	opr_info+="������ˮ:"+'<%=loginAccept%>'+"|";
	opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="ҵ����Чʱ�䣺"+istime+"|";
		
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	return retInfo;	
}

</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
			<div id="title_zi">���˲��������</div>
	</div> 
	
	<input type="hidden" name="opCode" value="<%=OpCode%>"> 
	<input type="hidden" name="opName" value="<%=opName%>"> 
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="loginNo" value="<%=workno%>">
	<input type="hidden" name="loginPwd" value="<%=nopass%>">
	<input type="hidden" name="orgCode" value="<%=org_code%>">
	<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>"> 

    <table  cellspacing="0">
	<TR>   
		<td class="blue" width="13%">�ֻ�����</td>                                 
		<td width="35%">                     
			<input  type="text"  v_type="mobphone" value =<%=activePhone%>  readonly class="InputGrey"  v_must=1 v_minlength=1 v_maxlength=11 name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
			<font class="orange">*</font>	
		</td>
		<TD class="blue" width="13%">������ˮ</TD>
		<TD width="39%">
			<input type="text"  name="loginAcceptOld"  v_type="string" v_must=1 value="<%=loginAcceptOld%>"  <%if(nextFlag==2){out.print("readonly ");out.print("class='InputGrey'");}%>>
			<font class="orange">*</font>
		</TD>
	</TR>
	</table>
<%
	if(nextFlag==1)
	{
%>
	<table  cellspacing="0">         
		<tr>
			<td id="footer"	>		
				<input  name=sure22 type=button class="b_foot" value="ȷ��" onClick="doQuery();" style="cursor:hand">
				<input  name=reset22 type=reset class="b_foot" value="���">
				<input  name=close22 type=button class="b_foot" value="�ر�" onclick="removeCurrentTab()">			
			</td>
		</tr>
	</table>
<%
	}
%>
            
<%
    if(nextFlag==2)//��ѯ����
    {
%> 
	<table  cellspacing="0">        
		<tr style="display:none">                
			<td class="blue">�ͻ�ID</td>
			<td> 
				<input type="text" name="cust_id" maxlength="6"   value="<%=sOutCustId%>">
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">�ͻ�����</td>
			<td width="35%"> 
				<input type="text" name="cust_name" class="InputGrey" value="<%=sOutCustName%>" <%if(nextFlag==2){out.print("readonly");}%> >
				<input type="hidden" readonly class="InputGrey" name="sOutCustAddress"  value="<%=sOutCustAddress%>">
				<input type="hidden" readonly class="InputGrey" name="sOutIdIccid"  value="<%=sOutIdIccid%>">
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">����Ԥ��</td>
			<td width="39%">
				<input type="text" readonly class="InputGrey" name="PrePay"  value="<%=sOutPrePay%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">ҵ��Ʒ��</td>
			<td width="35%"> 
				<input type="hidden" readonly class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
				<input type="text"   readonly class="InputGrey" name="sm_name"  value="<%=sOutSmName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">����״̬</td>
			<td width="39%"> 
				<input type="hidden" readonly class="InputGrey" name="RunCode"  value="<%=sOutRunCode%>">
				<input type="text"   readonly class="InputGrey" name="RunName"  value="<%=sOutRunName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">�ʷ��ײ�</td>
			<td width="35%"> 
				<input type="hidden" readonly name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
				<input type="text"   readonly class="InputGrey" name="ProductName" maxlength="5"      value="<%=sOutProductName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">�Ѷ��������Ʒ</td>
			<td width="39%"> 
				<input type="hidden" readonly class="InputGrey" name="UsingCRProdCode"  maxlength="20" value="<%=sOutUsingCRProdCode%>">
				<input type="text" readonly class="InputGrey"  name="UsingCRProdName"  maxlength="20" value="<%=sOutUsingCRProdName%>" <%if(nextFlag==2){out.print("readonly");}%>>
			</td>
		</tr>
	</table>
	<table  cellspacing=0 >
		<tbody> 
			<tr> 
				<td width=13% class="blue">ϵͳ��ע</td>
				<td width="87%">
					<input  readonly class="InputGrey" name=sysNote value="" size=60 maxlength="60">
				</td>
			</tr>         
		</tbody> 
	</table>
	<table  cellspacing=0>
		<tbody> 
			<tr> 
				<td id="footer"> 
					<input  name=sure class="b_foot" type="button" value=ȷ�� onclick="refain()">
					&nbsp;
					<input  name=clear class="b_foot" type=reset value=��һ�� onClick="javaScript:history.go(-1)">
					&nbsp;
					<input  name=reset class="b_foot" type=button value=�ر� onClick="removeCurrentTab()">
				</td>
			</tr>                
		</tbody> 
	</table>	
          <input  type="hidden" name=opNote size=60 value="" maxlength="60">
      <%@ include file="/npage/include/footer.jsp" %>        
<%
    }
%>
   
     <%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>
</HTML>


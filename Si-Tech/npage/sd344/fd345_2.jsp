<%
  /*
   * ����: ���Źܿػָ� d345
   * �汾: 1.0
   * ����: 2011/3/25
   * ����: huangrong 
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = request.getParameter("opCode");
	System.out.println(opCode);
	String opName = request.getParameter("opName");
	String phoneNo  = request.getParameter("phoneNo");
  	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���
	String hdword_no = (String)session.getAttribute("workNo");//����
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String regCode = (String)session.getAttribute("regCode");

  String strNewRunCode = request.getParameter("new_run_code");            //�������� 	
	
%>
<HEAD>
<TITLE>���Źܿػָ�</TITLE>

<SCRIPT>
<!--
function turnit()
{
	document.all.better.style.display="";
}

function checkexpDays()
{
	if(document.form1.expDays.value <= 0){
  	rdShowMessageDialog("����ȷ��������,��������Ϊ����0�죡");
    document.form1.expDays.value = "";
    document.form1.expDays.focus();
    return false;
  }
  
	if(document.form1.expDays.value > 10){
  	rdShowMessageDialog("����ȷ��������,�������ܳ���10�죡");
    document.form1.expDays.value = "";
    document.form1.expDays.focus();
    return false;
  }
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gbk"></HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<%
/***********************************���巵�ز���*********************************************/
	String oret_code="";              // �������               
	String oret_msg="";		          // ������Ϣ
	String oid_no="";		  		  //0  �û�id                
	String custName="";		      //1  �ͻ�����             
	String statusCode="";		      //2  ״̬����          
	String statusName="";		      //3  ״̬����  
	String custAddr="";		      //4  �ͻ�סַ          
	String idType="";		          //5  ֤������          
	String oid_name="";		          //6  ֤������          
	String idIccid="";		      //7  ֤������         
	String onew_run="";		          //8  ��״̬����        
	String onew_runname="";           //9  ��״̬���� 
	String smName="";           //10  ��Ʒ����
	String preMsg="";	           //11  �Ƿ���ԤԼ�ط�����ʾ��Ϣ
	String noteMsg=""	;           //12  ������ע��Ϣ
/**************************����s1246Init�����****************************/ 
  String loginAccept = "";                                //������ˮ
  String chnSource = "01";                                //������ʶ
	String workNo = hdword_no;                                 //��������
	String passWord = (String)session.getAttribute("password");//��������	
	String custWord = "";                                          //�û����� 
	String ChOpRunCode  =  request.getParameter("opFlag");          //��������״̬
	try
	{
%>
		<wtc:service name="sd344Init" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13">			
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=custWord%>"/>
		<wtc:param value="<%=ChOpRunCode%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
<%
		oret_code = retCode1;
		oret_msg = retMsg1;     
		System.out.println("2222:" + oret_code + ":" + oret_msg);
			
		oid_no  = result[0][0];                   //0 �û�id    
		custName = result[0][1];					//1 �ͻ�����              
		statusCode = result[0][2];					//2 ״̬����           
		statusName = result[0][3];			       //3 ״̬����                     
		custAddr = result[0][4];			       //4�ͻ�סַ           
		idType = result[0][5];			        //5 ֤������           
		oid_name = result[0][6];			        //6 ֤������           
		idIccid = result[0][7];			         //7 ֤������                 
		onew_run = result[0][8];                   //8 ��״̬����          
		onew_runname  = result[0][9];                   //9��״̬����
		smName  = result[0][10];                   //10 ��Ʒ����
	  preMsg=result[0][11];	           //11  �Ƿ���ԤԼ�ط�����ʾ��Ϣ
		noteMsg=result[0][12];           //12  ������ע��Ϣ
   }
		catch(Exception e){
       		System.out.println("Call services is Failed!");
     	}	
 if(!oret_code.equals("000000"))
	 {
		
%>
			  <script language='jscript'>
			   rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>��",0);
			   history.go(-1);
			  </script>
<%}else{%>
			  <script language='jscript'>
			  </script>
<%}%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="seq"/>
	<TABLE cellSpacing="0">
  	<TR> 
			<TD class="blue">�������</TD>
			<TD>
				<input class="InputGrey" name="phoneNo" value="<%=request.getParameter("phoneNo")%>" v_type="mobphone" v_must=1 onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}"  readonly >
			</TD>
			<TD class="blue">�ͻ�����</TD>
			<TD>
				<input class="InputGrey" name="custName" value="<%=custName%>" readonly >
			</TD>
   	</TR>
		<TR> 
			<TD class="blue">��Ʒ����</TD>
			<TD>
				<input class="InputGrey" name="smName" value="<%=smName%>" readonly >
			</TD>
			<TD class="blue">�ͻ���ַ</TD>
			<TD>
				<input class="InputGrey" size="60" name="custAddr" value="<%=custAddr%>" readonly>
			</TD>
   </TR>
	 <TR> 
	  	<TD class="blue">֤������</TD>
	  	<TD ><input class="InputGrey" name="idType" value="<%=oid_name%>" readonly>
	  	</TD>
	  	<TD class="blue">֤������</TD>
	  	<TD>
	  		<input class="InputGrey" name="idIccid" value="<%=idIccid%>"   readonly >
	  	</TD>
   </TR>
	 <TR> 
	 	  <TD class="blue">��ǰ״̬����</TD>
		  <TD>
			  <input class="InputGrey" name="statusCode" value="<%=statusCode%>" readonly>
			</TD>
			<TD class="blue">��ǰ״̬����</TD>
			<TD>
				<input class="InputGrey" name="statusName" value="<%=statusName%>" readonly>
			</TD>
   </TR>
	<TR> 
			<TD class="blue">�ָ�״̬����</TD>
			<TD>
				<input class="InputGrey" name="renewStatusCode" value="<%=onew_run%>" readonly>
			</TD>
			<TD class="blue">�ָ�״̬����</TD>
			<TD>
				<input class="InputGrey" name="renewStatusName" value="<%=onew_runname%>" readonly>
			</TD>
   </TR>
			 <%
				  String strsql = "";
				  String favor_code = "";
				  String hand_fee = "";
			  try{
				  strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
			%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
					<wtc:sql><%=strsql%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result_favor" scope="end" />
			<%
				  hand_fee = result_favor[0][0];
				  favor_code = result_favor[0][1];
			  }catch(Exception e)
			  {
				  e.printStackTrace() ;
			  }
			   
			 %>
			 <%
			int m =0;
			   for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
						for(int q = 0;q< favInfo[p].length;q++)
						{
						 if(favInfo[p][q].trim().equals(favor_code.trim()))
							 {
							   ++m;
						   }
						}
         }
			%>
      <TR>
			   <%if(m != 0){%>		 
				 <TD class="blue">������</TD>
				 <TD>
						 <input name="ohand_cash" value="<%=hand_fee%>" v_must=1  v_type=float >
						 <input class="InputGrey" type="hidden" name="ishould_fee" value="<%=hand_fee%>" readonly>
				 </TD>
				 <script language="jscript">
				 document.all.ohand_cash.focus();
				 </script>
		     <%}else{%>
				 <TD class="blue">������</TD>
				 <TD>
					 <input class="InputGrey" name="ohand_cash" value="<%=hand_fee%>" readonly>
					 <input class="InputGrey" type="hidden" name="ishould_fee" value="<%=hand_fee%>" readonly>
				 </TD>
		      <%}%>
				  <TD class="blue">���ػ������</TD>
				  <TD>
				 		<input name="icmd_code" class="InputGrey" value="<%=onew_runname%>" readonly>
          	<div id=better style="display:none">
				  		<input name="expDays" v_name="����" v_type="0_9" onChange="checkexpDays()" value="1"  onblur="if(this.value!=''){if(checkElement('expDays')==false){return false;}}">��
				  	</div>
				  </td>
        </TR>
	  
        <TR>
			   <TD class="blue">ϵͳ��ע</TD>
			   <TD colspan="3">
			   	<input class="InputGrey" name="opNote" readonly size="80" value="<%=noteMsg%>">
			   </TD>
		   </TR>
	   </TABLE>
       <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD align=center id="footer">
							  <input class="b_foot" name=sure  type=button value="ȷ��&��ӡ" onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtDlg(); ">
							  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
							  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
              </TD>
            </TR>
          </TBODY>
       </TABLE>
     <%@ include file="/npage/include/footer.jsp" %>  
	   <%@ include file="/npage/s1246/tail.jsp"%>
	   <!-----------------------------------����������----------------------------------------------->
	   <input type="hidden" name="stream" value="<%=seq%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="opName" value="<%=opName%>">
	   <input type="hidden" name="opCode" value="<%=opCode%>">
	   <input type="hidden" name="donote">
	   <!-------------------------------------------------------------------------------------------->
	   </FORM>
	    <%@ include file="/npage/include/footer.jsp" %>  
     </BODY>
   </HTML>
  
  <script language="javascript">
  onload=function()
  {
  	<%if(onew_runname.trim().equals("ǿ��")){%>
	       turnit();
	  <%}%>
  }
/*-----------------------------ҳ����ת����-----------------------------------------------*/
  function pageSubmit(page){
    document.form1.action="<%=request.getContextPath()%>/page/"+page;
	  form1.submit();
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
		if( tmpDays <= 0 || tmpDays > 365 || jtrim(document.all.expDays.value).length==0)
		{
			rdShowMessageDialog("ǿ��ʱ��������ȷ��ǿ��ʱ��,ǿ��ʱ����0-365֮��!",0);
			return false;
		}
	}
    return true;
} 

/*----------------���ô�ӡҳ�溯��---------------------*/
function showPrtDlg()
{  
	getAfterPrompt();
	var imo_phone = '<%=phoneNo%>' ;
	var onew_runname=document.all.icmd_code.value;
    thesysnote = imo_phone + onew_runname                        //����ϵͳ��ע
    document.all.donote.value= thesysnote;                      //����ҳ����ʾ��ϵͳ��ע
   /*����ģʽ�Ի��𣬲����û��������д���*/
   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2; 
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("�Ƿ��ӡ���������");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //����Ͽ�
        {
            conf("Detail","ȷʵҪ���е��������ӡ��","Yes");                          
        }
        else if(ret==0)                 //���ȡ��,���Ƿ��ύ
        {    
            crmsubmit();                     
        }
    }
}
/*-------------------------��ӡ�����ύ������-------------------*/
function conf(printType,DlgMessage,submitCfm)
{ 
	/***********************��ӡ����Ĳ���**********************************/
	var phone = '<%=phoneNo%>';								//�û��ֻ�����
	var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';                                                              //ϵͳ����
	var name = '<%=custName%>';         						    //�û�����
	var address = '<%=custAddr%>';							        //�û���ַ
	var cardno = '<%=idIccid%>'; 								    //֤������
	var stream = document.all.stream.value;							//��ӡ��ˮ
	var work_no = '<%=hdword_no%>';                                 //�õ�����
	var opNote = document.all.opNote.value;                        //����ӡ��ϵͳ��־
	/**********************��ӡ����Ĳ�����֯���****************************/

	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var sysAccept = document.all.stream.value;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=2355&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
	    crmsubmit();
	  }
		if(ret=="continueSub")
		{
		    crmsubmit();   
		}
  }
  else
  {
	   crmsubmit();
  }   
 }
 
function printInfo(printType)
{ 
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var phone = '<%=phoneNo%>';
	var name = '<%=custName%>';         						    //�û�����
	var address = '<%=custAddr%>';							        //�û���ַ
	var cardno = '<%=idIccid%>'; 								    //֤������  
	var retInfo = "";
	 
	cust_info+="�ֻ����룺   "+phone+"|";
	cust_info+="�ͻ�������   "+name+"|";
	cust_info+="�ͻ���ַ��   "+address+"|";
	cust_info+="֤�����룺   "+cardno+"|";
	
	opr_info+="ҵ�����ͣ����Źܿػָ�"+"|";
	opr_info+="ҵ����ˮ��"+document.all.stream.value+"|";
	note_info1 +="��ע��"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;	
}

function crmsubmit()
{
	if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1){
  	form1.action="fd345Cfm.jsp";
    form1.submit();
	}else{
		return false;
	}
}

 </script>


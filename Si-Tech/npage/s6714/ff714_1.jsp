<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-2-5
********************/
%>

<%
  String opCode = "6714";
  String opName = "���幦����ͣ/�ָ�";
%>            

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>
<%
		
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
    
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    int    nextFlag=1;
    String regionCode = (String)session.getAttribute("regCode");
    
    
    String OpCode ="6714";
    String sInOpNote  ="������Ϣ��ʼ��"; 
    
    String[][] temfavStr=(String[][])arr.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
    favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
    
	  
	  //��ȡ����ҳ�õ�����Ϣ
	  String loginAccept = request.getParameter("login_accept");
		if(loginAccept == null)
		{			
			//��ȡϵͳ��ˮ
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<%	 		
			loginAccept=sysAcceptl;			
		}
	  String op_code = "6710"  ;	
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
	  String sOutCRColorType    ="";             //��������           
	  String sOutCRColorTypeName="";             //������������       
	  String sOutCRRunCode      ="";             //��������״̬����   
	  String sOutCRRunName      ="";             //��������״̬����   
	  String sOutCRBellBeginTime="";             //���忪ͨʱ��       
	  String sOutCRBellEndTime  ="";             //�������ʱ��   
	  String sOutCustAddress ="";     //�û���ַ
    String sOutIdIccid     ="";     //֤������    
	  	  
	  String action=request.getParameter("action");     
	  if (action!=null&&action.equals("select")){
	    phone_no = request.getParameter("phone_no");     
	    password = request.getParameter("password");
	    String Pwd1 = Encrypt.encrypt(password);      	//�ڴ˶��û�������������м���
	    	    
      //�ڴ˶��û���������ж�
      if(pwrf==false){
			String[][] rt1 = new String[][]{};
      String sql="";
			sql = "select user_passwd from dcustmsg  where phone_no='"+phone_no+"'";
			//retPwd1 = co.sPubSelect("1",sql,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%			
			rt1 = result_t;
			String i3=rt1[0][0];
	    
	  	//if(0==Encrypt.checkpwd2(i3.trim(),Pwd1.trim())){				//�Ƚ��û��������ܵ�����ͷ���ȡ�����ܵ������Ƿ���ͬ
       %>
       <!-- <script language='jscript'>
           rdShowMessageDialog("�û��������",0);
           history.go(-1);
        </script>-->
       <%
    	 // }
    	}
		 	String paramsIn[] = new String[6];
		 	
		 	 paramsIn[0]=workno;                                 //��������         
	     paramsIn[1]=nopass;                                 //������������     
	     paramsIn[2]=OpCode;                                 //��������         
	     paramsIn[3]=sInOpNote;                              //��������         
	     paramsIn[4]=phone_no;                               //�û��ֻ�����     
	     paramsIn[5]=Pwd1;                                   //�û�����         
		 	
			//acceptList = callView.callFXService("s6714Init", paramsIn, "19");
%>

    <wtc:service name="s6714InitEx" outnum="19" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />				
		</wtc:service>
		<wtc:array id="result_t1" scope="end"  />

<%			
			String errCode = code1;
			String errMsg = msg1;     
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
				sOutCustId          =result_t1[0][0];           
				sOutCustName        =result_t1[0][1];           
				sOutSmCode          =result_t1[0][2];           
				sOutSmName          =result_t1[0][3];           
				sOutProductCode     =result_t1[0][4];           
				sOutProductName     =result_t1[0][5];           
				sOutPrePay          =result_t1[0][6].trim();           
				sOutRunCode         =result_t1[0][7];           
				sOutRunName         =result_t1[0][8];           
				sOutUsingCRProdCode =result_t1[0][9];           
				sOutUsingCRProdName =result_t1[0][10]; 
				sOutCRColorType     =result_t1[0][11]; 
				sOutCRColorTypeName =result_t1[0][12]; 
				sOutCRRunCode       =result_t1[0][13]; 
				sOutCRRunName       =result_t1[0][14]; 
				sOutCRBellBeginTime =result_t1[0][15]; 
				sOutCRBellEndTime   =result_t1[0][16]; 	
				sOutCustAddress  =result_t1[0][17];            // �û���ַ
        sOutIdIccid      =result_t1[0][18];            // ֤������ 			 
	   }  
	 }    
%>      
        
<HEAD><TITLE>������BOSS-���幦����ͣ�ָ�</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">
 var js_pwFlag="false";
 js_pwFlag="<%=pwrf%>";
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	//�����Ʒ
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  }  
}
		
//ȷ���ύ
function refain()
{   
	getAfterPrompt();	
		showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
		if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
		document.form.action="ff714_2.jsp";
	  document.form.submit();
	  return true;
	}  
}
//�����ֻ��ź����룬��ѯ������Ϣ
function doQuery()
	{
    if(!forMobil(document.form.phone_no))
    {
    	return false;
    }
	  //alert(document.form.phone_no.value);
		document.form.action = "ff714_1.jsp?action=select";
		document.form.submit(); 
	}
	
//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.form.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.form.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s6710/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&cust_id=" + document.all.cust_id.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|";
  if(retInfo ==undefined)      
    {   return false;   }    
  document.form.product_code.value = retInfo ;
}

function changeOthers(){
	var mebMonthFlag=document.form.mebMonthFlag.value;
	if(payType=="0"){
		  document.form.matureProdCode.value="";
		  document.form.matureFlag.value="";
			tbs2.style.display="";
			tbs3.style.display="";			
			if(mebMonthFlag=="Y"){
				tbs2.style.display="none";
				tbs3.style.display="none";
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{		
				tbs4.style.display="none";
				tbs5.style.display="";							
			}				         
	}else{
		  	tbs2.style.display="none";
				tbs3.style.display="none";
			if(mebMonthFlag=="Y"){
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{
				document.form.matureProdCode.value="";
		    document.form.matureFlag.value="";
				tbs4.style.display="none";
				tbs5.style.display="";							
			}	
	}	
}
//���ݲ�Ʒ���ͽ��в�Ʒ���
function tochange()
{  
		var mebMonthFlag = document.form.mebMonthFlag.value;
		var mode_type="";
		if(mebMonthFlag=="1")
		{
			mode_type="CR01";
		}else {
			mode_type= "CR02";
		}
		var sqlStr = "select mode_code,mode_name from sbillmodecode where  mode_type='"+mode_type+"'";	
		var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ��ҵ��ģʽ��Ϣ�����Ժ�......");
		myPacket.data.add("retType","changProd");
		myPacket.data.add("sqlStr",sqlStr);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
}

function changeMatureFlag(){
	var matureFlag=document.form.matureFlag.value;
	if(matureFlag=="N"){
	 document.form.matureProdCode.value="";
	 document.form.matureProdCode.disabled=true;
   }else{   
   document.form.matureProdCode.disabled=false;
   }	
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //��ʾ��ӡ�Ի���
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }
			   
		 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"	   
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=loginAccept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo =document.all.phone_no.value;                          //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
		
			}
			
function printInfo(printType) { 
	var OnOff = document.all.OnOff.value;
	if(OnOff==1) {
		OnOff="����ҵ��ָ�";
	}
	if(OnOff==0) {
		OnOff="����ҵ����ͣ";
	}
				
				
		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
		
		cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
		cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
		cust_info+="֤�����룺"+document.all.sOutIdIccid.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.sOutCustAddress.value+"|";
		
		opr_info+="ҵ��Ʒ�ƣ�"+document.all.sm_name.value+"|";
		opr_info+="����ҵ��"+OnOff+"|";
		opr_info+="������ˮ��"+'<%=loginAccept%>'+"|";
		opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="��Чʱ�䣺"+"����"+"|";
			
		note_info1+=""+"|";	
						
	    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

   		 return retInfo;
    
			}


</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���幦����ͣ�ָ�</div>
	</div>
 <table cellspacing="0">
    <input type="hidden" name="opCode" value="<%=OpCode%>"> 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">     

<%
	if(nextFlag==1)
	{
	String ph_no = (String)request.getParameter("ph_no");
%>
		     <TR >   
		  	     <td class="blue">�ֻ�����</td>                                 
              <td class="blue" >                     
               <input  type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11 v_name="�ֻ�����"  name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()"  value ="<%=(activePhone!=null?activePhone:ph_no)%>" readOnly Class="InputGrey">
               <font class="orange">*</font>
               </td>

            </TR>
            
			<tr >
				<td class="blue" colspan="4" id="footer" >
					<div align="center">
					<input  name=sure22 type=button value="ȷ��" onClick="doQuery();" style="cursor:hand" class="b_foot">
            		<input  name=reset22 type=reset value="���" class="b_foot">
            		<input  name=close22 type=button value="�ر�"  onClick="removeCurrentTab()"  class="b_foot">
					</div>
				</td>
			</tr>
<%
	}
%>
            <%
             if(nextFlag==2)//��ѯ����
             {
            %> 
            		     <TR >   
		  	     <td class="blue">�ֻ�����</td>                                 
              <td class="blue" >                     
               <input  type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11 v_name="�ֻ�����"  name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()"  value ="<%=phone_no%>" readOnly Class="InputGrey">
               <font class="orange">*</font>
               </td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
            </TR>
            
                <tr> 

                  <td class="blue">�ͻ�ID</td>
                  <td class="blue"> 
                    <input type="text"  readOnly  name="cust_id" maxlength="6"   value="<%=sOutCustId%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue">&nbsp;</td>
                  <td class="blue">&nbsp;</td>

                </tr>
                <tr> 
                  <td class="blue" width="13%">�ͻ�����</td>
                  <td class="blue" width="35%"> 
                    <input type="text" readOnly  name="cust_name"  value="<%=sOutCustName%>" >
                    <input type="hidden" readOnly   Class="InputGrey" name="sOutCustAddress"  value="<%=sOutCustAddress%>">
                    <input type="hidden" readOnly   Class="InputGrey" name="sOutIdIccid"  value="<%=sOutIdIccid%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">ҵ��Ʒ�� </td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="sm_name"  value="<%=sOutSmName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td class="blue" width="13%">�ʷ��ײ�</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="ProductName" maxlength="5"      value="<%=sOutProductName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">����״̬</td>
                  <td class="blue" width="39%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="RunCode"  value="<%=sOutRunCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="RunName"  value="<%=sOutRunName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
               <tr> 
                  <td class="blue" width="13%">ҵ������</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="CRColorType" maxlength="5"  value="<%=sOutCRColorType%>">
                    <input type="text"   readOnly   Class="InputGrey" name="CRColorTypeName" maxlength="5"      value="<%=sOutCRColorTypeName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">����ʱ�� </td>
                  <td class="blue" width="39%"> 
                    <input type="text" readOnly   Class="InputGrey"  name="CRBellBeginTime"  maxlength="20" value="<%=sOutCRBellBeginTime%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                  <tr> 
                  <td class="blue" width="13%">�����Ʒ</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="UsingCRProdCode"  maxlength="20" value="<%=sOutUsingCRProdCode%>">
                    <input type="text" readOnly   Class="InputGrey"  name="UsingCRProdName"  maxlength="20" value="<%=sOutUsingCRProdName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">��ǰ����״̬ </td>
                  <td class="blue" width="39%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="CRRunCode"  maxlength="20" value="<%=sOutCRRunCode%>">
                    <input type="text" readOnly   Class="InputGrey"  name="CRRunName"  maxlength="20" value="<%=sOutCRRunName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>                
            <TR>
               <td class="blue" >��������</TD>
					       <td class="blue" >
									<SELECT name="OnOff"  id="OnOff" onChange="" onclick="">
									 <%if(sOutCRRunCode.equals("A")){%>	
										<option value="0" selected>��ͣ</option>
									<%}else{%>
										<option value="1" selected>�ָ� </option>
									<%}%>	
									</SELECT>
									<font class="orange">*</font>
								</TD>
						<td class="blue">&nbsp;</TD>
            <td class="blue">&nbsp;</TD>      
             </TR>  
              <table  cellspacing="0">
                <tbody> 
                	
                <tr> 
                  <td class="blue" width=13%>��ע</td>
                  <td class="blue" width="87%">
                    <input  readOnly   Class="InputGrey" name=sysNote value="�ֻ�����<%=phone_no%>������幦��<%if(sOutCRRunCode.equals("A")){%>��ͣ<%}else{%>�ָ�<%}%>" size=60 maxlength="60">
                <input  name=opNote size=60 value="�ֻ�����<%=phone_no%>������幦��<%if(sOutCRRunCode.equals("A")){%>��ͣ<%}else{%>�ָ�<%}%>" maxlength="60" type="hidden">
                  </td>
                </tr>

                
                </tbody> 
              </table>
              <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
                <tbody> 
                <tr > 
                  <td class="blue" align=center width="100%" id="footer"> 
                    <input  name=sure type="button" value=ȷ�� onclick="refain()" class="b_foot">
                    &nbsp;
                    <input  name=clear type=reset value=��һ�� onClick="history.go(-1);" class="b_foot">
                    &nbsp;
                    <input  name=reset type=button value=�ر�  onClick="removeCurrentTab()"  class="b_foot">
                  </td>
                </tr>                
                </tbody> 
              </table>
              <p>&nbsp;</p>
				    <%
				    }//end   if(nextFlag==2)    
				   %>
    </table>
    <%if(nextFlag==2){%>
    	<%@ include file="/npage/include/footer.jsp" %>
    <%}else{%>
    	<%@ include file="/npage/include/footer_simple.jsp" %>
    <%}%>
</FORM>
</BODY>
</HTML>
<%
//����С���̹����ļ�
%>
<%@ include file="/npage/common/pwd_comm.jsp" %>

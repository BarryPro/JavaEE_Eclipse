<% 
  /*
   * ����: ���˲���ȡ��
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
   *
   *update:liutong@20080917
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>

<%
	String opCode = "6711";
	String opName = "���˲���ȡ��";
	String workno =(String)session.getAttribute("workNo");
	String workname =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String nopass = (String)session.getAttribute("password");
	
    int    nextFlag=1;   
    String OpCode ="6711";
    String sInOpNote  ="������Ϣ��ʼ��"; 
    
     String phone="";
	    phone = request.getParameter("activePhone");
	    if(null==phone||phone.equals("")){
	      phone = request.getParameter("phone_no");
	    }
	    System.out.println(phone+"________________________________________________________________________");
    
    //String[][] temfavStr=(String[][])arr.get(3);
    //String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
    //String[] favStr=new String[temfavStr.length];
    //for(int i=0;i<favStr.length;i++)
    //favStr[i]=temfavStr[i][0].trim();
    
	  String sqlStr1="";
	  String[][] retListString1 = null;
	  
	  //��ȡ����ҳ�õ�����Ϣ
	  String loginAccept = request.getParameter("login_accept");
	
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		//ArrayList retList1 = new ArrayList();  
		if(loginAccept == null)
		{			
			//��ȡϵͳ��ˮ
			//sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
			//retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
			//retListString1 = (String[][])retList1.get(0);
			//loginAccept=retListString1[0][0];			
		
		%>
		 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="outRet"/>			
		<%
		  loginAccept = outRet; 
		}
	
	  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
	  
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
	  String minusDay ="";                      //����������ʱ����ʱ��
	  String opFlag="one";    
	   	  
	  String action=request.getParameter("action");     

	  if (action!=null&&action.equals("select")){
	    phone_no = request.getParameter("phone_no");     
	    password = request.getParameter("password");
	    opFlag   = request.getParameter("opFlag");
	    String Pwd1 = Encrypt.encrypt(password);      	//�ڴ˶��û�������������м���
	    	    
     
	 	    
	  //  SPubCallSvrImpl callView = new SPubCallSvrImpl();
		 	String paramsIn[] = new String[6];
		 	
		   paramsIn[0]=workno;                                 //��������         
	     paramsIn[1]=nopass;                                 //������������     
	     paramsIn[2]=OpCode;                                 //��������         
	     paramsIn[3]=sInOpNote;                              //��������         
	     paramsIn[4]=phone_no;                               //�û��ֻ�����     
	     paramsIn[5]=Pwd1;                                   //�û�����         
		 	
		//	ArrayList acceptList = new ArrayList();
				   
		//	acceptList = callView.callFXService("s6714Init", paramsIn, "17");
		//	callView.printRetValue();
		
		%>
			<wtc:service name="s6714Init" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="19" >
			<wtc:param value="<%= paramsIn[0]%>"/>
			<wtc:param value="<%= paramsIn[1]%>"/>
			<wtc:param value="<%= paramsIn[2]%>"/>
			<wtc:param value="<%= paramsIn[3]%>"/>
			<wtc:param value="<%= paramsIn[4]%>"/>
			<wtc:param value="<%= paramsIn[5]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
		<%
			   	
		  if(errCode.equals("0")||errCode.equals("000000")){
         		 System.out.println("���÷���s6714Init in f6711_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

	 	        	if(result.length==0){
	 	            }else{
					 	         
	 	            	nextFlag = 2;		
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
						sOutCRColorType     =result[0][11];             
						sOutCRColorTypeName =result[0][12];             
						sOutCRRunCode       =result[0][13];             
						sOutCRRunName       =result[0][14];             
						sOutCRBellBeginTime =result[0][15];             
						sOutCRBellEndTime   =result[0][16]; 	        
						
						
						   String ColorType = request.getParameter("ColorType"); 
	  
							  if(!sOutCRColorType.equals("00")&&sOutCRColorType.equals("01")&&sOutCRColorType.equals("10")&&sOutCRColorType.equals("11")&&sOutCRColorType.equals("13"))
							   {
								  	{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("ѡ�������������Ŀǰ�Ĳ�Ʒ���Ͳ�����������ѡ��" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				  
							   }	 
								 if(sOutCRColorType.equals("00")||sOutCRColorType.equals("01"))
								 {
								    if(!ColorType.equals(sOutCRColorType))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("ѡ�������������Ŀǰ�Ĳ�Ʒ���Ͳ�������ѡ��<%=sOutCRColorTypeName%>���͡�" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 if(sOutCRColorType.equals("01") || sOutCRColorType.equals("02") || sOutCRColorType.equals("03") || sOutCRColorType.equals("04"))
								 {
								    if(!ColorType.equals("01"))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("ѡ�������������Ŀǰ�Ĳ�Ʒ���Ͳ�������ѡ��<%=sOutCRColorTypeName%>���͡�" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 if(sOutCRColorType.equals("10")||sOutCRColorType.equals("11"))
								 {
								    if(!ColorType.equals(""))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("ѡ�������������Ŀǰ�Ĳ�Ʒ���Ͳ�������ѡ��<%=sOutCRColorTypeName%>���͡�" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 
								 
						   System.out.println("checked2---------------------");     
							 /*���������Ч��δ���˶�ҵ��İ��꿨������ͻ����˶���������*/
							 //����ʱ��֮�������
						   java.text.SimpleDateFormat myFormatter = new java.text.SimpleDateFormat("yyyyMMdd");
						   java.util.Date date1= myFormatter.parse(dateStr); 
						   java.util.Date mydate= myFormatter.parse(sOutCRBellEndTime);
						   long  day1=(mydate.getTime()-date1.getTime())/(24*60*60*1000);
						   Long day2=new Long(day1);
						   minusDay=day2.toString();
						   System.out.println("minusDay===="+minusDay); 
						   if(day1<0){
						    %>        
							    <script language='jscript'>
							       rdShowMessageDialog("��Ĳ���<%=sOutCRColorTypeName%>ҵ���Ѿ����ڣ������¿�ͨ��" ,0);
							       history.go(-1);
						      </script> 	         
								<%    
						   }  
							
	 	        	   
	 	        	}
 	        	
 	     	}else{
 	         	System.out.println(errCode+"    errCode");
 	     		System.out.println(errMsg+"    errMsg");
 	     		System.out.println("���÷���s6714Init in f6711_1.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	     		
 	     			%>        
					    <script language='jscript'>
					       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
					       history.go(-1);
				       </script> 
			         
					<%  
 		
 			}
		
	}
%>      
        
<HTML><HEAD><TITLE>������BOSS-���˲���ȡ��</TITLE>

<script language="JavaScript">
onload = function() {
	opchange();
}

  //ȷ���ύ
function refain()
{
  
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	 {
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    document.all.opCode.value="6711";	    	
	  }else if(opFlag=="two")
	  {
	    document.all.opCode.value="6715";	    	
	  }else if(opFlag=="three"){
	  	document.all.opCode.value="6719";	    	
	  }
   } 
  }
  var op_code=document.all.opCode.value;
  getAfterPrompt(op_code);
if(document.all.CRColorType.value!="00"){
   	if(rdShowConfirmDialog("�����˶��Ĳ���"+document.all.CRColorTypeName.value+"ҵ����"+document.all.day.value+"��δ���ڣ��˶�����ò��˲�ת���������ʹ�ò���ҵ�񣬽����¿�ͨҵ������ȷ���Ƿ��˶���")==1){
   	    showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
				if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
			  document.form.action="f6711_2.jsp";
				document.form.submit();
				return true; 
    	  }
    	}
 		}else{  
		    showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
				if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
				     document.form.action="f6711_2.jsp";
					  document.form.submit();
					  return true;  
				   }    
    }
}

//�����ֻ��ź����룬��ѯ������Ϣ
function doQuery()
	{		
		
	var MobPhone=document.form.phone_no.value;
    if((MobPhone.substring(0,1) !=1) || (MobPhone.substring(1,2) !=3 && MobPhone.substring(1,2) !=5&& MobPhone.substring(1,2) !=8&& MobPhone.substring(1,2) !=4))
    {
    rdShowMessageDialog("�ֻ�����ֻ����13��14��15��ͷ�������������ֻ����룡" );
    document.form.phone_no.focus();
    return false;
    }
    if((myParseInt(MobPhone.substring(0,3),10)<134) || (myParseInt(MobPhone.substring(0,3),10)>139 && myParseInt(MobPhone.substring(0,2),10) !=15&& myParseInt(MobPhone.substring(0,2),10) !=18&& myParseInt(MobPhone.substring(0,2),10) !=14))
    { 
    rdShowMessageDialog("�ֻ����뷶ΧӦ����134~139֮�������15X��14X�Ŷ�");
    document.form.phone_no.focus();
    return false;	
    }	
	if(document.form.phone_no.value.length<11)
	{
		rdShowMessageDialog("�ֻ�����ӦΪ11λ��",0);
		return false;
	}

	 document.form.action = "f6711_1.jsp?action=select";
	 document.form.submit(); 
	
	}
//begin  add  by liutong
function myParseInt(nu)
{
  var ret=0;
  if(nu.length>0)
  {
    if(nu.substring(0,1)=="0")
	{
       ret=parseInt(nu.substring(1,nu.length));
	}
	else
	{
       ret=parseInt(nu);
	}
  }
  return ret;
}
//end add by  liutong
function opchange()
{
	 var op_code="";
	 if(document.all.opFlag[0].checked==true) 
	{	  	
	  	document.all.ColorType.value ="00";
	  	op_code="6711";
	  }else if(document.all.opFlag[1].checked==true) {
	    document.all.ColorType.value ="01";
	    op_code="6715";
	  }else{
	  	document.all.ColorType.value ="";
	  	op_code="6719";
	  }
	  beforePrompt(op_code);
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //��ʾ��ӡ�Ի���
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   	var pType="subprint";   
	var billType="1";  
	var sysAccept = '<%=loginAccept%>';
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var opCode="<%=opCode%>";
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
 	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=phone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,"",prop);
}
			
			function printInfo(printType) { 
					var retInfo = "";
					  var cust_info="";
					  var opr_info="";
					  var note_info1="";
					  var note_info2="";
					  var note_info3="";
					  var note_info4="";					
							retInfo+='<%=workname%>'+"|";
							retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
							cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
							cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
							cust_info+="�ͻ�ID��"+document.all.cust_id.value+"|";
							
							opr_info+="ҵ��Ʒ��:"+document.all.sm_name.value+"|";
							opr_info+="����ҵ��:"+"��������"+"|";
							opr_info+="������ˮ:"+'<%=loginAccept%>'+"|";
							opr_info+="����ʱ��:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
							opr_info+="ҵ����Чʱ��:"+"����"+"|";
							note_info1+="��ע��"+"|";
							if(document.all.CRColorType.value!="00"){
							note_info1+="�����˶�����"+document.all.CRColorTypeName.value+"ҵ���˶��������ò��˲�ת"+"|";	
							note_info1+="�������ʹ�ò���"+document.all.CRColorTypeName.value+"ҵ�񣬽����¿�ͨҵ����"+"|";	
							}

							note_info1+=""+document.all.simBell.value+"|";
							//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
							retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
							retInfo=retInfo.replace(new RegExp("#","gm"),"%23");							
							return retInfo;
			}	
function beforePrompt(op_code){
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
    core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
	packet =null;
}

function doGetAfterPrompt(packet)
{
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	if(retCode=="000000"){
		promtFrame(retMsg);
	}
}
</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
  
        <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">���˲���ȡ��</div>
		</div>
    
    <table cellspacing="0">
    <tr> 
       <TR> 
	          <TD width="13%"  class="blue">��������</TD>
              <TD width="47%" colspan="3">
			         <input type="radio" name="opFlag" value="one" onclick="opchange()" <%if(opFlag.equals("one"))out.println("checked");  if(action!=null&&action.equals("select"))out.println("disabled");%> >����ȡ��(�����еش�0Ԫ)&nbsp;&nbsp;
			         <input type="radio" name="opFlag" value="two" onclick="opchange()" <%if(opFlag.equals("two"))out.println("checked");  if(action!=null&&action.equals("select"))out.println("disabled"); %> >������/����/������/����ȡ�� &nbsp;&nbsp;
			         <input type="radio" name="opFlag" value="three" onclick="opchange()" <%if(opFlag.equals("three"))out.println("checked"); if(action!=null&&action.equals("select"))out.println("disabled");%> >���忨ȡ��
	          </TD>
		      <input type="hidden" name="opcode" >
         </TR>
        </tr>  
    <input type="hidden" name="opCode" > 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>"> 
    <input type="hidden" name="ColorType" value="00">   		      
       
		     <TR>   
		  	     <td  class="blue" >�ֻ�����</td>                                 
              <td colspan="3" >                     
               <input type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11  value="<%=phone%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(true){out.print("readonly  Class=\"InputGrey\" ");}%>>
               <font class="orange">*</font>
               </td>
            </TR>
<%
	if(nextFlag==1)
	{
%>
            <tr>
				<td nowrap colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" id="footer">
					<div align="center">
					<input class="b_foot" name=sure22 type=button value="ȷ��" onClick="doQuery();" style="cursor:hand">
            		<input class="b_foot" name=reset22 type=reset value="���">
            		<input class="b_foot" name=close22 type=button value="�ر�" onclick="removeCurrentTab()">
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
                <tr style="display:none"> 
                  <td  class="blue"> �ֻ�����</td>
                  <td>
                    <input class="button" type="text" name="phoneNo" maxlength="11" class="button"  value="<%=phone%>">
                    <font class="orange">*</font>
                  </td>
                  <td  class="blue">�ͻ�ID</td>
                  <td> 
                    <input type="text" name="cust_id" maxlength="6"  class="button" value="<%=sOutCustId%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td width="13%"  class="blue">�ͻ�����</td>
                  <td width="35%"> 
                    <input type="text" name="cust_name"  value="<%=sOutCustName%>"   readonly  Class="InputGrey" >
                    <font class="orange">*</font>
                  </td>
                  <td width="13%"  class="blue">ҵ��Ʒ�� </td>
                  <td width="35%"> 
                    <input type="text"   readonly  Class="InputGrey"  name="sm_name" value="<%=sOutSmName%>">
                    <font class="orange">*</font>
                    <input type="hidden" readonly  Class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
                  </td>
                </tr>
                <tr> 
                  <td width="13%"  class="blue">�ʷ��ײ�</td>
                  <td width="35%"> 
                   
                    <input type="text"   readonly  Class="InputGrey"  name="ProductName" maxlength="5"   value="<%=sOutProductName%>">
                    <font class="orange">*</font>
                     <input type="hidden" readonly  Class="InputGrey"  name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
                  </td>
                  <td width="13%"  class="blue">����״̬</td>
                  <td width="39%"> 
               
                    <input type="text"   readonly name="RunName"  Class="InputGrey"  value="<%=sOutRunName%>">
                    <font class="orange">*</font>
                   <input type="hidden" readonly name="RunCode"  Class="InputGrey"  value="<%=sOutRunCode%>">
                  </td>
                </tr>
               <tr> 
                  <td width="13%"  class="blue">ҵ������</td>
                  <td width="35%"> 
               
                    <input type="text"   readonly name="CRColorTypeName" maxlength="5"      Class="InputGrey"  value="<%=sOutCRColorTypeName%>">
                    <font class="orange">*</font>
                    <input type="hidden" readonly name="CRColorType" maxlength="5"  Class="InputGrey"  value="<%=sOutCRColorType%>">
                  </td>
                  <td width="13%"  class="blue">����ʱ��</td>
                  <td width="39%"> 
                    <input type="text" readonly  name="CRBellBeginTime"  Class="InputGrey"  maxlength="20" value="<%=sOutCRBellBeginTime%>">
                    <font class="orange">*</font>
                    <input type="hidden" name="day" value="<%=minusDay%>" > 
                  </td>
               </tr>
              <tr> 
                  <td width="13%"  class="blue">�Ѷ��������Ʒ</td>
                  <td width="35%"> 
                    <input type="text"   readonly name="UsingCRProdName" maxlength="5"     Class="InputGrey"  value="<%=sOutUsingCRProdName%>">
                    <font class="orange">*</font>
                     <input type="hidden" readonly name="UsingCRProdCode" maxlength="5"  Class="InputGrey"  value="<%=sOutUsingCRProdCode%>">
                  </td>
                  <td width="13%"  class="blue">��������״̬</td>
                  <td width="39%"> 
                    <input type="text" readonly  name="CRRunName"  Class="InputGrey"  maxlength="20" value="<%=sOutCRRunName%>">
                    <font class="orange">*</font>
               </td>
              </tr> 
            </table>                
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td width=13%  class="blue">��ע</td>
                  <td width="87%">
                    <input  Class="InputGrey"  readonly name=sysNote value="Ա��<%=workno%>���ֻ�����<%=phone_no%>ȡ�����˲���ҵ��"  size=60 maxlength="60">
                  </td>
                </tr>
                <tr style="display:none"> 
                  <td width="13%"  class="blue">�û���ע</td>
                  <td width="87%"> 
                    <input class="button" name=opNote size=60 value="Ա��<%=workno%>���ֻ�����<%=phone_no%>ȡ������<%=sOutUsingCRProdName%>ҵ��" maxlength="60">
                  </td>
                </tr>
                </tbody> 
              </table>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td align=center  id="footer"> 
                    <input class="b_foot" name=sure type="button" value=ȷ�� onclick="refain()">
                    &nbsp;
                    <input class="b_foot" name=clear type=reset value=��һ�� onClick="location = 'f6711_1.jsp?phone_no=<%=phone%>';">
                    &nbsp;
                    <input class="b_foot" name=reset type=button value=�ر� onClick="removeCurrentTab()">
                  </td>
                </tr>                
                </tbody> 
             
            
				    <%
				    }
				   %>
 </table>
<div id="relationArea" style="display:none"></div>
			<div id="wait" style="display:none">
			<img  src="/nresources/default/images/blue-loading.gif" />
		</div>
		<div id="beforePrompt"></div>
	 <%@ include file="/npage/include/footer_simple.jsp" %>  
 
</FORM>
</BODY>
</HTML>

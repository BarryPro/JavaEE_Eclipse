<%
/********************
 version v2.0
 ������: si-tech
 ģ��:ǿ�ƿ��ػ��ָ�
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%
	String opCode = request.getParameter("opCode");
	System.out.println(opCode);
  	String opName = request.getParameter("opName");
  	String phoneNo  = request.getParameter("i1");
  	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���
	String hdword_no = (String)session.getAttribute("workNo");//����
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String regCode = (String)session.getAttribute("regCode");
	String loginPwd  = (String)session.getAttribute("password"); 
%>
<HEAD>
<TITLE>������BOSS-���ػ�����ǿ�ƿ��ػ��ָ�</TITLE>

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
 <input type="hidden" name="oret_code" value="">

<%
/*********************************����ǰһҳ�洫������ֵ**************************************/

%>
<%      
    ArrayList retArray = new ArrayList();
    ArrayList  inputParam = new ArrayList();
    //String[][] result = new String[][]{};
 	String outList[][] = new String [][]{{"0","26"}};
%>

<%
/***********************************���巵�ز���*********************************************/

String oret_code="";              // �������               
String oret_msg="";		  // ������Ϣ
String oid_no="";		  // 0  �û�id            
String osm_code="";		  // 1  ҵ�����ʹ���      
String osm_name="";		  // 2  ҵ����������      
String ocust_name="";		  // 3  �ͻ�����          
String ouser_password="";	  // 4  �û�����          
String orun_code="";		  // 5  ״̬����          
String orun_name="";		  // 6  ״̬����          
String oowner_grade="";		  // 7  �ȼ�����          
String ograde_name="";		  // 8  �ȼ�����          
String oowner_type="";		  // 9  �û�����          
String oowner_typename="";	  //10  �û���������      
String ocust_addr="";		  //11  �ͻ�סַ          
String oid_type="";		  //12  ֤������          
String oid_name="";		  //13  ֤������          
String oid_iccid="";		  //14  ֤������          
String ocard_name="";		  //15  �ͻ�������        
String ototal_owe="";		  //16  ��ǰǷ��          
String ototal_prepay="";          //17  ��ǰԤ��          
String ofirst_oweconno="";	  //18  ��һ��Ƿ���ʺ�    
String ofirst_owefee="";	  //19  ��һ��Ƿ���ʺŽ��		 
String obak_field=""; 		  //20  �����ֶ�          
String ocmd_code="";		  //21  �������  
String strRunCode="";		  //22  ��ǰ״̬����          
String strRunName="";		  //23  ��ǰ״̬����         
String ocmd_name="";		  //22  ��������          
String onew_run="";		  //23  ��״̬����        
String onew_runname="";           //24  ��״̬���� 
String product_name="";   //��Ʒ����


/**************************����s1246Init�����****************************/
String iwork_no = hdword_no;                                 //��������
String iphone_no = request.getParameter("i1");                //�ֻ�����
String iop_code = "2355";                                    //op_code 
String iorg_code = hdorg_code;                               //org_code  
String strNewRunCode = request.getParameter("new_run_code");            //�������� 
String cfm_login = "";//����˺�


inputParam.add(iwork_no);
inputParam.add(iphone_no);
inputParam.add(iop_code);
inputParam.add(iorg_code);
inputParam.add(strNewRunCode);

	try
	{
		//retArray = callWrapper.callFXService("s1246Init",inputParam,"5",outList);
%>
		<wtc:service name="s1246Init" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="27">			

		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iop_code%>"/>
		<wtc:param value="<%=iwork_no%>"/> 
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=iphone_no%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=iorg_code%>"/>
	  <wtc:param value="<%=strNewRunCode%>"/>
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
<%
		oret_code = retCode1;
		oret_msg = retMsg1;
		      
		System.out.println("2222:" + oret_code + ":" + oret_msg);
		
		//result = (String[][])retArray.get(0);
		
		oid_no  = result[0][0];                   // 0 �û�id    
		osm_code  = result[0][1];		        	// 1 ҵ�����ʹ���       
		osm_name = result[0][2];					// 2 ҵ����������       
		ocust_name = result[0][3];					// 3 �ͻ�����           
		ouser_password = result[0][4];				// 4 �û�����           
		orun_code = result[0][5];					// 5 ״̬����           
		orun_name = result[0][6];			       // 6 ״̬����           
		oowner_grade = result[0][7];			   // 7 �ȼ�����           
		ograde_name = result[0][8];			        // 8 �ȼ�����           
		oowner_type = result[0][9];			       // 9 �û�����           
		oowner_typename = result[0][10];			//10 �û���������       
		ocust_addr = result[0][11];			       //11 �ͻ�סַ           
		oid_type = result[0][12];			        //12 ֤������           
		oid_name = result[0][13];			        //13 ֤������           
		oid_iccid = result[0][14];			         //14 ֤������           
		ocard_name = result[0][15];			      //15 �ͻ�������         
		ototal_owe = result[0][16];			        //16 ��ǰǷ��           
		ototal_prepay = result[0][17];			//17 ��ǰԤ��           
		ofirst_oweconno  = result[0][18];			//18 ��һ��Ƿ���ʺ�     
		ofirst_owefee = result[0][19];			//19 ��һ��Ƿ���ʺŽ��	
		obak_field = result[0][20];                   //20 �����ֶ�           
		ocmd_code = result[0][21];                   //21 �������            
		ocmd_name = result[0][22];                   //22 ��������            
		onew_run = result[0][23];                   //23 ��״̬����          
		onew_runname  = result[0][24];                   //24 ��״̬����
		product_name  = result[0][25];                   // ��Ʒ����
		cfm_login  = result[0][26];              //����˺�
			       
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
		<input class="InputGrey" name="i1" value="<%=request.getParameter("i1")%>" v_type="mobphone" v_must=1 onBlur="if(this.value!=''){if(checkElement('i1')==false){return false;}}"  readonly >
		</TD>
		<TD class="blue">�ͻ�����</TD>
		<TD>
		<input class="InputGrey" name="ocust_name" value="<%=ocust_name%>" readonly >
		</TD>
   	 </TR>
	<TR> 
		<TD class="blue">��Ʒ����</TD>
		<TD>
		<input class="InputGrey" name="product_name" value="<%=product_name%>" readonly >
		</TD>
		<TD class="blue">�ͻ�סַ</TD>
		<TD>
		<input class="InputGrey" size="60" name="ocust_addr" value="<%=ocust_addr%>" readonly>
		</TD>
    </TR>
		<TR> 
	  <TD class="blue">֤������</TD>
	  <TD ><input class="InputGrey" name="oid_type" value="<%=oid_name%>" readonly>
	  </TD>
	  <TD class="blue">֤������</TD>
	  <TD>
	  <input class="InputGrey" name="oid_iccid" value="<%=oid_iccid%>"   readonly >
	  </TD>
    </TR>
		<TR> 
		<TD class="blue">��ǰ״̬����</TD>
		<TD>
			<input class="InputGrey" name="cur_run_code" value="<%=orun_code%>" readonly>
		</TD>
		<TD class="blue">��ǰ״̬����</TD>
		<TD>
			<input class="InputGrey" name="cur_run_name" value="<%=orun_name%>" readonly>
		</TD>
    </TR>
		<TR> 
			<TD class="blue">�ָ�״̬����</TD>
			<TD>
				<input class="InputGrey" name="orun_code" value="<%=onew_run%>" readonly>
			</TD>
			<TD class="blue">�ָ�״̬����</TD>
			<TD>
				<input class="InputGrey" name="orun_name" value="<%=onew_runname%>" readonly>
			</TD>
    </TR>
			 <%
				  String strsql = "";
				  String favor_code = "";
				  String hand_fee = "";
			  try{
				  strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
				 // retArray_favor = callView.spubqry32Process("2","",strsql).getList();
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
				 // System.out.println("Call services is Failed!");
			  }
			   
			 %>
			 <%
			//out.println(favorcode);
			int m =0;
			   for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
						for(int q = 0;q< favInfo[p].length;q++)
						{
						 //out.println("�Ż��ʷѴ��룺["+ favInfo[p][q]+"]");
						 if(favInfo[p][q].trim().equals(favor_code.trim()))
							 {
						// out.println("wwww");
							   ++m;
						     }
							}
                   }
			//out.println("m="+m);
			%>
             <TR>
			     <%
			     
			     if("".equals(hand_fee.trim())){
			     	hand_fee = "0.00";
			     }
			     
			     if(m != 0){
			     
			     %>		 
				 <TD class="blue">������</TD>
				 <TD>
				 <input name="ohand_cash" value="<%=hand_fee%>" v_must=1  v_type=float readonly  class="InputGrey">
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
			   <input class="InputGrey" name="sysnote" readonly>
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
	   <%@ include file="tail.jsp"%>
	   <!-----------------------------------����������----------------------------------------------->
	   <!--input type="hidden" value="<%=onew_runname%>" name="onew_runname"-->
	   <input type="hidden" name="stream" value="<%=seq%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="opName" value="<%=opName%>">
	   <input type="hidden" name="opCode" value="<%=opCode%>">
	   <input type="hidden" name="osm_code" value="<%=osm_code%>">

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
 	/*if(flag==1){
	document.form1.action="<%=request.getContextPath()%>/page/change/f1274_3.jsp";  
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
		
		if( tmpDays <= 0 || tmpDays > 365 || jtrim(document.all.expDays.value).length==0)
		{
			rdShowMessageDialog("ǿ��ʱ��������ȷ��ǿ��ʱ��,ǿ��ʱ����0-365֮��!",0);
			return false;
		}
	}
    return true;
} 

var thesysnote = ""; //����ȫ�ֱ�����ϵͳ��ע

/*----------------���ô�ӡҳ�溯��---------------------*/
function showPrtDlg()
{  	getAfterPrompt();
	var imo_phone = '<%=phoneNo%>' ;

	
    //var onew_runname = document.all.onew_runname.value;
	var onew_runname=document.all.icmd_code.value;
    thesysnote = imo_phone + onew_runname                        //����ϵͳ��ע
    document.all.sysnote.value= thesysnote;                      //����ҳ����ʾ��ϵͳ��ע

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
			//senddata();                      //ͬʱ����ҳ��ƴ��
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
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';
                                                                    //ϵͳ����
   var name = '<%=ocust_name%>';         						    //�û�����
   var address = '<%=ocust_addr%>';							        //�û���ַ
   var cardno = '<%=oid_iccid%>'; 								    //֤������
   var stream = document.all.stream.value;							//��ӡ��ˮ
   var work_no = '<%=hdword_no%>';                                 //�õ�����
   var sysnote = document.all.sysnote.value;                        //����ӡ��ϵͳ��־

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
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
   var name = '<%=ocust_name%>';         						    //�û�����
   var address = '<%=ocust_addr%>';							        //�û���ַ
   var cardno = '<%=oid_iccid%>'; 								    //֤������  
	 var retInfo = "";


		if("<%=cfm_login%>"!=""){
			phone = "<%=cfm_login%>";
		}
			 
	cust_info+="�ֻ����룺   "+phone+"|";
	cust_info+="�ͻ�������   "+name+"|";
	cust_info+="�ͻ���ַ��   "+address+"|";
	cust_info+="֤�����룺   "+cardno+"|";
	
	opr_info+="ҵ�����ͣ�ǿ�ƿ��ػ��ָ�"+"|";
	opr_info+="ҵ����ˮ��"+document.all.stream.value+"|";
	note_info1 +="��ע��"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}

function crmsubmit()
{

	if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1){
  	form1.action="f2355_3.jsp";
    form1.submit();
	}else{
		return false;
	}
}


 /*-------------------------------��ʼ��������-----------------------------*/
 /*for(r=0;r<document.all.icmd_code.value.length;r++)
 {
	if(document.all.icmd_code.options[r].value =='<%=ocmd_code%>')
	{
		document.all.icmd_code.options[r].selected=true;
		break;
	 }
 
 }*/
 </script>

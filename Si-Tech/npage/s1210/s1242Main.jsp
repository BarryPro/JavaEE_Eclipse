 <%
/********************
version v2.0
������: si-tech
update:anln@2009-02-16 ҳ�����,�޸���ʽ
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<html>
<title>���뱸��</title>
<%
	String opCode = "1242";	
	String opName = "���뱸��";	//header.jsp��Ҫ�Ĳ���  
	String[][] temfavStr1=(String[][])session.getAttribute("favInfo");
	String[] favStr1=new String[temfavStr1.length];
	String sim="readonly";
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	for(int i=0;i<favStr1.length;i++){
		favStr1[i]=temfavStr1[i][0].trim();	
	}
	if(WtcUtil.haveStr(favStr1,"a003")){
		sim="";
}
 %>  
<%
    	
    	String work_no =  (String)session.getAttribute("workNo");
    	String loginName = (String)session.getAttribute("workName");
    	String org_code =  (String)session.getAttribute("orgCode");
	String op_code = "1242";

	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	  favStr[i]=temfavStr[i][0].trim();
   	
	boolean hfrf=false;
	

	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
    	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));	
 
	//-----------���������-------------
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE='"+op_code+"'";
	//ArrayList handFeeArr=co.spubqry32("2",sqHf,"phone",srv_no); 
	%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sqHf%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr" scope="end" />
	<%
	String oriHandFee="0";
	String oriHandFeeFlag="";    	
    if(handFeeArr!=null&&handFeeArr.length>0)
	{
	  
	  	oriHandFee=handFeeArr[0][0];
	  	oriHandFeeFlag=handFeeArr[0][1];
       		if(Double.parseDouble(oriHandFee) < 0.01)
		   	hfrf=true;
	   else
	   {
         	if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim()))
			hfrf=true;
	   }
	}
   	 else
	  hfrf=true;		  	 
 	
	//-----------����û�smName-------------
	/*	
	String sqHf1="select a.smName from ssmcode a,dcustmsg b where a.sm_code=b.sm_code and substr(b.belong_code,1,2)=a.region_code and b.phone_no='"+srv_no+"'";
	*/
	String sqHf1="select a.band_name from dcustmsg b, band a where a.sm_code=b.sm_code and b.phone_no='"+srv_no+"'";
	//ArrayList handFeeArr1=co1.spubqry32("1",sqHf1,"phone",srv_no); 
	%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:sql><%=sqHf1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr1" scope="end" />
	<%
	String smName="";	
	if(handFeeArr1!=null&&handFeeArr1.length>0)
	{		
		smName=handFeeArr1[0][0];
	}

	/****�õ���ӡ��ˮ****/
	String printAccept="";	
	printAccept = getMaxAccept();
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String loginPswInput = (String)session.getAttribute("password");

	//------------��÷������˳�ʼ����Ϣ����-----------	
  	%>
	<wtc:service name="s1220Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode3" retmsg="retMsg3" outnum="30" >
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=loginPswInput%>"/> 
		<wtc:param value="<%=srv_no%>"/>
		<wtc:param value=""/>  
	</wtc:service>	
	<wtc:array id="initStr" start="0" length="23" scope="end"/>
<%	
	if(initStr==null || initStr.length==0)
        	response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=14"+"&srv_no="+srv_no);        
        String sq1210 = "select trim(attr_code) from dcustMsg where phone_no='" + srv_no + "' and substr(run_code,2,1)<'a' and rownum<2";        
    
    	%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
		<wtc:sql><%=sq1210%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="twoFlag1" scope="end" />
<%
	String temFlag = "";
	if (twoFlag1.length == 0)
		temFlag = "00000";
	else
		temFlag = twoFlag1[0][0];
	
	String [][] twoFlag=new String[][]{};
	if (!temFlag.equals("")){
		String bigFlag = temFlag.substring(2, 4);
		String grpFlag = temFlag.substring(4, 5);		
		StringBuffer sq2Buf = new StringBuffer("select trim(card_name) from sBigCardCode where card_type='");
		sq2Buf.append(bigFlag);
		sq2Buf.append("';");
		sq2Buf.append("select trim(grp_name) from sGrpBigFlag where grp_flag='");
		sq2Buf.append(grpFlag);
		sq2Buf.append("'");		
		%>
			<wtc:mutilselect name="sPubMultiSel" routerKey="phone" routerValue="<%=srv_no%>"  id="twoFlag2" type="array"> 
				<wtc:sql><%=sq2Buf.toString()%></wtc:sql>
			</wtc:mutilselect>			
		<%	
			
			twoFlag=twoFlag2;
		}	
	
    if(twoFlag==null || twoFlag.length==0)
      response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=10"+"&srv_no="+srv_no);    
    if(initStr.length==0)
      	response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=11"+"&srv_no="+srv_no);  
    else
	{
      if(!retCode3.equals("000000"))
	  {
		if(Integer.parseInt(retCode6)==1007 || Integer.parseInt(retCode6)==1008)
		{
          		response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=100&oweAccount="+new String(initStr[0][8].getBytes("GBK"),"ISO8859_1")+"&oweFee="+initStr[0][7]+"&srv_no="+srv_no);
		}
		else
		{
          		response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=101&errCode="+retCode3+"&errMsg="+new String(retMsg3.getBytes("GBK"),"ISO8859_1")+"&srv_no="+srv_no);
		}
	  }
	}

    	if(ReqPageName.equals("sa242"))
	{
 	  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass"));
	}   
	if(!initStr[0][11].trim().equals(""))
	{
	  response.sendRedirect("sa242.jsp?ReqPageName=sa242Main&retMsg=102&BackupSimNo="+initStr[0][11].trim()+"&srv_no="+srv_no);
	}
%>

<%
	
	String highmsg=initStr[0][5].trim();
	String ss="�и߶��û�";
	int spos=highmsg.indexOf(ss,0);
%>
<head>
<script language=javascript>
if(<%=spos%>>=0){rdShowMessageDialog("���û����и߶��û���");}		  

  onload=function()
  {
    //self.status="";
    document.all.t_newsimf.focus(); 
  }

//----------------��֤���ύ����-----------------
function printCommit()
{          
getAfterPrompt();
// in here form check
showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}
		
		
function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	 
     if(check(frm))
     {
		document.all.t_sys_remark.value="�û�"+document.all.srv_no.value.trim()+"���뱸����";
		 if((document.all.t_op_remark.value.trim()).length==0)
      {
			  document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û��ֻ�"+document.all.srv_no.value.trim()+"�������뱸��"
	  }
						
		//��ʾ��ӡ�Ի��� 
  	
	  	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=printAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = <%=srv_no%>;                           //�ͻ��绰		  
  
     	var h=180;
     	var w=350;
     	var t=screen.availHeight/2-h/2;
     	var l=screen.availWidth/2-w/2;
	     
	    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);     
	

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ���뱸����Ϣ��')==1)
				{
					 conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ���뱸����Ϣ��')==1)
			{
				conf();
			}
		}
	 }
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
    
	cust_info+="�ͻ�������   " +document.all.cus_name.value+"|";
	cust_info+="�ֻ����룺   "+"<%=srv_no.trim()%>"+"|";
	cust_info+="�ͻ���ַ��   "+document.all.cus_addr.value+"|";
	cust_info+="֤�����룺   "+document.all.icc_no.value+"|";
	
	opr_info+="ҵ������ʱ�䣺<%=currentTime%>  "+"|";
	
	opr_info+="SIM���ѣ�"+document.all.t_simFeef.value+"|";
	opr_info+="�����ѣ�"+document.all.t_handFee.value+"|";
	opr_info+="ʵ�ս�"+(parseInt(document.all.t_simFeef.value)+parseInt(document.all.t_handFee.value))+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+"<%=smName%>"+" VIP���ԣ�"+'<%=initStr[0][5].trim()%>'+"|";
	opr_info+="����ҵ�����뱸��   ������ˮ��"+'<%=printAccept%>'+"|";
	opr_info+="SIM���ţ�"+document.all.t_newsimf.value+"  SIM�����ͣ�"+document.all.newSimName.value+"|";
	opr_info+="ϵͳ��ע��"+document.all.t_sys_remark.value+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	return retInfo;
	
}
	
//--------3---------��֤��ťר�ú���----------------
function chkSim(phoneNo,simOldNo,simNewNo)
{  
	if((document.all.t_newsimf.value.trim()).length==0)
	{
		rdShowMessageDialog("����SIM���Ų���Ϊ�գ�");
		document.all.t_newsimf.value="";
		document.all.t_newsimf.focus();
		return false;
	}	
	var myPacket = new AJAXPacket("chgSim1242.jsp","������֤����SIM���ţ����Ժ�......");
	
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("simOldNo",simOldNo);
	myPacket.data.add("simNewNo",simNewNo);
	myPacket.data.add("orgCode","<%=org_code%>");		
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
		
	function doProcess(packet)
		 {
		    	var errCode=packet.data.findValueByName("errCode");
			var errMsg=packet.data.findValueByName("errMsg");
			var simFee=packet.data.findValueByName("simFee");
		    	var simStatus=packet.data.findValueByName("simStatus");
			var simName=packet.data.findValueByName("simName");
		  
			self.status="";
			if(parseInt(errCode)!=0)
			{
			  //rdShowMessageDialog("SIM����֤����");
			  rdShowMessageDialog("����"+errCode+"��"+errMsg,0);
			  document.all.t_newsimf.value="";
			  document.all.t_newsimf.focus();
			}
			else
			{
			  
			  if(simFee > 0)
			  {
			  	//document.all.t_factFee.value = (parseFloat(document.all.t_handFee.value) + parseFloat(simFee)).toString();
			  	document.all.t_factFee.value = (parseFloat(document.all.t_handFee.value)).toString();
			  }
			  
			  document.all.t_simFeef.value=simFee.trim();
			  document.all.oriSimFee.value=simFee.trim();
			  document.all.newSimName.value=simName.trim();
			  if((document.all.t_simFeef.value.trim()).length==0)
			  document.all.t_simFeef.value="0";
			  if((document.all.oriSimFee.value.trim()).length==0)
			  document.all.oriSimFee.value="0";
			  if(simStatus.trim()=="9")
			  { 
			    document.all.op_type.value="1";
				document.all.t_optype.value="ȡ��";
			  }
			  else
			  {
			    document.all.op_type.value="0";
				document.all.t_optype.value="����";
			  }
			  document.all.t_simFeef.focus();
		      document.all.t_simFeef.select();
			  document.all.b_print.disabled=false;
			}
		 }
	
 function conf()
 { 
   frm.action="s1242_conf.jsp";
   frm.submit();
 } 
		
//-------6--------ʵ����ר�ú���----------------
function ChkHandFee()
{
	if((document.all.oriHandFee.value.trim()).length>=1 && (document.all.t_handFee.value.trim()).length>=1)
	{
		if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
		{		
rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");		  
document.all.t_handFee.value=document.all.oriHandFee.value;		  
document.all.t_handFee.select();			  
document.all.t_handFee.focus();			  
return;
		}
	}
	
	if((document.all.oriHandFee.value.trim()).length>=1 && (document.all.t_handFee.value.trim()).length==0)
	{
	document.all.t_handFee.value="0";
	}
}		
function getFew()		
{		
  if(window.event.keyCode==13)		
  {		
    var fee=document.all.t_handFee;		
	var simFee = document.all.t_simFeef;		
    var fact=document.all.t_factFee;		
    var few=document.all.t_fewFee;		
    if((fact.value.trim()).length==0)		
    {		
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");		
	  fact.value="";		
	  fact.focus();		
	  return;		
    }		
    //if(parseFloat(fact.value)<parseFloat(fee.value) + parseFloat(simFee))		
	if(parseFloat(fact.value)<parseFloat(fee.value))		
    {		
  	  rdShowMessageDialog("ʵ�ս��㣡");		
	  fact.value="";		
	  fact.focus();		
	  return;		
    } 		
		
	//var tem1=((parseFloat(fact.value)-parseFloat(simFee.value)-parseFloat(fee.value))*100+0.5).toString();		
	var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();		
			
	var tem2=tem1;		
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));		
    few.value=(tem2/100).toString();		
    few.focus();		
  }		
}	
</script>
</head>
<body>	
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">		
<%@ include file="/npage/include/header.jsp" %> 
<div class="title">
	
	<div id="title_zi">���뱸��</div>
	
</div>	

  <input type="hidden" name="ReqPageName" id="ReqPageName" value="sa242Main">
  <input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
  <input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">  
  <input type="hidden" name="op_type" id="op_type" value="">
  <input type="hidden" name="cus_id" id="cus_id" value=<%=initStr[0][1].trim()%>>
  <input type="hidden" name="cus_name" id="cus_name" value="<%=initStr[0][8].trim()%>">
  <input type="hidden" name="icc_no" id="icc_no" value="<%=initStr[0][14].trim()%>">
  <input type="hidden" name="cus_addr" id="cus_addr" value="<%=initStr[0][15].trim()%>">
  <input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
  <input type="hidden" name="oriSimFee" id="oriSimFee"  value="">
  <input type="hidden" name="simOldNo" id="simOldNo" value="<%=initStr[0][9].trim()%>">
   <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60"   v_maxlength=60  v_type=string   maxlength=60 index="4">

        <table  cellspacing="0" >
          <tr> 
            <td width="11%" nowrap  class="blue">   ��ͻ���־</td>            
            <td nowrap width="31%" > 
              <font color="#FF0000"><%=twoFlag[0][0]%></font>
            </td>
            <td width="11%" nowrap   class="blue">   ���ű�־  </td>
            <td nowrap  width="18%"> 
              <%=twoFlag[1][0]%>
            </td>
            <td nowrap  width="11%" class="blue"> ��������</td>
            <td nowrap  width="18%" > 
              <input  type="text" name="t_optype" id="t_optype" size="10" readonly class="InputGrey">
            </td>
          </tr>
          <tr> 
            <td width="11%" nowrap class="blue" > 
              �������
            </td>
            <td nowrap width="31%"  > 
              <%=srv_no.trim()%>
            </td>
            <td nowrap width="11%"  class="blue"> 
              SIM����
            </td>
            <td nowrap width="18%" > 
              <%=initStr[0][9].trim()%>
            </td>
            <td width="11%" nowrap  class="blue"> 
              �û�����
            </td>
            <td nowrap   width="18%"> 
              <%=initStr[0][10].trim()%>
            </td>
          </tr>
          <tr> 
            <td width="11%" nowrap class="blue"> 
              �ͻ�����
            </td>
            <td nowrap width="31%" > 
              <%=initStr[0][8].trim()%>
            </td>
            <td nowrap width="11%" class="blue"> 
              �û�ID
            </td>
            <td nowrap width="18%" > 
              <%=initStr[0][1].trim()%>
            </td>
            <td nowrap width="11%" class="blue" > 
              ����
            </td>
            <td nowrap width="18%" > 
              <%=initStr[0][5].trim()%>
            </td>
          </tr>
          <tr> 
            <td width="11%" nowrap class="blue"> 
              ��ǰԤ��
            </td>
            <td nowrap width="31%" > 
              <%=initStr[0][6].trim()%>
            </td>
            <td nowrap width="11%" class="blue"> 
              ��ǰǷ��
            </td>
            <td nowrap width="18%" > 
              <%=initStr[0][7].trim()%>
            </td>
            <td nowrap width="11%" class="blue"> 
              ��ǰ״̬
            </td>
            <td nowrap width="18%" > 
              <%=initStr[0][3].trim()%>
            </td>
          </tr>      
          <tr> 
            <td nowrap width="11%" class="blue"> 
              ����SIM����
            </td>
            <td nowrap width="31%" > 
              <input  type="text" name="t_newsimf" id="t_newsimf" size="20" v_minlength=1 v_maxlength=100    maxlength="20" index="0" onkeyup="if(event.keyCode==13)chkSim((document.all.srv_no.value.trim()),(document.all.simOldNo.value.trim()),document.all.t_newsimf.value.trim())">
              <font class="orange">*</font>
              <input   type="button" name="b_tr_normal" class="b_text" value="��֤"  onClick="chkSim(document.all.srv_no.value.trim(),document.all.simOldNo.value.trim(),document.all.t_newsimf.value.trim())">              
              <input type="hidden" name="flg_normal" id="flg_normal" value="0">
            </td>
            <td nowrap width="11%" class="blue"> 
              SIM����
            </td>
            <td nowrap >            
              <input  type="text" name="t_simFeef" id="t_simFeef" size="10" <%=sim%> index="1">             
              <font class="orange">*</font>
            </td>
	    <td nowrap width="11%" class="blue"> 
              SIM������
            </td>
            <td nowrap width="18%" > 
              <input  type="text" name="newSimName" size="16" readonly class="InputGrey">
            </td>  
          </tr>
          <tr> 
            <td nowrap width="11%" class="blue"> 
              ������
            </td>
            <td nowrap width="31%" >                
                <input type="text"  name="t_handFee" id="t_handFee" size="16"
		value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float  <%if(hfrf){%>readonly class="InputGrey"<%}%> onblur="ChkHandFee()" index="2">       
            </td>
            <td nowrap width="11%" class="blue"> 
              ʵ��
            </td>
            <td nowrap width="18%" >                
               <input type="text"  name="t_factFee" id="t_factFee" size="16" index="3" onKeyUp="getFew()" v_type=float  <%
	                             if(hfrf)
	                             {
 							   %>
							    readonly class="InputGrey"
							  <%
 								 }
							   %>
							   >
              
            </td>
            <td nowrap width="11%" class="blue"> 
              ����
            </td>
            <td nowrap width="18%" >                
                <input type="text" name="t_fewFee" id="t_fewFee" size="16" readonly class="InputGrey">             
            </td>
          </tr>
          <tr> 
            <td nowrap width="11%" class="blue"> 
              ϵͳ��ע
            </td>
            <td nowrap colspan="5" >                
                <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30 class="InputGrey">             
            </td>
          </tr>          
         </table>
         
         <table  cellspacing="0" >
          <tr> 
            <td id="footer" >              
                <input  type="button" class="b_foot_long" name="b_print" value="ȷ��&��ӡ" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  disabled index="5">
                <input  type="button" class="b_foot" name="b_clear" value="���" onClick="frm.reset();" index="6">
                <input  type="button" class="b_foot" name="b_back" value="����" onClick="history.go(-1)" index="7">             
            </td>
          </tr>
        </table>
	<%@ include file="/npage/include/footer.jsp" %>    
   </form>
</body>
</html>

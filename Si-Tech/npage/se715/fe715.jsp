 <%
	/********************
	 version v2.0
	������: si-tech
	add:wanghao@2009-03-08  �¾ɴ��벢��
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	String opCode = "e715";	
	String opName = "�¾ɴ��벢��";	//header.jsp��Ҫ�Ĳ��� 
	String loginNo=(String)session.getAttribute("workNo");    //���� 
	String loginName =(String)session.getAttribute("workName");//��������  	
	String powerRight= (String)session.getAttribute("powerRight");          
	String orgCode = (String)session.getAttribute("orgCode");        
	String ip_Addr = request.getRemoteAddr();       
	String regionCode = (String)session.getAttribute("regCode");       
	String GroupId = (String)session.getAttribute("groupId");       
	String OrgId = (String)session.getAttribute("orgId");
  
%>
	<head>
		<title>
			�¾ɴ��벢��
		</title>
		<script type=text/javascript>
		function getCustomerNumber(){
		var pageTitle = "EC��Ϣ";
	    var fieldName = "���ű���|���ſͻ�����|��ϵ�绰|";
	    var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "3|0|1|2|";
	    var flag="";
	    
	    var retToField = "ecsiid|ecsiname|linkphone|";
	    
	    var ecsiname = document.all.ecsiname.value;
		  var ecsiid = document.all.ecsiid.value;
	    if((ecsiname=="")&&(ecsiid==""))
	    {	 
	    	 	
	    	rdShowMessageDialog("�����뼯�ű�Ż��ſͻ����ƽ��в�ѯ��");
        document.frm.ecsiid.focus();
        return false;
	    }
	    
	    if((ecsiid!="")&&(isNaN(ecsiid)==true))
			{			
				rdShowMessageDialog("���ű���ֻ�������֣�");
				return false;
			 
			}			
			
	
	    var path = "<%=request.getContextPath()%>/npage/se715/fe715_getEcInfo.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName="+fieldName;
	    path = path + "&selType="+selType;
	    path = path + "&retQuence="+retQuence;
	    path = path + "&retToField="+retToField;
	    path = path + "&s_ecsiid=" +document.all.ecsiid.value;
	    path = path + "&s_ecsiname="   +document.all.ecsiname.value;
	    path = path + "&BaseServCodeProp="   +document.all.BaseServCodeProp.value;
	    path = path + "&combobox="   +document.all.combobox1.value;
	    
	    retInfo = window.open(path,
	                          "newwindow",
	                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
		
	}	
	


    function sendto()
    { 
    	if (document.frm.ecsiid.value == "")
				{
					rdShowMessageDialog("���ű��벻��Ϊ�գ�");
					document.frm.cust_id.focus();
					return false;		
				}
    	
    	if(document.frm.combobox1.value == "01")
    	{
    		
				
				if (document.frm.OldBaseServCode.value == "")
				{
					rdShowMessageDialog("�ɽ���Ų���Ϊ�գ�");
					document.frm.OldBaseServCode.focus();
					return false;		
				}
				if (document.frm.NewBaseServCode.value == "")
				{
					rdShowMessageDialog("�½���Ų���Ϊ�գ�");
					document.frm.NewBaseServCode.focus();
					return false;		
				}								
				confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");
				if (confirmFlag==1) {
		     frm.submit();	
    		}
		   
		  }else{	  	
		  	
		  	var str = "?ecsiid=" + document.all.ecsiid.value+"&BaseServCodeProp="+document.all.BaseServCodeProp1.value ;
				document.middle.location="fe715_qryRelation.jsp"+str;
				tabBusi.style.display="";
				document.all.commbutton.style.display="none";
					
		  }	
		    
	}
	

    
	function doclear()
	{
 		location="fe715.jsp";
 	}


function changecombox()
		{
			if(document.frm.combobox1.value == "01"){				
				document.all.instype.style.display ="";
			
			}else
			{				
				document.all.instype.style.display ="none";
				
			}
			
		}



 	function queryBaseMsg()
	{
		var queryType = document.frm.BaseServCodeProp1.value;
		var queryInfo = document.frm.ecsiid.value;
		var notype ="0";
		var baseserve=document.frm.NewBaseServCode.value;
		if (queryInfo == "")
		{
			rdShowMessageDialog("�����롰���ſͻ����롱��");
			return false;
		}
		document.frm.NewBaseServCode.value="";
		window.open("fe715_queryBaseMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo+"&baseserve="+baseserve+"&notype="+notype,"","height=500,width=400,scrollbars=yes");
	}

		function call_ISDNNOINFO()
		{		
		    if(!checkElement(document.all.NewBaseServCode)) {
		    	rdShowMessageDialog("���������ֻ�������֣�");
		    	return false;
		    }
		    if(document.all.NewBaseServCode.value<5) {
		    	rdShowMessageDialog("��������ų��Ȳ���С��5��");
		    	return false;
		    }
		    check_ISDNNO();		       			
		       
		}
		  function check_ISDNNO()
    {
	      var basecodetype="";
        basecodetype = document.frm.BaseServCodeProp1.value;
        var alterCode=document.all.NewBaseServCode.value;
        var myPacket = new AJAXPacket("fcheckisno.jsp","������֤��������ţ����Ժ�......");
				myPacket.data.add("OprCode","e539");
				myPacket.data.add("queryName",document.all.ecsiname.value);
 				myPacket.data.add("qryInfo",document.all.ecsiid.value);
		 		myPacket.data.add("alterCodeProp",basecodetype);
		 		myPacket.data.add("alterCode",alterCode);
				core.ajax.sendPacket(myPacket);
				myPacket=null;						
    }
    function doProcess(packet)
    {
        var retCode = packet.data.findValueByName("retCode");
        var retMessage=packet.data.findValueByName("retMessage");


        
        self.status="";
        if(retCode == "000000")          
        {
         rdShowMessageDialog("��֤ͨ����"); 
         document.all.confirm.disabled=false;           
        }
        else
        {
           rdShowMessageDialog("��֤ʧ�ܣ�<br/>������룺"+retCode+"��������Ϣ��"+retMessage);
           document.all.NewBaseServCode.value = "";
           document.all.NewBaseServCode.focus();
           return false;	
        }
        
     }	
 		function ISDNNO_QryFunc()
		{
			var dataObj;
			var	params = "?";
			params = params + 'BaseCodeType=' + $("#BaseServCodeProp").val();
			
			var retInfo = window.showModalDialog                                                         
			(                                                                                            
				"/npage/se539/fe539_getISDNNO.jsp"+params,                                                                 
				dataObj,                                                                                    
				'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'    
			); 
			
			if(retInfo!=undefined)
			{
				$("#NewBaseServCode").val(retInfo) ;
				call_ISDNNOINFO();
			}
			
			
			
		}
    	
		$(document).ready(function(){
			
			$('#ISDNNO_Qry').click(function(){
			     ISDNNO_QryFunc();
			 });
		});
		</script>
	</head>

	<body>
		<form name="frm" action="fe715Cfm.jsp" method="post">
			<div id="Main">

			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">			
			<input type="hidden" name="BaseServCodeProp1" value="">

		

			<%@ include file="/npage/include/header.jsp" %>     

			<div class="title">
					<div id="title_zi">��ѡ���������</div>
			</div>

					<TABLE cellSpacing="0">
						<TR>
							<TD width='12%'>
								�������ͣ�
							</TD>
							<TD>
								<SELECT name="combobox1" onChange="changecombox()">
									<OPTION value="01">01������	</option>									
									<OPTION value="02">02����ѯ	</option>
								</SELECT>
							</TD>
							<TD>
								������������ԣ�
							</TD>
							<TD>
								<SELECT id="BaseServCodeProp" name="BaseServCodeProp">
									<OPTION value="01">
										01������
									</option>
									<OPTION value="02">
										02������
									</option>
									<OPTION value="03">
										03��WAPPush
									</option>
								</SELECT>
							</TD>
						</TR>
						<TR>
							<TD width='12%'>
								���ſͻ����룺
							</TD>
							<TD width='32%'>
								<input type="text" name="ecsiid" id="ecsiid" size="24" maxlength="18"  v_must=1 index="1" value="" >
								<input name=custQuery type=button class="b_text" id="custQuery" onMouseUp="getCustomerNumber();" onKeyUp="if(event.keyCode==13)getCustomerNumber();" style="cursor��hand" value=��ѯ>
								<FONT color="#ff0000">
									*
								</FONT>
							</TD>
							<TD>
								���ſͻ����ƣ�
							</TD>
							<TD>
								<input type="text" name="ecsiname" id="ecsiname" size="20" maxlength="50"  v_must=1 index="2" value="" >
							</TD>
						</TR>
						<TR id="instype" style="display:">
							<TD width='12%'>
								�ɻ�������ţ�
							</TD>
							<TD width='32%'>
								<INPUT type="text" name="OldBaseServCode" readOnly>
								<INPUT type="button" name="qryOldCode" value="ѡ��" class="b_text" onclick="queryBaseMsg()" >
								<FONT color="#ff0000">
									*
								</FONT>
							</TD>
							<TD>
								�»�������ţ�
							</TD>
							<TD>
								<INPUT type="text" name="NewBaseServCode" id="NewBaseServCode" v_type="0_9" maxlength="21" >
								&nbsp;
								<input type="button" class="b_text" id="ISDNNO_Qry" value="��ѯ" >
								&nbsp;
								<INPUT type="button" name="button3" value="Ч��" class="b_text" onclick="call_ISDNNOINFO()" >
								<FONT color="#ff0000">
									*
								</FONT>
							</TD>
						</TR>

					</TABLE>			
	
		
		
			
					<TABLE cellSpacing="0" id="commbutton" name="commbutton">
						<TR>
							<TD align="center">
								<INPUT  class="b_foot" type="Button" name="confirm" value="ȷ��" onclick="sendto()"  disabled>
								<INPUT  class="b_foot" type="Button" name="reset" value="���"  onclick="doclear()" >
								<INPUT  class="b_foot" type="Button" name="back" value="�ر�" onClick="removeCurrentTab()">
							</TD>
						</TR>
					</TABLE>
					
	<TABLE id="tabBusi" style="display:none" height="0px" id="mainOne" cellspacing="0">	
				<TR> 
					<td nowrap>
				<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
				style="HEIGHT: 600px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
				</IFRAME>
			</td> 
		</TR>
	</TABLE>	    
	
				</DIV>
				
		
	
		</form>
	</body>
</html>



<%
   /*���ƣ����ſͻ���Ŀ���� - �鿴
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
		String regCode = (String)session.getAttribute("regCode"); 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");

	String grpParamSet="";
  String grpParamSetName="";
	String[] inParams = new String[2];
	String sqlStr ="";	
	String opCode = "2896";
	String opName = "�������ҵ����ͣ�ָ�";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String trId = request.getParameter("trId");
	String operId = request.getParameter("operId");
	String parterName = request.getParameter("parterName");
	
	%>
	 
	<wtc:service name="s2889QryOperMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="41" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2889"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=operId%>"/>
              <wtc:param value="<%=parterId%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	System.out.println("retCode = ===="+retCode);
	if(retCode.equals("000000")){	
	
	if (colNameArr != null)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null");
			}
		}
	inParams[0] = "select set_name  from sBizParamSet  where  param_set=:param_set";
	inParams[1] = "param_set="+colNameArr[0][1];	 
	 %>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="setnameTemp" scope="end" />
  <%
	 String[][] setname = setnameTemp;
	 grpParamSetName=setname[0][0];
	  
	 sqlStr = "select net_attr,net_name from sNetAttr";	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="netArrTemp" scope="end" />
<%
	 String[][] netArr = netArrTemp;
	 
	 if (netArr.length==0)
	 {
		netArr = null;
	 }	  
		
	    
  if(colNameArr==null)
 	{
 		System.out.println("colNameArr = null");
%>
		<script language='jscript'>
			rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
			window.close();
		</script>
<%  
	return;
	}else
    {
      
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script>

onload=function(){	   
			if(("<%=trId%>"=="2")&&("<%=colNameArr[0][11]%>"=="0") )
			{
 
				document.getElementById("YYYY").style.display="none";
			  document.getElementById("XXXX").style.display="none";
			  document.getElementById("cylx1").style.display="none";		
			}else if(("<%=trId%>"=="2")&&("<%=colNameArr[0][11]%>"=="1") ){
 
				document.getElementById("cylx1").style.display="none";
				var timelist="";			
				var startime="<%=colNameArr[0][31]%>";
				var endtime="<%=colNameArr[0][32]%>";		
				var starr = new Array();
				var etarr = new Array();
				starr=startime.split("|");
				etarr=endtime.split("|");
 
				for(var a=0; a< starr.length-1 ;a++)
				{
					timelist=timelist+starr[a]+"|"+etarr[a]+"|";
				}

			document.form1.InvalidTimeSpanList.value=timelist;
			document.form1.MOList.value="<%=colNameArr[0][33]%>";
			}

	    $("#bizTypeL").val("<%=colNameArr[0][38]%>");
	    $("#bizTypeS").val("<%=colNameArr[0][39]%>");	
	    $("#bizPRI").val("<%=colNameArr[0][40]%>");  

	    //changeBizTypeL();
}
function changeBizTypeL(){
    var vBizTypeL = $("#bizTypeL").val();

    var vBussId = document.form1.bussId.value;
	vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeS.jsp","���Ժ�...");
    packet.data.add("bizMode" ,vBussId);
    packet.data.add("bizTypeL" ,vBizTypeL);
    core.ajax.sendPacket(packet,doChangeBizTypeL,false);
    packet = null;
}

function doChangeBizTypeL(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeS").empty();
      	$(arr.join()).appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("��ȡҵ��С��ʧ��[������룺"+retCode+",������Ϣ��"+retMessage+"]",0);
		return false;
    }
}

</script>

</head> 

<body>

<form name="form1" method="post" action="">	

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
			<TABLE cellSpacing="0">
             <TR id="line_1">
             	<TD class="blue">EC/SI���� </TD>
	            <TD>
	              	<input type="text" name="spId" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="6"  value="<%=parterId %>" >
	            </TD> 
				<TD class="blue">ҵ����� </TD>
	            <TD>
	              	<input type="text" name="bizCode" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="18"   value="<%=operId %>" >&nbsp;
	            </TD> 	         								    		            	              
	         </TR>
	         
	          <TR id="line_1">           	
				<TD class="blue">ҵ������</TD>
	            <TD >
	              	<input type="text" name="bizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256"   value="<%=colNameArr[0][5]%>" >&nbsp;<font color="orange">*</font>	
	            </TD>
				<TD class="blue">ҵ�����</TD>
	            <TD> <input type="text" name="bussId"  v_type="string" v_must="1" v_minlength="1" v_maxlength="10"   value="<%=colNameArr[0][4]%>" readonly class="InputGrey">&nbsp;<font color="orange">*</font>
	            </TD>
	         </TR>
	         <tr>
	            <td class='blue'>ҵ�����</td>
	            <td>
	                <%
	                    String smCode = "";
	                    if("M".equals(colNameArr[0][38].substring(0,1))){
	                        smCode = "ML";
	                    }else{
	                        smCode = "AD";
	                    }
	                %>
	                <select name="bizTypeL" id="bizTypeL" onChange="changeBizTypeL()">
    	  			<wtc:qoption name="sPubSelect" outnum="2">
    				<wtc:sql>select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='<%=smCode%>'</wtc:sql>
    				</wtc:qoption>
    				</select>
    				&nbsp;<font class='orange'>*</font>
	            </td>
	            <td class='blue'>ҵ��С��</td>
	            <td>
	                <select name="bizTypeS" id="bizTypeS">
    	  			<wtc:qoption name="sPubSelect" outnum="2">
    				<wtc:sql> select biztype,biztype||'->'||biztypename from sbiztypecode where sm_code='<%=smCode%>' and main_type='<%=colNameArr[0][38]%>'</wtc:sql>
    				</wtc:qoption>
    				</select>
    				&nbsp;<font class='orange'>*</font>
	            </td>
	        </tr>
	         <TR id="line_1"> 
	         	<TD class="blue">EC/SI����</TD>
	            <TD>
	              	<input type="text" readonly class="InputGrey" name="spBizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256"  maxlength="256" value="<%=parterName%>" >
	            </TD>
				<TD class="blue">����ģʽ</TD>
	            <TD>
	            		<select name="accessModel" disabled>
	            		<%
	            		String accessModel1="";
	            		String accessModel2="";
	            		String accessModel3="";
	            		String accessModel4="";
	            		
	            		if(colNameArr[0][10].equals("01"))
	            		{
	            			accessModel1="selected";
	            		}else if(colNameArr[0][10].equals("02"))
	            		{
	            			accessModel2="selected";
	            		}else if(colNameArr[0][10].equals("03"))
	            		{
	            			accessModel3="selected";
	            		}
	            		else if(colNameArr[0][10].equals("04"))
	            		{
	            			accessModel4="selected";
	            		}
	            	%>
          					<option value='01' <%=accessModel1%>  >SMS</option>
          					<option value='02' <%=accessModel2%>  >WAP</option>
          					<option value='03' <%=accessModel3%>  >MMS</option>
          					<option value='04' <%=accessModel4%>  >����</option>
	              	</select>
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue">���������</TD>
	            <TD>
	              	<input type="text" name="accNum"  v_type="int" v_must="1" v_minlength="8" v_maxlength="128"  maxlength="128" value="<%=colNameArr[0][2]%>" class="InputGrey" readonly >	
	            </TD> 
	             <TD class="blue">��������ԣ�</TD>
				<TD>  
					<select name="BaseServCodeProp" style="width:133px;" disabled > 
	        <%          String accessType1="";
	            		String accessType2="";
	            		String accessType3="";
	            		
	            		
	            		if(colNameArr[0][3].equals("01"))
	            		{
	            			accessType1="selected";
	            		}else if(colNameArr[0][3].equals("02"))
	            		{
	            			accessType2="selected";
	            		} else if(colNameArr[0][3].equals("03"))
	            		{
	            			accessType3="selected";
	            		}   
	         %>   		  
	         			<option value='01' <%=accessType1%>  >����</option>
          				<option value='02' <%=accessType2%>  >����</option>
          				<option value='03' <%=accessType3%>  >WAPPush</option> 
          		</select>
	            </TD>	
	            </TR>
	             <TR id="YYYY" name="YYYY" class="YYYY">					
								<TD class="blue">����</TD>
	            	<TD>
	              	<input type="text" name="price" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="9" maxlength="9" value="<%=colNameArr[0][16]%>" >&nbsp;<font color="orange">*</font>	
	            	(Ԫ)
	            	</TD>	 
	         			<TD class="blue">�Ʒ�����</TD>
	            	<TD>
	            	<%
	            		String btFlag1="";
	            		String btFlag2="";
	            		String btFlag3="";
	            		
	            		if(colNameArr[0][17].equals("00"))
	            		{
	            			btFlag1="selected";
	            		}else if(colNameArr[0][17].equals("01"))
	            		{
	            			btFlag2="selected";
	            		}else if(colNameArr[0][17].equals("02"))
	            		{
	            			btFlag3="selected";
	            		}
	            	%>
	            	<select name="billingType"  onchange="changeRBList()" >
          					<option value='00' <%=btFlag1%> >���</option>
          					<option value='01' <%=btFlag2%> >����</option>
          					<option value='02' <%=btFlag3%> >����</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
	         </TR>
	         <TR>
				<TD class="blue">ҵ�����ȼ�</TD>
	            <TD>
	              	<select name="bizPRI">
	           		 	<option value='00'>00</option>
	      					<option value='01'>01</option>
	      					<option value='02'>02</option>
	      					<option value='03'>03</option>
	      					<option value='04'>04</option>
	      					<option value='05'>05</option>
	      					<option value='06'>06</option>
	      					<option value='07'>07</option>
	      					<option value='08'>08</option>
	      					<option value='09'>09</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	         								    		            	              
	         
	         
	          
	         	<TD class="blue">ҵ��״̬</TD>
	            <TD>
	            	
	            	<%
	            		String bsFlag1="";
	            		String bsFlag2="";
	            		String bsFlag3="";
	            		String bsFlag4="";
	            		
	            		if(colNameArr[0][18].equals("A"))
	            		{
	            			bsFlag1="selected";
	            		}else if(colNameArr[0][18].equals("S"))
	            		{
	            			bsFlag2="selected";
	            		}else if(colNameArr[0][18].equals("T"))
	            		{
	            			bsFlag3="selected";
	            		}
	            		else if(colNameArr[0][18].equals("R"))
	            		{
	            			bsFlag4="selected";
	            		}
	            	%>
	            	<select name="bizStatus">
      					<option value='A' <%=bsFlag1%> >��������</option>
      					<option value='S' <%=bsFlag2%> >�ڲ�����</option>
      					<option value='T' <%=bsFlag3%> >���Դ���</option>
      					<option value='R' <%=bsFlag4%> >������</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
	           </TR>
	         
	       
	            
	         <TR id="line_1"> 
	            <TD class="blue">��������</TD>
	            <TD>
	            	<select name="netAttr" style="width:133px;" disabled >
	            		<%
	            		if(netArr!=null) {
		            		for(int i = 0; i < netArr.length; i++)
										{		  
		            		%>
          					<option value="<%=netArr[i][0]%>" <%if(colNameArr[0][9].equals(netArr[i][0])){out.println("selected");}%> )><%=netArr[i][1]%></option>
          			<%	}
          			}else
          				{
          				%>
          				<option ></option>
          				<%
          				}
          			%>	
	              	</select>
	            </TD>	  	         								    		            	              
	         
	         	<TD class="blue" >ҵ�񿪷����</TD>
                   <TD > 
              	<%
              	if(colNameArr[0][11].equals("0"))
	            		{%>
	            			<input type="hidden" name="bizType" value="0" >����EC
	            			<%
	            		}else if(colNameArr[0][11].equals("1"))
	            		{%>
	            			<input type="hidden" name="bizType" value="1" >�������
	            			<%
	            		}
	            		%>
	            </TD>		 		
	         </TR>
	         <TR>
	        
	            <TD class="blue">��Чʱ��</TD>
	            <TD>
	              	<input type="text" name="oprEffTime" maxlength="8" value="<%=colNameArr[0][14].substring(0,8)%>" >&nbsp;<font color="orange">*</font>&nbsp;(��ʽ��yyyymmdd)	
	            </TD>			
	            <TD class="blue">�������� </TD>
	          <TD>
					<input name="grpParamSet" type="hidden" value="<%=colNameArr[0][1]%>" size="16" maxlength=8 readonly v_type="string">
					<input name="grpParamSetName" type="text" value="<%=grpParamSetName%>" size="16" v_must="1"  maxlength=8 readonly class="InputGrey" v_type="string">
					<input type="button" class="b_text" name="checkFatherBtn1" value="��ѯ" onClick="getParamSet(1)" >&nbsp;<font color="orange">*</font>
	        </TD>	 
	       </TR>
	       <TR id="XXXX" name="XXXX" class="XXXX"> 
							<TD class="blue">ҵ������</TD>
	             <TD >
	            	<%
	            		String rBList1="";
	            		String rBList2="";
	            		String rBList3="";
	            		String rBList4="";
	            	if(colNameArr[0][19].equals("1"))
	            		{
	            			rBList1="selected";
	            		}else if(colNameArr[0][19].equals("2"))
	            		{
	            			rBList2="selected";
	            		}else if(colNameArr[0][19].equals("3"))
	            		{
	            			rBList3="selected";
	            		}else if(colNameArr[0][19].equals("4"))
	            		{
	            			rBList4="selected";
	            		}
	            		
	            	%>
	            	<select name="rBList" style="width:133px;" disabled >
          					<option value='1' <%=rBList1%> >�����԰�����</option>
          					<option value='2' <%=rBList2%> >������</option>
          					<option value='3' <%=rBList3%> >���ƴ���������</option>
          					<option value='4' <%=rBList4%> >�㲥ҵ��</option>
	              	</select>&nbsp;
	            	
	            </TD>	 
	         		<TD class="blue">�����·�������</TD>
	            <TD  height = 20>
	              	<input type="text" name="LimitAmount"  maxlength="12" v_type="0_9" v_must="0" v_minlength="0" v_maxlength="12" v_name="�����·�����" value="<%=colNameArr[0][22]%>">&nbsp;
	           </TD>	
	         	 
	         		
	            </TR>
	          <TR id="cylx1"  name="cylx1" >	
	          	<TD class="blue" >��Ա����</TD>
              <TD  colspan="3" > 
              	<%
              	if(colNameArr[0][20].equals("0"))
	            		{%>
	            			<input type="hidden" name="CreateFlag" value="0"  >B-C/P��
	            			<%
	            		}else if(colNameArr[0][20].equals("1"))
	            		{%>
	            			<input type="hidden" name="CreateFlag" value="1"  >B-E/M��
	            			<%
	            		}
	            		%>
	            </TD>
	          	</TR>    
	         <TR id="line_1">	         	
				<TD class="blue">SIProvision��URL</TD>
	            <TD colspan="3">
	              	<input type="text" name="provURL" maxlength="128" value="<%=colNameArr[0][6]%>" size="101">&nbsp;&nbsp;(��120���ַ�)
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue">ҵ��ʹ�÷�������</TD>
	            <TD colspan="3">
	              	<input type="text" name="usageDesc" v_type="string"  v_minlength="1" v_maxlength="512" maxlength="512" value="<%=colNameArr[0][7]%>" size="101">&nbsp;&nbsp;(��500���ַ�)	
	            </TD> 					         								    		            	              
	         </TR>
	         
	         <TR id="line_1">	         	 
				<TD class="blue">ҵ��Ľ�����ַ</TD>
	            <TD colspan="3">
	              	<input type="text" name="introURL" maxlength="128" value="<%=colNameArr[0][8]%>" size="101">&nbsp;&nbsp;(��120���ַ�)
	            </TD>	         								    		            	              
	         </TR>
	         
	        <%          if("1".equals(colNameArr[0][11]))
             {
%>
				<TR   id="line_1">
	         	<TD class="blue" >�Ƿ���Ԥ����ҵ��</TD>
	            <TD >
	              	<%
	              	   String isPreflag1="";
	              	   String isPreflag2="";
	              	   if(colNameArr[0][29].equals("0"))
	              	   {
	              	       isPreflag1="selected";
	              	   }else if(colNameArr[0][29].equals("1"))
	              	   {
	              	   	   isPreflag2="selected";
	              	   }
	                %>
	              	  <select name="isPrepay" style="width:133px; "  >
          					<option value='0' <%=isPreflag1%> >��</option>
          					<option value='1' <%=isPreflag2%> >��</option>
          					
	              	</select>&nbsp; 
	            </TD>
	            <TD class="blue">ȱʡǩ�����ԣ�</TD>
	            <TD>
	            	<%
	            		String DefaultSignflag1="";
	            		String DefaultSignflag2="";
	            		
	            		
	            		if(colNameArr[0][26].equals("1"))
	            		{
	            			DefaultSignflag1="selected";
	            		}else if(colNameArr[0][26].equals("2"))
	            		{
	            			DefaultSignflag2="selected";
	            		}
	            	%>
	            	<select name="defaultSign" style="width:133px;"   >
          					<option value='1' <%=DefaultSignflag1%> >����</option>
          					<option value='2' <%=DefaultSignflag2%> >Ӣ��</option>	
	              	</select>&nbsp;
	            </TD>
	        </TR>
				<TR   id="line_1"> 
	          	<TD class="blue" >Ӣ������ǩ����</TD>
	            <TD  height = 20>
	              	<input type="text" name="TextSignEn"  maxlength="30" v_type="string" v_must="1" v_minlength="1" v_maxlength="30" v_name="Ӣ������ǩ��" value="<%=colNameArr[0][27]%>">&nbsp;<font color="#FF0000">*</font>
	           </TD>	
                <TD class="blue" >��������ǩ����</TD>
	            <TD >
	              	<input type="text" name="TextSignZh"  v_type="string" v_must="1" v_minlength="1" v_maxlength="30" v_name="��������ǩ��" maxlength="30" value="<%=colNameArr[0][28]%>" >&nbsp;	<font color="#FF0000">*</font>
	            </TD>	         								    		            	              
	         </TR>
	         <TR   id="line_1">
	         	<TD class="blue" >�Ƿ�֧������ǩ����</TD>
	            <TD >
	              	<%
	              	   String ISTextSignflag1="";
	              	   String ISTextSignflag2="";
	              	   if(colNameArr[0][25].equals("0"))
	              	   {
	              	       ISTextSignflag1="selected";
	              	   }else if(colNameArr[0][25].equals("1"))
	              	   {
	              	   	   ISTextSignflag2="selected";
	              	   }
	                %>
	              	  <select name="ISTextSign" style="width:133px;"   >
          					<option value='0' <%=ISTextSignflag1%> >��֧��</option>
          					<option value='1' <%=ISTextSignflag2%> >֧��</option>
          					
	              	</select>&nbsp; 
	            </TD>
	            <TD class="blue">ҵ�����ż�Ȩ��ʽ��</TD>
	            <TD >
	            	<%
	            		String AuthModeflag1="";
	            		String AuthModeflag2="";
	            		
	            		
	            		if(colNameArr[0][21].equals("1"))
	            		{
	            			AuthModeflag1="selected";
	            		}else if(colNameArr[0][21].equals("2"))
	            		{
	            			AuthModeflag2="selected";
	            		}
	            	%>
	            	<select name="AuthMode" style="width:133px;"  >
          					<option value='1' <%=DefaultSignflag1%> >��ȷƥ��</option>
          					<option value='2' <%=DefaultSignflag2%> >ģ��ƥ��</option>	
	              	</select>&nbsp;
	            </TD>
	        </TR>
				<TR   id="line_1"> 
	          	<TD class="blue" >ÿ���·������������</TD>
	            <TD  >
	              	<input type="text" name="MaxItemPerDay"  maxlength="12" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="12" v_name="ÿ���·����������" value="<%=colNameArr[0][23]%>">&nbsp;<font color="#FF0000">*</font>
	           </TD>	
                <TD class="blue" >ÿ���·������������</TD>
	            <TD >
	              	<input type="text" name="MaxItemPerMon"�� v_type="0_9" v_must="1" v_minlength="0" v_maxlength="12" v_name="ÿ���·����������" maxlength="12" value="<%=colNameArr[0][24]%>" >&nbsp;<font color="#FF0000">*</font>	
	            </TD>	         								    		            	              
	         </TR>
	         <TR   id="line_1"> 
	          	 <TD class="blue" >ҵ�����ţ�</TD>
	            <TD colspan="3" >
	              	<input type="text" name="accessNumber" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="128" v_name="ҵ������"  value="<%=colNameArr[0][30]%>" >&nbsp;<font color="#FF0000">*</font>	
	            </TD>	         								    		            	              
	         </TR>
	         <TD class="blue" >�������·�ʱ����б�</TD>
	              <TD colspan="3" >
	              	<input type="text" name="InvalidTimeSpanList" maxlength="128" value="" size="60" readOnly>&nbsp;	              
	                </TD>	
	                        								    		            	              
	         </TR>
	         <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD  class="blue">����ҵ��ָ�</TD>
	              <TD colspan="3" >
	              	<input type="text" name="MOList" maxlength="128" value="" size="60" readOnly>&nbsp;	            
	                </TD>	
	                       								    		            	              
	         </TR>
	        
<%          }
%>	  
	         
		</TABLE>	       
		

		<TABLE cellSpacing=0>
			 <TR id='footer'> 
	         	<TD> 		      
	         	    <input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="�ر�" onClick="javascript:window.close()">	         	    	         	     		         	     	         	   
			 	</TD>
	       </TR>
	    </TABLE>	   	
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%}
}else{%>

	<script language='jscript'>
	          rdShowMessageDialog("������Ϣ��<%=retMsg%>",0);		          
	           parent.location="f2896_1.jsp"; 
	      </script>   
	<% }%>
 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-11 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String opCode = "1110";		
		String opName = "һ��˫�Ŷ�Ӧ��ϵ";	//header.jsp��Ҫ�Ĳ��� 	
		String workNo = (String)session.getAttribute("workNo"); 
		String regionCode=(String)session.getAttribute("regCode");  	
		String login_accept=request.getParameter("login_accept");	
%>  

<%
	
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String error_code="444444";	

	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
		
	String[][] result = new String[][]{};
	String[][] result_detail = new String[][]{};
	
	String[][] input_paras = new String[1][6];  
	String[][] recv_num = new String[3][2];
	
	String opType = request.getParameter("opType");			//��������
	String phoneType = "0";	//�������� 0--������1--����
	String phoneNo = request.getParameter("mainPhoneNo");	//���ֻ�����
    	String oprType_Add = "A";
    	String oprType_Upd = "U";
    	String orgCode = request.getParameter("orgCode");		//��������

	String op_code = "1110";
	
	String region_code="";
	
	String addMainCustName ="";
	String addMainSimNo ="";
	String addMainImsiNo ="";
	                         
	String addAppendPhoneNo ="";
	String addAppendCustName ="";
	String addAppendSimNo ="";
	String addAppendImsiNo ="";
	
	if( opType.equals(oprType_Add) ){//����
		valid = 0;
	
		addMainCustName =request.getParameter("mainCustName");
		addMainSimNo =request.getParameter("mainSimNo");
		addMainImsiNo =request.getParameter("mainImsiNo");
		
		addAppendPhoneNo =request.getParameter("appendPhoneNo");
		addAppendCustName =request.getParameter("appendCustName");
		addAppendSimNo =request.getParameter("appendSimNo");
		addAppendImsiNo =request.getParameter("appendImsiNo");
	}else{

		input_paras[0][0] = opType;	 
		input_paras[0][1] = phoneType;	
		input_paras[0][2] = phoneNo;	
		input_paras[0][3] = workNo;
		input_paras[0][4] = orgCode;
		input_paras[0][5] = op_code;
	
		if( opType.equals(oprType_Upd) ){//�޸�
			recv_num = new String[2][2];
		  	//[0]:��ʼλ��,[1]:����
			recv_num[0][0] = "0";
			recv_num[0][1] = "2";	
			recv_num[1][0] = "2";
			recv_num[1][1] = "7";	
		}else{
			recv_num = new String[3][2];
		  	//[0]:��ʼλ��,[1]:����
			recv_num[0][0] = "0";
			recv_num[0][1] = "2";	
			recv_num[1][0] = "2";
			recv_num[1][1] = "7";
			recv_num[2][0] = "9";
			recv_num[2][1] = "8";
		}


		
    		region_code = orgCode.substring(0,2);	
	
		for(int i=0; i<input_paras[0].length; i++){
			
			if( input_paras[0][i] == null ){
				input_paras[0][i] = "";
			}
			
		}
	 
  		//al = oneboss.get_commDyn( region_code, op_code,"s1110Qry",recv_num,input_paras ); 		
  		
  	%>
  		<wtc:service name="s1110Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="17" >
			<wtc:param value="<%=opType%>"/>
			<wtc:param value="<%=phoneType%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=op_code%>"/>
		</wtc:service>
		<wtc:array id="al" start="0" length="2" scope="end"/>
		<wtc:array id="result1" start="2" length="7" scope="end"/>
		<wtc:array id="result_detail1" start="9" length="8" scope="end"/>
  	<%

	 	if( al == null ){	 	
			valid = 1;
		}else{
			
			//errCodeMsg = (String[][])al.get(0);
			//error_code = errCodeMsg[0][0];
			error_code=retCode2;
		//System.out.println("=====test=error_code="+error_code);	
	
			if( !error_code.equals("000000")){
				valid = 2;
				//error_msg = errCodeMsg[0][1];
				error_msg=retMsg2;
			}else{
				valid = 0;
				//result = (String[][])al.get(1);	
				result=result1;
				
				if( opType.equals(oprType_Upd) ){//�޸�
					;
				}else{
					result_detail=result_detail1;
					//result_detail = (String[][])al.get(2);	
				}		
	
			}
		}

	}//	end .opType.equals("A")
%>

<%if( valid != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>�������:["+"<%=error_code %>]</br>"+"������Ϣ:["+"<%=error_msg %>"+"]",0);
	history.go(-1);
//-->
</script>
<%}%>    
<HTML>
	<HEAD>
		<TITLE>������BOSS-����</TITLE>

		<SCRIPT type=text/javascript>
		//-----------------------------
		
			function fillSelectUseValue_noArr(fillObject,indValue)
			{	
					for(var i=0;i<document.all(fillObject).options.length;i++){
						if(document.all(fillObject).options[i].value == indValue){
							document.all(fillObject).options[i].selected = true;
							break;
						}
					}							
			}
			
			function init()
			{
			
				fillSelectUseValue_noArr("opType","<%=opType%>");
				document.frm1110.opType.disabled = true;    
			}
			
			function jspCommit()
			{
					document.frm1110.bakOpType.value = document.frm1110.opType.value;
					frm1110.action="f1110_3.jsp";
					frm1110.submit();
			}
		//========================================
		</SCRIPT>
	</HEAD>
<body  onload="init()">
	<FORM method=post name="frm1110" action="f1110_2.jsp">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">һ��˫�Ź�ϵ��Ӧ</div>
		</div>		
      	<table cellspacing="0">
           <tbody> 
            <tr > 
                <td width="16%" class="blue">ҵ������</td>
                <td width="84%">һ��˫�Ź�ϵ��Ӧ</td> 
              </tr>
            </tbody> 
         </table>  
        
        <table cellspacing="0">
          <TBODY>
            <TR> 
              <TD width=16%  class="blue">��������</TD>
              <TD width="34%"> 
              	<select align="left" name="opType" id="opType" width=50 >
                  <option  value="A">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</option>
                  <option  value="Q">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ѯ</option>
                  <option  value="D">ɾ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</option>
                </select> </TD>
              <TD>&nbsp;</TD>
              <TD>&nbsp;</TD>
            </TR>
            <TR> 
              <TD width=16%  class="blue">���������</TD>
              <TD width="34%"> 
              	<input  name=mainPhoneNo value="<%=phoneNo%>" readonly class="InputGrey"> 
                <input name=infoQuery type=button  onclick="getInfo()" style="cursor:hand" value=��ѯ disabled> 
              </TD>
              <TD  class="blue">���ͻ�����</TD>
              <TD>
              	<input  name=mainCustName size=35 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainCustName);}else{ if(valid==0) out.println(result[0][0]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR > 
              <TD  class="blue">��SIM����</TD>
              <TD>
              	<input  name=mainSimNo size=30 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainSimNo);}else{ if(valid==0) out.println(result[0][1]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">��IMSI��</TD>
              <TD>
              	<input  name=mainImsiNo value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainImsiNo);}else{ if(valid==0) out.println(result[0][2]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR> 
              <TD  class="blue">���������</TD>
              <TD>
              	<input  name=appendPhoneNo value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendPhoneNo);}else{ if(valid==0) out.println(result[0][3]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">���ͻ�����</TD>
              <TD>
              	<input  name=appendCustName size=35 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendCustName);}else{ if(valid==0) out.println(result[0][4]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR> 
              <TD  class="blue">��SIM����</TD>
              <TD>
              	<input  name=appendSimNo size=30 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendSimNo);}else{ if(valid==0) out.println(result[0][5]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">��IMSI��</TD>
              <TD>
              	<input  name=appendImsiNo value=
              "<%if( opType.equals(oprType_Add) ){out.println(addAppendImsiNo);}else{ if(valid==0) out.println(result[0][6]);}%>" readonly class="InputGrey"></TD>
            </TR>
          </TBODY>
        </TABLE> 
 
<!----------------------------
  		2���ͻ�������3��SIM���š�4��IMSI�š�5���ֻ����롢
              6���ͻ�������7��SIM���š�8��IMSI�š�9SIM���š�10�����롢11�����롢12�޸Ĺ��š�
              13�޸���ˮ��14�޸�ʱ�䡢15����ģ�顢16�޸�����  
------------------------------>  
	
        <TABLE  cellSpacing=0>
          <TBODY> 
          	<TR   align="center">
          		<Th>��SIM��</Th>
          		<Th>������</Th>
          		<Th>������</Th>
          		<Th>��������</Th>
          		<Th>������ˮ</Th>
          		<Th>����ʱ��</Th>
          		<Th>����ģ��</Th>
          		<Th>��������</Th>
          	</TR> 
<%
			for(int i=0;i<result_detail.length;i++)
			{
				if(i%2 == 0)
				{	out.print("<TR  align='center'>");				}
				else
				{	out.print("<TR  align='center'>");				}
				for(int j=0;j<result_detail[0].length;j++)
				{
					out.print("<TD>" + result_detail[i][j] + "</TD>");
				}
				out.print("</TR>");
			}	
%>     	         	     	         	     	         	     	         	     	         	          	          	
          </TBODY>
        </TABLE>  
        <TABLE  cellSpacing=0>
          <TBODY>
            <TR> 
            <TD width=16%  class="blue">��ע</TD>
            <TD>
              <input  name=sysNote size=75 readonly maxlength="60" class="InputGrey">
            </TD>                          
      	   </tr>
          </TBODY>
        </TABLE>        
                                           
        <!----------------------------------------------------------->                
        <TABLE cellSpacing=0>
          <TBODY>
            <TR> 
              <TD id="footer" >
              	<input  name=print  onClick="jspCommit()" class="b_foot"
			style="cursor:hand" type=button value=ȷ��
<%
						if(opType.compareTo("Q") == 0)
						{	
%>                     
							disabled
<%
						}
%>							   
                        >&nbsp;
              <input  name=reset class="b_foot" onClick="history.go(-1);" style="cursor:hand" type=button value=���>&nbsp;
              <input  name=back class="b_foot" style="cursor:hand" onClick="removeCurrentTab()" type=button value=�ر�>&nbsp;
             </TD>
            </TR>
          </TBODY>
        </TABLE>
  	<!------------------------> 
  		<input type="hidden" name=opNote  size=75 maxlength="60" >
  		<input type="hidden" name="bakOpType" value="<%=opType%>">  			<!--��������-->     
  		<input type="hidden" name="loginNo" value="<%=workNo%>">  				<!--����-->     
  		<input type="hidden" name="orgCode" value="<%=orgCode%>">  				<!--��������-->  
  		<input type="hidden" name="login_accept" value="<%=login_accept%>">
  	<!------------------------>   
     
    	 <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>

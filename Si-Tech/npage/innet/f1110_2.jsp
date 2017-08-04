 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-11 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String opCode = "1110";		
		String opName = "一卡双号对应关系";	//header.jsp需要的参数 	
		String workNo = (String)session.getAttribute("workNo"); 
		String regionCode=(String)session.getAttribute("regCode");  	
		String login_accept=request.getParameter("login_accept");	
%>  

<%
	
	String error_msg="系统错误，请与系统管理员联系，谢谢!!";
	String error_code="444444";	

	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
		
	String[][] result = new String[][]{};
	String[][] result_detail = new String[][]{};
	
	String[][] input_paras = new String[1][6];  
	String[][] recv_num = new String[3][2];
	
	String opType = request.getParameter("opType");			//操作类型
	String phoneType = "0";	//号码类型 0--主卡；1--副卡
	String phoneNo = request.getParameter("mainPhoneNo");	//主手机号码
    	String oprType_Add = "A";
    	String oprType_Upd = "U";
    	String orgCode = request.getParameter("orgCode");		//机构代码

	String op_code = "1110";
	
	String region_code="";
	
	String addMainCustName ="";
	String addMainSimNo ="";
	String addMainImsiNo ="";
	                         
	String addAppendPhoneNo ="";
	String addAppendCustName ="";
	String addAppendSimNo ="";
	String addAppendImsiNo ="";
	
	if( opType.equals(oprType_Add) ){//增加
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
	
		if( opType.equals(oprType_Upd) ){//修改
			recv_num = new String[2][2];
		  	//[0]:开始位置,[1]:列数
			recv_num[0][0] = "0";
			recv_num[0][1] = "2";	
			recv_num[1][0] = "2";
			recv_num[1][1] = "7";	
		}else{
			recv_num = new String[3][2];
		  	//[0]:开始位置,[1]:列数
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
				
				if( opType.equals(oprType_Upd) ){//修改
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
	rdShowMessageDialog("<br>错误代码:["+"<%=error_code %>]</br>"+"错误信息:["+"<%=error_msg %>"+"]",0);
	history.go(-1);
//-->
</script>
<%}%>    
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-入网</TITLE>

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
			<div id="title_zi">一卡双号关系对应</div>
		</div>		
      	<table cellspacing="0">
           <tbody> 
            <tr > 
                <td width="16%" class="blue">业务类型</td>
                <td width="84%">一卡双号关系对应</td> 
              </tr>
            </tbody> 
         </table>  
        
        <table cellspacing="0">
          <TBODY>
            <TR> 
              <TD width=16%  class="blue">操作类型</TD>
              <TD width="34%"> 
              	<select align="left" name="opType" id="opType" width=50 >
                  <option  value="A">增&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加</option>
                  <option  value="Q">查&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;询</option>
                  <option  value="D">删&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;除</option>
                </select> </TD>
              <TD>&nbsp;</TD>
              <TD>&nbsp;</TD>
            </TR>
            <TR> 
              <TD width=16%  class="blue">主服务号码</TD>
              <TD width="34%"> 
              	<input  name=mainPhoneNo value="<%=phoneNo%>" readonly class="InputGrey"> 
                <input name=infoQuery type=button  onclick="getInfo()" style="cursor:hand" value=查询 disabled> 
              </TD>
              <TD  class="blue">主客户名称</TD>
              <TD>
              	<input  name=mainCustName size=35 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainCustName);}else{ if(valid==0) out.println(result[0][0]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR > 
              <TD  class="blue">主SIM卡号</TD>
              <TD>
              	<input  name=mainSimNo size=30 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainSimNo);}else{ if(valid==0) out.println(result[0][1]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">主IMSI号</TD>
              <TD>
              	<input  name=mainImsiNo value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addMainImsiNo);}else{ if(valid==0) out.println(result[0][2]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR> 
              <TD  class="blue">副服务号码</TD>
              <TD>
              	<input  name=appendPhoneNo value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendPhoneNo);}else{ if(valid==0) out.println(result[0][3]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">副客户名称</TD>
              <TD>
              	<input  name=appendCustName size=35 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendCustName);}else{ if(valid==0) out.println(result[0][4]);}%>" readonly class="InputGrey"></TD>
            </TR>
            <TR> 
              <TD  class="blue">副SIM卡号</TD>
              <TD>
              	<input  name=appendSimNo size=30 value=
              	"<%if( opType.equals(oprType_Add) ){out.println(addAppendSimNo);}else{ if(valid==0) out.println(result[0][5]);}%>" readonly class="InputGrey"></TD>
              <TD  class="blue">副IMSI号</TD>
              <TD>
              	<input  name=appendImsiNo value=
              "<%if( opType.equals(oprType_Add) ){out.println(addAppendImsiNo);}else{ if(valid==0) out.println(result[0][6]);}%>" readonly class="InputGrey"></TD>
            </TR>
          </TBODY>
        </TABLE> 
 
<!----------------------------
  		2主客户姓名、3主SIM卡号、4主IMSI号、5副手机号码、
              6副客户姓名、7副SIM卡号、8副IMSI号、9SIM卡号、10主号码、11副号码、12修改工号、
              13修改流水、14修改时间、15操作模块、16修改类型  
------------------------------>  
	
        <TABLE  cellSpacing=0>
          <TBODY> 
          	<TR   align="center">
          		<Th>主SIM卡</Th>
          		<Th>主号码</Th>
          		<Th>副号码</Th>
          		<Th>操作工号</Th>
          		<Th>操作流水</Th>
          		<Th>操作时间</Th>
          		<Th>操作模块</Th>
          		<Th>操作类型</Th>
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
            <TD width=16%  class="blue">备注</TD>
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
			style="cursor:hand" type=button value=确认
<%
						if(opType.compareTo("Q") == 0)
						{	
%>                     
							disabled
<%
						}
%>							   
                        >&nbsp;
              <input  name=reset class="b_foot" onClick="history.go(-1);" style="cursor:hand" type=button value=清除>&nbsp;
              <input  name=back class="b_foot" style="cursor:hand" onClick="removeCurrentTab()" type=button value=关闭>&nbsp;
             </TD>
            </TR>
          </TBODY>
        </TABLE>
  	<!------------------------> 
  		<input type="hidden" name=opNote  size=75 maxlength="60" >
  		<input type="hidden" name="bakOpType" value="<%=opType%>">  			<!--操作代码-->     
  		<input type="hidden" name="loginNo" value="<%=workNo%>">  				<!--工号-->     
  		<input type="hidden" name="orgCode" value="<%=orgCode%>">  				<!--机构编码-->  
  		<input type="hidden" name="login_accept" value="<%=login_accept%>">
  	<!------------------------>   
     
    	 <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>

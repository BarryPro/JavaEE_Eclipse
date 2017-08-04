<%
/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.15
 模块:用户办理开关业务
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<!----------------------正文--------------------->
<body>
<%  //----head 标题及opcode
    String pageName="梦网业务开关设置";
    String opName = "用户办理开关业务";
    String opCode = "1984";
    String message="";
    System.out.println(pageName + "::start");
%>

<%
    String phone_no = request.getParameter("phone_no");
    String user_passwd = (String)session.getAttribute("password");
    String LoginNo  = (String)session.getAttribute("workNo");
    String Org_code =(String)session.getAttribute("orgCode");
%>


 <!-----------正文-------->
<%

String ip_address=(String)session.getAttribute("ipAddr");
String errCode = "";
String errMsg = "";
String[][] result1Temp = null; 
String []switch_type     = null;
String []switch_name   = null;
String owner_name="";
String run_name="";
String sm_code="";
String sm_name="";
String belong_code="";
String tfc_code = "";
String cust_id="";
String id_no = "";


//--------免填单变量-----
String ret=     "";
String Msg  =       "";
String func_name=       "";
String cust_name =      "";
String id_iccid  =      "";
String sim_no =         "";
String mode_name3  =    "";
String cust_address=     "";
String prn_note  =      "";
String note1   =        "";
String login_accept=    "";
String in_content_str = "";

String paramsOut0 = null;
String paramsOut1 = null;
String paramsOut2 = null;
String paramsOut3 = null;
String paramsOut4 = null;
String paramsOut5 = null;
String paramsOut6 = null;
String paramsOut7 = null;
String paramsOut14 = null;

String[][] paramsOut8 = null;
String[][] paramsOut9 = null;
String[][] paramsOut10= null;
String[][] paramsOut11= null;
String[][] paramsOut12= null;
String[][] paramsOut13= null;

String flag199 = "";

StringBuffer fieldCode=new StringBuffer();


//---------------------------
if (phone_no != null && !phone_no.equals("")) {

		String[] paramsIn = new String[]  {Org_code,
		                                   LoginNo,
		                                   user_passwd,
		                                   ip_address,
		                                   opCode,
		                                   phone_no};

        //retArray=callView.callFXService("s1984PhoneOut", paramsIn, "15");
%>
		<wtc:service name="s1984PhoneOut" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="15">			
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>	
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>	
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>		
		</wtc:service>	
		<wtc:array id="result1" start="0" length="8" scope="end"/>
		<wtc:array id="result8" start="8" length="1" scope="end"/>
		<wtc:array id="result9" start="9" length="1" scope="end"/>
		<wtc:array id="result10" start="10" length="1" scope="end"/>
		<wtc:array id="result11" start="11" length="1" scope="end"/>
		<wtc:array id="result12" start="12" length="1" scope="end"/>
		<wtc:array id="result13" start="13" length="1" scope="end"/>
		<wtc:array id="result14" start="14" length="1" scope="end"/>
<%

        errCode = retCode1;
        errMsg = retMsg1;
        System.out.println("errCode======"+errCode);
       	System.out.println("errMsg======"+errMsg);
        result1Temp = result1;
        if (errCode.equals("000000") && result1.length>0) {
            paramsOut0=result1[0][0];                                    
            paramsOut1=result1[0][1];                                    
            paramsOut2=result1[0][2];                                    
            paramsOut3=result1[0][3];                                    
            paramsOut4=result1[0][4];                                    
            paramsOut5=result1[0][5];                                    
            paramsOut6=result1[0][6];                                    
            paramsOut7=result1[0][7];                                    

            paramsOut8 =result8;
            paramsOut9 =result9;
            paramsOut10=result10;
            paramsOut11=result11;
            paramsOut12=result12;
            paramsOut13=result13;
            
            paramsOut14=result14[0][0];

            System.out.println("paramsOut0="+paramsOut0);
            System.out.println("paramsOut1="+paramsOut1);
            System.out.println("paramsOut2="+paramsOut2);
            System.out.println("paramsOut3="+paramsOut3);
            System.out.println("paramsOut4="+paramsOut4);
            System.out.println("paramsOut5="+paramsOut5);
            System.out.println("paramsOut6="+paramsOut6);
            System.out.println("paramsOut7="+paramsOut7);

            for (int i=0; i<paramsOut8.length; i++){
                System.out.println("paramsOut8[0]["+i+"]="+paramsOut8[i][0]);
            }
            for (int i=0; i<paramsOut9.length; i++){
                System.out.println("paramsOut9[0]["+i+"]="+paramsOut9[i][0]);
            }
            for (int i=0; i<paramsOut10.length; i++){
                System.out.println("paramsOut10[0]["+i+"]="+paramsOut10[i][0]);
            }
            for (int i=0; i<paramsOut11.length; i++){
                System.out.println("paramsOut11[0]["+i+"]="+paramsOut11[i][0]);
            }
            for (int i=0; i<paramsOut12.length; i++){
                System.out.println("paramsOut12[0]["+i+"]="+paramsOut12[i][0]);
            }
            for (int i=0; i<paramsOut13.length; i++){
                System.out.println("paramsOut13[0]["+i+"]="+paramsOut13[i][0]);
            }

        } else {
            errMsg = "[" + errCode + "][" + errMsg + "]";
        }

        flag199 = paramsOut13[0][0];
        
        for (int i=0;i<paramsOut8.length;i++){
				fieldCode.append(paramsOut8[i][0]+"|");
				System.out.println("============:"+paramsOut8[i][0]);
			}
        
    }

    if (errCode.equals("000000") && result1Temp.length>0) {
%>

<form action="" method="post" name="form1" >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">客户信息</div>
		</div>
 	
<table cellspacing="0">
        <tr>
            <td class="blue">手机号码</td>
            <td>
                <input class="InputGrey" type="text" name="phone_no" v_must=1 v_type="id_no"  readonly value="<%=phone_no%>"/>
            </td>
            <td class="blue">客户　ID</td>
            <td>
                <input class="InputGrey" type="text" name="id_no" size="30" readonly="true" value="<%=paramsOut0%>"/>
            </td>
        </tr>
        <tr>
            <td class="blue">客户姓名</td>
            <td>
                <input class="InputGrey" type="text" name="owner_name" size="30" readonly="true" value="<%=paramsOut2%>"/>
            </td>
            <td class="blue">客户品牌</td>
            <td><input class="InputGrey" type="text" name="sm_name" size="30" readonly="true" value="<%=paramsOut14%>"/>　
            </td>
        </tr>
        
        <tr>
            <td class="blue">客户状态</td>
            <td><input class="InputGrey" type="text" name="run_name" size="30" readonly="true" value="<%=paramsOut3%>"/>
            </td>
            <td class="blue">客户地址</td>
            <td>
                <input class="InputGrey" type="text" name="cust_address" size="30" readonly="true" value="<%=paramsOut7%>"/>
            </td>
        </tr>
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">操作信息</div>
</div>        
        
		<TABLE cellSpacing="0">
				<TR  id="s<%=paramsOut8 [0][0]%>" >
					<TD class="blue"><%=paramsOut9 [0][0]%></TD>
    			   <TD width="16%">
					<input type="radio" name="f<%=paramsOut8 [0][0]%>" value="0" onclick="openOthers()" <%="ZZZZ".equals(paramsOut10[0][0])?"onclick=\"closeOther();\"":""%>>开
					<input type="radio" name="f<%=paramsOut8 [0][0]%>" value="1" onclick="closeOthers()" <%="ZZZZ".equals(paramsOut10[0][0])?"onclick=\"closeOther();\"":""%>>关
				   </TD>
		   	</TR>	  

			<% for (int i=1; i< paramsOut8.length; i++){%>
		    <TR id="s<%=paramsOut8[i][0]%>" >
			   <TD class="blue"><%=(paramsOut9[i][0])%></TD>
			   <TD>
				<input type="radio"  id = "n<%=i%>" name="f<%=paramsOut8 [i][0]%>" value="0" <%="ZZZZ".equals(paramsOut10[i][0])?"onclick=\"closeOther();\"":""%>>开
				<input type="radio"  id = "m<%=i%>" name="f<%=paramsOut8 [i][0]%>" value="1" <%="ZZZZ".equals(paramsOut10[i][0])?"onclick=\"closeOther();\"":""%>>关
			   </TD>
		   	</TR>
		   	<%}%>

		    <TR>
			   <TD class="blue">操作备注</TD>
			   <TD>
				<input type="text" name="op_note" value="<%=phone_no%>用户信息变更" class="InputGrey" readOnly size="40" >
			   </TD>
		   	</TR>
		</TABLE>
		
 
        <INPUT type="hidden" name="id_no" value="<%=id_no%>" />
        <INPUT type="hidden" name="sm_code" value="<%=paramsOut5%>" />
        <INPUT type="hidden" name="belong_code" value="<%=paramsOut6%>" />
        <INPUT type="hidden" name="hand_fee" value="0.00" />
        <INPUT type="hidden" name="tfc_code" value="<%=tfc_code%>" />
        <INPUT type="hidden" name="cust_id" value="<%=paramsOut1%>" />
        
        <INPUT type="hidden" name="switch_type_list" value="0" />
        <INPUT type="hidden" name="switch_type" value="0" />
        
		 <%
        }else{

        %>
        <script>
            rdShowMessageDialog("<%=errMsg%>",0);
            window.location.href="/npage/MessageQuery/s1984/f1984_1.jsp";
        </script>
     	 <%}%>


    <TABLE cellSpacing="0">
        <TR>
            <TD noWrap id="footer">
                <input type="button" name="query" class="b_foot" value="确认&打印" onclick="docheck()" index="9">
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="返回" onclick="history.go(-1)" index="10">
                &nbsp;
                <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" index="13">
            </TD>
        </TR>
    </TABLE>
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
<!------------------------------------->
<script>
onload = function(){
		if (<%=paramsOut13[0][0].equals("1")%>)
	{
		<%for(int i=1; i < paramsOut8.length; i++ ){%>
		document.form1.n<%=i%>.disabled="false";
		document.form1.m<%=i%>.disabled="false";
		<%}%>
	}

	<%for(int i=0; i<paramsOut12.length; i++){%>
		if ("<%=paramsOut12[i][0]%>" == "1"){
			for(var i=0; i< document.form1.f<%=paramsOut8 [i][0]%>.length; i++){
				if (document.form1.f<%=paramsOut8 [i][0]%>[i].value == "0")
					document.form1.f<%=paramsOut8 [i][0]%>[i].checked = true;
			}
		}
		if ("<%=paramsOut13[i][0]%>" == "1"){
			for(var i=0; i< document.form1.f<%=paramsOut8 [i][0]%>.length; i++){
				if (document.form1.f<%=paramsOut8 [i][0]%>[i].value == "1")
					document.form1.f<%=paramsOut8 [i][0]%>[i].checked = true;
			}
		}
    <%}%>
	onloadCloseOther();
}

function closeOthers()
{
	<%for(int i=1; i<paramsOut12.length; i++){%>
		if ("<%=paramsOut12[i][0]%>" == "1"){
			for(var i=0; i< document.form1.f<%=paramsOut8 [i][0]%>.length; i++){
				if (document.form1.f<%=paramsOut8 [i][0]%>[i].value == "0")
					document.form1.f<%=paramsOut8 [i][0]%>[i].checked = true;
			}
		}
		if ("<%=paramsOut13[i][0]%>" == "1"){
			for(var i=0; i< document.form1.f<%=paramsOut8 [i][0]%>.length; i++){
				if (document.form1.f<%=paramsOut8 [i][0]%>[i].value == "1")
					document.form1.f<%=paramsOut8 [i][0]%>[i].checked = true;
			}
		}
    <%}%>
	<%for(int i=1; i < paramsOut8.length; i++ ){%>
		document.form1.n<%=i%>.disabled="false";
		document.form1.m<%=i%>.disabled="false";
	<%}%>
}
function openOthers()
{
	<%for(int i=1; i < paramsOut8.length; i++ ){%>
		document.all.n<%=i%>.removeAttribute("disabled");
		document.all.m<%=i%>.removeAttribute("disabled");
	<%}%>
}


function closeOther()
{
  var value;
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if ("ZZZZ".equals(paramsOut10[i][0])){%>
	for(var i = 0; i < document.form1.f<%=paramsOut8[i][0]%>.length; i ++){
        if (document.form1.f<%=paramsOut8[i][0]%>[i].checked){
            value = document.form1.f<%=paramsOut8[i][0]%>[i].value;
        }
    }
    <%}%>
<%}%>
    if (value == "0"){
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if (!"ZZZZ".equals(paramsOut10[i][0])){%>
        s<%=paramsOut8[i][0]%>.style.visibility="visible"
        s<%=paramsOut8[i][0]%>.style.display   ="block";
        for (var i=0; i < document.form1.f<%=paramsOut8[i][0]%>.length; i++){
        	if (document.form1.f<%=paramsOut8[i][0]%>[i].value == "0")
        		document.form1.f<%=paramsOut8[i][0]%>[i].checked = true;
        }
    <%}%>
<%}%>
	}else if (value == "1"){
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if (!"ZZZZ".equals(paramsOut10[i][0])){%>
        s<%=paramsOut8[i][0]%>.style.visibility="hidden"
        s<%=paramsOut8[i][0]%>.style.display   ="none";
        for (var i=0; i < document.form1.f<%=paramsOut8[i][0]%>.length; i++){
        	if (document.form1.f<%=paramsOut8[i][0]%>[i].value == "0")
        		document.form1.f<%=paramsOut8[i][0]%>[i].checked = true;
        }
    <%}%>
<%}%>
	}
}

function onloadCloseOther()
{
  var value;
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if ("ZZZZ".equals(paramsOut10[i][0])){%>
	for(var i = 0; i < document.form1.f<%=paramsOut8[i][0]%>.length; i ++){
        if (document.form1.f<%=paramsOut8[i][0]%>[i].checked){
            value = document.form1.f<%=paramsOut8[i][0]%>[i].value;
        }
    }
    <%}%>
<%}%>
    if (value == "0"){
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if (!"ZZZZ".equals(paramsOut10[i][0])){%>
        s<%=paramsOut8[i][0]%>.style.visibility="visible"
        s<%=paramsOut8[i][0]%>.style.display   ="block";
    <%}%>
<%}%>
	}else if (value == "1"){
<%for(int i=0; i < paramsOut8.length; i++ ){%>
	<%if (!"ZZZZ".equals(paramsOut10[i][0])){%>
        s<%=paramsOut8[i][0]%>.style.visibility="hidden"
        s<%=paramsOut8[i][0]%>.style.display   ="none";
    <%}%>
<%}%>
	}
}

//界面检查，跳转到查询结果页
function docheck(){
	getAfterPrompt();
    var vSwtchTypeList = "";
    var vSwtchType = "";

    <%for(int i=0; i < paramsOut8.length; i++ ){%>
    var v<%=paramsOut8[i][0]%> = "";
    for(var i=0; i< document.form1.f<%=paramsOut8[i][0]%>.length; i++){
        if (document.form1.f<%=paramsOut8[i][0]%>[i].checked)
            v<%=paramsOut8[i][0]%> = document.form1.f<%=paramsOut8[i][0]%>[i].value;
    }
    vSwtchTypeList = vSwtchTypeList+"<%=paramsOut8[i][0]%>|";
    if (v<%=paramsOut8[i][0]%> == "1")
        vSwtchType = vSwtchType+"1|";
    else if(v<%=paramsOut8[i][0]%> == "0")
        vSwtchType = vSwtchType+"0|";
    <%}%>
    
    document.form1.switch_type_list.value = vSwtchTypeList;
    document.form1.switch_type.value = vSwtchType;


    var prtFlag = rdShowConfirmDialog("是否提交操作?");
    if (prtFlag==1) {
        document.form1.action="f1984_cfm.jsp";
        document.form1.submit();
    } else{
        return false;
    }
}


 </script>

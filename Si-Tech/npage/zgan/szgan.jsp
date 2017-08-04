   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "zgan";
  String opName = "生日关怀参数配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>

<%
//---------------------------------java代码区------------------------------------
//读取session信息
	    
	    String regionCode = (String)session.getAttribute("regCode");
	    String workNo = (String)session.getAttribute("workNo");

	//-----------------------所属地市--------------------------
	String sqlStr="";
	
      sqlStr ="select region_code,region_name from sRegionCode where region_code='?' Order By region_code";

	
  //	retList = impl.sPubSelect("2",sqlStr,"region",regionCode);
%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
  	 <wtc:param value="<%=regionCode%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
  	String[][] retListString = result_t1;

	//----------------------查找出所其他参数配置---------------------------
  	String sqlStr1 = "select t.key_value,t.note from  cKeyWordMap t where t.key_word = '?' and t.op_code = '?' and t.op_type = 'MODE'";

%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
  	 <wtc:param value="<%=regionCode%>"/>
  	 <wtc:param value="<%=opCode%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%  	

  	String[][] retListString1 = result_t2;
		String keyMode = "";
		String note = "";


	if(retListString1.length != 0){
		keyMode = retListString1[0][0];
		note = retListString1[0][1];

	}
	

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>其他参数配置</title>
<%//-----------------------------------js区域-------------------------------------%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript>

	//--------------------------------提交表单------------------------------------
	function commit(){
		if(checkcommit()){
			form1.action="szgan_Cfm.jsp";
			form1.submit();
			return true;
		}
	}
	
	//---------------------------------清空表单---------------------------------------
	function resetJSP(){
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].type=="text"){
				document.form1.elements[i].value = "";
			}
		}
	}

	//------------------------------------验证------------------------------------------
	function checkcommit(){

		return true;
	}
	
	function goDoIt(){
		document.form1.submit1.disabled = false ;
	}
</script>
</head>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<form name="form1" method="post">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">其他参数配置</div>
	</div>
	

        <table cellspacing="0">
          
          <tr > 
            <td width="10%"  class="blue">地市</td>
            <td width="90%"> 
							<select name="sales_region"  v_name="地市" v_type="string" v_must="1">
								<%
									for(int i=0;i < retListString.length;i ++){
								%>
					              <option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
								<%
									}
								%>
	            </select>
		     			<font class="orange">*</font>            
						</td>
          </tr>
          <tr > 
            <td width="20%"   class="blue">启用开关</td>
            <td width="30%"> 
							<select name="sel_mode"  v_name="模式" v_type="string" v_must="1" onMouseDown="goDoIt()">

								<option value='OFF' <%=keyMode.equals("OFF")?"selected":""%>>禁用模式</option>
								<%
								if(regionCode.equals("01"))
								{
								%>
								<option value='HRB' <%=keyMode.equals("HRB")?"selected":""%>>哈尔滨个性模式</option>
								<%
								}
								%>
								<option value='HLJ' <%=keyMode.equals("HLJ")?"selected":""%>>全省统一模式</option>
	            </select>
		     			<font class="orange">*</font>           
						</td>

      		</tr>
		  
<input type="hidden" id="region_code" name ="region_code" value="<%=regionCode%>" />
<input type="hidden" id="login_no" name ="login_no" value="<%=workNo%>" />


          <tr > 
            <td colspan="2" id="footer"> 
              <div align="center"> 
                <input name="submit1" type="button" class="b_foot" value="确认" onClick="commit()" disabled >
                &nbsp; 
                <input name="reset" type="button"  class="b_foot" value="清除" onClick="resetJSP()">
                &nbsp; 
                <input name="back" onClick="removeCurrentTab()" class="b_foot" type="button"  value="返回">
                &nbsp; </div>
            </td>
          </tr>
        </table>


  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

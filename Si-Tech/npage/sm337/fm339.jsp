<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<%@ page import="import java.util.*;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
	String beizhu=workNo+"进行宽带资源与资费配置审批查询";
	String password    = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<%
String  inputParsm [] = new String[10];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = beizhu;

%>
	<wtc:service name="sM339Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="16">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="S"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=inputParsm[3]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
	</wtc:service>
	<wtc:array id="dcust2"scope="end"/>
		<%
    if(!"000000".equals(retCode)){
%>
      <script language=javascript>
        rdShowMessageDialog('查询失败，错误代码：<%=retCode%><br>错误信息：<%=retMsg%>');
        window.close();
      </script>
<%
      return;
    }
 %>   
  <script language="javascript">
   
    function frmCfm(){
      frm.submit();
      return true;
    }
			
		
    
    function reSetTab(){
      window.location.href="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }
    

	
	function save() {
	
				var checklength=0;
				var returnResultstate ="";
				var returnResultstr ="";
        var checkflag="0";
        var xiaoqudaima="";
        var offeriddaima="";
        var shenpizhuangtai="";
        var shenpiyuanyinstr="";
        var checkflag22="0";
        
        var objnums="";
        
        var xiaoqudaima2="";
        var shenpizhuangtai2="";
        var shenpiyuanyinstr2="";
        var yingxiaolength=0;
				$.each($("input[name='zfbox']:checked"),function(){
					checklength++;
					xiaoqudaima+=$(this).parent().find("#zfxq"+$(this).val()).val()+"|";
					offeriddaima+=$(this).parent().find("#zfdm"+$(this).val()).val()+"|";
					shenpizhuangtai+=$("#setResults"+$(this).val()).val()+"|";
					shenpiyuanyinstr+=$("#failReason3Area"+$(this).val()).val().trim()+"|";
					
					if($("#setResults"+$(this).val()).val()=="N") {
          	if($("#failReason3Area"+$(this).val()).val().trim()=="") {
	           	checkflag="1";
	           	
	          }
           if($("#failReason3Area"+$(this).val()).val().trim().indexOf("|")!=-1) {
           	checkflag22="1";
           }
        	}
				});
				
				$.each($("input[name='yxbox']:checked"),function(){
					yingxiaolength++;
					xiaoqudaima2+=$(this).parent().find("#yxxq"+$(this).val()).val()+"|";
					shenpizhuangtai2+=$("#setResults"+$(this).val()).val()+"|";
					shenpiyuanyinstr2+=$("#failReason3Area"+$(this).val()).val().trim()+"|";
					
					if($("#setResults"+$(this).val()).val()=="N") {
          	if($("#failReason3Area"+$(this).val()).val().trim()=="") {
	           	checkflag="1";
	           	
	          }
           if($("#failReason3Area"+$(this).val()).val().trim().indexOf("|")!=-1) {
           	checkflag22="1";
           }
        	}
				});
				
				
					
				
				if(checklength==0&&yingxiaolength==0) {
					rdShowMessageDialog("请选择要审批的项！");
   			  return false;						
				}
				
				if(checkflag=="1") {
					rdShowMessageDialog("请填写审批不通过原因！");
					eval('document.frm.failReasonArea'+objnums+'.focus()');
   			  return false;				
				}

				if(checkflag22=="1") {
					rdShowMessageDialog("审批原因不能包含竖线符号！");
					eval('document.frm.failReasonArea'+objnumss+'.focus()');
   			  return false;				
				}				
				
	
			$("#xiaoqudaima").val(xiaoqudaima);
			$("#offeriddaima").val(offeriddaima);
			$("#shenpizhuangtai").val(shenpizhuangtai);
			$("#shenpiyuanyinstr").val(shenpiyuanyinstr);
			$("#shenpinums").val(checklength);
			
			$("#xiaoqudaima2").val(xiaoqudaima2);
			$("#shenpizhuangtai2").val(shenpizhuangtai2);
			$("#shenpiyuanyinstr2").val(shenpiyuanyinstr2);
			$("#shenpinums2").val(yingxiaolength);
	
	
			frmCfm();
	}
	
    	function setResult(obj) {
					if($(obj).val()=="Y") {
						$(obj).parent().find("#reason3Div").hide();
					}
					else if($(obj).val()=="N") {
						$(obj).parent().find("#reason3Div").show();
					}	
			}
			
			function checkAll() { 
					var el = document.getElementsByTagName('input');
					var len = el.length;
					for(var i=0; i<len; i++) {
						if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
							el[i].checked = true;
						}
					}
				}
				function clearAll() {
					var el = document.getElementsByTagName('input');
					var len = el.length;
					for(var i=0; i<len; i++) {
						if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
							el[i].checked = false;
						}
					}
				}
				function zfCheck(obj,len){
						$.each($("input[id='zfbox"+len+"']"),function(){
							if($(obj).attr("checked")&&"A"==$(this).parent().find("#zfzt"+len).val()){
								$(this).attr("checked",true);
							}
							else{
								$(this).attr("checked",false);
							}
						});
						if($(obj).attr("checked")&&"A"==$("#yxzt"+len).val()){
							$("#yxbox"+len).attr("checked",true);
						}
						else{
							$("#yxbox"+len).attr("checked",false);
						}
				}
		</script>
		<body>
		  <form name="frm" method="POST" action="fm339Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>


        <table cellspacing="0">		
        	<tr>
        		  <th></th>	
			    		<th>地市名称</th>
			    		<th>小区代码</th>
			    		<th>小区名称</th>
			    		<th></th>
			    		<th></th>
			    		<th></th>
			    		<th>审批操作</th>
			    	</tr>
							<%if(retCode.equals("000000")) {
							   if(dcust2.length>0) {
							   HashMap dcusthash=new HashMap();
									for (int i = 0; i < dcust2.length; i++) {
										List dcustlist = new ArrayList();
										dcusthash.put(dcust2[i][0]+"#@#"+dcust2[i][1]+"#@#"+dcust2[i][2], dcustlist);
									}
									
									for (int i = 0; i < dcust2.length; i++) {
										Iterator iter = dcusthash.entrySet().iterator();
										while (iter.hasNext()) {
											Map.Entry entry = (Map.Entry) iter.next();
											Object key = entry.getKey();
											List listval = (List)entry.getValue();
											if(key.toString().equals(dcust2[i][0]+"#@#"+dcust2[i][1]+"#@#"+dcust2[i][2])){
													listval.add(dcust2[i]);
											}
										}
									}
									Iterator iter = dcusthash.entrySet().iterator();
									int groupsl=0;
									while (iter.hasNext()) {
										Map.Entry entry = (Map.Entry) iter.next();
										Object key = entry.getKey();
										List listval = (List)entry.getValue();
										String[] titles=key.toString().split("#@#");
										%>
										<tr >
												<td width="15px"><input type="checkbox" id="ckbox" name="ckbox" onclick="zfCheck(this,<%=groupsl%>)"/></td>
												<td width="40px"><%=titles[0]%></td>
												<td width="250px"><%=titles[1]%></td>
												<td><%=titles[2]%></td>
												<td></td>
								    		<td></td>
								    		<td></td>
								    		<td width="100px">
								 					<select style="width:60px" id="setResults<%=groupsl%>" onChange="setResult(this)">
								 						<option value="Y">通过</option>
								 						<option value="N">不通过</option>
								 					</select>
								 					<div id="reasonDiv" style="display:none"><input type="textArea" value="" id="failReasonArea" name="failReasonArea" maxlength="30" style="overflow: scroll; height: 50px; width: 160px;" value=""><font class="orange">*</font></div>
								 					<div id="reason2Div" style="display:none"><input type="textArea" value="" id="failReason2Area" name="failReason2Area" maxlength="30" style="overflow: scroll; height: 50px; width: 160px;" value=""><font class="orange">*</font></div>
								 					<div id="reason3Div" style="display:none"><input type="textArea" id="failReason3Area<%=groupsl%>" name="failReason3Area" maxlength="30" style="overflow: scroll; height: 50px; width: 160px;" value=""><font class="orange">*</font></div>
								 		    </td>
										</tr>
										<tr >
												<td></td>
												<td></td>
												<td><b>资费代码</b></td>
												<td><b>资费名称</b></td>
												<td><b>初装费</b></td>
								    		<td><b>审批状态</b></td>
								    		<td></td>
								    		<td></td>
								    </tr>
										<% for(int i=0;i<listval.size();i++){%>
											<%if("Y".equals(((String[])listval.get(i))[8])||"A".equals(((String[])listval.get(i))[8])){%>
											<tr>
												<td><input type="checkbox" style="display:none" id="zfbox<%=groupsl%>" name="zfbox" value="<%=groupsl%>"/>
														<input type="hidden" id="zfxq<%=groupsl%>" value="<%=titles[1]%>">
														<input type="hidden" id="zfdm<%=groupsl%>" value="<%=((String[])listval.get(i))[3]%>">
														<input type="hidden" id="zfzt<%=groupsl%>" value="<%=((String[])listval.get(i))[8]%>"></td>
												<td></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(i))[8])){%>#A0A0A0<%}%>"><%=((String[])listval.get(i))[3]%></font></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(i))[8])){%>#A0A0A0<%}%>"><%=((String[])listval.get(i))[4]%></font></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(i))[8])){%>#A0A0A0<%}%>"><%=((String[])listval.get(i))[5]%></font></td>
								    		<td><font color="<%if("Y".equals(((String[])listval.get(i))[8])){%>#A0A0A0<%}%>"><%if("Y".equals(((String[])listval.get(i))[8])){%>审批通过<%}else if("N".equals(((String[])listval.get(i))[8])){%>审批未通过<%}else if("A".equals(((String[])listval.get(i))[8])){%>待审批<%}%></font></td>
								    		<td></td>
								    		<td></td>
											</tr>
											<%}%>
										<%}%>
										<tr >
												<td></td>
												<td></td>
												<td><b>营销活动</b></td>
												<td><b>备注信息</b></td>
												<td><b>配置工号</b></td>
								    		<td><b>操作时间</b></td>
								    		<td><b>审批状态</b></td>
								    		<td></td>
								    </tr>
								    <% if(listval.size()>0){%>
								    <% if("Y".equals(((String[])listval.get(0))[15])||"A".equals(((String[])listval.get(0))[15])){%>
								    <tr >
												<td><input type="checkbox" style="display:none" id="yxbox<%=groupsl%>" name="yxbox" value="<%=groupsl%>"/>
														<input type="hidden" id="yxxq<%=groupsl%>" value="<%=titles[1]%>">
														<input type="hidden" id="yxzt<%=groupsl%>" value="<%=((String[])listval.get(0))[15]%>"></font></td>
												<td></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(0))[15])){%>#A0A0A0<%}%>"><%=((String[])listval.get(0))[11]%></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(0))[15])){%>#A0A0A0<%}%>"><%=((String[])listval.get(0))[12]%></font></td>
												<td><font color="<%if("Y".equals(((String[])listval.get(0))[15])){%>#A0A0A0<%}%>"><%=((String[])listval.get(0))[13]%></font></td>
								    		<td><font color="<%if("Y".equals(((String[])listval.get(0))[15])){%>#A0A0A0<%}%>"><%=((String[])listval.get(0))[14]%></font></td>
								    		<td><font color="<%if("Y".equals(((String[])listval.get(0))[15])){%>#A0A0A0<%}%>"><%if("Y".equals(((String[])listval.get(0))[15])){%>审批通过<%}else if("N".equals(((String[])listval.get(0))[15])){%>审批未通过<%}else if("A".equals(((String[])listval.get(0))[15])){%>待审批<%}%></font></td>
								    		<td></td>
								    </tr>
								    <%}%>
								    <%}%>
								    
								<%
									groupsl++;}
		  }else {
		%>
		<tr height='25' align='center'><td colspan='12'>查询信息为空！</td></tr>
<%}}else {
			%>
	  <tr height='25' align='center'><td colspan='12'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>
					<%
	}%>
	
				</table>
				
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="确定" onclick="save()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	
      	<input type="hidden" name="xiaoqudaima" id="xiaoqudaima" />
      	<input type="hidden" name="offeriddaima" id="offeriddaima" />
      	<input type="hidden" name="shenpizhuangtai" id="shenpizhuangtai" />
      	<input type="hidden" name="shenpiyuanyinstr" id="shenpiyuanyinstr" />
      	<input type="hidden" name="shenpinums" id="shenpinums" />
      	<br/>
      	<input type="hidden" name="xiaoqudaima2" id="xiaoqudaima2" />
      	<input type="hidden" name="shenpizhuangtai2" id="shenpizhuangtai2" />
      	<input type="hidden" name="shenpiyuanyinstr2" id="shenpiyuanyinstr2" />
      	<input type="hidden" name="shenpinums2" id="shenpinums2" />

      </form>
    </body>
</html>
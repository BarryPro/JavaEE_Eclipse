<%
/*************************************
* 功  能: g380虚拟V网用户退出文件 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:52:45
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String workName     = (String)session.getAttribute("workName");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String groupNo = request.getParameter("jituanhao");
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	String groupName = "";
	String groupNo_new = "";
	StringBuffer offerSb = new StringBuffer("");
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<wtc:service name="sVVpmnUnitQry"  retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
	</wtc:service>
	<wtc:array id="qryArr"  scope="end"/>
<%
	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		groupName = qryArr[0][1];
		groupNo_new = qryArr[0][0];
	}else {
		%>
		<script type=text/javascript>
			rdShowMessageDialog("查询错误！错误代码：<%=retCode%>，错误信息：<%=retMsg%>" ,0);	
		</script>
			<%
			return;
		}
%>
		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
$(window.parent.document).find("iframe[@id='groupIframe']").css('height','300px');
  
  function showTable() {
  	$('#groupTable').css('display','block');
  	$('#userTable').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
  }
  function clearTable() {
  		$('#tabList2').empty();
  		$('#groupTable').css('display','none');
  		$('#userTable').css('display','none');
  }
  

function clickss() {
		if (document.getElementsByName("opFlag")[0].checked) {


			document.getElementById("dangehaoma").style.display = "block";
			document.getElementById("wenjian").style.display = "none";
			document.getElementById("wenjian2").style.display = "none";
		} else if (document.getElementsByName("opFlag")[1].checked) {
		document.getElementById("dangehaoma").style.display = "none";
		document.getElementById("wenjian").style.display = "block";
		document.getElementById("wenjian2").style.display = "block";
		
		}
}

				function addwenjian() {
							if(frm2.j1PosFile.value.length<1)
						{
							rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
							document.frm2.j1PosFile.focus();
							return false;
						}
						var sm= new Array();
						
						document.frm2.target="groupIframe";
				    document.frm2.action="fg378_upload.jsp?opCodess=<%=opCode%>&opName=<%=opName%>&groupName=<%=groupName%>&groupNo_new=<%=groupNo_new%>";
				    document.frm2.submit();
				}


</script>

<body>
<form name="frm2" action="" method="post" ENCTYPE="multipart/form-data">
		<div id="groupTable">
			<div id="Operation_Table" style="padding:0px">
					<table id="tabList2" cellspacing=0>
							<tr>	
								<th>集团号</th>			
								<th>集团名称</th>
							</tr>
							<%
								if(qryFlag) {
									out.println("<tr><td>" + groupNo_new + "</td>" +
											        "<td>" + groupName + "</td></tr>");
								}
							%>
							
					</table>
			</div>
		</div>
		
		<div id="userTable">
			<div class="title">
				<div id="title_zi">用户号码添加</div>
			</div>
			
			<div id="Operation_Table" style="padding:0px">

      <table  id="wenjian" name="wenjian" >
    <tr>
        <td class='blue' nowrap width='18%'>录入文件</td>	   
        <td > 
            <input type="file" name="j1PosFile" id="j1PosFile" class="button"  />
            
        </td>
    </tr>
    <tr>        
             <font class='orange'>&nbsp;&nbsp; 上传文件为文本格式.txt文本文件，内容为：手机号码回车</font>

    </tr>
</table>
				
				 <table id="wenjian2" name="wenjian2" >
				    					    
				   <tr id='footer'>
				        <td colspan='6'>
				            <input type="button"  id="addUserBtn" class='b_foot' value="退出" onClick="addwenjian()" />
				            <input type="button" value="清除" class='b_foot' onclick="j1PosFile.outerHTML=j1PosFile.outerHTML">
				      
				        </td>
				    </tr>

				</table>

			</div>
		</div>
  <input type='hidden' id='inputFiless' name='inputFiless' value="" />
	<input type="hidden" name="loginAccept" id="loginAccept" value="" />	
	<input type="hidden" name="sm_code" id="sm_code" value="vp" />
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=loginAccept%>" />
	<input type="hidden" name="groupName" id="groupName" value="<%=groupName%>" />
	<input type="hidden" name="groupNo_new" id="groupNo_new" value="<%=groupNo_new%>" />
	<input type="hidden" name="offeridxuan" id="offeridxuan"  />
	<input type="hidden" name="opCodess" id="opCodess" value="<%=opCode%>" />
</form>
</body>
</html>
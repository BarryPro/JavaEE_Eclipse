<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wano = (String)request.getParameter("wano");
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<script type="text/javascript" src="/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/common/common1.js"></script>
<script type="text/javascript" src="/js/common/errmsg.js"></script>
<script type="text/javascript" src="/js/common/common_check.js"></script>
<script type="text/javascript" src="/js/common/common_util.js"></script>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="/js/common/common_single.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>

<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function submitCfm()
{
  var change_type = document.all.change_type.options[document.all.change_type.selectedIndex].value 
	var assignRole = document.all.assign_Role.options[document.all.assign_Role.selectedIndex].value 
	var belongOrg = document.all.belongOrg.options[document.all.belongOrg.selectedIndex].value 
	var assignLogin = document.all.assignLogin.options[document.all.assignLogin.selectedIndex].value 

	var url="f_wb_2_08.jsp?change_type="+change_type+"&assignRole="+assignRole+"&belongOrg="+belongOrg+"&assignLogin="+assignLogin+"&wano="+<%=wano%>;
	
	$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        alert('操作错误');
    },
    success: function(html){
    		eval(html.replace('/\r/g','').replace('/\n/g',''));
    		window.close();
    }
});

}

function change(){      
        //对附加资料隐藏域的控制       
      
		var ic = document.all.change_type.options[document.all.change_type.selectedIndex].value 
     
		if(ic=="0")
	    { 
          
		   		document.all("role").style.display="";
				document.all("login").style.display="none";
		   		
		}
		else if(ic=="1")
	  {
                document.all("role").style.display="none";
				document.all("login").style.display="";
		}
		
		
}
//-->
</SCRIPT>
<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="form1" method="post">
  <%@ include file="../../public/head_view_wf.jsp" %>
  <div id="Operation_Table">
    <table id=tbs9 width=100% height=25 border=0 align="center" >
      <tbody>
        <tr bgcolor="E8E8E8">
          <td width="15%" bgcolor="E8E8E8" align=left >分配类型：<select name="change_type" onChange="change()" >
              <option value='0'>角色</option>
              <option value='1'>工号</option>
            </select>
          </td>
        </tr>
        <tr bgcolor="E8E8E8">
          <TABLE id=role width=100% border=0 align="center" cellSpacing=1 >
            <TBODY>
              <TR bgcolor="#EEEEEE">
                <td width="15%" bgcolor="E8E8E8" align=left >分配角色：<select name="assign_Role"  >
                    <option value="0">测试角色</option>
                  </select>
                </td>
                <td width="15%" bgcolor="E8E8E8" align=left >分配地区：<select name="belongOrg"  >
                    <option value="10408">测试地区</option>
                  </select>
                </td>
              </TR>
            </TBODY>
          </TABLE>
        </tr>
        <tr bgcolor="E8E8E8">
          <TABLE id=login width=100% border=0 align="center" cellSpacing=1 style="display='none'">
            <TBODY>
              <TR bgcolor="#EEEEEE">
                <td bgcolor="E8E8E8" align=left >分配工号：<select name="assignLogin"  >
                    <option value="aa0002">测试工号</option>
                  </select>
                </td>
              </TR>
            </TBODY>
          </TABLE>
        </tr>
      </TBODY>
    </TABLE>
    <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
      <TBODY>
        <TR bgcolor="#eeeeee">
          <TD align=middle bgcolor="#eeeeee"><input class="button"   index="3" type=button value="确认" onClick="submitCfm()" >
            &nbsp;&nbsp; 
            &nbsp;&nbsp;
            <input class="button" name=back  type=button value="关闭" onClick="window.close()">
          </TD>
        </TR>
      </TBODY>
    </TABLE>
    <input type='hidden' name='work_No' value='1'>
  </div>
  <%@ include file="../../public/foot.jsp" %>
</FORM>
</BODY>
</HTML>

<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opName="资费FAQ";
  String opCode = "5144";
  String work_no = (String)session.getAttribute("workNo");
  String work_name = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
  String group_id = (String)session.getAttribute("groupId");
  String accountType = (String)session.getAttribute("accountType"); /*yanpx 修改 20100427 取工号类型 2为客服工号*/
  
  String ip_Addr = request.getRemoteAddr();  
  String op_code = "5144";
  int loginRight = 0;
  String faq_id_list = "";
  String faq_mode_list = "";
  String keyWord = request.getParameter("keyword");
  if(keyWord == null)
  {
  	keyWord = "";
  }
  String regionCode = "";
  if(accountType.equals("2")){
  	regionCode = request.getParameter("region_code");
  }else{
	regionCode = org_code.substring(0,2);
	if( "10014".equals(group_id))
	{
	  regionCode = "99";
	}
  }
  System.out.println("regionCoderegionCoderegionCoderegionCode="+regionCode);
  String paraArray[] = new String[4];
  
  paraArray[0] = work_no;
  paraArray[1] = regionCode;
  paraArray[2] = "";
  paraArray[3] = keyWord;
  
%>
           <wtc:service name="s5144Init" routerKey="regionCode" routerValue="<%=org_code.substring(0,2)%>"  retcode="errCode" retmsg="errMsg"  outnum="3" >
			       <wtc:param value="<%=paraArray[0]%>"/>
			       <wtc:param value="<%=paraArray[1]%>"/>
			       <wtc:param value="<%=paraArray[2]%>"/>
			       <wtc:param value="<%=paraArray[3]%>"/>
			</wtc:service>
			<wtc:array id="result0" start="0" length="1" scope="end" />
			<wtc:array id="result1" start="1" length="1" scope="end" />
			<wtc:array id="result2" start="2" length="1" scope="end" />
<%  
  if(!errCode.equals("000000"))
  {
%>
<script language="javascript">
    rdShowMessageDialog("<%=errMsg%>");
    window.parent.opener="";
    window.parent.close();
</script>
<%  
    response.getWriter().close();
  }
  
  if(result1 != null)
  {
    //loginRight = Integer.parseInt(result0[0][0]);
    loginRight = 128;
    faq_id_list = new String(result1[0][0]);
    faq_mode_list = new String(result2[0][0]);
  }
%>
  <head>
  </head>
  <body>
    <form name="frm" method="post">
    <%@ include file="/npage/include/header.jsp" %>
    <table cellspacing="0">
      <tr>
        <td class="blue">关键字
        </td>
        <td>
        	<input type="text" name="keyword" maxlength="15">
        	<input type="button" class="b_text" value="查询" onclick="doSearch()" >
        	<%if(accountType.equals("2")){%>
        	<input type="button" class="b_text" value="返回" onclick="doQuery()" >
        	<%}%>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="blue"><b>资费套餐名称</b>
        </td>
      </tr>
<%
  if(faq_id_list != null && faq_id_list.length() != 0)
  {
    String faq_ids[] = faq_id_list.split("\\|");
    String faq_modes[] = faq_mode_list.split("\\|");
    for (int row = 0; row < faq_ids.length; row++)
    {
%>
      <tr>
        <td><%=row+1%></td>
        <td nowrap>
          <a style="cursor:hand;" onclick="listQA('<%=faq_ids[row]%>')"><%=faq_modes[row]%></a>
<%
      if(loginRight == 128&&(!accountType.equals("2"))) //管理员
      {
%>
          <a style="cursor:hand;" onclick="modify('<%=faq_ids[row]%>')">修改</a>&nbsp;
          <a style="cursor:hand;" onclick="del_faq('<%=faq_ids[row]%>')">删除</a>
<%
      }
%>
          </td>
      </tr>
<%
    }
  }
%>
    </table>
    <input type="hidden" name="faq_id" />
    <%@ include file="/npage/include/footer.jsp" %>
    </form>
  </body>
</html>
<script language="javascript">
function doQuery(){
	document.frm.action = "./f5144ModeKf.jsp";
	document.frm.submit();
}	
function listQA(i_faq_id)
{
  document.frm.faq_id.value = i_faq_id;
  document.frm.target="frameMain";
  document.frm.action="./f5144Main.jsp";
  document.frm.submit();
}

function del_faq(i_faq_id)
{
  if(confirm('确定要删除此记录吗？'))
    {
        document.frm.faq_id.value = i_faq_id;
    document.frm.target="_parent";
    document.frm.action="./f5144DelCfm.jsp";
    document.frm.submit();
    }
    else
    {
        return;
    }
}

function modify(i_faq_id)
{
  document.frm.faq_id.value = i_faq_id;
  document.frm.target="_parent";
  document.frm.action="./f5144Modify.jsp";
  document.frm.submit();
}

function doSearch()
{
	document.frm.target="_self";
	document.frm.action="./f5144Mode.jsp";
  	document.frm.submit();
}
</script>
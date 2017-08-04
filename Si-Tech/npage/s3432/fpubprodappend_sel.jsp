   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN集团开户";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<% request.setCharacterEncoding("gb2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>

<%
	//得到输入参数
    Logger logger = Logger.getLogger("fpubprodappend_sel.jsp");
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[] paramsIn = null;

    /*得到操作员的工号和密码*/
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String[][] pass = (String[][])arr.get(4);
    String workno = baseInfo[0][2];
    String nopass  = pass[0][0];
    String powerRight = baseInfo[0][5].trim();
	String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String product_code = request.getParameter("product_code");
    String showType = request.getParameter("showType");   //显示类型 
    String sqlStr = "";
    String org_id = "";
    String group_id = "";
    String class_code = "";
    String owner_code = "JT";
    String credit_code = "E";
    String business_code = "0"; //开户
    
    
    String regionCode = (String)session.getAttribute("regCode");
    try
    {
        sqlStr = "select a.org_id, a.group_id, b.innet_type from dLoginMsg a, sTownCode b, sSmSelPAttr c where a.login_no = '" + workno + "' and a.group_id = b.group_id and c.sm_code = '" + sm_code + "'";
       // retArray = callView.sPubSelect("3",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%        
        result = result_t1;
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
    }
    catch(Exception e){
        logger.error("查询sSmSelPAttr错误!");
    }
%>

<%
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = "产品代码|产品名称|";

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

	if(showType.compareTo("Default") == 0) //只显示默认产品时的列标题
	{	fieldName = "产品代码|产品名称|";		}

    String selType = "M";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
%>

<HTML><HEAD><TITLE>黑龙江移动BOSS<%=pageTitle%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
//-------------------------------------------------------------------
function turnToDepend()
{
	var retCode = "";

	//产品代码|产品名称|
	for(var i=0;i<pubProduct.elements.length;i++)
	{
		if (pubProduct.elements[i].name=="List")
		{   //判断是否是单选或复选框
			if (pubProduct.elements[i].checked==true)
			{
			    //判断是否被选中
 				rIndex = pubProduct.elements[i].RIndex;
 				objCode = "Rinput" + rIndex + 1;
				if(document.all(objCode).value != "")
				{
					if (retCode == "") {
						retCode = document.all(objCode).value;
                    }
					else {
						retCode = retCode + "," + document.all(objCode).value;
                    }
				}
			}
		}
	}

    window.returnValue = retCode;
    if(retCode == "")
    {
    	rdShowMessageDialog("请选择产品信息！",0);
    	return false;
    }
	opener.getvalueProdAppend(retCode);
    window.close();
}
//-------------------------------------------------
function allChoose()
{   //复选框全部选中
    for(i=0;i<pubProduct.elements.length;i++)
    {
        if(pubProduct.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            if(pubProduct.elements[i].disabled == false)
            {   pubProduct.elements[i].checked = true;	}
        }
    }
}
function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<pubProduct.elements.length;i++)
    {
        if(pubProduct.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            if(pubProduct.elements[i].disabled == false)
            {   pubProduct.elements[i].checked = false;		}
        }
    }
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="pubProduct">
	<%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi">产品选择</div>
	</div>

  <table cellspacing="0" >
    <tr>
<%  //绘制界面表头
     chPos = fieldName.indexOf("|");
     out.print("<TR bgcolor='649ECC' height=25 >");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TD class=\" blue \">&nbsp;&nbsp;" + valueStr + "</TD>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);

%>

<%
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{
			fieldNum = "3";
      		String choiceFlag = "0";

            paramsIn = new String[12];
            paramsIn[0] = workno;
            paramsIn[1] = nopass;
            paramsIn[2] = sm_code;
            paramsIn[3] = op_code;
            paramsIn[4] = org_id;
            paramsIn[5] = group_id;
            paramsIn[6] = owner_code;
            paramsIn[7] = class_code;
            paramsIn[8] = credit_code;
            paramsIn[9] = powerRight;
            paramsIn[10] = product_code;
            paramsIn[11] = business_code;
            //retArray = callView.callFXService("sPubSubProdSel", paramsIn, "11", "region", "01");
%>

    <wtc:service name="TlsPubSelCrm" outnum="11" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
			<wtc:param value="<%=paramsIn[11]%>" />											
		</wtc:service>
		<wtc:array id="result_t2" scope="end"  />
			

<%
                int recordNum = result_t2.length;
                if (result[0][0].trim().length() == 0)
                
	      		outer: for(int i=0;(i<recordNum) && (i<iEndPos);i++)
	      		{
                    if (i < iStartPos) continue;
	      		    typeStr = "";
	      		    inputStr = "";
	      		    choiceFlag = "0";
          		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
	      		    {
	                    if(j==0)
	                    {
                            //choiceFlag为绑定标志,0-自由选择,1-多项选一,2-绑定
	                    	choiceFlag = ((String[][])retArray.get(6))[i][0];
	                    	if(choiceFlag.compareTo("0") != 0 && choiceFlag.compareTo("1") != 0 && choiceFlag.compareTo("2") != 0 )
	                    	{	continue outer;	}
	                    	out.print("<TR bgcolor='#EEEEEE'>");
	                    }
	                    else if(j==1)
	                    {
	                        //复选框
	                        typeStr ="<TD>&nbsp;<input type='" + selType +
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +
	                            " onkeydown='if(event.keyCode==13)turnToDepend();'";
	                        //判断是否是绑定产品
	                        if(choiceFlag.compareTo("2") == 0)
	                        {  	typeStr = typeStr + "checked disabled"; }
	                        typeStr = typeStr + ">";
	                        //代码信息
	                        typeStr = typeStr + (result_t2[i][3]).trim() + "<input type='hidden' " +
	          		            " id='Rinput" + i + j + "' class='button' value='" +
	          		            (result_t2[i][3]).trim() + "'readonly></TD>";
	                    }
                        else
                        {
	          		        inputStr = inputStr + "<TD>&nbsp;" + (result_t2[i][4]).trim() +
	          		            "<input type='hidden' " +
	          		            " id='Rinput" + i + j + "' class='button' value='" +
	          		            (result_t2[i][4]).trim() + "'readonly></TD>";
	                    }
          		    }
	                inputStr = inputStr + "</TD>";
	      		    out.print(typeStr + inputStr);
	      		    out.print("</TR>");
            }
     	}catch(Exception e){
			e.printStackTrace();
     	}
%>
<%


%>
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD align=center id=""footer>
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='b_foot_long' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");
    }
%>
                <input class="b_foot" name=commit onClick="turnToDepend()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close();" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>

  <!------------------------>
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>

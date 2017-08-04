<%

/********************

 * version v2.0

 * 开发商: si-tech

 * update by leimd @ 2009-04-15

 ********************/

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%request.setCharacterEncoding("GBK");%>

<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.util.page.*"%>



<%

    String opName = "集团包年产品信息查询";

    String regionCode = (String)session.getAttribute("regCode");

    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));

    //得到输入参数

    String[][] result = new String[][]{};

    String[][] allNumStr =  new String[][]{};

    String opCode = "1036";

    

%>



<%

/*

	SQL语句        sql_content

	选择类型       sel_type

	标题           title

	字段1名称      field_name1

*/

	String pageTitle = request.getParameter("pageTitle");

    String fieldNum = "";

    String fieldName = request.getParameter("fieldName");

	String iccid = request.getParameter("iccid");

    String cust_id = request.getParameter("cust_id");

    String unit_id = request.getParameter("unit_id");

    String user_no = request.getParameter("user_no");

	String sm_code =request.getParameter("sm_code");

    String sqlFilter = "";

    

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));

    

    int iPageSize = 25;

    int iStartPos = (iPageNumber-1)*iPageSize;

    int iEndPos = iPageNumber*iPageSize;

    

    if (iccid != null)

    {

	    if (iccid.trim().length() > 0) {

	        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";

	    }

	}    

    if (cust_id != null)

    {

	    if (cust_id.trim().length() > 0) {

	        sqlFilter = sqlFilter + " and a.cust_id = " + cust_id + " and b.cust_id = " + cust_id + " and c.cust_id = " + cust_id;

	    }

    }

    if (unit_id != null)

    {

	    if (unit_id.trim().length() > 0) {

	        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;

	    }

    }

    if (user_no != null)

    {

	    if (user_no.trim().length() > 0) {

	        sqlFilter = sqlFilter + " and e.service_type = c.sm_code and e.service_no = '" + user_no + "'";

	    }

    }

    if (sm_code != null)

    {

		if (sm_code.trim().length() > 0) {

	        sqlFilter = sqlFilter + " and c.sm_code ='" + sm_code+"'";

	    }

	}

    String sqlStr = "SELECT nvl(count(*),0) num FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e WHERE c.product_code = d.product_code  AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and trim(c.user_no) = Trim(e.msisdn) and c.run_code = 'A'" + sqlFilter;



    String sqlStr1 = "select * from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(e.service_no), TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,g.sm_code,rownum id FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and Trim(c.user_no) = Trim(e.msisdn) and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code and c.run_code = 'A' " + sqlFilter + "/* and c.sm_code ='np'*/ ) where id <"+iEndPos+" and id>="+iStartPos;



	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr="+sqlStr);

	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr1="+sqlStr1);

    String selType = request.getParameter("selType");

    String retQuence = request.getParameter("retQuence");

    if(selType.compareTo("S") == 0)

    {   selType = "radio";    }

    if(selType.compareTo("M") == 0)

    {   selType = "checkbox";   }

    if(selType.compareTo("N") == 0)

    {   selType = "";   }

    int chPos = 0;

    String typeStr = "";

    String inputStr = "";

    String valueStr = "";

    

%> 

 

<html xmlns="http://www.w3.org/1999/xhtml">

<HEAD>

<TITLE>黑龙江BOSS-集团客户查询</TITLE>

<META content=no-cache http-equiv=Pragma>

<META content=no-cache http-equiv=Cache-Control>



<SCRIPT type="text/javascript">

function saveTo()

{

      var rIndex;        //选择框索引

      var retValue = ""; //返回值

      var chPos;         //字符位置

      var obj;

      var fieldNo;        //返回域序列号

      var retFieldNum = document.fPubSimpSel.retFieldNum.value;

      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列

      var retNum = retQuence.substring(0,retQuence.indexOf("|"));

      retQuence = retQuence.substring(retQuence.indexOf("|")+1);

      var tempQuence;

      if(retFieldNum == "")

      {     return false;   }

       //返回单条记录

          for(i=0;i<document.fPubSimpSel.elements.length;i++)

          {

                  if (document.fPubSimpSel.elements[i].name=="List")

                  {    //判断是否是单选或复选框

                       if (document.fPubSimpSel.elements[i].checked==true)

                       {     //判断是否被选中

                             rIndex = document.fPubSimpSel.elements[i].RIndex;

                             tempQuence = retQuence;

                             for(n=0;n<retNum;n++)

                             {

                                chPos = tempQuence.indexOf("|");

                                fieldNo = tempQuence.substring(0,chPos);

                                obj = "Rinput" + rIndex +"0"+ fieldNo;

                                retValue = retValue + document.all(obj).value + "|";

                                tempQuence = tempQuence.substring(chPos + 1);

                             }

                             window.returnValue= retValue;

                       }

                }

            }

        if(retValue =="")

        {

            rdShowMessageDialog("请选择信息项！",0);

            return false;

        }

        opener.getvaluecust(retValue);

        

        window.close();

}



function allChoose()

{   //复选框全部选中

    for(i=0;i<document.fPubSimpSel.elements.length;i++)

    {

        if(document.fPubSimpSel.elements[i].type=="checkbox")

        {    //判断是否是单选或复选框

            document.fPubSimpSel.elements[i].checked = true;

        }

    }

}



function cancelChoose()

{   //取消复选框全部选中

    for(i=0;i<document.fPubSimpSel.elements.length;i++)

    {

        if(document.fPubSimpSel.elements[i].type =="checkbox")

        {    //判断是否是单选或复选框

            document.fPubSimpSel.elements[i].checked = false;

        }

    }

}

</SCRIPT>



</HEAD>

<BODY>

<FORM method=post name="fPubSimpSel">

<%@ include file="/npage/include/header_pop.jsp" %>

<div class="title">

	<div id="title_zi">查询结果</div>

</div>

<table cellspacing="0">

    <tr>

	<TR align="center">

	    <TH>证件号码 </TH>

	    <TH>集团客户ID </TH>

	    <TH>集团客户名称 </TH>

	    <TH>集团产品ID</TH>

	    <TH>集团用户编号 </TH>

	    <TH>集团用户名称 </TH>

	    <TH>产品代码 </TH>

	    <TH>产品名称 </TH>

	    <TH>集团ID </TH>

	    <TH>产品付费帐户 </TH>

	    <TH>品牌名称 </TH>

	    <TH>品牌代码 </TH>

    </TR>

<% 

 //绘制界面表头

     chPos = fieldName.indexOf("|");

     out.print("");

     String titleStr = "";

     int tempNum = 0;

     while(chPos != -1)

     {

        valueStr = fieldName.substring(0,chPos);

        titleStr = "";

        out.print(titleStr);

        fieldName = fieldName.substring(chPos + 1);

        tempNum = tempNum +1;

        chPos = fieldName.indexOf("|");

     }

     out.print("");

     fieldNum = String.valueOf(tempNum);

%>



<%

    //根据传人的Sql查询数据库，得到返回结果

    try

    {



	

    %>

        <wtc:service name="s3096QryCheckE" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="19" >

        	<wtc:param value="<%=workNo%>"/>

        	<wtc:param value="<%=unit_id%>"/> 

            <wtc:param value="u03"/> 

            <wtc:param value=""/> 

            <wtc:param value="<%=iccid%>"/> 

            <wtc:param value="<%=cust_id%>"/> 

            <wtc:param value="<%=user_no%>"/> 

            <wtc:param value="<%=opCode%>"/> 

        </wtc:service>

        <wtc:array id="retArr1" scope="end"/>

    <%

        result=retArr1;

        int recordNum = result.length;

    

        //allNumStr = retArr2;

        //System.out.println("---------------"+allNumStr[0][0]);

        //System.out.println("---------------"+retArr2[0][0]);

        //int recordNum = Integer.parseInt(allNumStr[0][0].trim());

        for(int i=0;i<recordNum;i++)

        {

            typeStr = "";

            inputStr = "";

            out.print("<TR>");

            for(int j=0;j<Integer.parseInt(fieldNum);j++)

            {

                if(j==0)

                {

                    typeStr = "<TD>";

                    if(selType.compareTo("") != 0)

                    {

                        typeStr = typeStr + "<input type='" + selType +

                            "' name='List' style='cursor:hand' RIndex='" + i + "'" +

                            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";

                    }

                    typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +

                        " id='Rinput" + i + "0" + j + "' value='" +

                        (result[i][j]).trim() + "'readonly></TD>";

                }

                else

                {

                    inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +

                        " id='Rinput" + i + "0" + j + "' value='" +

                        (result[i][j]).trim() + "'readonly></TD>";

                }

            }

            out.print(typeStr + inputStr);

            out.print("</TR>");

        }

      }catch(Exception e){

            e.printStackTrace();

        }

%>

	</tr>

</table>







<TABLE cellSpacing=0>

    <TBODY>

        <TR id="footer">

            <TD>

<%

    if(selType.compareTo("checkbox") == 0)

    {

        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");

        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");

    }

%>



<%

                if(selType.compareTo("") != 0)

                {

%>

                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>

<%

                }

%>

                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>

            </TD>

        </TR>

    </TBODY>

</TABLE>

	<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>

  	<input type="hidden" name="retQuence" value=<%=retQuence%>>

<%@ include file="/npage/include/footer_pop.jsp" %>

</FORM>

</BODY>

</HTML>  	


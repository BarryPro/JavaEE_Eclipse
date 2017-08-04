<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3216";
  String opName = "查询集团成员信息";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>


<%

        ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfoSession = (String[][])arrSession.get(0);
        String[][] otherInfoSession = (String[][])arrSession.get(2);
        String loginNo =(String)session.getAttribute("workNo");
        String loginName = (String)session.getAttribute("workName");
        String orgCode = (String)session.getAttribute("orgCode");
        String ip_Addr = (String)session.getAttribute("ipAddr");

        String regionCode = (String)session.getAttribute("regCode");
        String regionName = regionCode;

        String GroupId = baseInfoSession[0][21];
        String OrgId = baseInfoSession[0][23];
				
				
				System.out.println("-------------------orgCode----------------"+orgCode);
				System.out.println("-------------------GroupId----------------"+GroupId);
				System.out.println("-------------------OrgId------------------"+OrgId);


%>

<%

    int isGetDataFlag = 1;  //0：正确,其他错误. add by yl.
    String errorMsg ="";
    String tmpStr="";
    String insql = "";

dataLabel:
    while(1==1){

    isGetDataFlag = 0;
 break;
 }


     errorMsg = "取数据错误："+Integer.toString(isGetDataFlag);

     //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
	
<!--
    rdShowMessageDialog("<%=errorMsg%>");
    window.close();
    window.opener.focus();
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查询集团成员信息</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
<!--
    //定义应用全局的变量
    var SUCC_CODE   = "0";          //自己应用程序定义
    var ERROR_CODE  = "1";          //自己应用程序定义
    var YE_SUCC_CODE = "0000";      //根据营业系统定义而修改
    var dynTbIndex=1;               //用于动态表数据的索引位置,开始值为1.考虑表头

    var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";


    onload=function()
    {
        init();
    }

    function reset_globalVar()
    {
      dynTbIndex=1;
    }

    function init()
    {
        //将查询去掉：style.display="none"; by yl.2004-2-10.
        document.frm.GRPIDQRY.style.display = "none";
        document.frm.GRPNAME.style.display = "none";
        document.frm.PHONENOQRY.style.display = "none";
        document.frm.ISDNNOQRY.style.display = "none";


        chg_noType();

    }

    function chg_noType()
    {
    var no_type = document.frm.noType[document.frm.noType.selectedIndex].value;

        if( no_type == "0" )//短号
        {
            document.all.showID1.style.display="";
            document.all.showID2.style.display="none";

            //document.frm.PHONENO.value = "";
        }
        else //真实号码
        {
            document.all.showID1.style.display="none";
            document.all.showID2.style.display="";

            //document.frm.ISDNNO.value = "";
        }


    }

    //---------1------RPC处理函数------------------
    function doProcess(packet){
        //使用RPC的时候,以下三个变量作为标准使用.
        error_code = packet.data.findValueByName("errorCode");
        error_msg =  packet.data.findValueByName("errorMsg");
        verifyType = packet.data.findValueByName("verifyType");
        backArrMsg = packet.data.findValueByName("backArrMsg");

        self.status="";

    }

    function fillSelectUseValue_noArr(fillObject,indValue)
    {
            for(var i=0;i<document.all(fillObject).options.length;i++){
                if(document.all(fillObject).options[i].value == indValue){
                    document.all(fillObject).options[i].selected = true;
                    break;
                }
            }
    }



    function PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
    {

        var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
        //var path = "../public/fPubSimpSel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;

        retInfo = window.showModalDialog(path);
        if(typeof(retInfo) == "undefined")
        {   return false;   }
        var chPos_field = retToField.indexOf("|");
        var chPos_retStr;
        var valueStr;
        var obj;
        while(chPos_field > -1)
        {
            obj = retToField.substring(0,chPos_field);
            chPos_retInfo = retInfo.indexOf("|");
            valueStr = retInfo.substring(0,chPos_retInfo);
            document.all(obj).value = valueStr;
            retToField = retToField.substring(chPos_field + 1);
            retInfo = retInfo.substring(chPos_retInfo + 1);
            chPos_field = retToField.indexOf("|");

        }
    }

    function call_PHONENOQRY()
    {
        var pageTitle = "集团成员号码查询";
        var fieldName = "短号|集团号|";
        var sqlStr ="";

         if( document.frm.GRPID.value == "" )
         {
            rdShowMessageDialog("请输入集团号!!");
            return false;
         }

        if(!checkElement("GRPID")) return false;
        if(!checkElement("PHONENO")) return false;

        sqlStr = "select short_no,group_no from dvpmnusrmsg  "+
                 " where group_no="+document.frm.GRPID.value;

        sqlStr =  sqlStr + " and short_no like '"+encodeURI("%" +jtrim(document.frm.PHONENO.value))+"%'" ;

       sqlStr = sqlStr + " order by short_no " ;

        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "2|0|1|";
        var retToField = "PHONENO|GRPID|";
        PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);

    }

    function call_ISDNNOQRY()
    {
        var pageTitle = "集团成员号码查询";
        var fieldName = "真实号码|集团号|";
        var sqlStr ="";
        var flag=0;

         if( document.frm.GRPID.value != "" )
         {
            if(!checkElement("GRPID")) return false;
            flag=1;
         }

        if(!checkElement("ISDNNO")) return false;

        sqlStr = "select real_no,group_no from dvpmnusrmsg   ";
        if( flag == 1 )
        {
            sqlStr = sqlStr + " where  group_no="+document.frm.GRPID.value;
            sqlStr =  sqlStr + " and real_no like '"+encodeURI("%" +jtrim(document.frm.ISDNNO.value))+"%'" ;
        }else{
            sqlStr =  sqlStr + " where real_no like '"+encodeURI("%" +jtrim(document.frm.ISDNNO.value))+"%'" ;
        }

       sqlStr = sqlStr + " order by real_no " ;

        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "2|0|1|";
        var retToField = "ISDNNO|GRPID|";
        PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);

    }

    function call_GRPIDQRY()
    {

        var pageTitle = "集团号查询";
        var fieldName = "集团号|集团名称|";

        var sqlStr ="";

        sqlStr = "select b.group_no,trim(b.group_name)"+
                 " from  dVPMNGRPMSG b "+
                 " where  ";

        sqlStr = sqlStr +"  group_no like '"+encodeURI("%" +jtrim(document.frm.GRPID.value))+"%'" +
                         " and group_name like '%" +jtrim(document.frm.GRPNAME.value)+"%'" ;

        sqlStr = sqlStr + " order by group_no " ;

        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "2|0|1|";
        var retToField = "GRPID|GRPNAME|";

        PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);


    }

     
    function judge_valid()
    {
    var no_type = document.frm.noType[document.frm.noType.selectedIndex].value;

        //1.检查单独的域
         if(no_type == "0" && document.all.GRPID.value==""){rdShowMessageDialog("集团号不能为空!"); return false;}

        if(no_type == "0")
        {
            if (!checkElement(document.all.PHONENO)) return false;
        }
        else
        {
            if (!checkElement(document.all.ISDNNO)) return false;
        }

        return true;
    }



    function isNullMy(obj)
    {
        if( document.all(obj).value == "" )
        {
            document.all(obj).focus();
            return true;
        }
        else{
            return false;
            }
    }


    function resetJsp()
    {
    var no_type = document.frm.noType[document.frm.noType.selectedIndex].value;

        init();

     with(document.frm)
     {
        GRPID.value         = "";
        GRPNAME.value       = "";
        if(no_type == "0"){//短号列表
            PHONENO.value           = "";
        }else{
            ISDNNO.value            = "";
        }

     }

        reset_globalVar();

    }

    function commitJsp()
    {
        var ind1Str ="";
        var ind2Str ="";
        var ind3Str ="";
        var ind4Str ="";
        var ind5Str ="";

        var tmpStr="";

        var procSql = "";
        var page="";
        var qry_type = document.frm.qryType[document.frm.qryType.selectedIndex].value;
        var no_type = document.frm.noType[document.frm.noType.selectedIndex].value;

        if( !judge_valid() )
        {
            return false;
        }

        if( qry_type == "1")//基本信息
        {
            page = "f3216_base.jsp";
        }
        else if( qry_type == "2")//话费信息
        {
            page = "f3216_fee.jsp";
        }
        else if( qry_type == "3")//全部信息
        {
            page = "f3216_all.jsp";
        }

        if( no_type == "0" )//短号列表
        {
            document.frm.ISDNNO.value  = "";
        }else
        {
            document.frm.PHONENO.value  = "";
        }

        //2.对form的隐含字段赋值

        //4.提交页面
        tmpStr = "查询 " + ",集团号码："+document.all.GRPID.value+"";


        document.frm.opCode.value="3216";

        document.frm.opNote.value =  tmpStr;

        //8.提交页面
        document.frm.confirm.disabled = true;
        frm.action=page;
        frm.method="post";
        frm.submit();
    }

//-->
</script>

</head>


<body>
<form name="frm" method="post" action="">
 <%@ include file="/npage/include/header.jsp" %>                         
<div class="title">
		<div id="title_zi">查询集团成员信息</div>
	</div>
        <table  cellspacing="0" >
          <tr>
            <td class="blue" width="16%">操作类型</td>
            <td class="blue" width="36%" > <input name="noUse" type="text"  id="noUse" value="查询"  readonly class="InputGrey">
            </td>
            <td class="blue" width="16%">地市代码</td>
            <td class="blue" width="34%"><input name="regionName" type="text"  id="regionName" value="<%=regionName%>" maxlength="2" readonly  class="InputGrey">
            </td>
          </tr>
          <tr >
            <td class="blue" width="16%" >集团号</td>
            <td class="blue" colspan="3"> <input name="GRPID" type="text"  id="GRPID" size="10" maxlength="10" v_must=1 v_type=0_9 v_minlength=10  v_name="集团号">
              <input name="GRPNAME" type="text"  id="GRPNAME" maxlength="36">
              <!--font color="#FF0000">*</font--> <input name="GRPIDQRY" type="button"  id="GRPIDQRY" onClick="call_GRPIDQRY()" value="查询"></td>
          </tr>
          <tr >
            <td class="blue">请选择查询类型</td>
            <td class="blue" ><select name="qryType" id="qryType">
                <!--option value="1">1--&gt;基本信息</option-->
                <option value="2">2--&gt;话费信息</option>
                <option value="3" selected>3--&gt;全部信息</option>
             <!--
              </select></td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>
          <tr>-->
            <td class="blue" width="16%">请选择号码类型</td>
            <td class="blue"><select name="noType" onChange="chg_noType()">
            	<option value="1">1--&gt;真实号码列表</option>
                <option value="0">0--&gt;短号列表</option>
                <!--
				</select></td>
				
				<td class="blue">&nbsp;</td>
				<td class="blue">&nbsp; </td>-->
          </tr>
          <tr id="showID1">
            <td class="blue">短号</td>
            <td class="blue" ><input name="PHONENO" type="text" id="PHONENO" maxlength="6"  value="" v_must=1 v_type=0_9 v_minlength=3   v_name="短号" >
              	 <font class="orange">*</font> 
              <input name="PHONENOQRY" type="button"  id="PHONENOQRY" value="查询" onClick="call_PHONENOQRY()">
            </td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>
          <tr id="showID2">
            <td class="blue">真实号码</td>
            <td class="blue" ><input name="ISDNNO" type="text" id="ISDNNO" maxlength="11"  value="" v_must=1 v_type=0_9 v_minlength=1   v_name="真实号码" >
              <font class="orange">*</font> 
              <input name="ISDNNOQRY" type="button"  id="ISDNNOQRY" value="查询" onClick="call_ISDNNOQRY()">
             </td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>
          <tr >
            <td class="blue" width="16%" >用户备注</td>
            <td class="blue" colspan="3"><input name="opNote" type="text"  id="opNote" size="60" maxlength="60"></td>
          </tr>
          <tr>
            <td id="footer" colspan="4"> <div align="center"> &nbsp;
                <input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">
                &nbsp;
                <input name="reset" type="button"  class="b_foot"  value="清除" onClick="resetJsp()">
                &nbsp;
                <input name="back" onClick="removeCurrentTab()"  class="b_foot" type="button"  value="关闭">
                &nbsp; </div></td>
          </tr>
        </table>
 

    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
    <input type="hidden" name="loginName" id="loginName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

    <input type="hidden" name="tmpLOCKFLAG" id="tmpLOCKFLAG" value="">
    <input type="hidden" name="tmpUSERTYPE" id="tmpUSERTYPE" value="">
    <input type="hidden" name="tmpCURFEETYPE" id="tmpCURFEETYPE" value="">
    <input type="hidden" name="tmpFEETYPE" id="tmpFEETYPE" value="">

    <input type="hidden" name="STATUS" id="STATUS" value="">
    <input type="hidden" name="FEEFLAG" id="FEEFLAG" value="">
    <input type="hidden" name="USERPIN" id="USERPIN" value="">

    <input type="hidden" name="tmpR1" id="tmpR1" value="">
    <input type="hidden" name="tmpR2" id="tmpR2" value="">
    <input type="hidden" name="tmpR3" id="tmpR3" value="">
    <input type="hidden" name="tmpR4" id="tmpR4" value="">
    <input type="hidden" name="tmpR5" id="tmpR5" value="">

    <input type="hidden" name="tmpAddShortNo" id="tmpAddShortNo" value="">
    <input type="hidden" name="tmpAddRealNo" id="tmpAddRealNo" value="">

    <input type="hidden" name="NUMLIST" id="NUMLIST" value="">
    <input type="hidden" name="org_id"  value="<%=OrgId%>">
    <input type="hidden" name="group_id"  value="<%=GroupId%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

